<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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

	<div class="container-md">
		<div class="row">
			<div class="col">
			
				<div class="d-flex">
					<h1 class="me-auto">
						관리자 ${adminMember.adminMemberId }
						 
						<c:url value="/admin/modify" var="modifyLink">
							<c:param name="username" value="${adminMember.adminMemberId }"></c:param>
						</c:url>
						
						<a class="btn btn-warning" href="${modifyLink }">
							<i class="fa-solid fa-pen-to-square"></i>
						</a>
						
					</h1>
				</div>
			
				<div class="mb-3">
					<label class="form-label">
						아이디 
					</label>
					<input class="form-control" type="text" value="${adminMember.adminMemberId }" readonly>
				</div>	
				
				<div class="mb-3">
					<label class="form-label">
						비밀번호 
					</label>
					<input class="form-control" type="password" value="${adminMember.password }" readonly>
				</div>
				
				<div class="mb-3">
					<label class="form-label">
						권한 
					</label>
					<input class="form-control" type="text" value="${adminMember.authorityList }" readonly>
				</div>	
				
				
				<%-- 이미지 출력 --%>
				<%-- <div>
					<c:forEach items="${board.fileName }" var="name">
						<div>
							<img class="img-fluid img-thumbnail" src="${imgUrl }/${board.id }/${URLEncoder.encode(name, 'utf-8')}" alt="">
						</div>
					</c:forEach>		
				</div> --%>
	
	
			</div>
		</div>
	</div>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>