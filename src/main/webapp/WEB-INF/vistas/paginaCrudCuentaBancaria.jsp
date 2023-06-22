<jsp:include page="paginaValida.jsp" />
<!DOCTYPE html>
<html lang="esS" >
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Expires" content="-1" />
<meta http-equiv="Cache-Control" content="private" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />

<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="js/dataTables.bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrapValidator.js"></script>
<script type="text/javascript" src="js/global.js"></script>

<link rel="stylesheet" href="css/bootstrap.css"/>
<link rel="stylesheet" href="css/dataTables.bootstrap.min.css"/>
<link rel="stylesheet" href="css/bootstrapValidator.css"/>

<title>Pagina</title>
</head>
<body>
<div class="container" style="margin-top: 10%; text-align: center;"><h4>CRUD CUENTA BANCARIA</h4></div>

<div class="container" style="margin-top: 1%">

    <!-- INICIO CONSULTA -->
    <div class="row" style="margin-top: 1%">
        <div class="col-md-1">
            <button type="button" class="btn btn-primary" data-toggle='modal' data-target="#id_div_modal_registra">Registrar Cuenta Bancaria</button>
        </div>	
    </div>

    <!-- FIN CONSULTA -->

    <div class="row" style="margin-top: 4%">
        <table id="id_table" class="table table-bordered table-hover table-condensed" >
            <thead style='background-color:#337ab7; color:white'>
                <tr>
                    <th>Id</th>
                    <th>Fecha de Registro</th>
                    <th>Usuario</th>
                    <th>Banco</th>
                    <th>Monto</th>
                    <th>Numero de Cuenta</th>
                    <th></th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <!-- . -->
            </tbody>
        </table>
    </div>

    <!-- INICIO MODAL DE REGISTRO -->
    <div class="modal fade" id="id_div_modal_registra" >
        <div class="modal-dialog" style="width: 60%">
                <div class="modal-content">
                <div class="modal-header" >
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4><span class="glyphicon glyphicon-ok-sign"></span>Registro de Banco</h4>
                </div>
                <div class="modal-body" >
                        <div class="panel-group" id="steps">
                            <div class="panel panel-default">
                                <div id="stepOne" class="panel-collapse collapse in">
                                    <form id="id_form_registra">
                                    <div class="panel-body">


                                        <div class="form-group">
                                            <label class="col-lg-3 control-label" for="id_reg_usuario">Usuario</label>
                                            <div class="col-lg-8">
                                                <select class="form-control" id="id_reg_usuario" name="idUsuario">
                                                    <option value=" ">[Seleccione]</option>
                                                </select>
                                            </div>
                                        </div> 	
                                        <div class="form-group">
                                            <label class="col-lg-3 control-label" for="id_reg_banco">Banco</label>
                                            <div class="col-lg-8">
                                                <select class="form-control" id="id_reg_banco" name="idBanco">
                                                    <option value=" ">[Seleccione]</option>
                                                </select>
                                            </div>
                                        </div> 	

                                        <div class="form-group">
                                            <label class="col-lg-3 control-label" for="id_reg_monto">Monto</label>
                                            <div class="col-lg-8">
                                                <input class="form-control" id="id_reg_monto" name="monto" placeholder="Ingresa Monto" type="text" maxlength="20"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-lg-3 control-label" for="id_reg_numeroCuenta">Numero de Cuenta</label>
                                            <div class="col-lg-8">
                                                <input class="form-control" id="id_reg_numeroCuenta" name="numeroCuenta" placeholder="Ingrese Numero de Cuenta" type="text" maxlength="20"/>
                                            </div>
                                        </div>
                                         	 
                                        <div class="form-group">
                                            <div class="col-lg-12" align="center">
                                                <button type="button" style="width: 80px" id="id_btn_registra" class="btn btn-primary btn-sm">Registra</button>
                                                <button type="button" style="width: 80px" id="id_btn_reg_cancelar" class="btn btn-primary btn-sm" data-dismiss="modal">Cancela</button>
                                            </div>
                                        </div>   
                                        </div>

                                        </form>
                                </div>
                            </div>
                        </div>
                </div>
            </div>
        </div>
    </div>	 
    <!-- FIN MODAL DE REGISTRO -->

    <!-- INICIO MODAL DE ACTUALIZA -->
    <div class="modal fade" id="id_div_modal_actualiza" >
        <div class="modal-dialog" style="width: 60%">
                <div class="modal-content">
                <div class="modal-header" >
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4><span class="glyphicon glyphicon-ok-sign"></span> Actualizar Revista</h4>
                </div>
                <div class="modal-body" >
                        <div class="panel-group" id="steps">
                            <div class="panel panel-default">
                                <div id="stepOne" class="panel-collapse collapse in">
                                    <form id="id_form_actualiza">
                                    <input type="hidden" name="idCuenta" id="idCuenta">
                                    <div class="panel-body">


                                        <div class="form-group">
                                            <label class="col-lg-3 control-label" for="id_act_usuario">Usuario</label>
                                            <div class="col-lg-8">
                                                <select class="form-control" id="id_act_usuario" name="idUsuario">
                                                    <option value=" ">[Seleccione]</option>
                                                </select>
                                            </div>
                                        </div> 	
                                        <div class="form-group">
                                            <label class="col-lg-3 control-label" for="id_act_banco">Banco</label>
                                            <div class="col-lg-8">
                                                <select class="form-control" id="id_act_banco" name="idBanco">
                                                    <option value=" ">[Seleccione]</option>
                                                </select>
                                            </div>
                                        </div> 	

                                        <div class="form-group">
                                            <label class="col-lg-3 control-label" for="id_act_monto">Monto</label>
                                            <div class="col-lg-8">
                                                <input class="form-control" id="id_act_monto" name="monto" placeholder="Ingresa Monto" type="text" maxlength="20"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-lg-3 control-label" for="id_act_numeroCuenta">Numero de Cuenta</label>
                                            <div class="col-lg-8">
                                                <input class="form-control" id="id_act_numeroCuenta" name="numeroCuenta" placeholder="Ingrese Numero de Cuenta" type="text" maxlength="20"/>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <div class="col-lg-12" align="center">
                                                <button type="button" style="width: 80px" id="id_btn_actualiza" class="btn btn-primary btn-sm">Actualizar</button>
                                                <button type="button" style="width: 80px" id="id_btn_act_cancelar" class="btn btn-primary btn-sm" data-dismiss="modal">Cancela</button>
                                            </div>
                                        </div>   
                                        </div>
                                        </form>
                                </div>
                            </div>
                        </div>
                </div>
            </div>
        </div>
    </div>	
    <!-- FIN MODAL DE ACTUALIZA -->

	
</div>

<!-- JAVASCRIPT -->
<script type="text/javascript">
var paginaIndex = 0;


// LISTAR CUENTAS
$.getJSON("listaCrudCuentaBancaria", function(data) {
        agregarGrilla(data);
    });


// AGREGAR TABLA
function agregarGrilla(lista) {
    var usuarios = [];
    var bancos = [];

    // Bucle por cada item en lista
    lista.forEach(function(item) {
        // Crear usuario por cada item para obtener el nombre completo
        var usuario = $.ajax({
            url: '/buscarUsuarioCuentaBancaria?id=' + item.idUsuario,
            method: 'GET'
        }).done(function(response) {
            // Actualizar idUsuario con el email
            item.idUsuario = response[0].email;
        });

        usuarios.push(usuario);
    });
    
    lista.forEach(function(item) {
        var banco = $.ajax({
            url: '/buscarBancoCuentaBancaria?id=' + item.idBanco,
            method: 'GET'
        }).done(function(response) {
            item.idBanco = response[0].nombre_banco;
        });

        bancos.push(banco);
    });

    // Wait for all the usuarios to resolve
    Promise.all([Promise.all(usuarios), Promise.all(bancos)]).then(function() {
        $('#id_table').DataTable().clear();
        $('#id_table').DataTable().destroy();
        $('#id_table').DataTable({
            data: lista,
            language: {
                url: '//cdn.datatables.net/plug-ins/1.13.4/i18n/es-ES.json',
            },
            searching: true,
            ordering: true,
            processing: true,
            pageLength: 10,
            lengthChange: false,
            info: true,
            scrollY: 305,
            scroller: {
                loadingIndicator: true
            },
            columns: [
                {data: "idCuenta",className:'text-center'},
                {data: "fechaRegistro",className:'text-center'},
                {data: "idUsuario",className:'text-center'},
                {data: "idBanco",className:'text-center'},
                {data: "monto",className:'text-center'},
                {data: "numeroCuenta",className:'text-center'},
                {data: function(row, type, val, meta){
                    return '<button type="button" class="btn btn-info btn-sm" onClick="verFormularioActualiza(\'' + row.idCuenta + '\',\'' + 2 + '\',\'' + 2 + '\',\'' + row.monto + '\',\'' + row.numeroCuenta + '\');">Editar</button>';  
                },className:'text-center'},
                {data: function(row, type, val, meta){
                    return '<button type="button" class="btn btn-danger btn-sm"  onClick="eliminacionFisica(\'' + row.idCuenta +'\');" >Eliminar</button>';
                },className:'text-center'},
            ]
        });
    });
}

// CARGAR
$.getJSON("cargaUsuarioCuentaBancaria",{}, function (data){
    $.each(data, function(index, item){
        $("#id_reg_usuario").append("<option value='"+ item.idUsuario +"'>"+ item.email+"</option>");
        $("#id_act_usuario").append("<option value='"+ item.idUsuario +"'>"+ item.email+"</option>");
    })
});

$.getJSON("cargaBancoCuentaBancaria",{}, function (data){
    $.each(data, function(index, item){
        $("#id_reg_banco").append("<option value='"+ item.id_banco +"'>"+ item.nombre_banco+"</option>");
        $("#id_act_banco").append("<option value='"+ item.id_banco +"'>"+ item.nombre_banco+"</option>");
    })
});


// FORMULARIO ACTUALIZAR
function verFormularioActualiza(idCuenta, idUsuario, idBanco, monto, numeroCuenta){
    debugger;

    console.log(">> verFormularioActualiza >> " + idCuenta);
    $("#id_div_modal_actualiza").modal("show");
    $("#idCuenta").val(idCuenta);
    $("#id_act_usuario").val(idUsuario);
    $("#id_act_banco").val(idBanco);
    $("#id_act_monto").val(monto);
    $("#id_act_numeroCuenta").val(numeroCuenta);
}


// VALIDACIONES
$(document).ready(function() {
$('#id_form_registra').bootstrapValidator({
    message: 'This value is not valid',
    feedbackIcons: {
        valid: 'glyphicon glyphicon-ok',
        invalid: 'glyphicon glyphicon-remove',
        validating: 'glyphicon glyphicon-refresh'
    },
    
    fields:{
        usuario : {  
            selector: "#id_reg_usuario",
            validators : {
                notEmpty: {
                    message: 'El usuario es requerido'
                },
            }
        },
        banco : {
            selector: "#id_reg_banco",
            validators : {
                notEmpty: {
                    message: 'El banco es requerido'
                },
            }
        },
    
        monto : {  
            selector: "#id_reg_monto",
            validators : {
                notEmpty: {
                    message: 'La fecha de creacion es requerida'
                },
                regexp: {
                        regexp: /^[0-9]{1,}$/,
                        message: 'Ingresar al menos un numero'
                },
            }
        },
        numeroCuenta : {  
            selector: "#id_reg_numeroCuenta",
            validators : {
                notEmpty: {
                    message: 'El estado requerido'
                },
                regexp: {
                        regexp: /^[0-9]{1,}$/,
                        message: 'Ingresar al menos un numero'
                },
            }
        },
    }
});
});

$(document).ready(function() {
$('#id_form_actualiza').bootstrapValidator({
    message: 'This value is not valid',
    feedbackIcons: {
        valid: 'glyphicon glyphicon-ok',
        invalid: 'glyphicon glyphicon-remove',
        validating: 'glyphicon glyphicon-refresh'
    },
    
    fields:{
        usuario : {  
            selector: "#id_act_usuario",
            validators : {
                notEmpty: {
                    message: 'El usuario es requerido'
                },
            }
        },
        banco : {
            selector: "#id_act_banco",
            validators : {
                notEmpty: {
                    message: 'El banco es requerido'
                },
            }
        },
    
        monto : {  
            selector: "#id_act_monto",
            validators : {
                notEmpty: {
                    message: 'La fecha de creacion es requerida'
                },
                regexp: {
                        regexp: /^[0-9]{1,}$/,
                        message: 'Ingresar al menos un numero'
                },
            }
        },
        numeroCuenta : {  
            selector: "#id_act_numeroCuenta",
            validators : {
                notEmpty: {
                    message: 'El estado requerido'
                },
                regexp: {
                        regexp: /^[0-9]{1,}$/,
                        message: 'Ingresar al menos un numero'
                },
            }
        },
    }
});
});	




// FUNCION REGISTRAR
$("#id_btn_registra").click(function() {
    var validator = $('#id_form_registra').data('bootstrapValidator');
    validator.validate();

    /* TEST creando hidden input con valor de la opcion seleccionada y agregarlo a la lista serializada
    var selectedValue = $('#id_reg_usuario').val();
    var hiddenInput = $('<input>').attr({
    type: 'hidden',
    name: 'idUsuario',
    value: selectedValue
    });
    $('#id_form_registra').append(hiddenInput);
    var newSerialized = $('#id_form_registra').serialize();
    */

    if (validator.isValid()) {
        $.ajax({
                type: "POST",
                url: "registraCrudCuentaBancaria", 
                data: $('#id_form_registra').serialize(),
                success: function(data){
                    paginaIndex = $('#id_table').DataTable().page();
                    agregarGrilla(data.datos);
                    limpiarFormulario();
                    validator.resetForm();
                    $('#id_div_modal_registra').modal("hide");
                },
                error: function(){
                    mostrarMensaje(MSG_ERROR);
                }
        });
    }
});

// FUNCION ACTUALIZAR
$("#id_btn_actualiza").click(function() {
    var validator = $('#id_form_actualiza').data('bootstrapValidator');
    validator.validate();

    if (validator.isValid()) {

        $.ajax({
                type: "POST",
                url: "actualizaCrudCuentaBancaria",
                data: $('#id_form_actualiza').serialize(),
                success: function(data){
                    paginaIndex = $('#id_table').DataTable().page();
                    mostrarMensaje(data.mensaje);
                    agregarGrilla(data.datos);
                    validator.resetForm();
                    $('#id_div_modal_actualiza').modal("hide");
                },
                error: function(){
                    mostrarMensaje(MSG_ERROR);
                }
        });
    }
});

// FUNCION ELIMINAR
function eliminacionFisica(idCuenta){	
    var array = [idCuenta];
    mostrarMensajeConfirmacion(MSG_ELIMINAR, accionEliminacionFisica,null,array);
}

function accionEliminacionFisica(arreglo){
    $.ajax({
        type: "POST",
        url: "eliminaFisicaCrudCuentaBancaria", 
        data: { "id":arreglo[0]},
        success: function(data){
            paginaIndex = $('#id_table').DataTable().page();
            mostrarMensaje(data.mensaje);
            agregarGrilla(data.datos);
        },
        error: function(){
            mostrarMensaje(MSG_ERROR);
        }
    });
}


// FUNCION CANCELAR REGISTRAR
$("#id_btn_reg_cancelar").click(function() {
    var validator = $('#id_form_registra').data('bootstrapValidator');
    validator.resetForm();
    limpiarFormulario();
});

// FUNCION CANCELAR ACTUALIZAR
$("#id_btn_act_cancelar").click(function() {
    var validator = $('#id_form_actualiza').data('bootstrapValidator');
    validator.resetForm();
    limpiarFormulario();
});

function limpiarFormulario(){	
            $('#id_reg_usuario').val(" ");
            $('#id_reg_banco').val(" ");
            $('#id_reg_monto').val("");
			$('#id_reg_numeroCuenta').val("");
            $('#id_act_usuario').val(" ");
            $('#id_act_banco').val(" ");
            $('#id_act_monto').val("");
			$('#id_act_numeroCuenta').val("");
}

</script>  		
</body>
</html>