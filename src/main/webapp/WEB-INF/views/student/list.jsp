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
	<div class="row p-2">
		<div class="col">
			<table class="table">
				<div class="d-flex">
					<div class="mt-3 ms-3 mb-3 me-auto">
						<h3><i class="fa-solid fa-angle-right"></i> 학생 정보</h3>
					</div>
					
					<hr>
					<button onclick="RegisterStudent()" class="btn btn-link" type="button">
						학생 등록
					</button>
				</div>
				<thead>
					<tr>
						<th>학번</th>
						<th>학부</th>
						<th>학년</th>
						<th>이름</th>
						<th>아이디</th>
						<th>패스워드</th>
						<th>주민등록번호</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${studentList }" var="student">
						<tr>
							<td>
								<button onclick="GetStudentInfo(${student.studentNumber})" class="btn btn-link" type="button">
									${student.studentNumber }
								</button>
							</td>
							<td>${student.department.name }</td>
							<td>${student.grade }</td>
							<td>${student.studentName }</td>
							<td>${student.id }</td>
							<td>*******</td>
							<td>******-*******</td>
						</tr>
					</c:forEach>				
				</tbody>
			</table>
		</div>
		<div id="paginationId1">
		<c:url value="/student/list" var="currentPageLink"></c:url>
		<my:paginationNav></my:paginationNav>
		</div>		
	</div>
</div>

<c:if test="${hasAuthority }">
	<div class="me-5" id="studentInfoByStudentNumber">
	
	</div>
	
	<div class="me-3" id="modifyStudentId1"></div>
</c:if>
<div class="ms-auto" id="adminLogId1"></div>
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



/* <tr>
<td>\${adminLog.id }</td>
<td>\${adminLog.menu } - \${adminLog.category }</td>
<td>\${adminLog.log }</td>
<td>\${adminLog.adminId }-\${adminLog.adminName }</td>
<td>\${adminLog.inserted }</td>
</tr> */

const adminLog1 = document.querySelector("#adminLogId1");
function GetAdminLog(page) {
	fetch(ctx + "/admin/getAdminLog/" + page)
	.then(res => res.json())
	.then(data => {
		const adminLogList = data.adminLogList;
		const maxPage = data.maxPage;
		
		let adminLogBody = ``;
		
		for(var adminLog of adminLogList) {
			adminLogBody += `
				<tr>
					<td>\${adminLog.id }. \${adminLog.log }</td>
					<td>\${adminLog.adminId }-\${adminLog.adminName }</td>
				</tr>			
			`;
		}
		
		
		const startPage = parseInt((page - 1) / 10) + 1;
		const endPage = (page + 9) < maxPage ? page + 9 : maxPage;
		
		var val2 = '';
		var val3 = '';
		var val4 = '';
		var val5 = '';
		
		if(page == 1) {
			var val2 = 'disabled';
		}
		
		if(page <= 10) {
			var val3 = 'disabled';
		} 		
		
		if(((page - 1) / 10) * 10 + 11 > maxPage) {
			var val4 = 'disabled';
		} 
		
		if(page == maxPage) {
			var val5 = 'disabled';
		} 		

		
		let pageOptions = ``;
		for(var i = startPage; i <= endPage; i++ ) {
			var val1 = ``;
			if(page == i) {
				var val1 = 'active'
			}
			
			pageOptions += `
				<li class="page-item \${val1}">
				<button onclick="GetAdminLog(\${i})" class="page-link">\${i }</button>
			    </li>`;
		}
		
		
		let pagination1 = `
			<nav aria-label="Page navigation example">
			  <ul class="pagination justify-content-center">

			    <li class="page-item \${val2}">
				    <button onclick="GetAdminLog(1)" class="page-link"><i class="fa-solid fa-angles-left"></i></button>
			    </li>

			    <li class="page-item \${val3}">
				    <button onclick="GetAdminLog(\${(page - 1) - (page - 1) % 10 })" class="page-link"><i class="fa-solid fa-angle-left"></i></button>
			    </li> 
			    
			    \${pageOptions}
			  
			     <li class="page-item \${val4}">
				    <button onclick="GetAdminLog(\${((page - 1) / 10) * 10 + 11 })" class="page-link"><i class="fa-solid fa-angle-right"></i></button>
			    </li>
			    
			    <li class="page-item \${val5}">
				    <button onclick="GetAdminLog(\${maxPage })" class="page-link"><i class="fa-solid fa-angles-right"></i></button>
			    </li>
			  </ul>
			</nav>		
		`;
		
		adminLog1.innerHTML = `
		<div class="row">
			<div class="col">
				<table class="table">
					<div class="mt-3 ms-3 mb-3 me-auto">
						<h3><i class="fa-solid fa-angle-right"></i> 관리자 로그</h3>
					</div>			
					<thead>
						<tr>
							<th>로그</th>
							<th>관리자명</th>
						</tr>
					</thead>
					<tbody>
						\${adminLogBody}				
					</tbody>
				</table>
			</div>
			\${pagination1}
		</div>`;	

		
	});
}


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
				<select onchange="SetStudentNumberByDepartment(this.value)" name="departmentId" class="form-select" aria-label="Default select example">
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

function ModifyStudent(studentNumber) {
	fetch(ctx + "/student/modify/" + studentNumber)
	.then(res => res.json())
	.then(data => {
		const student = data.student;
		const organizationList = data.organizationList;
		
		let organizationOption = `<option value="0"> </option>`;
		
		for(var organization of organizationList) {
			organizationOption += `<option value="\${organization.id }">\${organization.name }</option>`
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
					
					<label for="" class="form-label">학부</label>
					<div class="mb-3 d-flex">
						<div id="organizationId1">
							<select onchange="GetCollegeByOrganization(this.value)" name="organizationId" value="0" class="form-select" aria-label="Default select example">
								\${organizationOption}
							</select>	
						</div>
						<div id="collegeId1">
							<select name="collegeId" value="0" class="form-select" aria-label="Default select example" >
								<option value=""> </option>
							</select>
						</div>
						
						<div id="departmentId1">
							<select name="departmentId1" value="0" class="form-select" aria-label="Default select example" >
								<option value=""> </option>
							</select>
						</div>
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
	GetCollegeByOrganization(0);
	});
}


//register에서 department에 따른 studentNumber 자동 할당
function SetStudentNumberByDepartment(departmentId) {
	console.log(departmentId);
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
		const studentNumber = data.studentNumber;
		const organizationList = data.organizationList;
		
		let organizationOption = `<option value="0"> </option>`;
		
		for(var organization of organizationList) {
			organizationOption += `<option value="\${organization.id }">\${organization.name }</option>`
		}
		
		document.querySelector("#studentInfoByStudentNumber").innerHTML = `
			<div class="row">
				<div class="col">
					<div class="mb-3">
						<h1>학생 등록</h1>
					</div>
					<form id="registerForm1" action="\${ctx}/student/register" method="post" enctype="multipart/form-data">
					
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
							<select onchange="SetStudentNumberByDepartment(this.value)" name="departmentId" value="1" class="form-select" aria-label="Default select example" >
							</select>
						</div>
					</div>
						
						<div class="mb-3">
							<label for="" class="form-label">학번</label>
							<input id="studentNumberId1" required="required" type="number" value="\${studentNumber}" class="form-control" name="studentNumber">
						</div>
						
						<div class="mb-3">
							<label for="" class="form-label">학년</label>
							<select name="grade" class="form-select" aria-label="Default select example">
								<option value="1학년" selected="selected">1학년</option>
								<option value="2학년">2학년</option>
								<option value="3학년">3학년</option>
								<option value="4학년">4학년</option>
								<option value="5학년">5학년</option>
							</select>
						</div>
						
						<div class="mb-3">
							<label for="" class="form-label">이름</label>
							<input required="required" type="text" class="form-control" name="studentName" value="">
						</div>
						
						<div class="mb-3">
							<label for="" class="form-label">주민번호</label>
							<div class="d-flex">
							<div class="d-flex">
							<input required="required" type="number" class="form-control" name="firstResidentId" placeholder="주민등록번호 앞 6자리">
							<div class="ms-2 me-2"><i class="fa-solid fa-minus"></i></div>
							<input required="required" type="number" class="form-control" name="lastResidentId" placeholder="주민등록번호 뒤 7자리">
						</div>
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


function GetStudentInfo(studentNumber) {
	modifyStudent1.innerHTML = "";
	fetch(ctx + "/student/getInfo/" + studentNumber)
	.then(res => res.json())
	.then(student => {	
		document.querySelector("#studentInfoByStudentNumber").innerHTML = `
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
						<input class="form-control" type="text" value="\${student.department.college.organization.name } - \${student.department.college.name } - \${student.department.name }" readonly>
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