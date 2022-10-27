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
					<p><strong>${book.title}</strong><br>
					<em>Author: ${book.author.firstName} ${book.author.lastName}</em></p>
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
			
				<div class="form-check form-check-inline">
  					<input class="form-check-input" type="radio" name="forBorrow" id="forBorrow" value="TRUE">
  					<label class="form-check-label" for="forBorrow">For Borrow</label>
				</div>
				<div class="form-check form-check-inline">
	  				<input class="form-check-input" type="radio" name="forBorrow" id="forBorrow" value="FALSE">
  					<label class="form-check-label" for="forBorrow">Not For Borrow</label>
				</div>
			<br>			
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