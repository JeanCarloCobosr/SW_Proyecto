<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

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

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrapValidator.js"></script>

<link rel="stylesheet" href="css/form-elements.css">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/bootstrapValidator.css">

<title>pagina</title>
</head>   
<body>    


        <div class="top-content">
            <div class="inner-bg">
                <div class="container">
                	<c:if test="${requestScope.mensaje != null}">
               		<div class="alert alert-danger fade in" id="success-alert">
				        <a href="#" class="close" data-dismiss="alert">&times;</a>
				        <strong>${requestScope.mensaje}</strong>
				    </div>
				    </c:if>
                    <div class="row">
                        <div class="col-sm-6 col-sm-offset-3 form-box">
                        	<div class="form-top">
                        		<div class="form-top-left">
                        			<h3>Ingreso al Sistema de pagina</h3>
                            		<p>Ingrese su Usuario y Contrasena:</p>
                        		</div>
                            </div>
                            <div class="form-bottom">
			                    <form id="id_form"  action="login" method="post" class="login-form">
			                    	<div class="form-group">
			                    		<label class="sr-only" for="form-username">Usuario</label>
			                        	<input type="text" name="filtro" placeholder="Ingrese Usuario" class="form-username form-control" id="filtro" maxlength="20" value="admin@email.com">
			                        </div>
			                        <div class="form-group">
			                        	<label class="sr-only" for="form-password">Contrasena</label>
			                        	<input type="password" name="pw" placeholder="Ingrese Contrasena" class="form-password form-control" id="pw" maxlength="20" value="admin">
			                        </div>
			                        <button type="submit" class="btn btn-primary" id="id_btn_filtro">Ingresar</button>
			                    </form>
		                    </div>
                        </div>   
                    </div>
                    
                </div>
            </div>
            
        </div>



<!-- JAVASCRIPT -->
<script type="text/javascript">
$("#success-alert").fadeTo(1000, 500).slideUp(500, function(){
    $("#success-alert").slideUp(500);
});
</script>

<!-- JAVASCRIPT -->
<script type="text/javascript">

$(document).ready(function() {
    $('#id_form').bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	dni: {
                validators: {
                    notEmpty: {
                        message: 'El usuario es obligatorio'
                    },
                    stringLength :{
                    	message: 'El usuario es de 2 a 20 caracteres',
                    	min : 2,
                    	max : 20
                    }
                }
            },
            password: {
                validators: {
                    notEmpty: {
                        message: 'La contrasena es obligatoria'
                    },
                    stringLength :{
                    	message: 'La contrasena es de 2 a 20 caracteres',
                    	min : 2,
                    	max : 20
                    }
                }
            }
        }   
    });

    $('#validateBtn').click(function() {
        $('#id_form').bootstrapValidator('validate');
    });
});
</script>

</body>
</html>