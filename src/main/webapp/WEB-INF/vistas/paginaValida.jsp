<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<c:if test="${sessionScope.objUsuario == null}">
	<c:set var="mensaje" value="Debe autenticarse para ingresar al sistema" scope="request"/>
	<jsp:forward page="/WEB-INF/vistas/paginaLogin.jsp" />
</c:if>

<c:choose>
	<c:when test="${sessionScope.objRol.nombre == 'ROLE_ADMIN'}">
		<jsp:include page="paginaCabeceraAdmin.jsp" />
	</c:when>
	<c:otherwise>
		<jsp:include page="paginaCabecera.jsp" />
	</c:otherwise>
</c:choose>