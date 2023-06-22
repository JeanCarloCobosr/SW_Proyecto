package com.proyecto.controller;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.proyecto.entity.Banco;

@Controller
public class BancoController {
	

	String URL_BANCO= "http://localhost:8093/rest/banco"; //mongodb

	@Autowired
	private RestTemplate restTemplate;

	@RequestMapping("/listaBanco")
	@ResponseBody
	public List<Banco> listaBanco() {

		ResponseEntity<List<Banco>> responseEntity =
		restTemplate.exchange(URL_BANCO, HttpMethod.GET, null,new ParameterizedTypeReference<List<Banco>>() {});

		List<Banco> lstBanco = responseEntity.getBody();
		return lstBanco;
	}

	@RequestMapping("/consultaBancoPorNombre")
	@ResponseBody
	public List<Banco> consultaBancoPorNombre(@RequestParam("nombre_banco") String nombre) {

		ResponseEntity<List<Banco>> responseEntity =
		restTemplate.exchange(URL_BANCO + "/porNombre/" + nombre, HttpMethod.GET, null,new ParameterizedTypeReference<List<Banco>>() {});

		List<Banco> lstMovimiento = responseEntity.getBody();
		return lstMovimiento;
	}
}
