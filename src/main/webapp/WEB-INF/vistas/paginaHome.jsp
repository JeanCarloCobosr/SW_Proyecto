<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
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

<link rel="stylesheet" href="css/bootstrap.css"/>
<link rel="stylesheet" href="css/dataTables.bootstrap.min.css"/>
<link rel="stylesheet" href="css/bootstrapValidator.css"/>


<title>pagina</title>
</head>
<body>
       

<div class="container" style="margin-top: 8%; text-align: center;">
<h3>PAGINA PRINCIPAL</h3>
<br><br>
<h4>Bienvenido Sr(a): ${sessionScope.objUsuario.nombreCompleto}</h4><br>                
<h4>DNI: ${sessionScope.objUsuario.dni}</h4><br>        
<h4>Tu saldo es: ${sessionScope.objSaldo.saldo}</h4><br>
<h4>Rol: ${sessionScope.objRol.nombre}</h4>

</div>

<div class="container" >
<div class="col-md-12" align="center" style="width: 50px; height: 150px" > 
</div>
</div>

    		
</body>
</html>