<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>booked</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
	<jsp:include page="navBar.jsp" />


	<h2>LOGIN</h2>

	<form action="login.do" method="POST">
		<input type="text" placeholder="Unique User Name" name="username">
		<input placeholder="Password" type="password" name="password" /> <input
			type="submit" value="Log In">
	</form>
	<form action="createAccount.do" method="GET">
		<input type="submit" value="Create Account">
	</form>
	<c:choose>
		<c:when test="${invalid == true}">
			<p>Invalid User Name or Password</p>
		</c:when>
	</c:choose>

	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>