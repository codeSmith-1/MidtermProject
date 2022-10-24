<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%-- ${user.username} --%>'s Bookshelf
</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
	<jsp:include page="navBar.jsp" />
<div class="col-6">
	<table>
		<thead>
			<tr>
				<th>Title</th>
				<th>Author</th>
				<th>Genre</th>
				<th>Condition</th>
				<th>Rating</th>
			</tr>
		</thead>
		<tbody>
				<c:forEach var="sb" items="${books}">
					<tr>
						<td>${sb.book.title}</td>
						<td>${sb.book.author}</td>
						<td>${sb.book.genres}</td>
						<td>${sb.condition}</td>
						<td>${sb.book.rating}</td>
					</tr>
				</c:forEach>
		</tbody>
	</table>
</div>
<div class="col-6">
	<table>
		<thead>
			<tr>
				<th>Title</th>
				<th>Author</th>
				<th>Genre</th>
				<th>Condition</th>
				<th>Rating</th>
			</tr>
		</thead>
		<tbody>
				<c:forEach var="fav" items="${favs}">
					<tr>
						<td>${fav.title}</td>
						<td>${fav.author}</td>
						<td>${fav.genres}</td>
					</tr>
				</c:forEach>
		</tbody>
	</table>
</div>

	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>