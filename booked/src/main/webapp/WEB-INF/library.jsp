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
	<div class="container">
		<table class="table table-bordered">
			<thead>
				<tr>
					<th>Title</th>
					<th>Author</th>
					<th>Genre</th>
					<th>Rating</th>
					<th>Add to Your Bookshelf</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="bk" items="${allBooks}">
					<tr>
						<td><a href="viewBook.do?id=${bk.id }">${bk.title}</a></td>
						<td>${bk.author.firstName}${bk.author.lastName}</td>
						<td><c:forEach var="genre" items="${bk.genres}">${genre.name}</c:forEach></td>
						<td>${bk.rating}</td>
						<td><form action="addShelfBook.do" method="GET">
								<input type="hidden" name="id" value="${bk.id}">
								<input type="submit" name="id" value="Add">
							</form></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>