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
<div class="container" style="margin-top: 10%; text-align: center;"><h4>CRUD BANCO</h4></div>

<div class="container" style="margin-top: 1%">

    <!-- INICIO CONSULTA -->
    <div class="row" style="margin-top: 1%">
        <div class="col-md-3">
            <label class="control-label" for="id_filtro">Nombre de Banco</label> 
        </div>	
        <div class="col-md-6">
            <input	class="form-control" type="text" id="id_filtro" name="nombre" placeholder="Ingrese el banco">
        </div>	
        <div class="col-md-1">
            <button type="button" class="btn btn-primary" id="id_btn_filtro">Filtra</button>
        </div>	
    </div>

    <!-- FIN CONSULTA -->

    <div class="row" style="margin-top: 4%">
        <table id="id_table" class="table table-bordered table-hover table-condensed" >
            <thead style='background-color:#337ab7; color:white'>
                <tr>
                    <th>Id</th>
                    <th>Nombre</th>
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

// BOTON FILTRAR
$("#id_btn_filtro").click(function() {
    var nombre_banco = $("#id_filtro").val();

    if (nombre_banco === "")
    {
        $.getJSON("listaBanco", function(data) {
            agregarGrilla(data);
        });
    } 
    else
    {
        $.getJSON("consultaBancoPorNombre", {"nombre_banco":nombre_banco}, function(data) {
            agregarGrilla(data);
        });
    }

});

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
                {data: "id_banco",className:'text-center'},
                {data: "nombre_banco",className:'text-center'},
            ]                                     
        });
    // Restaurar index de pagina cuando termine de llenarse
    $('#id_table').DataTable().one('draw.dt', function () {
        $('#id_table').DataTable().page(paginaIndex).draw('page');
      });
}




function verFormularioActualiza(id_banco, nombre_banco){
    debugger;

    console.log(">> verFormularioActualiza >> " + id_banco);
    $("#id_div_modal_actualiza").modal("show");
    $("#id_banco").val(id_banco);
    $("#id_act_nombre").val(nombre_banco);
}

$(document).ready(function() {
$('#id_form_registra').bootstrapValidator({
    message: 'This value is not valid',
    feedbackIcons: {
        valid: 'glyphicon glyphicon-ok',
        invalid: 'glyphicon glyphicon-remove',
        validating: 'glyphicon glyphicon-refresh'
    },
    
    fields:{
        nombre : {  
            selector: "#id_reg_nombre",
            validators : {
                notEmpty: {
                    message: 'El nombre es requerido'
                },
                stringLength: {
                    min: 3,
                    max: 30,
                    message: 'El Nombre tiene de 3 a 30 caracteres'
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
        nombre : {  
            selector: "#id_act_nombre",
            validators : {
                notEmpty: {
                    message: 'El nombre es requerido'
                },
                stringLength: {
                    min: 2,
                    max: 30,
                    message: 'El nombre tiene de 2 a 30 caracteres'
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

    if (validator.isValid()) {
        $.ajax({
                type: "POST",
                url: "registraCrudBanco", 
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
                url: "actualizaCrudBanco",
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



// ELIMINAR FISICA
function eliminacionFisica(idBanco){	
    var array = [idBanco];
    mostrarMensajeConfirmacion(MSG_ELIMINAR, accionEliminacionFisica,null,array);
}

function accionEliminacionFisica(array){
    $.ajax({
        type: "POST",
        url: "eliminaFisicaCrudBanco", 
        data: { "id_banco":array[0]},
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
});

function limpiarFormulario(){	
            $('#id_reg_nombre').val("");
			$('#id_reg_frecuencia').val("");
			$('#id_reg_fechaCreacion').val("");
            $('#id_reg_modalidad').val(" ");
            $('#id_reg_pais').val(" ");
}

</script>  		
</body>
</html>