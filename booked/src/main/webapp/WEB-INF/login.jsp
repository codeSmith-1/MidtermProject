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
<div class="logo">
<p>booked</p>
</div>
<div class="login">
		<h2>LOGIN</h2>
		
		<form action="login.do" method="POST">
		<input type="text" placeholder="User Name" name="username">
		<br><input placeholder="Password" type="password" name="password" />
		<br><button class="btn btn-secondary" type="submit">Log In</button>
		</form>
		<form action="createAccount.do" method="GET">
		<br><button class="btn btn-secondary" type="submit">Create Account</button>
		</form>
		<form action="library.do" method="GET">
		<br><button class="btn btn-secondary" type="submit">Browse</button>
		</form>
		
		<c:choose>
			<c:when test="${invalid == true}">
				<p>Invalid User Name or Password</p>
			</c:when>
		</c:choose>
		<c:choose>
			<c:when test="${inactive == true}">
				<p>Account Successfully Removed</p>
			</c:when>
		</c:choose>
		
</div>
	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>