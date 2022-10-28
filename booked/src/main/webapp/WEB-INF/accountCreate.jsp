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
	<c:if test="${not empty Error }">Account not created : ${Error}</c:if>
		<div class="container">
		<h2>Create Account</h2>
			<br>
			<form action="createAccount.do" method="POST" class="row g-3">
				<div class="row justify-content-center">
					<div class="col align-self-center">
						<label for="firstName" class="form-label">First Name: </label> <input
							name="firstName" type="text" id="firstName"
							value="${user.firstName}" required>
					</div>
				</div>
				<div class="row justify-content-center">
					<div class="col">
						<label for="lastName" class="form-label">Last Name: </label> <input
							name="lastName" type="text" id="lastName"
							value="${user.lastName}" required>
					</div>
				</div>
				<div class="row justify-content-center">
					<div class="col">
						<label for="email" class="form-label">E-Mail: </label> <input
							name="email" type="text" id="email" value="${user.email}"
							required>
					</div>
				</div>
				<div class="row justify-content-center">
					<div class="col">
						<label for="username" class="form-label">Username: </label> <input
							name="username" type="text" id="username"
							placeholder="Unique UserName" required>
					</div>
				</div>
				<div class="row justify-content-center">
					<div class="col">
						<label for="password" class="form-label">Password: </label> <input
							name="password" type="password" id="password"
							placeholder="Strong Password" required>
					</div>
				</div>
				<div class="row justify-content-center">
					<div class="col">
						<label for="aboutMe" class="form-label">About Me: </label> <input
							name="aboutMe" type="text" id="aboutMe" value="${user.aboutMe}">
					</div>
				</div>

				<div class="row justify-content-center">
					<div class="col">
						<label for="genreId" class="form-label">Genre</label> <select
							name="genreId" class="form-label"
							aria-label="Default select example">
							<c:forEach var="genre" items="${genres }">
								<option value="${genre.id }">${genre.name }</option>
							</c:forEach>
						</select>
					</div>
				</div>


				<%-- <div class="col-md-3">
			<label for="validationDefault05" class="form-label">Currently Reading</label> <input
				name="reading" type="text" class="form-control" id="validationDefault05" value="${user.reading}">
		</div> --%>

				<div class="row justify-content-center">
					<div class="col">
						<label for="address.street" class="form-label">Street: </label> <input
							name="address.street" type="text" id="address.street"
							value="${user.address.street}" required>
					</div>
				</div>
				<div class="row justify-content-center">
					<div class="col">
						<label for="address.street2" class="form-label">Apt/Suite:
						</label> <input name="address.street2" type="text" id="address.street2"
							value="${user.address.street2}">
					</div>
				</div>
				<div class="row justify-content-center">
					<div class="col">
						<label for="address.city" class="form-label">City: </label> <input
							name="address.city" type="text" id="address.city"
							value="${user.address.city}" required>
					</div>
				</div>
				<div class="row justify-content-center">
					<div class="col">
						<label for="address.state" class="form-label">State: </label> <input
							name="address.state" type="text" id="address.state"
							value="${user.address.state}" required>
					</div>
				</div>
				<div class="row justify-content-center">
					<div class="col">
						<label for="address.zipcode" class="form-label">Zip Code:
						</label> <input name="address.zipcode" type="text" id="address.zipcode"
							value="${user.address.zipcode}" required>
					</div>
				</div>
				<div class="row justify-content-center">
					<div class="col">
						<button class="btn btn-secondary" type="submit">Join
							booked.</button>
					</div>
				</div>
			</form>
		</div>

	<jsp:include page="bootstrapFoot.jsp" />

</body>
</html>