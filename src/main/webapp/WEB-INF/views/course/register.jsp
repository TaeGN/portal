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
					<h1>새 강의 등록</h1>
				</div>
				<form id="registerForm1" action="" method="post" enctype="multipart/form-data">
					<div class="mb-3">
						<label for="" class="form-label">학년</label>
						<input required="required" type="number" class="form-control" name="grade" value="1">
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">학수번호 - 교과목명</label>
						<select name="classNumber" class="form-select" aria-label="Default select example">
							<c:forEach items="${courseInfoList }" var="courseInfo">
								<option value="${courseInfo.classNumber }">${courseInfo.classNumber } - ${courseInfo.courseName }</option>
							</c:forEach>
						</select>
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">수강정원</label>
						<input required="required" type="number" class="form-control" name="maxPersonnel" value="40">
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">관장학과</label>
						<select name="departmentId" class="form-select" aria-label="Default select example">
							<c:forEach items="${departmentList }" var="department">
								<option value="${department.id }">${department.name }</option>
							</c:forEach>
						</select>
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">년도</label>
						<input required="required" type="number" class="form-control" name="year" value="2022">
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">학기</label>
						<select name="semester" class="form-select" aria-label="Default select example">
						  <option value="1학기">1학기</option>
						  <option value="여름학기">여름학기</option>
						  <option value="2학기">2학기</option>
						  <option value="겨울학기" selected>겨울학기</option>
						</select>
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