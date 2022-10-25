<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Change Password</title><jsp:include page="bootstrapHead.jsp" />
</head>
<body>
	<jsp:include page="navBar.jsp" />
	
	<form action="updatePassword.do?id=${user.id}" method="POST">
		<input type="text" name="username" />
		<input type="text" name="password" />
		<input type="text" name="newPassword"/>
		<input type="submit" value="Submit"/>
	</form>
	
	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>