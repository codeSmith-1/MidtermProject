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
	<br>
	<div class="container">
	<div style="height:700px;overflow:auto;">
		<table class="table table-secondary table-bordered border-black caption-top table-striped">
		<caption><strong>Library</strong></caption>
			<thead>
				<tr class="table-dark">
					<th>Title</th>
					<th>Author</th>
					<th>Genre</th>
					<th>Rating</th>
					<th>Bookshelf</th>
					<th>Favorites</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="bk" items="${allBooks}">
					<tr>
						<td><a href="viewBook.do?id=${bk.id }">${bk.title}</a></td>
						<td>${bk.author.firstName} ${bk.author.lastName}</td>
						<td><c:forEach var="genre" items="${bk.genres}">${genre.name}</c:forEach></td>
						<td>${bk.rating}</td>
						<td><form action="addShelfBook.do" method="GET">
								<input type="hidden" name="id" value="${bk.id}">
								<button class="btn btn-secondary" type="submit">ADD</button>
							</form></td>
						<td><form action="addFavBook.do" method="GET">
								<input type="hidden" name="id" value="${bk.id}">
								<button class="btn btn-secondary" type="submit">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star" viewBox="0 0 16 16">
  <path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.565.565 0 0 0-.163-.505L1.71 6.745l4.052-.576a.525.525 0 0 0 .393-.288L8 2.223l1.847 3.658a.525.525 0 0 0 .393.288l4.052.575-2.906 2.77a.565.565 0 0 0-.163.506l.694 3.957-3.686-1.894a.503.503 0 0 0-.461 0z"/>
</svg></button></form></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>
	</div>

	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>