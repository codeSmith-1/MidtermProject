<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${user.firstName}'s Book</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
	<jsp:include page="navBar.jsp" />
	<div class="container">
		<div class="row">
			<div class="col-6">
				<!-- This table is Books, not ShelfBooks -->
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>Title</th>
							<th>Author</th>
							<th>Genre</th>
							<th>Borrow Request</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>${sb.book.title}</td>
							<td>${sb.book.author.firstName}${sb.book.author.lastName}</td>
							<td><c:forEach var="genre" items="${sb.book.genres}">${genre.name}</c:forEach></td>
						</tr>
					</tbody>
				</table>
				<c:if test="${not empty sb.checkouts }">
				
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>User</th>
							<th>Request Date</th>
							<th>Checked Out Date</th>
							<th>Return Date</th>
						</tr>
					</thead>
					<tbody>
				<c:forEach var="c" items="${sb.checkouts }">
						<tr>
							<td>${c.user.username}</td>
							<td>${c.requestDate}</td>
							<td><c:choose> 
							<c:when test="${not empty c.checkoutDate}">
							${c.checkoutDate}
							</c:when>
							<c:otherwise>form w/button to approve/reject</c:otherwise>
							</c:choose>
							</td>
							<td><c:choose> 
							<c:when test="${not empty c.returnDate}">
							${c.returnDate}
							</c:when>
							<c:otherwise>form w/button to approve/reject</c:otherwise>
							</c:choose>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				
				</c:if>
			</div>
		</div>
	</div>














	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>