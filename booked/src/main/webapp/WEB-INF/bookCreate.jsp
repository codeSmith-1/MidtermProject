<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>New Book</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
	<jsp:include page="navBar.jsp" />
	<div class="container">
		<h2>Add a book</h2>
		<form action="addBook.do" method="POST">
			<div class="row justify-content-center">
				<div class="col">
					<label for="validationDefault01" class="form-label">Author First Name</label>
					<input type="text" name="firstName" required/>
				</div>
			</div>
			
			<div class="row justify-content-center">
				<div class="col">
					<label for="validationDefault01" class="form-label">Author Last Name</label>
					<input type="text" name="lastName" required/>
				</div>
			</div>
			
			<div class="row justify-content-center">
				<div class="col">
					<label for="validationDefault01" class="form-label">Title</label>
					<input type="text" name="title" required/>
				</div>
			</div>
			
			<div class="row justify-content-center">
				<div class="col">
					<label for="validationDefault01" class="form-label">Description</label>
					<input type="text" name="description" required/>
				</div>
			</div>
			
			<div class="row">
				<div class="col align-self-center">
					<label for="genreId" class="form-label">Genre</label>
					<select name="genreId" class="form-label" aria-label="Default select example" required>
						<c:forEach var="genre" items="${genres }">
							<option value="${genre.id }">${genre.name }</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="row justify-content-center">
				<div class="col">
				<button class="btn btn-secondary" type="submit">Add</button>
				</div>
			</div>
		</form>
	</div>
	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>