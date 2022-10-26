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
		<form action="addBook.do" method="POST">
		
			<div class="row justify-content-center">
				<div class="col">
					<label for="validationDefault01" class="form-label">Author First Name</label>
					<input type="text" name="firstName" />
				</div>
			</div>
			
			<div class="row justify-content-center">
				<div class="col">
					<label for="validationDefault01" class="form-label">Author Last Name</label>
					<input type="text" name="lastName" />
				</div>
			</div>
			
			<div class="row justify-content-center">
				<div class="col">
					<label for="validationDefault01" class="form-label">Title</label>
					<input type="text" name="title" />
				</div>
			</div>
			
			<div class="row justify-content-center">
				<div class="col">
					<label for="validationDefault01" class="form-label">Description</label>
					<input type="text" name="description" />
				</div>
			</div>
			
			<div class="row">
				<div class="col align-self-center">
					<label for="genre.id" class="form-label">Genre</label>
					<select name="genre.id" class="form-label" aria-label="Default select example">
						<c:forEach var="genre" items="${genres }">
							<option value="${genre.id }">${genre.name }</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="row justify-content-center">
				<div class="col">
					<input type="submit" value="Submit" />
				</div>
			</div>
		</form>
	</div>
	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>