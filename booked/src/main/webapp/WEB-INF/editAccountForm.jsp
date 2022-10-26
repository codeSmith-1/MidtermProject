<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${user}</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
<jsp:include page="navBar.jsp" />

	<h3>Edit Account Details for ${user.firstName}</h3>
	<form action="editAccount.do?id=${user.id}" method="POST">
		<label for="validationDefault02" class="form-label">First Name</label>
		<input type="text" name="firstName" value="${user.firstName}"/>
		<label for="validationDefault02" class="form-label">Last name</label>
		<input type="text" name="lastName" value="${user.lastName}"/>
		<label for="validationDefault02" class="form-label">Street</label>
		<input type="text" name="address.street" value="${user.address.street}"/>
		<label for="validationDefault02" class="form-label">Apt or Suite</label>
		<input type="text" name="address.street2" value="${user.address.street2}"/>
		<label for="validationDefault02" class="form-label">City</label>
		<input type="text" name="address.city" value="${user.address.city}"/>
		<label for="validationDefault02" class="form-label">State</label>
		<input type="text" name="address.state" value="${user.address.state}"/>
		<label for="validationDefault02" class="form-label">Zip Code</label>
		<input type="text" name="address.zipcode" value="${user.address.zipcode}"/>
		<label for="validationDefault02" class="form-label">User Name</label>
		<input type="text" name="username" value="${user.username}"/>
		<label for="validationDefault02" class="form-label">Email</label>
		<input type="text" name="email" value="${user.email}"/>
		<%-- <label for="validationDefault02" class="form-label">Currently Reading</label>
		<input type="text" name="email" value="${user.reading}"/> --%>
		
		<input type="submit" value="Submit"/>
	</form>

	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>