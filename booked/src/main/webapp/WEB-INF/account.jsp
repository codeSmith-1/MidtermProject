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
	<div class="container">
		<h2>Hey ${user.firstName }</h2>
		<div class="dropdown">
			<button class="btn btn-secondary dropdown-toggle" type="button"
				data-bs-toggle="dropdown" aria-expanded="false">Account Options</button>
			<ul class="dropdown-menu">
				<li><a class="dropdown-item" href="editAccountForm.do?id=${user.id}">Update Account</a></li>
				<li><a class="dropdown-item" href="updatePassword.do">Change Password</a></li>
			</ul>
		</div>



	</div>
	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>