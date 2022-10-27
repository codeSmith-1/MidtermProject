<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${user.username}'s Bookshelf</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
	<jsp:include page="navBar.jsp" />
	<div class="container">
		<div class="row">
			<div class="col">
			<table class="table table-secondary table-bordered border-black caption-top table-striped">
  					<caption><strong>${user.username }'s Bookshelf</strong></caption>
					<thead>
						<tr class="table-dark">
							<th>Title</th>
							<th>Author</th>
							<th>Genre</th>
							<th>Condition</th>
							<th>Requests</th>
							<th>Remove Book</th>
						</tr>
						</thead>
					<tbody>
						<c:forEach var="sb" items="${books}">
							<tr>
								<td><a href="viewShelfBook.do?id=${sb.id }">
										${sb.book.title}</a></td>
								<td>${sb.book.author.firstName} ${sb.book.author.lastName}</td>
								<td><c:forEach var="genre" items="${sb.book.genres}">${genre.name}</c:forEach></td>
								<td>${sb.condition.name}</td>
								<td><c:choose>
										<c:when test="${not empty sb.activeRequests}"><strong>Rental requests pending.</strong>
										</c:when>
										<c:otherwise>No active requests</c:otherwise>
									</c:choose>
								<td><form action="deleteShelfBook.do" method="GET">
										<input type="hidden" name="id" value="${sb.id}" /> <input
											type="submit" value="Remove book from shelf." />
									</form></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="col-6">
				
			</div>
		</div>
		<div class="row">
			<div class="col-6">
				<form action="addBook.do" method="GET">
					<input type="submit" value="Add a Book to My Shelf">
				</form>
			</div>
		</div>
	</div>

	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>