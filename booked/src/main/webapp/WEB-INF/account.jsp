<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>booked</title>
<jsp:include page="bootstrapHead.jsp"/>
</head>
<body>
<jsp:include page="navBar.jsp"/>

<h2>Hey ${user.firstName }</h2>
<h2>Addr ${user.address }</h2>


<div class="dropdown">
  <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
    Dropdown button
  </button>
  <ul class="dropdown-menu">
    <li><a class="dropdown-item" href="editAccountForm.do?id=${user.id}">Update Account</a></li>
    <li><a class="dropdown-item" href="#">Another action</a></li>
    <li><a class="dropdown-item" href="#">Something else here</a></li>
  </ul>
</div>


<button class="bg-primary" value="${SMOKETEST}" />
<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>