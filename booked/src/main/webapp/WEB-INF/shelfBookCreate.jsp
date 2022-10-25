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
	<form action="addShelfBook.do" method="POST" class="row g-3">
		<!-- 
	<label for="validationDefault01" class="form-label">Title</label>
		<input type="text" name="book.title" value="${book.title}"/>
	<label for="validationDefault01" class="form-label">Author First Name</label>
		<input type="text" name="book.author.firstName" value="${book.author.firstName}"/>
	<label for="validationDefault01" class="form-label">Author Last Name</label>
		<input type="text" name="book.author.lastName" value="${book.author.lastName}"/>
	<label for="validationDefault01" class="form-label">Description</label>
		<input type="text" name="book.description" value="${book.description}"/>
	<label for="validationDefault01" class="form-label">Genres</label>
		<input type="text" name="book.genres" value="<c:forEach var="g" items="${book.genres}">${g.name}</c:forEach>"/>
		-->
		
		<input type="hidden" name="bookId" value="${book.id }"/>
		
		<label for="condition.id" class="form-label">Condition</label>
		<select name="condition.id" class="form-select" aria-label="Default select example">
			<c:forEach var="cond" items="${conditions }">
			<option value="${cond.id }">${cond.name }</option>
			</c:forEach>
		</select>
		<label for="forBorrow" class="form-label">For Borrow</label> <input
			type="text" name="forBorrow" /> <label for="forSale"
			class="form-label">For Sale</label> <input type="text" name="forSale" />
		<label for="salePrice" class="form-label">Price</label> <input
			type="text" name="salePrice" /> <input type="submit" value="Submit" />
	</form>
	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>