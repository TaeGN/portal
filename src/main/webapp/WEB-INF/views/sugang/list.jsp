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
<style type="text/css">


</style>
</head>
<body>
<sec:authentication property="name" var="studentId"/>
<sec:authorize access="hasAuthority('student')" var="hasStudentAdmin"></sec:authorize>

<my:sugangNavBar></my:sugangNavBar>
<form action="" method="get" id="searchFormId1">
<div class="d-flex mb-3 mt-3">
	<label class="form-label">
		조직
	</label>
	<div class="me-3">
		<!-- <label for="" class="form-label">조직</label> -->
		<select onchange="GetCollegeByOrganization(this.value)" name="organizationId" value="0" class="form-select" aria-label="Default select example">
			<option value="0">전체</option>
			<c:forEach items="${organizationList }" var="organization" >
				<option value="${organization.id }">${organization.name }</option>
			</c:forEach>
		</select>
	</div>
	<label class="form-label">
		대학
	</label>
	<div id="collegeId1"></div>
	
	<label class="form-label">
		학부
	</label>
	<div id="departmentId1"></div>
	
	<label class="form-label">
		이수구분
	</label>
	<div class="me-3">
		<select name="courseClassification" class="form-select" aria-label="Default select example">
		  <option value="전체">전체</option>
		  <option value="전공기초">전공기초(필수)</option>
		  <option value="전공심화">전공심화</option>
		  <option value="전공핵심">전공핵심</option>
		  <option value="핵심교양">핵심교양</option>
		  <option value="일반교양">일반교양</option>
		  <option value="교양필수">교양필수</option>
		</select>
	</div>
	
	<label class="form-label">
		년도
	</label>
	<div class="me-3">
		<select name="year" id="yearId1" class="form-select" aria-label="Default select example">
			<option value="0">전체</option>
			<c:set var="nowYear" value="2022"></c:set>
			<c:forEach var="i" begin="2000" end="${nowYear }" step="1">
			  <option value="${nowYear - i + 2000 }">${nowYear - i + 2000 }</option>
			</c:forEach>
		</select>
	</div>
	
	<label class="form-label">
		학기
	</label>
	<div class="me-3">
		<select name="semester" id="semesterId1" class="form-select" aria-label="Default select example">
		<option value="전체">전체</option>
		  <option value="1학기">1학기</option>
		  <option value="여름학기">여름학기</option>
		  <option value="2학기">2학기</option>
		  <option value="겨울학기">겨울학기</option>
		</select>
	</div>
	
	<label class="form-label">
		학년
	</label>
	<div class="me-3">
		<select name="grade" id="gradeId1" class="form-select" aria-label="Default select example">
		  <option selected value="전체">전체</option>
		  <option value="1학년">1</option>
		  <option value="2학년">2</option>
		  <option value="3학년">3</option>
		  <option value="4학년">4</option>
		  <option value="5학년">5</option>
		  <option value="전학년">전학년</option>
		</select>
	</div>
	
	<div class="ms-auto me-3">
		<c:url var="goListLink" value="/sugang/list"></c:url>
		<a class="btn btn-success" href="${goListLink }">초기화</a>
	</div>

</div>

	
<div class="d-flex mb-3">
	<label class="form-label">
		강의동
	</label>
	<div class="me-3">
		<select name=building value="전체" class="form-select" aria-label="Default select example">
			<option value="전체">전체</option>
			<c:forEach items="${buildingList }" var="building2" >
				<option value="${building2.campus },${building2.name }">${building2.campus } ${building2.name }</option>
			</c:forEach>
		</select>
	</div>


	<label class="form-label">
		학수번호 
	</label>
	<div class="me-3">
		<input class="form-control" name="classNumber" type="text" value="">
	</div>
	
 	<label class="form-label">
		교과목명 
	</label>
	<div class="me-3">
		<input class="form-control" name="courseName" type="text" value="">
	</div>


 	<label class="form-label">
		교강사 
	</label>
	<div class="me-3">
		<input class="form-control" name="professorName" type="text" value="">
	</div>
	
	
	<div class="ms-auto me-3">
		<button onclick="SearchCourse(${studentId}, this.value)" class="btn btn-primary" id="submitButton1" type="button" value="1">조회</button>
	</div>
	
</div>


</form>

<hr>

<input type="hidden" name="studentId" value="${studentId }">

<div id="sugangListId1" >
	<div class="row">
		<div class="col">
			<table class="table table-bordered">
				<thead id="theadId1">
					<tr class="table-secondary">
						<sec:authorize access="isAuthenticated()">
							<c:if test="${hasStudentAdmin }">
								<th>수강희망</th>
							</c:if>
						</sec:authorize>
						<th>학년</th>
						<th>이수구분</th>
						<th>수업번호</th>
						<th>학수번호</th>
						<th>교과목명</th>
						<th>교강사</th>
						<th>학점</th>
						<th>강의</th>
						<th>실습</th>
						<th>수강정원</th>
						<th>수업시간</th>
						<th>강의실</th>
						<th>관장학과</th>
					</tr>
				</thead>
				<tbody id="sugangListBodyId">
					<c:forEach items="${courseList }" var="course">
						<tr>
<%-- 							<c:url value="/course/getByClassCode" var="getByClassCodeLink">
								<c:param name="classCode" value="${course.classCode }"></c:param>
							</c:url>
							<c:url value="/course/getByClassNumber" var="getByClassNumberLink">
								<c:param name="classNumber" value="${course.classNumber }"></c:param>
							</c:url> --%>
							<sec:authorize access="isAuthenticated()">
								<c:if test="${hasStudentAdmin }">
									<c:if test="${course.desire eq 'false'}">
										<td><button onclick="InsertCourseDesire(${course.classCode}, ${studentId}, ${page })" class="btn btn-primary" value="${course.classCode }">신청</button></td>
									</c:if>
									<c:if test="${course.desire eq 'true' }">
										<td><button onclick="DeleteCourseDesire(${course.classCode}, ${studentId}, ${page })" class="btn btn-danger" value="${course.classCode }">취소</button></td>
									</c:if>
								</c:if>
							</sec:authorize>
							<td>${course.grade }</td>
							<td>${course.courseInfo.courseClassification }</td>
							<td>
								<button onclick="GetSyllabus(${course.classCode})" type="button" class="btn btn-link">
								  ${course.classCode } <i class="fa-solid fa-magnifying-glass"></i>
								</button>
							</td>
							<td>
								<button onclick='GetCourseInfo("${course.classNumber}")' type="button" class="btn btn-light">
								  ${course.classNumber } <i class="fa-solid fa-magnifying-glass"></i>
								</button>
							</td>
							<td>${course.courseInfo.courseName }</td>
							<td>${course.professor.name }</td>
							<td>${course.courseInfo.credit }</td>
							<td>${course.courseInfo.theory }</td>
							<td>${course.courseInfo.practice }</td>
							<td>${course.maxPersonnel }</td>
							<td>${course.dayTime }</td>
<%-- 							<td>
								<c:forEach items="${course.courseSchedule }" var="courseSchedule">
									${courseSchedule.day } ${courseSchedule.startTime }-${courseSchedule.endTime } <br>
								</c:forEach>
							</td> --%>
							<td>${course.classroom }</td>
							<td>${course.department.name }</td>
						</tr>
					</c:forEach>				
				</tbody>
			</table>
		</div>
	</div>
</div>

<div id="paginationId1">
			<nav aria-label="Page navigation example">
			  <ul class="pagination justify-content-center">

			    <li class="page-item ${page eq 1 ? 'disabled' : ''}">
				    <button onclick="SearchCourse(${studentId}, 1)" class="page-link"><i class="fa-solid fa-angles-left"></i></button>
			    </li>

			    <li class="page-item ${page <= 10 ? 'disabled' : ''}">
				    <button onclick="SearchCourse(${studentId},${(page - 1) - (page - 1) % 10 })" class="page-link"><i class="fa-solid fa-angle-left"></i></button>
			    </li> 
			    
    			<c:forEach var="i" begin="${(page - 1) / 10 + 1 }" end="${page + 9 < maxPage ? page + 9 : maxPage}">
	    			<li class="page-item ${page eq i ? 'active' : ''}">
				    	<button onclick="SearchCourse(${studentId}, ${i })" class="page-link">${i }</button>
				    </li>
    			</c:forEach>
			  
			     <li class="page-item ${((page - 1) / 10) * 10 + 11 > maxPage ? 'disabled' : ''}">
				    <button onclick="SearchCourse(${studentId}, ${((page - 1) / 10) * 10 + 11 })" class="page-link"><i class="fa-solid fa-angle-right"></i></button>
			    </li>
			    
			    <li class="page-item \${page eq maxPage ? 'disabled' : ''}">
				    <button onclick="SearchCourse(${studentId}, ${maxPage })" class="page-link"><i class="fa-solid fa-angles-right"></i></button>
			    </li>
			  </ul>
			</nav>	
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
const ctx = "${pageContext.request.contextPath}";
const college1 = document.querySelector("#collegeId1");
const department1 = document.querySelector("#departmentId1");
const sugangListBody = document.querySelector("#sugangListBodyId");
const sugangList1 = document.querySelector("#sugangListId1");
const pagination1 = document.querySelector("#paginationId1");
const searchForm1 = document.querySelector("#searchFormId1");
const toast1 = document.querySelector("#toastId1");
const toastStrong1 = document.querySelector("#toastStrongId1");
const toastBody1 = document.querySelector("#toastBodyId1");

GetCollegeByOrganization(0);

function SearchCourse(studentId, page) {
	var formValues = document.querySelector("#searchFormId1");
	const search = {
			organizationId : formValues.elements[0].value,
			collegeId : formValues.elements[1].value,
			departmentId : formValues.elements[2].value,
			courseClassification : formValues.elements[3].value,
			year : formValues.elements[4].value,
			semester : formValues.elements[5].value,
			grade : formValues.elements[6].value,
			buildingStr : formValues.elements[7].value,
			classNumber : formValues.elements[8].value,
			courseName : formValues.elements[9].value,
			professorName : formValues.elements[10].value,
			studentId : studentId,
			page : page
	};
	
	fetch(ctx + "/sugang/getSearchCourse", {
		method : "post",
		headers : {
			"Content-Type" : "application/json"
		},
		body : JSON.stringify(search)
	})
	.then(res => res.json())
	.then(map => {
		const courseList = map.courseList;
		const search = map.search;
		const maxPage = map.maxPage;
		
		let courseOptions = ``;
		
		for(var course of courseList) {
			
			var desire = course.desire;
			let desireButton = ``;
			
			if(desire == 'false') {
				desireButton = `<td><button onclick="InsertCourseDesire(\${course.classCode}, \${studentId}, \${page})" class="btn btn-primary" value="\${course.classCode }">신청</button></td>`;
			} else {
				desireButton = `<td><button onclick="DeleteCourseDesire(\${course.classCode}, \${studentId}, \${page})" class="btn btn-danger" value="\${course.classCode }">취소</button></td>`;
			}
			
			
			courseOptions += `
		<tr>			
			\${desireButton }
			
			<td>\${course.grade }</td>
			<td>\${course.courseInfo.courseClassification }</td>
			<td>
				<button onclick="GetSyllabus(\${course.classCode})" type="button" class="btn btn-link">
				  \${course.classCode } <i class="fa-solid fa-magnifying-glass"></i>
				</button>
			</td>
			<td>
				<button onclick='GetCourseInfo("\${course.classNumber}")' type="button" class="btn btn-light">
				  \${course.classNumber } <i class="fa-solid fa-magnifying-glass"></i>
				</button>
			</td>
			<td>\${course.courseInfo.courseName }</td>
			<td>\${course.professor.name }</td>
			<td>\${course.courseInfo.credit }</td>
			<td>\${course.courseInfo.theory }</td>
			<td>\${course.courseInfo.practice }</td>
			<td>\${course.maxPersonnel }</td>
			<td>\${course.dayTime }</td>
			<td>\${course.classroom }</td>
			<td>\${course.department.name }</td>
		</tr>`
		}
		
		sugangList1.innerHTML = `
		<div class="row">
			<div class="col">
				<table class="table table-bordered">
					<thead>
						<tr class="table-secondary">
							<th>수강희망</th>
							<th>학년</th>
							<th>이수구분</th>
							<th>수업번호</th>
							<th>학수번호</th>
							<th>교과목명</th>
							<th>교강사</th>
							<th>학점</th>
							<th>강의</th>
							<th>실습</th>
							<th>수강정원</th>
							<th>수업시간</th>
							<th>강의실</th>
							<th>관장학과</th>
						</tr>
					</thead>
					<tbody>
						
						\${courseOptions}
					
					</tbody>
				</table>
			</div>
		</div>
		`;
		
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
			    	<button onclick="SearchCourse(\${studentId}, \${i })" class="page-link">\${i }</button>
			    </li>`;
		}
		
		
		pagination1.innerHTML = `
			<nav aria-label="Page navigation example">
			  <ul class="pagination justify-content-center">

			    <li class="page-item \${val2}">
				    <button onclick="SearchCourse(\${studentId}, 1)" class="page-link"><i class="fa-solid fa-angles-left"></i></button>
			    </li>

			    <li class="page-item \${val3}">
				    <button onclick="SearchCourse(\${studentId},\${(page - 1) - (page - 1) % 10 })" class="page-link"><i class="fa-solid fa-angle-left"></i></button>
			    </li> 
			    
			    \${pageOptions}
			  
			     <li class="page-item \${val4}">
				    <button onclick="SearchCourse(\${studentId}, \${((page - 1) / 10) * 10 + 11 })" class="page-link"><i class="fa-solid fa-angle-right"></i></button>
			    </li>
			    
			    <li class="page-item \${val5}">
				    <button onclick="SearchCourse(\${studentId}, \${maxPage })" class="page-link"><i class="fa-solid fa-angles-right"></i></button>
			    </li>
			  </ul>
			</nav>		
		`;
		
 		let pppp = `<li class="page-item \${val4}">
		    <button onclick="SearchCourse(\${studentId}, \${((page - 1) / 10) * 10 + 11 })" class="page-link"><i class="fa-solid fa-angle-right"></i></button>
		    </li>`
		    
		console.log("pageOptions : " + pageOptions);
		console.log("pppp : " + pppp); 
		
	});
}

function GetCollegeByOrganization(organizationId) {
	fetch(ctx + "/sugang/getCollege/" + organizationId)
	.then(res => res.json())
	.then(data => {
		const collegeList = data.collegeList;
		
		let collegeOption = `<option value="0">전체</option>`;
		
		for(var college of collegeList) {
			collegeOption += `<option value="\${college.id }">\${college.name }</option>`
		}
		
		college1.innerHTML = `
			<div class="me-3">
				<select onchange="GetDepartmentByCollege(this.value)" name="collegeId" value="0" class="form-select" aria-label="Default select example">
					\${collegeOption}
				</select>
			</div>
		`;
	});
	
	GetDepartmentByCollege(0);
}

function GetDepartmentByCollege(collegeId) {
	fetch(ctx + "/sugang/getDepartment/" + collegeId)
	.then(res => res.json())
	.then(data => {
		const departmentList = data.departmentList;
		
		let departmentOption = `<option value="0">전체</option>`;
		
		for(var department of departmentList) {
			departmentOption += `<option value="\${department.id }">\${department.name }</option>`
		}
		
		department1.innerHTML = `
			<div class="me-3">
				<select name="departmentId" value="0" class="form-select" aria-label="Default select example">
					\${departmentOption}
				</select>
			</div>
		`;
	});
}


function GetCourseInfo(classNumber) {
	window.open(ctx + "/courseInfo/getCourseInfo/" + classNumber, "myWindow", 'width=800,height=600');
	window.close();
}


function GetSyllabus(classCode) {
	window.open(ctx + "/course/getSyllabus/" + classCode, "myWindow", 'width=800,height=600');
	window.close();
}

// signUp table에서 제거
function DeleteCourseDesire(classCode, studentId, page) {
	const data = {classCode, studentId};
	fetch(ctx + "/courseSignUp/remove", {
		method : "delete",
		headers : {
			"Content-Type" : "application/json"
		},
		body : JSON.stringify(data)
	})
	.then(res => res.json())
	.then(data => {
		// 페이지 새로고침
		SearchCourse(studentId, page); 
		
		toastStrong1.innerText = data.message;
		toastBody1.innerText = "학번 : " + data.studentNumber + "님이 수업 코드 : " + data.classCode + " " + data.message;
		const toast = new bootstrap.Toast(toast1);
 		toast.show();
	});
};


// signUp table에 추가
function InsertCourseDesire(classCode, studentId, page) {
	const data = {classCode, studentId};
	fetch(ctx + "/courseSignUp/register", {
		method : "post",
		headers : {
			"Content-Type" : "application/json"
		},
		body : JSON.stringify(data)
	})
	.then(res => res.json())
	.then(data => {
		// 페이지 새로고침
		SearchCourse(studentId, page); 
		
		toastStrong1.innerText = data.message;
		toastBody1.innerText = "학번 : " + data.studentNumber + "님이 수업 코드 : " + data.classCode + " " + data.message;
		const toast = new bootstrap.Toast(toast1);
 		toast.show();
	});
};


</script>

</body>
</html>