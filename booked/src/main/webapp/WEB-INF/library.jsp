<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Library</title>
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
				<th>Rating</th>
			</tr>
		</thead>
		<tbody>
				<c:forEach var="bk" items="${allBooks}">
					<tr>
						<td>${bk.book.title}</td>
						<td>${bk.book.author.firstName} ${bk.book.author.lastName}</td>
						<td><c:forEach var="genre" items="${bk.book.genres}">${genre.name}</c:forEach></td>
						<td>${bk.book.rating}</td>
					</tr>
				</c:forEach>
		</tbody>
	</table>

	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>