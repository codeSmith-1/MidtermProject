<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${user.firstName}'s Book</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
	<jsp:include page="navBar.jsp" />
	<div class="container">
		<div class="row">
			<div class="col-6">
				<!-- This table is Books, not ShelfBooks -->
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>Title</th>
							<th>Author</th>
							<th>Genre</th>
							<th>Owner</th>
							<th>Condition</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>${sb.book.title}</td>
							<td>${sb.book.author.firstName} ${sb.book.author.lastName}</td>
							<td><c:forEach var="genre" items="${sb.book.genres}">${genre.name}</c:forEach></td>
							<td>${sb.user.username }</td>
							<td>${sb.condition.name}</td>
						</tr>
					</tbody>
				</table>
				<c:if test="${checkedOut}"> ${message}</c:if>
				
				<c:choose><c:when test="${!checkedOut}"> 
				<p>If you want to borrow this book, send a greeting to the host expressing your interest. They will be notified by your message.</p>
					<br>
		
		<form action="checkoutBook.do" method="POST">
		<input type="hidden" name="id" value="${sb.id}"/>
			<div class="form-floating">
				<textarea name="comment" class="form-control"
					placeholder="Leave a comment here" id="floatingTextarea2"
					style="height: 100px">Greetings ${sb.user.username}, I'm interested in borrowing your book: ${sb.book.title}!</textarea>
				<input type="submit" value="Submit">
			</div>
		</form>
		</c:when>
		</c:choose> 
	</div>
				</div>
				</div>
				<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>