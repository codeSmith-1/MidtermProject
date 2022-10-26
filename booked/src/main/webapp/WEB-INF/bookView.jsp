<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${user.firstName}'sBookshelf</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
	<jsp:include page="navBar.jsp" />
	<div class="container">
		<div class="row">
			<div class="col-6">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>Title</th>
							<th>Author</th>
							<th>Genre</th>
							<th>Rating</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>${book.title}</td>
							<td>${book.author.firstName}${book.author.lastName}</td>
							<td><c:forEach var="genre" items="${book.genres}">${genre.name}</c:forEach></td>
							<td>${book.rating}</td>

						</tr>
					</tbody>
				</table>
			</div>
			<div class="col-6">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>Copies</th>
							<th>Condition</th>
							<th>Available to borrow</th>
							<th>Available to purchase</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="b" items="${books}">
							<tr>
								<td>${b.book.title}</td>
								<td>${b.condition.name }</td>
								<td><c:choose>
										<c:when test="${b.forBorrow}">
											<a href="checkout.do">Request</a>
										</c:when>
										<c:otherwise>Unavailable</c:otherwise>
									</c:choose></td>
								<td><c:choose>
										<c:when test="${b.forSale}">Request
										</c:when>
										<c:otherwise>Not for sale</c:otherwise>
									</c:choose></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>

		<ul class="list-group">
			<c:forEach var="c" items="${book.comments}">
				<li class="list-group-item"><strong>${c.user.username}</strong>
					<em>${c.commentDate}:</em>
					<p>${c.comment}
					<p></li>
			</c:forEach>
		</ul>

		<form action="postComment.do" method="POST">
			<div class="form-floating">
				<textarea name="comment" class="form-control"
					placeholder="Leave a comment here" id="floatingTextarea2"
					style="height: 100px"></textarea>
				<input type="submit" value="Submit">
			</div>
		</form>
	</div>
	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>