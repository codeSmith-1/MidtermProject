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
			<c:choose>
				<c:forEach var="book" items="${books}">
					<tr>
						<td>${book.title}</td>
						<td>${book.author}</td>
						<td>${book.genre}</td>
						<td>${book.condition}</td>
						<td>${book.rating}</td>
					</tr>
				</c:forEach>
			</c:choose>
		</tbody>
	</table>

	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>