package com.proyecto.entity;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CuentaBancaria {

	private int idCuenta;
	private Date fechaRegistro;
	
	private int idUsuario;
	private int idBanco;
	
	private double monto;
	private String numeroCuenta;

}
