<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>New Shelf Book</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
	<jsp:include page="navBar.jsp" />
	<div class="container">
		<form action="addShelfBook.do" method="POST">
		
			<div class="row">
				<div class="col align-self-center">
					<input type="hidden" name="bookId" value="${book.id}" />
				</div>
			</div>
			
			<div class="row">
				<div class="col align-self-center">
					<h3>Title: ${book.title}</h3>
				</div>
			</div>
			
			<div class="row">
				<div class="col align-self-center">
					<h3>Author: ${book.author.firstName} ${book.author.lastName}</h3>
				</div>
			</div>
			
			<div class="row">
				<div class="col align-self-center">
				<h3>Genres: </h3><c:forEach var="genre" items="${genres }"><h3>${genre.name}</h3></c:forEach>
				</div>
			</div>
			
			<div class="row">
				<div class="col align-self-center">
					<label for="conditionId" class="form-label">Condition</label> <select
						name="conditionId" class="form-label"
						aria-label="Default select example">
						<c:forEach var="cond" items="${conditions }">
							<option value="${cond.id }">${cond.name }</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="row justify-content-center">
				<div class="col">
					<label for="forBorrow" class="form-label">For Borrow</label> <input
						type="text" name="forBorrow" />
				</div>
			</div>
			
			<div class="row justify-content-center">
				<div class="col">
					<label for="forSale" class="form-label">For Sale</label> <input
						type="text" name="forSale" />
				</div>
			</div>
			
			<div class="row justify-content-center">
				<div class="col">
					<label for="salePrice" class="form-label">Price</label> <input
						type="text" name="salePrice" />
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