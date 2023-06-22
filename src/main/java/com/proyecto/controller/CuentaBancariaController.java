package com.proyecto.controller;

import java.util.Date;
import java.util.List;

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

import com.proyecto.entity.Banco;
import com.proyecto.entity.CuentaBancaria;
import com.proyecto.entity.Respuesta;
import com.proyecto.entity.Usuario;

@Controller
public class CuentaBancariaController {

	@Autowired
	private RestTemplate restTemplate;
	
	String URL_BANCO= "http://localhost:8093/rest/banco"; //mongodb
	String URL_CUENTA_BANCARIA = "http://localhost:8091/rest/cuenta_bancaria"; //postgres
	
	String URL_SALDO = "http://localhost:8092/rest/saldo"; //mysql
	String URL_MOVIMIENTO = "http://localhost:8092/rest/movimiento";
	String URL_USUARIO = "http://localhost:8092/rest/usuario";
	String URL_ROL = "http://localhost:8092/rest/rol";
	
	@RequestMapping("/cargaUsuarioCuentaBancaria")
	@ResponseBody
	public List<Usuario> cargaUsuario() {

		ResponseEntity<List<Usuario>> responseEntity =
		restTemplate.exchange(URL_USUARIO, HttpMethod.GET, null,new ParameterizedTypeReference<List<Usuario>>() {});

		List<Usuario> lstCuenta = responseEntity.getBody();
		return lstCuenta;
	}
	
	@RequestMapping("/cargaBancoCuentaBancaria")
	@ResponseBody
	public List<Banco> cargaBanco() {

		ResponseEntity<List<Banco>> responseEntity =
		restTemplate.exchange(URL_BANCO, HttpMethod.GET, null,new ParameterizedTypeReference<List<Banco>>() {});

		List<Banco> lstCuenta = responseEntity.getBody();
		return lstCuenta;
	}
	
	
	@RequestMapping("/buscarUsuarioCuentaBancaria")
	@ResponseBody
	public List<Usuario> buscarUsuario(@RequestParam("id") String id) {

		ResponseEntity<List<Usuario>> responseEntity =
		restTemplate.exchange(URL_USUARIO + "/porId/" + id, HttpMethod.GET, null,new ParameterizedTypeReference<List<Usuario>>() {});

		List<Usuario> lstCuenta = responseEntity.getBody();
		//String nombre = lstCuenta.get(0).get
		return lstCuenta;
	}
	
	@RequestMapping("/buscarBancoCuentaBancaria")
	@ResponseBody
	public List<Banco> buscarBanco(@RequestParam("id") String id) {

		ResponseEntity<List<Banco>> responseEntity =
		restTemplate.exchange(URL_BANCO + "/porId/" + id, HttpMethod.GET, null,new ParameterizedTypeReference<List<Banco>>() {});

		List<Banco> lstCuenta = responseEntity.getBody();
		return lstCuenta;
	}

	@RequestMapping("/listaCrudCuentaBancaria")
	@ResponseBody
	public List<CuentaBancaria> consultaMovimiento() {

		ResponseEntity<List<CuentaBancaria>> responseEntity =
		restTemplate.exchange(URL_CUENTA_BANCARIA, HttpMethod.GET, null,new ParameterizedTypeReference<List<CuentaBancaria>>() {});

		List<CuentaBancaria> lstCuenta = responseEntity.getBody();
		return lstCuenta;
	}
	
	
	
	
	
	

	
	@RequestMapping("/registraCrudCuentaBancaria")
	@ResponseBody
	public Respuesta registra(CuentaBancaria objCuentaBancaria){
		objCuentaBancaria.setFechaRegistro(new Date());

		HttpEntity<CuentaBancaria> request = new HttpEntity<CuentaBancaria>(objCuentaBancaria);
		restTemplate.postForObject(URL_CUENTA_BANCARIA, request, CuentaBancaria.class);
		ResponseEntity<List<CuentaBancaria>> responseEntity = 	restTemplate.exchange(URL_CUENTA_BANCARIA, HttpMethod.GET, null, new ParameterizedTypeReference<List<CuentaBancaria>>(){});
		List<CuentaBancaria> lstCuentaBancaria = responseEntity.getBody();


		Respuesta objRespuesta = new Respuesta();
		objRespuesta.setDatos(lstCuentaBancaria);
		objRespuesta.setMensaje("Registro exitoso");
		return objRespuesta;
	}
	
	@RequestMapping("/eliminaFisicaCrudCuentaBancaria")
	@ResponseBody
	public Respuesta elimina(String id){
		restTemplate.delete(URL_CUENTA_BANCARIA + "/" + id);
		ResponseEntity<List<CuentaBancaria>> responseEntity = 	restTemplate.exchange(URL_CUENTA_BANCARIA, HttpMethod.GET, null, new ParameterizedTypeReference<List<CuentaBancaria>>(){});
		List<CuentaBancaria> lstCuentaBancaria = responseEntity.getBody();

		Respuesta objRespuesta = new Respuesta();
		objRespuesta.setDatos(lstCuentaBancaria);
		objRespuesta.setMensaje("Eliminación exitosa");
		return objRespuesta;
	}
	
	@RequestMapping("/actualizaCrudCuentaBancaria")
	@ResponseBody
	public Respuesta actualiza(CuentaBancaria objCuentaBancaria){
		ResponseEntity<CuentaBancaria> responseEntity1 = restTemplate.exchange(URL_CUENTA_BANCARIA +"/porId/"+ objCuentaBancaria.getIdCuenta(), HttpMethod.GET, null, new ParameterizedTypeReference<CuentaBancaria>(){});
		CuentaBancaria objActual = responseEntity1.getBody();
		
		//objActual.setNombre(objCuentaBancaria.getFechaRegistro());
		objActual.setIdUsuario(objCuentaBancaria.getIdUsuario());
		objActual.setIdBanco(objCuentaBancaria.getIdBanco());
		objActual.setMonto(objCuentaBancaria.getMonto());
		objActual.setNumeroCuenta(objCuentaBancaria.getNumeroCuenta());

		HttpEntity<CuentaBancaria> request = new HttpEntity<CuentaBancaria>(objActual);
		restTemplate.put(URL_CUENTA_BANCARIA, request, CuentaBancaria.class);
		
		ResponseEntity<List<CuentaBancaria>> responseEntity2 = 
		restTemplate.exchange(URL_CUENTA_BANCARIA, HttpMethod.GET, null, new ParameterizedTypeReference<List<CuentaBancaria>>(){});
		List<CuentaBancaria> lstCuentaBancaria = responseEntity2.getBody();

		Respuesta objRespuesta = new Respuesta();
		objRespuesta.setDatos(lstCuentaBancaria);
		objRespuesta.setMensaje("Actualización exitosa");

		return objRespuesta;
	}

}
