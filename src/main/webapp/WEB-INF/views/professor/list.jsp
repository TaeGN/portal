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

<sec:authorize access="hasAnyAuthority('admin','member')" var="hasAuthority"></sec:authorize>

<my:adminPageTopNav></my:adminPageTopNav>

<div class="d-flex">
<my:adminPageLeftNav></my:adminPageLeftNav>
<div>
	<div class="row">
		<div class="col">
			<table class="table">
				<div class="d-flex">
					<h1 class="me-auto">교수리스트</h1>
					<button onclick="RegisterProfessor()" class="btn btn-link" type="button">
						교수 등록
					</button>
				</div>
				<thead>
					<tr>
						<th>#</th>
						<th>이름</th>
						<th>아이디</th>
						<th>비밀번호</th>
						<th>연락처</th>
						<th>이메일</th>
						<th>홈페이지</th>
						<th>소속학부</th>
						<c:if test="${hasAuthority }">
							<th>주민번호</th>
						</c:if>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${professorList }" var="professor">
						<tr>
							<td>
								<button onclick="GetProfessorInfo(${professor.professorNumber})" class="btn btn-link" type="button">
									${professor.professorNumber }
								</button>
							</td>
							<td>${professor.name }</td>
							<td>${professor.loginId }</td>
							<td>*******</td>
							<td>${professor.contact }</td>
							<td>${professor.email }</td>
							<td>${professor.homepage }</td>
							<td>${professor.department.name }</td>
							<c:if test="${hasAuthority }">
								<td>${professor.firstResidentId }-${professor.lastResidentId }</td>
							</c:if>
						</tr>
					</c:forEach>				
				</tbody>
			</table>
		</div>
	</div>
</div>
</div>
<c:if test="${hasAuthority }">
	<div class="me-5" id="professorInfoByProfessorNumber">
	
	</div>
	
	<div id="modifyStudentId1"></div>
</c:if>

</div>


	<!-- modify Modal -->
	<div class="modal fade" id="modifyModal" tabindex="-1" aria-labelledby="modifyModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="modifyModalLabel">수정 확인</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        수정하시겠습니까?
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button id="modifyConfirmButton" type="button" class="btn btn-primary">확인</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- remove Modal -->
	<div class="modal fade" id="removeModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">삭제 확인</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        삭제하시겠습니까?
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button id="removeConfirmButton" type="button" class="btn btn-danger">확인</button>
	      </div>
	    </div>
	  </div>
	</div>




						<!-- <button onclick="GetStudentInfo(\${student.studentNumber})" class="btn btn-link" type="button">
						<i class="fa-solid fa-pen-to-square">이전</i>
						</button> -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
const ctx = "${pageContext.request.contextPath}";
const modifyStudent1 = document.querySelector("#modifyStudentId1");


// 수정확인 버튼 클릭하면 수정 form 전송
document.querySelector("#modifyConfirmButton").addEventListener("click", function() {
	document.querySelector("#modifyForm").submit();
});

// 삭제확인 버튼 클릭하면 삭제 form 전송
document.querySelector("#removeConfirmButton").addEventListener("click", function() {
	document.querySelector("#removeForm").submit();
});

function ModifyStudent(studentNumber) {
	fetch(ctx + "/student/modify/" + studentNumber)
	.then(res => res.json())
	.then(data => {
		const departmentList = data.departmentList;
		const student = data.student;
		
		let departmentOption = ``;
		
		for(var department of departmentList) {
			departmentOption += `<option value="\${department.id }">\${department.name } - \${department.college.name } - \${department.college.organization.name }</option>`
		}
		
		document.querySelector("#modifyStudentId1").innerHTML = `

			<div class="row">
				<div class="col">
					<div class="d-flex">
						<h1 class="me-auto">학생 정보 수정</h1>
					</div>
					<form id="modifyForm" action="\${ctx}/student/modify" method="post" enctype="multipart/form-data">
					<div class="mb-3">
						<label class="form-label">
							학번 
						</label>
						<input class="form-control" name="studentNumber" type="number" value="\${student.studentNumber }" readonly="readonly">
					</div>
					
						<div class="mb-3">
							<label for="" class="form-label">학부</label>
							<select name="departmentId" class="form-select" aria-label="Default select example">
									
							\${departmentOption}
							
							</select>
						</div>
					
						<div class="mb-3">
							<label for="" class="form-label">학년</label>
							<select name="grade" class="form-select" aria-label="Default select example">
								<option value="1학년">1학년</option>
								<option value="2학년">2학년</option>
								<option value="3학년">3학년</option>
								<option value="4학년">4학년</option>
								<option value="5학년">5학년</option>
							</select>
						</div>

					<div class="mb-3">
						<label class="form-label">
							이름 
						</label>
						<input class="form-control" name="studentName" type="text" value="\${student.studentName }">
					</div>	
					
					<div class="mb-3">
						<label class="form-label">
							아이디 
						</label>
						<input class="form-control" name="id" type="text" value="\${student.id }">
					</div>
					
					<div class="mb-3">
						<label class="form-label">
							패스워드 
						</label>
						<input class="form-control" name="password" type="number" value="">
					</div>
					
					<div class="mb-3">
						<label class="form-label">
							주민등록번호 
						</label>
						<div class="d-flex">
							<input required="required" type="number" class="form-control" name="firstResidentId" value="\${student.firstResidentId }" placeholder="주민등록번호 앞 6자리">
							<div class="ms-2 me-2"><i class="fa-solid fa-minus"></i></div>
							<input required="required" type="number" class="form-control" name="lastResidentId" value="\${student.lastResidentId }" placeholder="주민등록번호 뒤 7자리">
						</div>
					</div>
					</form>
					
					<input class="btn btn-warning" type="submit" value="수정" data-bs-toggle="modal" data-bs-target="#modifyModal">
					<input class="btn btn-danger" type="submit" value="삭제" data-bs-toggle="modal" data-bs-target="#removeModal">
					
					<form id="removeForm" action="\${ctx }/student/remove" method="post">
					<input type="hidden" name="studentNumber" value="\${student.studentNumber }">
					</form>
				</div>
			</div>
		`;

	});
}


//register에서 department에 따른 studentNumber 자동 할당
function SetStudentNumberByDepartment(departmentId) {
	fetch(ctx + "/student/setStudentNumber", {
		method : "post",
		headers : {
			"Content-Type" :"application/json"
		},
		body : JSON.stringify({departmentId})
	})
	.then(res => res.json())
	.then(data => {
		console.log(data.studentNumber);
		document.querySelector("#studentNumberId1").value = data.studentNumber;
	});
}


function RegisterStudent() {
	modifyStudent1.innerHTML = "";
	fetch(ctx + "/student/register")
	.then(res => res.json())
	.then(data => {
		const departmentList = data.departmentList;
		const studentNumber = data.studentNumber;
		
		let departmentOption = ``;
		
		for(var department of departmentList) {
			departmentOption += `<option value="\${department.id }">\${department.name } - \${department.college.name } - \${department.college.organization.name }</option>`
		}
		
		document.querySelector("#professorInfoByProfessorNumber").innerHTML = `
			<div class="row">
			<div class="col">
				<div class="mb-3">
					<h1>교수 등록</h1>
				</div>
				<form id="registerForm1" action="" method="post" enctype="multipart/form-data">
				
					<div class="mb-3">
						<label for="" class="form-label">학부</label>
						<select onchange="SetProfessorNumberByDepartment(this.value)" id="selectDepartmentId1" name="departmentId" class="form-select" aria-label="Default select example">
							\${departmentOption}
						</select>
					</div>
					
					
					<div class="mb-3">
						<label for="" class="form-label">교수번호</label>
						<input id="professorNumberId1" required="required" type="number" class="form-control" name="professorNumber">
					</div>
				
					<div class="mb-3">
						<label for="" class="form-label">이름</label>
						<input id="" required="required" type="text" class="form-control" name="name">
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">아이디</label>
						<input id="" type="text" class="form-control" name="loginId">
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">비밀번호</label>
						<input id="" type="text" class="form-control" name="password">
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">연락처</label>
						<input id="" type="text" class="form-control" name="contact">
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">이메일</label>
						<input id="" type="email" class="form-control" name="email">
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">홈페이지</label>
						<input id="" type="url" class="form-control" name="homepage">
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
		`;
	});
}



function GetStudentInfo(studentNumber) {
	modifyStudent1.innerHTML = "";
	fetch(ctx + "/student/getInfo/" + studentNumber)
	.then(res => res.json())
	.then(student => {	
		document.querySelector("#professorInfoByProfessorNumber").innerHTML = `
			<div class="row">
				<div class="col">
					<div class="d-flex">
						<h1 class="me-auto">학생 정보</h1>
						<button onclick="ModifyStudent(\${student.studentNumber})" class="btn btn-link" type="button">
						<i class="fa-solid fa-pen-to-square">학생 정보 수정</i>
						</button>
					</div>

					<div class="mb-3">
						<label class="form-label">
							학번 
						</label>
						<input class="form-control" type="number" value="\${student.studentNumber }" readonly>
					</div>	
					
					<div class="mb-3">
						<label class="form-label">
							학부 
						</label>
						<input class="form-control" type="text" value="\${student.department.name } - \${student.department.college.name } - \${student.department.college.organization.name }" readonly>
					</div>	
					
					<div class="mb-3">
						<label class="form-label">
							학년 
						</label>
						<input class="form-control" type="text" value="\${student.grade }" readonly>
					</div>	
					
					<div class="mb-3">
						<label class="form-label">
							이름 
						</label>
						<input class="form-control" type="text" value="\${student.studentName }" readonly>
					</div>	
					
					<div class="mb-3">
						<label class="form-label">
							아이디 
						</label>
						<input class="form-control" type="text" value="\${student.id }" readonly>
					</div>
					
					<div class="mb-3">
						<label class="form-label">
							패스워드 
						</label>
						<input class="form-control" type="text" value="\${student.password }" readonly>
					</div>
					
					<div class="mb-3">
						<label class="form-label">
							주민등록번호 
						</label>
						<input class="form-control" type="text" value="\${student.firstResidentId }-*******" readonly>
					</div>
				</div>
			</div>
		`
	});
}
</script>
</body>
</html>