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

	<form action="login.do">
		<input type="text" name="username"> <input type="password"
			name="password" /> <input type="submit" value="Log In">
	</form>
		<c:choose>
			<c:when test="${bothIncorrect}">
				<p>Invalid username <strong>AND</strong> password.</p>
			</c:when>
			<c:when test="${usernameIncorrect}">
				<p>Invalid username.</p>
			</c:when>
			<c:when test="${passwordIncorrect}">
				<p>Invalid password.</p>
			</c:when>
		</c:choose>
</body>
</html>