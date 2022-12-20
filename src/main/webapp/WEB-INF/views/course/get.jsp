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
	<div class="ms-3 me-5">
		<div class="row">
			<div class="col">
			
				<div class="d-flex mb-3 mt-3 me-auto">
					<h3><i class="fa-solid fa-angle-right"></i> 수업번호 : ${course.classCode } - ${course.courseInfo.courseName }</h3>
					
						 
					<button onclick="ModifyCourse(this.value)" value="${course.classCode}" class="btn btn-link" type="button">
						<i class="fa-solid fa-pen-to-square">강의 정보 수정</i>
					</button>
				</div>
				
				<div class="mb-3">
					<label class="form-label">
					년도 / 학년 / 학기
					</label>
					<input class="form-control" type="text" value="${course.year }년 / ${course.grade } / ${course.semester }" readonly>
				</div>
				
				<div class="mb-3">
					<label class="form-label">
						이수구분 
					</label>
					<input class="form-control" type="text" value="${course.courseInfo.courseClassification }" readonly>
				</div>	
				
				<div class="mb-3">
					<label class="form-label">
						수업번호 
					</label>
					<input class="form-control" type="text" value="${course.classCode }" readonly>
				</div>
				
				<div class="mb-3">
					<label class="form-label">
						학수번호 
					</label>
					<input class="form-control" type="text" value="${course.classNumber }" readonly>
				</div>
				
				<div class="mb-3">
					<label class="form-label">
						교과목명 
					</label>
					<input class="form-control" type="text" value="${course.courseInfo.courseName }" readonly>
				</div>
				
				<div class="mb-3">
					<label class="form-label">
						교강사 
					</label>
					<input class="form-control" type="text" value="${course.professor.name }" readonly>
				</div>
				
				<div class="mb-3">
					<label class="form-label">
						학점 
					</label>
					<input class="form-control" type="text" value="${course.courseInfo.credit }" readonly>
				</div>		
				
				<div class="mb-3">
					<label class="form-label">
						강의 
					</label>
					<input class="form-control" type="text" value="${course.courseInfo.theory }" readonly>
				</div>	
				
				<div class="mb-3">
					<label class="form-label">
						실습 
					</label>
					<input class="form-control" type="text" value="${course.courseInfo.practice }" readonly>
				</div>	
				
				
				<div class="mb-3">
					<label class="form-label">
						강의시간 
					</label>
					<input class="form-control" type="text" value="${course.dayTime }" readonly>
				</div>	
				
				<div class="mb-3">
					<label class="form-label">
						강의실 
					</label>
					<input class="form-control" type="text" value="${course.classroom }" readonly>
				</div>
				
				<div class="mb-3">
					<label class="form-label">
						수강정원 
					</label>
					<input class="form-control" type="text" value="${course.maxPersonnel }" readonly>
				</div>
				
				<div class="mb-3">
					<label class="form-label">
						관장학과 
					</label>
					<input class="form-control" type="text" value="${course.department.name }" readonly>
				</div>
			</div>
		</div>
	</div>
	
	<div id="modifyCourseId1"></div>
	
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


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
const ctx = "${pageContext.request.contextPath}";
const modifyCourse1 = document.querySelector("#modifyCourseId1");

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
		
		let departmentOption = ``;
		
		for(var department of departmentList) {
			departmentOption += `<option value="\${department.id }">\${department.name }</option>`
		}
		
		document.querySelector("#departmentId1").innerHTML = `
			<div>
				<select name="departmentId" value="0" class="form-select" aria-label="Default select example">
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
		let collegeOption = ``;
		
		for(var college of collegeList) {
			collegeOption += `<option value="\${college.id }">\${college.name }</option>`
		}
		
		document.querySelector("#collegeId1").innerHTML = `
			<div>
				<select onchange="GetDepartmentByCollege(this.value)" name="collegeId" value="1" class="form-select" aria-label="Default select example">
					\${collegeOption}
				</select>
			</div>
		`;
	});
	
	GetDepartmentByCollege(1);
}


// 수정확인 버튼 클릭하면 수정 form 전송
document.querySelector("#modifyConfirmButton").addEventListener("click", function() {
	document.querySelector("#modifyForm").submit();
});

// 삭제확인 버튼 클릭하면 삭제 form 전송
document.querySelector("#removeConfirmButton").addEventListener("click", function() {
	document.querySelector("#removeForm").submit();
});

function SelectStartTime(selectStartTime) {
	const startTimeId = selectStartTime.value;
	const nextSelect = selectStartTime.nextElementSibling;
	
	fetch(ctx + "/course/getEndTime/" + startTimeId)
	.then(res => res.json())
	.then(map => {
		
		const courseTimeList = map.courseTimeList;
		
		let endTimeOptions = ``;
		for(let courseTime of courseTimeList) {
			endTimeOptions += `<option value="\${courseTime.id }">\${courseTime.time }</option>`;
		} 
		
		nextSelect.innerHTML = `
			\${endTimeOptions}
		`;
	})
}

function AddCourseSchedule(num) {
	document.querySelector("#courseScheduleId1").insertAdjacentHTML("beforeend",`
			<div class="d-flex">
				<select name="day" class="form-select" aria-label="Default select example">
					<option value="Monday">월</option>
					<option value="Tuesday">화</option>
					<option value="Wednesday">수</option>
					<option value="Thursday">목</option>
					<option value="Friday">금</option>
					<option value="Saturday">토</option>
					<option value="Sunday">일</option>
				</select>
				<select onclick="SelectStartTime(this)" value="1" name="startTimeId" class="form-select" aria-label="Default select example">
					<c:forEach items="${courseTimeList }" var="courseTime" end="23">
						<option value="${courseTime.id }">${courseTime.time }</option>
					</c:forEach>
				</select>
				<select name="endTimeId" class="form-select" aria-label="Default select example">
					<c:forEach items="${courseTimeList }" var="courseTime" begin="1">
						<option value="${courseTime.id }">${courseTime.time }</option>
					</c:forEach>
				</select>
				<button onclick="DeleteCourseSchedule(this)" value="" type="button" class="btn btn-light">
					<i class="fa-solid fa-xmark"></i>
				</button>
				<button onclick="AddCourseSchedule(this.value)" value="" type="button" class="btn btn-primary">
					<i class="fa-solid fa-plus"></i>
				</button>
			</div>
			`);
}

function DeleteCourseSchedule(deleteButton) {
	deleteButton.parentElement.remove();
}

function ModifyCourse(classCode) {
	fetch(ctx + "/course/modify/" + classCode)
	.then(res => res.json())
	.then(data => {
		const organizationList = data.organizationList;
		const course = data.course;
		const courseInfoList = data.courseInfoList;
		const professorList = data.professorList;
		const courseTimeList = data.courseTimeList;
		const buildingList = data.buildingList;
		const roomListByFirstBuilding = data.roomListByFirstBuilding;
		
		let organizationOption = ``;
		let classNumberOption = ``;
		let professorOption = ``;
		let buildingOption = ``;
		let roomOption = ``;
		
		for(var organization of organizationList) {
			organizationOption += `<option value="\${organization.id }">\${organization.name }</option>`
		}
		
		for(var courseInfo of courseInfoList) {
			classNumberOption += `<option value="\${courseInfo.classNumber }">\${courseInfo.classNumber } : \${courseInfo.courseName }</option>`
		}	
		
		for(var professor of professorList) {
			professorOption += `<option value="\${professor.professorNumber }">\${professor.name } : \${professor.department.name } - \${professor.department.college.name } - \${professor.department.college.organization.name }</option>`
		}	
		
		for(var building of buildingList) {
			buildingOption += `<option value="\${building.campus }:\${building.id }">\${building.campus } \${building.name }</option>`
		}
		for(var room of roomListByFirstBuilding) {
			roomOption += `<option value="\${room.room }\${room.classification }">\${room.room }\${room.classification }</option>`
		}	
		
		modifyCourse1.innerHTML = `

			<div class="row">
				<div class="col">
					<div class="d-flex mb-3 mt-3 me-auto">
						<h3><i class="fa-solid fa-angle-right"></i> 수업번호 : ${course.classCode } - ${course.courseInfo.courseName } 수정</h3>
					</div>
					<form id="modifyForm" action="\${ctx}/course/modify" method="post" enctype="multipart/form-data">
						<div class="mb-3">
							<label class="form-label">
								수업번호 
							</label>
							<input class="form-control" type="text" value="\${course.classCode }" name="classCode">
						</div>
						
						<div class="mb-3">
							<label for="" class="form-label">학수번호</label>
							<select name="classNumber" value="\${course.classNumber}" class="form-select" aria-label="Default select example">
								\${classNumberOption}
							</select>
						</div>
						
						<label for="" class="form-label">년도 / 학년 / 학기</label>
						<div class="mb-3 d-flex">
							<input required="required" type="number" class="form-control" name="year" value="\${course.year}">
							<select name="grade" class="form-select" aria-label="Default select example">
								<option value="1학년">1학년</option>
								<option value="2학년">2학년</option>
								<option value="3학년">3학년</option>
								<option value="4학년">4학년</option>
								<option value="5학년">5학년</option>
								<option value="전학년">전학년</option>
							</select>
								<select name="semester" class="form-select" aria-label="Default select example">
								  <option value="1학기">1학기</option>
								  <option value="여름학기">여름학기</option>
								  <option value="2학기">2학기</option>
								  <option value="겨울학기" selected>겨울학기</option>
								</select>
						</div>
						
						
						<div class="mb-3">
							<label for="" class="form-label">교강사</label>
							<select name="professorNumber" class="form-select" aria-label="Default select example">
								\${professorOption}
							</select>
						</div>
						
						<div class="mb-3">
							<label for="" class="form-label">수강정원</label>
							<input required="required" type="number" class="form-control" name="maxPersonnel" value="\${course.maxPersonnel}">
						</div>
						
						<div id="courseScheduleId1" class="mb-3">
							<label for="" class="form-label">
								수업시간 
							</label>
							<div class="d-flex">
								<select name="day" class="form-select" aria-label="Default select example">
									<option value="Monday">월</option>
									<option value="Tuesday">화</option>
									<option value="Wednesday">수</option>
									<option value="Thursday">목</option>
									<option value="Friday">금</option>
									<option value="Saturday">토</option>
									<option value="Sunday">일</option>
								</select>
								<select onclick="SelectStartTime(this)" value="1" name="startTimeId" class="form-select" aria-label="Default select example">
									<c:forEach items="${courseTimeList }" var="courseTime" end="23">
										<option value="${courseTime.id }">${courseTime.time }</option>
									</c:forEach>
								</select>
								<select name="endTimeId" class="form-select" aria-label="Default select example">
									<c:forEach items="${courseTimeList }" var="courseTime" begin="1">
										<option value="${courseTime.id }">${courseTime.time }</option>
									</c:forEach>
								</select>
								<div id="buttonId1" class="d-flex">
									<button id="" type="button" disabled="disabled" class="btn btn-light">
										<i class="fa-solid fa-xmark"></i>
									</button>
									<button onclick="AddCourseSchedule(this.value + 1)" value="1" type="button" class="btn btn-primary">
										<i class="fa-solid fa-plus"></i>
									</button>
								</div>
							</div>
						</div>
						
						<div class="mb-3">
							<label for="" class="form-label">강의실</label>
							<div class="d-flex">
								<select id="selectBuildingId1" name="building" class="form-select" aria-label="Default select example" >
									\${buildingOption}
								</select>
								<select id="selectRoomId1" name="room" class="form-select" aria-label="Default select example">
									\${roomOption}
								</select>
							</div>
						</div>
						
						<label for="" class="form-label">관장학과</label>
						<div class="mb-3 d-flex">
							<div id="organizationId1">
								<select onchange="GetCollegeByOrganization(this.value)" name="organizationId" value="0" class="form-select" aria-label="Default select example">
									\${organizationOption}
								</select>	
							</div>
							<div id="collegeId1">
								<select name="collegeId" value="0" class="form-select" aria-label="Default select example" >
								</select>
							</div>
							
							<div id="departmentId1">
								<select name="departmentId1" value="0" class="form-select" aria-label="Default select example" >
								</select>
							</div>
						</div>
						
						
					</form>
					
					<input class="btn btn-warning" type="submit" value="수정" data-bs-toggle="modal" data-bs-target="#modifyModal">
					<input class="btn btn-danger" type="submit" value="삭제" data-bs-toggle="modal" data-bs-target="#removeModal">
					
					<form id="removeForm" action="\${ctx }/course/remove" method="post">
					<input type="hidden" name="classCode" value="\${course.classCode }">
					</form>
				</div>
			</div>
		`;
	
	GetCollegeByOrganization(1);
	});
}

</script>
</body>
</html>