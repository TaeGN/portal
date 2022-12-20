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
<div class="me-5">
	<div class="row">
		<div class="col">
			<table class="table">
				<div class="d-flex">
				    <div class="mt-3 ms-3 mb-3 me-auto">
						<h3><i class="fa-solid fa-angle-right"></i> 교수 정보</h3>
					</div>
					
					<hr>
					<button onclick="RegisterProfessor()" class="btn btn-link" type="button">
						교수 등록
					</button>
				</div>
				<thead>
					<tr>
						<th>교수번호</th>
						<th>이름</th>
						<th>연락처</th>
						<th>이메일</th>
						<th>홈페이지</th>
						<th>소속학부</th>
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
							<td>${professor.contact }</td>
							<td>${professor.email }</td>
							<td>${professor.homepage }</td>
							<td>${professor.department.name }</td>
						</tr>
					</c:forEach>				
				</tbody>
			</table>
		</div>
		<div id="paginationId1">
		<c:url value="/professor/list" var="currentPageLink"></c:url>
		<my:paginationNav></my:paginationNav>
		</div>
	</div>
</div>
<c:if test="${hasAuthority }">
	<div class="me-5" id="professorInfoByProfessorNumber"></div>
	<div class="me-3" id="modifyProfessorId1"></div>
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
	<div class="modal fade" id="removeModal" tabindex="-1" aria-labelledby="removeModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="removeModalLabel">삭제 확인</h1>
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


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
const ctx = "${pageContext.request.contextPath}";
const modifyProfessor1 = document.querySelector("#modifyProfessorId1");


// 수정확인 버튼 클릭하면 수정 form 전송
document.querySelector("#modifyConfirmButton").addEventListener("click", function() {
	document.querySelector("#modifyForm").submit();
});

// 삭제확인 버튼 클릭하면 삭제 form 전송
document.querySelector("#removeConfirmButton").addEventListener("click", function() {
	document.querySelector("#removeForm").submit();
});


function GetDepartmentByCollege(collegeId) {
	fetch(ctx + "/sugang/getDepartment/" + collegeId)
	.then(res => res.json())
	.then(data => {
		const departmentList = data.departmentList;
		
		let departmentOption = `<option value=""> </option>`;
		
		for(var department of departmentList) {
			departmentOption += `<option value="\${department.id }">\${department.name }</option>`
		}
		
		document.querySelector("#departmentId1").innerHTML = `
			<div>
				<select onchange="SetProfessorNumberByDepartment(this.value)" name="departmentId" class="form-select" aria-label="Default select example">
					\${departmentOption}
				</select>
			</div>
		`;
	});
}

function GetCollegeByOrganization(organizationId) {
	fetch(ctx + "/sugang/getCollege/" + organizationId)
	.then(res => res.json())
	.then(data => {
		const collegeList = data.collegeList;
		let collegeOption = `<option value="0"> </option>`;
		
		for(var college of collegeList) {
			collegeOption += `<option value="\${college.id }">\${college.name }</option>`
		}
		
		document.querySelector("#collegeId1").innerHTML = `
			<div>
				<select onchange="GetDepartmentByCollege(this.value)" name="collegeId" class="form-select" aria-label="Default select example">
					\${collegeOption}
				</select>
			</div>
		`;
	});
	GetDepartmentByCollege(0);
}

function ModifyProfessor(professorNumber) {
	fetch(ctx + "/professor/modify/" + professorNumber)
	.then(res => res.json())
	.then(data => {
		const professor = data.professor;
		const organizationList = data.organizationList;
		
		let organizationOption = `<option value="0"> </option>`;
		
		for(var organization of organizationList) {
			organizationOption += `<option value="\${organization.id }">\${organization.name }</option>`
		}
		
		document.querySelector("#modifyProfessorId1").innerHTML = `

			<div class="row">
				<div class="col">
					<div class="d-flex">
						<h1 class="me-auto">교수 정보 수정</h1>
					</div>
					<form id="modifyForm" action="\${ctx}/professor/modify" method="post" enctype="multipart/form-data">
						<div class="mb-3">
							<label for="" class="form-label">교수번호</label>
							<input id="professorNumberId1" value="\${professor.professorNumber }" type="number" class="form-control" name="professorNumber" readonly>
						</div>
					
						<label for="" class="form-label">학부</label>
						<div class="mb-3 d-flex">
							<div>
								<select onchange="GetCollegeByOrganization(this.value)" name="organizationId" value="0" class="form-select" aria-label="Default select example">
									\${organizationOption}
								</select>	
							</div>
							<div id="collegeId1">
								<select name="collegeId" value="0" class="form-select" aria-label="Default select example" >
								</select>
							</div>
							
							<div id="departmentId1">
								<select name="departmentId" value="0" class="form-select" aria-label="Default select example" >
								</select>
							</div>
						</div>
						
					
						<div class="mb-3">
							<label for="" class="form-label">이름</label>
							<input type="text" value="\${professor.name }" class="form-control" name="name">
						</div>
						
						<div class="mb-3">
							<label for="" class="form-label">아이디</label>
							<input type="text" class="form-control" value="\${professor.loginId }" name="loginId">
						</div>
						
						<div class="mb-3">
							<label for="" class="form-label">비밀번호</label>
							<input type="text" class="form-control" value="" name="password">
						</div>
						
						<div class="mb-3">
							<label for="" class="form-label">연락처</label>
							<input type="text" class="form-control" value="\${professor.contact }" name="contact">
						</div>
						
						<div class="mb-3">
							<label for="" class="form-label">이메일</label>
							<input type="email" class="form-control" value="\${professor.email }" name="email">
						</div>
						
						<div class="mb-3">
							<label for="" class="form-label">홈페이지</label>
							<input type="url" class="form-control" value="\${professor.homepage }" name="homepage">
						</div>
					
						
						<div class="mb-3">
							<label for="" class="form-label">주민번호</label>
							<div class="d-flex">
								<input required="required" type="text" class="form-control" name="firstResidentId" value="\${professor.firstResidentId }" placeholder="주민등록번호 앞 6자리">
								<input required="required" type="password" class="form-control" name="lastResidentId" value="\${professor.lastResidentId }" placeholder="주민등록번호 뒤 7자리">
							</div>
						</div>
						
					</form>
					
					<input class="btn btn-warning" type="submit" value="수정" data-bs-toggle="modal" data-bs-target="#modifyModal">
					<input class="btn btn-danger" type="submit" value="삭제" data-bs-toggle="modal" data-bs-target="#removeModal">
					
					<form id="removeForm" action="\${ctx }/professor/remove" method="post">
					<input type="hidden" name="professorNumber" value="\${professor.professorNumber }">
					</form>
				</div>
			</div>
		`;
		GetCollegeByOrganization(0);
	});
}


//register에서 department에 따른 professorNumber 자동 할당
function SetProfessorNumberByDepartment(departmentId) {
	fetch(ctx + "/professor/setProfessorNumber", {
		method : "post",
		headers : {
			"Content-Type" :"application/json"
		},
		body : JSON.stringify({departmentId})
	})
	.then(res => res.json())
	.then(data => {
		console.log(data.professorNumber);
		document.querySelector("#professorNumberId1").value = data.professorNumber;
	});
}


function RegisterProfessor() {
	modifyProfessor1.innerHTML = "";
	fetch(ctx + "/professor/register")
	.then(res => res.json())
	.then(data => {
		const professorNumber = data.professorNumber;
		const organizationList = data.organizationList;
		
		let organizationOption = `<option value="0"> </option>`;
		
		for(var organization of organizationList) {
			organizationOption += `<option value="\${organization.id }">\${organization.name }</option>`
		}
		console.log(organizationOption)
		
		document.querySelector("#professorInfoByProfessorNumber").innerHTML = `
		<div class="row">
			<div class="col">
				<div class="mb-3">
					<h1>교수 등록</h1>
				</div>
				<form id="registerForm1" action="\${ctx}/professor/register" method="post" enctype="multipart/form-data">
				
				<label for="" class="form-label">학부</label>
				<div class="mb-3 d-flex">
					<div id="organizationId1">
						<select onchange="GetCollegeByOrganization(this.value)" name="organizationId" value="1" class="form-select" aria-label="Default select example">
							\${organizationOption}
						</select>	
					</div>
					<div id="collegeId1">
						<select name="collegeId" value="1" class="form-select" aria-label="Default select example" >
						</select>
					</div>
					
					<div id="departmentId1">
						<select onchange="SetProfessorNumberByDepartment(this.value)" name="departmentId" value="1" class="form-select" aria-label="Default select example" >
						</select>
					</div>
				</div>
					
					
					<div class="mb-3">
						<label for="" class="form-label">교수번호</label>
						<input id="professorNumberId1" required="required" type="number" class="form-control" value="\${professorNumber}" name="professorNumber">
					</div>
				
					<div class="mb-3">
						<label for="" class="form-label">이름</label>
						<input required="required" type="text" class="form-control" name="name">
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">아이디</label>
						<input type="text" class="form-control" name="loginId">
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">비밀번호</label>
						<input type="text" class="form-control" name="password">
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">연락처</label>
						<input type="text" class="form-control" name="contact">
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">이메일</label>
						<input type="email" class="form-control" name="email">
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">홈페이지</label>
						<input type="url" class="form-control" name="homepage">
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
		GetCollegeByOrganization(0);
	});
}



function GetProfessorInfo(professorNumber) {
	modifyProfessor1.innerHTML = "";
	fetch(ctx + "/professor/getInfo/" + professorNumber)
	.then(res => res.json())
	.then(professor => {	
		document.querySelector("#professorInfoByProfessorNumber").innerHTML = `
			<div class="row">
				<div class="col">
					<div class="d-flex">
						<h1 class="me-auto">교수 정보</h1>
						<button onclick="ModifyProfessor(\${professor.professorNumber})" class="btn btn-link" type="button">
						<i class="fa-solid fa-pen-to-square">교수 정보 수정</i>
						</button>
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">교수번호</label>
						<input value="\${professor.professorNumber }" type="number" class="form-control" name="professorNumber" readonly>
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">학부</label>
						<input class="form-control" type="text" value="\${professor.department.name } - \${professor.department.college.name } - \${professor.department.college.organization.name }" readonly>
					</div>
					
				
					<div class="mb-3">
						<label for="" class="form-label">이름</label>
						<input type="text" value="\${professor.name }" class="form-control" name="name" readonly>
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">아이디</label>
						<input type="text" class="form-control" value="\${professor.loginId }" name="loginId" readonly>
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">비밀번호</label>
						<input type="text" class="form-control" value="*******" name="password" readonly>
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">연락처</label>
						<input type="text" class="form-control" value="\${professor.contact }" name="contact" readonly>
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">이메일</label>
						<input type="email" class="form-control" value="\${professor.email }" name="email" readonly>
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">홈페이지</label>
						<input type="url" class="form-control" value="\${professor.homepage }" name="homepage" readonly>
					</div>
				
					
					<div class="mb-3">
						<label for="" class="form-label">주민번호</label>
						<div class="d-flex">
						<input class="form-control" type="text" value="\${professor.firstResidentId }-*******" readonly>
						</div>
					</div>
					
		`
	});
}
</script>
</body>
</html>