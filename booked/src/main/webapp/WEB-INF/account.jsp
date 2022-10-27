<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Your Account</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
	<jsp:include page="navBar.jsp" />
	<div class="container">
		<div class="row">
			<div class="col-3">
				<h2>Hey ${user.firstName}</h2>
				<div class="dropdown">
					<button class="btn btn-secondary dropdown-toggle" type="button"
						data-bs-toggle="dropdown" aria-expanded="false">Account
						Options</button>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item"
							href="editAccountForm.do?id=${user.id}">Update Account</a></li>
						<li><a class="dropdown-item" href="updatePassword.do">Change
								Password</a></li>
					</ul>
				</div>
			</div>
			<div class="col-9">

				<table class="table table-secondary table-bordered border-black caption-top table-striped">
				<caption><strong>Suggested books based on genre</strong></caption>
					<thead>
						<tr class="table-dark">
							<th>Title</th>
							<th>Author</th>
							<th>Rating</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="bk" items="${booksInGenre}"><tr>
							<td><a href="viewBook.do?id=${bk.id }">${bk.title}</a></td>
							<td>${bk.author.firstName} ${bk.author.lastName}</td>
							<td>${bk.rating}</td>
						</tr></c:forEach>
					</tbody>
				</table>
			</div>

		</div>
		<div class="row">

			<table class="table table-secondary table-bordered border-black caption-top table-striped">
			<caption><strong>Your favorite books</strong></caption>

				<thead>
					<tr class="table-dark">
						<th>Title</th>
						<th>Author</th>
						<th>Genre</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="fav" items="${favs}">
						<tr>
							<td>${fav.title}</td>
							<td>${fav.author.firstName} ${fav.author.lastName}</td>
							<td><c:forEach var="genre" items="${fav.genres}">${genre.name}</c:forEach></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

	<c:if test="${not empty checkouts}">
		<div class="row">
			<table class="table table-bordered">
				<caption class="sfcaption">Active checkouts</caption>
				<thead>
					<tr>
						<th>Title</th>
						<th>Owner</th>
						<th>Checkout Date</th>
						<th>Return</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="chk" items="${checkouts}">
						<tr>
							<td>${chk.shelfBook.book.title}</td>
							<td>${chk.shelfBook.user.username}
								<td>${chk.checkoutDate}</td>
							<td>
								<form action="returnedByBorrower.do" method="POST">
													<input type="hidden" name="id" value="${chk.id}" />
													<div class="form-floating">
														<input type="submit" value="Return">
													</div>
												</form>
							
							<td></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			</div>
	</c:if>

	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>