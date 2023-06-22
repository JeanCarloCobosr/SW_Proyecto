package com.proyecto.entity;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UsuarioHasRol {

	private UsuarioHasRolPK usuarioHasRolPk;
	private Usuario usuario;
	private Rol rol;

}
