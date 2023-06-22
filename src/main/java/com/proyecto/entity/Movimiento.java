package com.proyecto.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Movimiento {

	private int idMovimiento;
	private Date fechaMovimiento;
	private int idUsuario;
	private int idCuentaBancaria;
	private double monto;
	private String tipoMovimiento;
	
}
