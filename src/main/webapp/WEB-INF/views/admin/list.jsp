<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
<my:adminPageTopNav></my:adminPageTopNav>

<div class="d-flex">
<my:adminPageLeftNav></my:adminPageLeftNav>
	<div class="row">
		<div class="col">
			<table class="table">
				<div class="d-flex">
					<h1 class="me-auto">관리자리스트</h1>
					<c:url value="/admin/register" var="registerLink"></c:url>
					<a href="${registerLink }">새 관리자 등록</a>
				</div>
				<c:if test="${not empty message }">
					<div class="alert alert-success">
						${message }
					</div>
				</c:if>
				<thead>
					<tr>
						<th>#</th>
						<th>관리자명</th>
						<th>아이디</th>
						<th>비밀번호</th>
						<th>권한</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${adminMemberList }" var="adminMember">
						<tr>
							<c:url value="/admin/get" var="getLink">
								<c:param name="username" value="${adminMember.adminMemberId }"></c:param>
							</c:url>
							<td>${adminMember.id }</td>
							<td><a href="${getLink }">${adminMember.name }</a></td>
							<td>${adminMember.adminMemberId }</td>
							<td>*******</td>
							<td>
								<c:forEach items="${adminMember.authorityList }" var="authority">
									${authority } 
								</c:forEach>
							</td>
						</tr>
					</c:forEach>				
				</tbody>
			</table>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>