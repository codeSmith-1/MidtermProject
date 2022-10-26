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
					<h4>Borrow requests</h4>
							<p>Title: <strong>${sb.book.title}</strong></p>
							<p>by: <em>${sb.book.author.firstName} ${sb.book.author.lastName}</em></p>

<br>
				<c:if test="${not empty sb.checkouts }">

					<table class="table table-bordered">
					<caption class="sfcaption">Requests for this book</caption>
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
											<c:otherwise>


												<form action="approveCheckout.do" method="POST">
													<input type="hidden" name="id" value="${c.id}" />
													<div class="form-floating">
														<input type="submit" value="Approve">
													</div>
												</form>

												<form action="rejectCheckout.do" method="POST">
													<input type="hidden" name="id" value="${c.id}" />
													<div class="form-floating">
														<input type="submit" value="Reject">
													</div>
												</form>


											</c:otherwise>
										</c:choose></td>
									<td><c:choose>
											<c:when test="${not empty c.returnDate}">
											${c.returnDate}
									</c:when>
											<c:otherwise>
												<form action="returned.do" method="POST">
													<input type="hidden" name="id" value="${c.id}" />
													<div class="form-floating">
														<input type="submit" value="Returned? Make available.">
													</div>
												</form>
											</c:otherwise>
										</c:choose></td>
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