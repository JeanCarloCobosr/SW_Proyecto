package com.proyecto.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.proyecto.entity.CuentaBancaria;
import com.proyecto.entity.Movimiento;
import com.proyecto.entity.Respuesta;
import com.proyecto.entity.Rol;
import com.proyecto.entity.Saldo;
import com.proyecto.entity.Usuario;

@Controller
public class LoginController {
	

	String URL_BANCO= "http://localhost:8093/rest/banco"; //mongodb
	String URL_CUENTA_BANCARIA = "http://localhost:8091/rest/cuenta_bancaria"; //postgres
	
	String URL_SALDO = "http://localhost:8092/rest/saldo"; //mysql
	String URL_MOVIMIENTO = "http://localhost:8092/rest/movimiento";
	String URL_USUARIO = "http://localhost:8092/rest/usuario";
	String URL_ROL = "http://localhost:8092/rest/rol";

	@Autowired
	private RestTemplate restTemplate;

	@RequestMapping("/login")
	public String login(@RequestParam("filtro") String filtro, @RequestParam("pw") String pw, HttpSession session, HttpServletRequest request) {

		ResponseEntity<List<Usuario>> responseEntity1 =
		restTemplate.exchange(URL_USUARIO + "/porSesion/" + filtro + "/" + pw, HttpMethod.GET, null,new ParameterizedTypeReference<List<Usuario>>() {});
		List<Usuario> lstUsuario = responseEntity1.getBody();

		
		if (lstUsuario.size() < 1) {
			request.setAttribute("mensaje", "Error en el usuario o contraseña");
			return "paginaLogin";
		}
		
		ResponseEntity<List<Saldo>> responseEntity2 =
		restTemplate.exchange(URL_SALDO + "/porUsuario/" + lstUsuario.get(0).getIdUsuario(), HttpMethod.GET, null,new ParameterizedTypeReference<List<Saldo>>() {});
		List<Saldo> lstSaldo = responseEntity2.getBody();
		
		ResponseEntity<List<Rol>> responseEntity3 =
		restTemplate.exchange(URL_ROL + "/porUsuario/" + lstUsuario.get(0).getIdUsuario(), HttpMethod.GET, null,new ParameterizedTypeReference<List<Rol>>() {});
		List<Rol> lstRol = responseEntity3.getBody();
		
		session.setAttribute("objUsuario", lstUsuario.get(0));
		session.setAttribute("objSaldo", lstSaldo.get(0));
		session.setAttribute("objRol", lstRol.get(0));
		
		/*switch(lstRol.get(0).getNombre())
		{
			case "ROLE_ADMIN":
				return "paginaHome";
		}*/
		return "paginaHome";
	}

	@RequestMapping("/logout")
	public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		session.invalidate();

		response.setHeader("Cache-control", "no-cache");
		response.setHeader("Expires", "0");
		response.setHeader("Pragma", "no-cache");

		request.setAttribute("mensaje", "El usuario salió de sesión");
		return "paginaLogin";

	}
	
	
	
	
	
	
	
	
	
	@RequestMapping("/consultaMovimiento")
	@ResponseBody
	public List<Movimiento> consultaMovimiento(@RequestParam("idUsuario") int idUsuario) {

		ResponseEntity<List<Movimiento>> responseEntity =
		restTemplate.exchange(URL_MOVIMIENTO + "/porUsuario/" + idUsuario, HttpMethod.GET, null,new ParameterizedTypeReference<List<Movimiento>>() {});

		List<Movimiento> lstMovimiento = responseEntity.getBody();
		return lstMovimiento;
	}
	
	@RequestMapping("/cargaCuentaBancariaUsuario")
	@ResponseBody
	public List<CuentaBancaria> cargaCuentaBancaria(@RequestParam("idUsuario") int idUsuario) {

		ResponseEntity<List<CuentaBancaria>> responseEntity =
		restTemplate.exchange(URL_CUENTA_BANCARIA + "/porUsuario/" + idUsuario, HttpMethod.GET, null,new ParameterizedTypeReference<List<CuentaBancaria>>() {});

		List<CuentaBancaria> lstCuenta = responseEntity.getBody();
		return lstCuenta;
	}
	
	@RequestMapping("/actualizaDeposito")
	@ResponseBody
	public Respuesta actualizaDeposito(@RequestParam("idUsuario") int idUsuario, @RequestParam("idCuenta") int idCuenta, @RequestParam("cantidad") double cantidad){

		Respuesta objRespuesta = new Respuesta();
		
		// Obtener Saldo por Usuario
		ResponseEntity<List<Saldo>> responseEntity1 = restTemplate.exchange(URL_SALDO + "/porUsuario/" + idUsuario, HttpMethod.GET, null,new ParameterizedTypeReference<List<Saldo>>() {});
		List<Saldo> lstSaldo = responseEntity1.getBody();
		Saldo objSaldo = lstSaldo.get(0);
		
		// Calcular nuevo sueldo
		double nuevoSueldo = objSaldo.getSaldo() + cantidad;
		objSaldo.setSaldo(nuevoSueldo);
		
		// Obtener Cuenta Bancaria por Id
		ResponseEntity<CuentaBancaria> responseEntity2 = restTemplate.exchange(URL_CUENTA_BANCARIA +"/porId/"+ idCuenta, HttpMethod.GET, null, new ParameterizedTypeReference<CuentaBancaria>(){});
		CuentaBancaria objCuentaBancaria = responseEntity2.getBody();
		
		// Calcular nuevo monto
		double nuevoMonto = objCuentaBancaria.getMonto() - cantidad;
		objCuentaBancaria.setMonto(nuevoMonto);

		// Validar Cantidad
		if(cantidad > objCuentaBancaria.getMonto()) {
			objRespuesta.setMensaje("No tienes suficiente dinero en esta cuenta bancaria");
			return objRespuesta;
		}
		
		// Actualizar Saldo
		HttpEntity<Saldo> request1 = new HttpEntity<Saldo>(objSaldo);
		restTemplate.put(URL_SALDO, request1, Saldo.class);

		// Actualizar Monto
		HttpEntity<CuentaBancaria> request2 = new HttpEntity<CuentaBancaria>(objCuentaBancaria);
		restTemplate.put(URL_CUENTA_BANCARIA, request2, CuentaBancaria.class);
		
		// Registrar Movimiento
		Movimiento objMovimiento = new Movimiento();
		objMovimiento.setIdMovimiento(0);
		objMovimiento.setFechaMovimiento(new Date());
		objMovimiento.setIdUsuario(idUsuario);
		objMovimiento.setIdCuentaBancaria(1); //fk sin uso (postgres instead)
		objMovimiento.setMonto(cantidad);
		objMovimiento.setTipoMovimiento("Deposito");

		HttpEntity<Movimiento> request = new HttpEntity<Movimiento>(objMovimiento);
		restTemplate.postForObject(URL_MOVIMIENTO, request, Movimiento.class);
		
		ResponseEntity<List<Movimiento>> responseEntity = restTemplate.exchange(URL_MOVIMIENTO, HttpMethod.GET, null, new ParameterizedTypeReference<List<Movimiento>>(){});
		List<Movimiento> lstMovimiento = responseEntity.getBody();
		 
		objRespuesta.setDatos(lstMovimiento);
		objRespuesta.setMensaje("Movimiento exitoso");

		return objRespuesta;
	}
	
	@RequestMapping("/actualizaRetiro")
	@ResponseBody
	public Respuesta actualizaRetiro(@RequestParam("idUsuario") int idUsuario, @RequestParam("idCuenta") int idCuenta, @RequestParam("cantidad") double cantidad){

		Respuesta objRespuesta = new Respuesta();
		
		// Obtener Saldo por Usuario
		ResponseEntity<List<Saldo>> responseEntity1 = restTemplate.exchange(URL_SALDO + "/porUsuario/" + idUsuario, HttpMethod.GET, null,new ParameterizedTypeReference<List<Saldo>>() {});
		List<Saldo> lstSaldo = responseEntity1.getBody();
		Saldo objSaldo = lstSaldo.get(0);
		
		// Calcular nuevo sueldo
		double nuevoSueldo = objSaldo.getSaldo() - cantidad;
		objSaldo.setSaldo(nuevoSueldo);
		
		// Obtener Cuenta Bancaria por Id
		ResponseEntity<CuentaBancaria> responseEntity2 = restTemplate.exchange(URL_CUENTA_BANCARIA +"/porId/"+ idCuenta, HttpMethod.GET, null, new ParameterizedTypeReference<CuentaBancaria>(){});
		CuentaBancaria objCuentaBancaria = responseEntity2.getBody();
		
		// Calcular nuevo monto
		double nuevoMonto = objCuentaBancaria.getMonto() + cantidad;
		objCuentaBancaria.setMonto(nuevoMonto);

		// Validar Cantidad
		if(cantidad > objSaldo.getSaldo()) {
			objRespuesta.setMensaje("No tienes suficiente dinero en este usuario");
			return objRespuesta;
		}
		
		// Actualizar Saldo
		HttpEntity<Saldo> request1 = new HttpEntity<Saldo>(objSaldo);
		restTemplate.put(URL_SALDO, request1, Saldo.class);

		// Actualizar Monto
		HttpEntity<CuentaBancaria> request2 = new HttpEntity<CuentaBancaria>(objCuentaBancaria);
		restTemplate.put(URL_CUENTA_BANCARIA, request2, CuentaBancaria.class);
		
		// Registrar Movimiento
		Movimiento objMovimiento = new Movimiento();
		objMovimiento.setIdMovimiento(0);
		objMovimiento.setFechaMovimiento(new Date());
		objMovimiento.setIdUsuario(idUsuario);
		objMovimiento.setIdCuentaBancaria(1); //fk sin uso (postgres instead)
		objMovimiento.setMonto(cantidad);
		objMovimiento.setTipoMovimiento("Retiro");

		HttpEntity<Movimiento> request = new HttpEntity<Movimiento>(objMovimiento);
		restTemplate.postForObject(URL_MOVIMIENTO, request, Movimiento.class);
		
		ResponseEntity<List<Movimiento>> responseEntity = restTemplate.exchange(URL_MOVIMIENTO, HttpMethod.GET, null, new ParameterizedTypeReference<List<Movimiento>>(){});
		List<Movimiento> lstMovimiento = responseEntity.getBody();
		 
		objRespuesta.setDatos(lstMovimiento);
		objRespuesta.setMensaje("Movimiento exitoso");

		return objRespuesta;
	}

}
