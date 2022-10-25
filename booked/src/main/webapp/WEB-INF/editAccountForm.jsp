<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${user}</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
<jsp:include page="navBar.jsp" />
	<form action="editAccount.do?id=${user.id}" method="POST">
		<input type="text" name="firstName" value="${user.firstName}"/>
		<input type="text" name="lastName" value="${user.lastName}"/>
		<input type="text" name="address.street" value="${user.address.street}"/>
		<input type="text" name="address.street2" value="${user.address.street2}"/>
		<input type="text" name="address.city" value="${user.address.city}"/>
		<input type="text" name="address.state" value="${user.address.state}"/>
		<input type="text" name="address.zipcode" value="${user.address.zipcode}"/>
		<input type="text" name="username" value="${user.username}"/>
		<input type="submit" value="Submit"/>
	</form>
	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>