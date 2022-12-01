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
	<div class="container-md">
		<div class="row">
			<div class="col">
				<div class="mb-3">
					<h1>관리자 등록</h1>
				</div>
				<form id="registerForm1" action="" method="post" enctype="multipart/form-data">
					<div class="mb-3">
						<label for="" class="form-label">닉네임</label>
						<input required="required" type="text" class="form-control" name="name">
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">아이디</label>
						<input required="required" type="text" class="form-control" name="adminMemberId">
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">비밀번호</label>
						<input required="required" type="text" class="form-control" name="password">
					</div>
					
					<label for="" class="form-label">권한</label>
					<div class="form-check">
					  <input class="form-check-input" type="checkbox" value="member" id="checkbox1" name="authorityList">
					  <label class="form-check-label" for="flexCheckDefault1">
					    member
					  </label>
					</div>
					<div class="form-check">
					  <input class="form-check-input" type="checkbox" value="course" id="checkbox2" name="authorityList">
					  <label class="form-check-label" for="flexCheckDefault2">
					    course
					  </label>
					</div>
					<div class="form-check">
					  <input class="form-check-input" type="checkbox" value="courseInfo" id="checkbox2" name="authorityList">
					  <label class="form-check-label" for="flexCheckDefault3">
					    courseInfo
					  </label>
					</div>
					<input id="submitButton1" class="btn btn-primary" type="submit" value="등록">
				</form>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
const ctx = "${pageContext.request.contextPath}";
	
</script>
</body>
</html>