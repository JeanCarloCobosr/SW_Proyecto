package com.proyecto.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class EnlaceController {

	// Global
	@RequestMapping("/")
	public String verLogin() {	return "paginaLogin";  }
	
	@RequestMapping("/verPaginaHome")
	public String verPaginaHome() {	return "paginaHome";  }
	
	@RequestMapping("/verMovimientos")
	public String verPaginaMovimientos() {	return "paginaMovimientos";  }

	// Admin
	@RequestMapping("/verConsultaBanco")
	public String verConsultaBanco() {	return "paginaConsultaBanco";	}
	
	@RequestMapping("/verCrudCuentaBancaria")
	public String verCrudCuentaBancaria() {	return "paginaCrudCuentaBancaria";	}
	
}