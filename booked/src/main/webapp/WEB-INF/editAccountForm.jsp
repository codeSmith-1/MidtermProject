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
	<div class="container">
		<h3>Edit Account Details for ${user.firstName}</h3>
		<form action="editAccount.do?id=${user.id}" method="POST">
			<div class="row justify-content-center">
				<div class="col">
			<label for="validationDefault02" class="form-label">First Name</label>
				<input type="text" name="firstName" value="${user.firstName}" />
				</div></div>
			<div class="row justify-content-center">
				<div class="col">
			<label for="validationDefault02" class="form-label">Last name</label>
				<input type="text" name="lastName" value="${user.lastName}" />
			</div></div>
			<div class="row justify-content-center">
				<div class="col">
			<label for="validationDefault02" class="form-label">Street</label>
				<input type="text" name="address.street" value="${user.address.street}" />
			</div></div>
			<div class="row justify-content-center">
				<div class="col">
			<label for="validationDefault02" class="form-label">Apt or Suite</label>
				<input type="text" name="address.street2" value="${user.address.street2}" />
			</div></div>
			<div class="row justify-content-center">
				<div class="col">
			<label for="validationDefault02" class="form-label">City</label>
				<input type="text" name="address.city" value="${user.address.city}" />
			</div></div>
			<div class="row justify-content-center">
				<div class="col">
			<label for="validationDefault02" class="form-label">State</label>
				<input type="text" name="address.state" value="${user.address.state}" />
			</div></div>
			<div class="row justify-content-center">
				<div class="col">
			<label for="validationDefault02" class="form-label">Zip Code</label>
				<input type="text" name="address.zipcode" value="${user.address.zipcode}" />
			</div></div>
			<div class="row justify-content-center">
				<div class="col">
			<label for="validationDefault02" class="form-label">User Name</label>
				<input type="text" name="username" value="${user.username}" />
			</div></div>
			<div class="row justify-content-center">
				<div class="col">
			<label for="validationDefault02" class="form-label">Email</label>
				<input type="text" name="email" value="${user.email}" />
				</div></div>
			<%-- <label for="validationDefault02" class="form-label">Currently Reading</label>
		<input type="text" name="email" value="${user.reading}"/> --%>
		<div class="row justify-content-center">
				<div class="col">
			<input type="submit" value="Submit" />
			</div></div>
		</form>
	</div>
	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>