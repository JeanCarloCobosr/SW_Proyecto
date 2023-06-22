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

<title>pagina</title>
<style>
    #mensajeLabel {
        display: none;
    }
</style>

</head>
<body>
<div class="container" style="margin-top: 10%; text-align: center;"><h4>LISTA DE MOVIMIENTOS</h4></div>

<div class="container" style="margin-top: 1%">

    <!-- INICIO CONSULTA -->
    <div class="row" style="margin-top: 1%">
        <div class="col-md-1">
            <button type="button" class="btn btn-primary" id="id_btn_movimiento" data-toggle='modal' data-target="#id_div_modal_registra">Realizar Movimiento</button>
        </div>
    </div>

    <!-- FIN CONSULTA -->

        <!-- INICIO MODAL DE REALIZAR MOVIMIENTO -->
        <div class="modal fade" id="id_div_modal_registra" >
            <div class="modal-dialog" style="width: 60%">
                    <div class="modal-content">
                    <div class="modal-header" >
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4><span class="glyphicon glyphicon-ok-sign"></span>Registro de Revista</h4>
                    </div>
                    <div class="modal-body" >
                            <div class="panel-group" id="steps">
                                <div class="panel panel-default">
                                    <div id="stepOne" class="panel-collapse collapse in">
                                        <form id="id_form_registra">
                                        <div class="panel-body">
                                            <div class="form-group" >
                                                <label class="col-lg-3 control-label" for="id_reg_cantidad">Cantidad</label>
                                                <div class="col-lg-8">
                                                    <input class="form-control" id="id_reg_cantidad" name="cantidad" placeholder="Ingrese la Cantidad" type="text" maxlength="100"/>
                                                </div>
                                            </div> 	
                                            <div class="form-group">
                                                <label class="col-lg-3 control-label" for="id_reg_cuentaBancaria">Cuenta Bancaria</label>
                                                <div class="col-lg-8">
                                                    <select class="form-control" id="id_reg_cuentaBancaria" name="idCuenta">
                                                        <option value=" ">[Seleccione]</option>
                                                    </select>
                                                </div>
                                            </div> 	
                                            
                                            <div class="form-group">
                                                <label class="col-lg-3 control-label" for="id_reg_tipoMovimiento">Tipo de Movimiento</label>
                                                <div class="col-lg-8">
                                                    <select class="form-control" id="id_reg_tipoMovimiento" onchange="toggleMensajeLabel()">
                                                        <option value="option1">Deposito</option>
                                                        <option value="option2">Retiro</option>
                                                    </select>
                                                </div>
                                            </div> 	


                                            <label id="mensajeLabel" style="text-align: center;">Se descontara el dinero de tu saldo</label>


                                            <div class="form-group">
                                                <div class="col-lg-12" align="center">
                                                    <button type="button" style="width: 80px" id="id_btn_finalizar" class="btn btn-primary btn-sm">Finalizar</button>
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
        <!-- FIN MODAL DE REALIZAR MOVIMIENTO -->

    <div class="row" style="margin-top: 2%">
        <table id="id_table" class="table table-bordered table-hover table-condensed" >
            <thead style='background-color:#337ab7; color:white'>
                <tr>
                    <th>ID</th>
                    <th>Fecha de Movimiento</th>
                    <th>Monto</th>
                    <th>Tipo de Movimiento</th>
                </tr>
            </thead>
            <tbody>
                <!-- . -->
            </tbody>
        </table>
    </div>
	
</div>

<!-- JAVASCRIPT -->
<script type="text/javascript">
var paginaIndex = 0;

// SESION USUARIO
var idUsuario = "${sessionScope.objUsuario.idUsuario}";

// LISTAR MOVIMIENTOS
$.getJSON("consultaMovimiento", {"idUsuario":idUsuario}, function(data) {
    agregarGrilla(data);
});

// CARGAR CUENTAS BANCARIAS
$.getJSON("cargaCuentaBancariaUsuario", {"idUsuario":idUsuario}, function (data){
    $.each(data, function(index, item){
        $("#id_reg_cuentaBancaria").append("<option value='"+ item.idCuenta +"'>"+ item.numeroCuenta+"</option>");
    })
});

// FUNCION MOSTRAR MENSAJE LABEL POR OPCION
function toggleMensajeLabel() {
    var tipoMovimiento =  $("#id_reg_tipoMovimiento").val();
    var mensajeLabel = document.getElementById("mensajeLabel");

    if (tipoMovimiento === "option1") {
        mensajeLabel.style.display = "none";
    } else if (tipoMovimiento === "option2") {
        mensajeLabel.style.display = "block";
    }
}

// BOTON FINALIZAR
$("#id_btn_finalizar").click(function() {
    var cantidad =  $("#id_reg_cantidad").val();
    var idCuentaBancaria =  $("#id_reg_cuentaBancaria").val();
    var tipoMovimiento =  $("#id_reg_tipoMovimiento").val();
    var saldo = "${sessionScope.objSaldo.saldo}"
    var url_controller = "actualizaDeposito"

    if (tipoMovimiento === "option1") { //deposito
        //${sessionScope.objSaldo.saldo} = 1;
        url_controller = "actualizaDeposito"
    } else if (tipoMovimiento === "option2") { //retiro
        url_controller = "actualizaRetiro"
    }


    // Actulizar Saldo y Cuenta + Registrar Movimiento
    var validator = $('#id_form_registra').data('bootstrapValidator');
    validator.validate();

    if (validator.isValid()) {
        $.ajax({
                type: "POST",
                url: url_controller,
                data:{
                    idUsuario: idUsuario,
                    idCuenta: idCuentaBancaria,
                    cantidad: cantidad
                },
                success: function(data){
                    paginaIndex = $('#id_table').DataTable().page();
                    agregarGrilla(data.datos);
                    mostrarMensaje(data.mensaje);
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

// BOTON CANCELAR
$("#id_btn_reg_cancelar").click(function() {
    var validator = $('#id_form_registra').data('bootstrapValidator');
    validator.resetForm();
    limpiarFormulario();
});

// AGREGAR TABLA
function agregarGrilla(lista){
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
            info:true,
            scrollY: 305,
            scroller: {
                loadingIndicator: true
            },
            columns:[
                {data: "idMovimiento",className:'text-center'},
                {data: "fechaMovimiento",className:'text-center'},
                {data: "monto",className:'text-center'},
                {data: "tipoMovimiento",className:'text-center'},
            ]                                     
        });
    // Restaurar index de pagina cuando termine de llenarse
    $('#id_table').DataTable().one('draw.dt', function () {
        $('#id_table').DataTable().page(paginaIndex).draw('page');
      });
}

// LIMPIAR
function limpiarFormulario(){	
    $('#id_reg_cantidad').val("");
    $('#id_reg_cuentaBancaria').val(" ");
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
            cantidad : {  
                selector: "#id_reg_cantidad",
                validators : {
                    notEmpty: {
                        message: 'La cantidad es requerida'
                    },
                    regexp: {
                        regexp: /^[0-9]{1,}$/,
                        message: 'Ingresar al menos un numero'
                    },
                }
            },
            fechaCreacion : {  
                selector: "#id_reg_cuentaBancaria",
                validators : {
                    notEmpty: {
                        message: 'La cuenta bancaria es requerida'
                    },
                }
            },
        }
    });
});

</script>  		
</body>
</html>