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
					<h1>학생 등록</h1>
				</div>
				<form id="registerForm1" action="" method="post" enctype="multipart/form-data">
				
					<div class="mb-3">
						<label for="" class="form-label">학부</label>
						<select id="selectDepartmentId1" name="departmentId" class="form-select" aria-label="Default select example">
							<c:forEach items="${departmentList }" var="department">
								<option value="${department.id }">${department.name }</option>
							</c:forEach>
						</select>
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">학번</label>
						<input id="studentNumberId1" required="required" type="number" class="form-control" name="studentNumber">
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">학년</label>
						<select name="grade" class="form-select" aria-label="Default select example">
							<option value="1학년" selected="selected">1</option>
							<option value="2학년">2</option>
							<option value="3학년">3</option>
							<option value="4학년">4</option>
							<option value="5학년">5</option>
						</select>
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">이름</label>
						<input required="required" type="text" class="form-control" name="studentName" value="">
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">주민번호</label>
						<div class="d-flex">
							<input required="required" type="text" class="form-control" name="firstResidentId" value="" placeholder="주민등록번호 앞 6자리">
							<input required="required" type="password" class="form-control" name="lastResidentId" value="" placeholder="주민등록번호 뒤 7자리">
						</div>
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
const selectDepartment = document.querySelector("#selectDepartmentId1");

setStudentNumberBySeleteDepartment();

function setStudentNumberBySeleteDepartment() {
	const department = selectDepartment.value;
	fetch(ctx + "/student/setStudentNumber", {
		method : "post",
		headers : {
			"Content-Type" :"application/json"
		},
		body : JSON.stringify({department})
	})
	.then(res => res.json())
	.then(data => {
		document.querySelector("#studentNumberId1").value = data.studentNumber;
	});
}

selectDepartment.addEventListener("change", function() {
	setStudentNumberBySeleteDepartment();
});

</script>
</body>
</html>