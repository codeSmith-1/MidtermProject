<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${user.username}'sBookshelf</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
	<jsp:include page="navBar.jsp" />
	<div class="container">
		<div class="row">
			<div class="col">
				<table
					class="table table-secondary table-bordered border-black caption-top table-striped">
					<caption>
						<strong>${user.username }'s Bookshelf</strong>
					</caption>
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
								<td>${sb.book.author.firstName}&#20;${sb.book.author.lastName}</td>
								<td><c:forEach var="genre" items="${sb.book.genres}">${genre.name}</c:forEach></td>
								<td>${sb.condition.name}</td>
								<td><c:choose>
										<c:when test="${not empty sb.activeRequests}">
											<strong>Borrow requests pending.</strong>
										</c:when>
										<c:otherwise>No requests.</c:otherwise>
									</c:choose>
								<td style="text-align:center"><form action="deleteShelfBook.do" method="GET">
										<input type="hidden" name="id" value="${sb.id}" />
										<button class="btn btn-dark" type="submit">
											<svg xmlns="http://www.w3.org/2000/svg" width="16"
												height="16" fill="currentColor" class="bi bi-trash3"
												viewBox="0 0 16 16">
  		<path d="M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5ZM11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H2.506a.58.58 0 0 0-.01 0H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1h-.995a.59.59 0 0 0-.01 0H11Zm1.958 1-.846 10.58a1 1 0 0 1-.997.92h-6.23a1 1 0 0 1-.997-.92L3.042 3.5h9.916Zm-7.487 1a.5.5 0 0 1 .528.47l.5 8.5a.5.5 0 0 1-.998.06L5 5.03a.5.5 0 0 1 .47-.53Zm5.058 0a.5.5 0 0 1 .47.53l-.5 8.5a.5.5 0 1 1-.998-.06l.5-8.5a.5.5 0 0 1 .528-.47ZM8 4.5a.5.5 0 0 1 .5.5v8.5a.5.5 0 0 1-1 0V5a.5.5 0 0 1 .5-.5Z" />
				</svg>
										</button>
									</form></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="col-6"></div>
		</div>
		<div class="row">
			<div class="col-6">
				<form action="addBook.do" method="GET">
					<button class="btn btn-dark" type="submit">Add a Book to
						Bookshelf</button>
				</form>
			</div>
		</div>
	</div>

	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>