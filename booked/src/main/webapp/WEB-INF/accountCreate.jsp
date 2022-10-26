<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Account</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
	<jsp:include page="navBar.jsp" />
	<div class="container">
		<c:if test="${not empty Error }">Account not created : ${Error}</c:if>
		<form action="createAccount.do" method="POST" class="row g-3">
			<div class="col-md-4">
				<label for="validationDefault01" class="form-label">First
					name</label> <input name="firstName" type="text" class="form-control"
					id="validationDefault01" value="${user.firstName}" required>
			</div>
			<div class="col-md-4">
				<label for="validationDefault02" class="form-label">Last
					name</label> <input name="lastName" type="text" class="form-control"
					id="validationDefault02" value="${user.lastName}" required>
			</div>
			<div class="col-md-4">
				<label for="validationDefault02" class="form-label">Email</label> <input
					name="email" type="text" class="form-control"
					id="validationDefault02" value="bookworm@email.com" required>
			</div>
			<div class="col-md-4">
				<label for="validationDefault02" class="form-label">UserName</label>
				<input name="username" type="text" class="form-control"
					id="validationDefault02" value="not password" required>
			</div>
			<div class="col-md-4">
				<label for="validationDefault02" class="form-label">Password</label>
				<input name="password" type="text" class="form-control"
					id="validationDefault02" value="not password" required>
			</div>
			<div class="mb-3">
				<label for="formFile" class="form-label">Profile Picture</label> <input
					name="profileImg" class="form-control" type="file" id="formFile">
			</div>
			<div class="col-md-3">
				<label for="validationDefault05" class="form-label">About
					Me:</label> <input name="aboutMe" type="text" class="form-control"
					id="validationDefault05" value="optional">
			</div>
			<div class="col-md-4">
				<label for="validationDefault02" class="form-label">Street</label> <input
					name="address.street" type="text" class="form-control"
					id="validationDefault02" value="last" required>
			</div>
			<div class="col-md-4">
				<label for="validationDefault02" class="form-label">Street</label> <input
					name="address.street2" type="text" class="form-control"
					id="validationDefault02" value="last" required>
			</div>
			<div class="col-md-3">
				<label for="validationDefault05" class="form-label">City</label> <input
					name="address.city" type="text" class="form-control"
					id="validationDefault05" required>
			</div>
			<div class="col-md-3">
				<label for="validationDefault05" class="form-label">State</label> <input
					name="address.state" type="text" class="form-control"
					id="validationDefault05" required>
			</div>
			<div class="col-md-3">
				<label for="validationDefault05" class="form-label">Zip</label> <input
					name="address.zipcode" type="text" class="form-control"
					id="validationDefault05" required>
			</div>
			<div class="col-12">
				<button class="btn btn-primary" type="submit">Submit form</button>
			</div>
		</form>
	</div>
	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>