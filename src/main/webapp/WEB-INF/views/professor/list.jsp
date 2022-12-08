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
<div id="sugangListId1" class="container-md">
<my:professorAdminNav></my:professorAdminNav>
<h1>교수리스트</h1>
	<div class="row">
		<div class="col">
			<table class="table">
				<thead>
					<tr>
						<th>#</th>
						<th>이름</th>
						<th>아이디</th>
						<th>비밀번호</th>
						<th>연락처</th>
						<th>이메일</th>
						<th>홈페이지</th>
						<th>학부</th>
						<th>주민번호</th>
						<th>나이 등등</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${professorList }" var="professor">
						<tr>
							<td>${professor.professorNumber }</td>
							<td>${professor.name }</td>
							<td>${professor.loginId }</td>
							<td>*******</td>
							<td>${professor.contact }</td>
							<td>${professor.email }</td>
							<td>${professor.homepage }</td>
							<td>${professor.department.name }</td>
							<td>${professor.firstResidentId }-${professor.lastResidentId }</td>
							<td>추가 예정</td>
						</tr>
					</c:forEach>				
				</tbody>
			</table>
		</div>
	</div>
</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>