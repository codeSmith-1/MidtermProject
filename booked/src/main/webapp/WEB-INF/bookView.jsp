<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${book.title}</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
	<jsp:include page="navBar.jsp" />
	<div class="container">
		<div class="row">
			<div class="col-6">
				<table class="table table-secondary table-bordered border-black caption-top table-striped">
					<caption><strong>${book.title}</strong></caption>
					<thead>
						<tr class="table-dark">
							<th>Title</th>
							<th>Author</th>
							<th>Genre</th>
							<th>Rating</th>
							<c:if test="${not empty sessionScope.user}">
								<th>User Rating</th>
							</c:if>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>${book.title}</td>
							<td>${book.author.firstName} ${book.author.lastName}</td>
							<td><c:forEach var="genre" items="${book.genres}">${genre.name}</c:forEach></td>
							<td>${book.rating}</td>
							<c:if test="${not empty sessionScope.user}">
								<td><c:choose>
										<c:when test="${not empty userRating}">
											<form action="updateRating.do?id=${book.id}" method="POST">
												<select name="ratingValue" class="form-select">
													<c:forEach var="num" items="1,2,3,4,5">
														<c:choose>
															<c:when test="${userRating.rating == num}">
																<option selected value="${num}">${num}</option>
															</c:when>
															<c:otherwise>
																<option value="${num}">${num}</option>
															</c:otherwise>
														</c:choose>

													</c:forEach>
												</select> <input type="submit" value="Update" />
											</form>
										</c:when>
										<c:otherwise>
											<form action="rateBook.do?id=${book.id}" method="POST">
												<select name="ratingValue" class="form-select" required>
													<option value="1">1</option>
													<option value="2">2</option>
													<option value="3">3</option>
													<option value="4">4</option>
													<option value="5">5</option>
												</select> <input type="submit" value="Rate" />
											</form>
										</c:otherwise>
									</c:choose></td>
							</c:if>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="col-5">
			<table class="table table-secondary table-bordered border-black caption-top table-striped">
				<caption><strong>Copies in library</strong></caption>
				<thead>
					<tr class="table-dark">
						<th>Owner</th>
						<th>Condition</th>
						<th>Available to borrow</th>
						<th>Available to purchase</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="b" items="${books}">
						<tr>
							<td>${b.user.username}</td>
							<td>${b.condition.name}</td>
							<td><c:choose>
									<c:when test="${b.forBorrow}">
										<a href="requestBook.do?id=${b.id}">Request</a>
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
	<div>
		<ul class="list-group" style="background:transparent">
			<c:forEach var="c" items="${book.comments}">
				<li class="list-group-item comments">
					<strong style="background-color: gray">${c.user.username}</strong>
					<em style="background-color: gray">${c.commentDate}:</em>
					<p>${c.comment}
					</p></li>
			</c:forEach>
		</ul>

		<form action="postComment.do" method="POST">
			<input type="hidden" name="id" value="${book.id}" />
			<div class="form-floating">
				<textarea name="comment" class="form-control"
					placeholder="Leave a comment here" id="floatingTextarea2"
					style="height: 75px; width:700px"></textarea>
				<input type="submit" value="Submit">
			</div>
		</form>
	</div>
</div>
	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>