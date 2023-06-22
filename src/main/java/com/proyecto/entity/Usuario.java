package com.proyecto.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Usuario {
	
	private int idUsuario;
	private String apellidos;
	private String direccion;
	private String dni;
	private String email;
	private String email_recuperacion;
	private int estado;

	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd hh:mm:ss")
	private Date fechaIngreso;

	private String nombres;
	private String password;
	private String telefono;
	private String ubigeo;
	private String nombreCompleto;
	
}
