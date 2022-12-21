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
<sec:authentication property="name" var="studentId"/>
<sec:authorize access="hasAuthority('student')" var="hasStudentAdmin"></sec:authorize>

<my:sugangNavBar></my:sugangNavBar>
<div class="mt-3 ms-3 d-flex">
	<h5><i class="fa-solid fa-angle-right"></i> 희망수업</h5>
	<div class="ms-auto d-flex me-3" id="desireId1">${totalNum}과목 / ${desireCredit }학점</div>
</div>

<hr>

<div class="d-flex">
<div id="sugangListId1"  data-studentId="${studentId }">
	<div class="row p-2">
		<div class="col">
			<table class="table table-bordered">
				<thead id="theadId1">
					<tr class="table-secondary">
						<sec:authorize access="isAuthenticated()">
							<c:if test="${hasStudentAdmin }">
								<th>수강신청</th>
							</c:if>
						</sec:authorize>
						<th>신청인원</th>
						<th>제한인원</th>
						<th>희망인원</th>
						<th>이수구분</th>
						<th>수업번호</th>
						<th>학수번호</th>
						<th>교과목명</th>
						<th>희망삭제</th>
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
					<input id="getStudentId" type="hidden" name="studentId" value="${studentId }">
					<c:forEach items="${desireList }" var="course">
						<tr>
							<td>
								<sec:authorize access="isAuthenticated()">
									<c:if test="${hasStudentAdmin }">
										<c:if test="${course.signUp eq 'false'}">
											<button onclick="CourseSignUpConfirm(${course.classCode}, ${studentId}, ${page })" class="btn btn-primary" value="${course.classCode }">신청</button>
										</c:if>
									</c:if>
								</sec:authorize>
							</td>
							<td>${course.countSignUp }</td>
							<td>${course.maxPersonnel }</td>
							<td>${course.countDesire }</td>
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
							<td>
								<sec:authorize access="isAuthenticated()">
									<c:if test="${hasStudentAdmin }">
										<c:if test="${course.desire eq 'true' and course.signUp eq 'false' }">
											<button onclick="DeleteCourseDesire(${course.classCode}, ${studentId}, ${page })" class="btn btn-danger" value="${course.classCode }">삭제</button>
										</c:if>
									</c:if>
								</sec:authorize>
							</td>
							<td>${course.professor.name }</td>
							<td>${course.courseInfo.credit }</td>
							<td>${course.courseInfo.theory }</td>
							<td>${course.courseInfo.practice }</td>
							<td>${course.maxPersonnel }</td>
							<td>${course.dayTime }</td>
							<td>${course.classroom }</td>
							<td>${course.department.name }</td>
						</tr>
					</c:forEach>				
				</tbody>
			</table>
		</div>
	</div>
</div>
</div>

<div id="paginationId1">
<c:url value="/sugang/desireList" var="currentPageLink"></c:url>

<my:paginationNav></my:paginationNav>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
const ctx = "${pageContext.request.contextPath}";
const sugangListBody = document.querySelector("#sugangListBodyId");
const sugangList1 = document.querySelector("#sugangListId1");
const pagination1 = document.querySelector("#paginationId1");
const toast1 = document.querySelector("#toastId1");
const toastStrong1 = document.querySelector("#toastStrongId1");
const toastBody1 = document.querySelector("#toastBodyId1");

function GetCourseInfo(classNumber) {
	window.open(ctx + "/courseInfo/getCourseInfo/" + classNumber, "myWindow", 'width=800,height=600');
	window.close();
}


function GetSyllabus(classCode) {
	window.open(ctx + "/course/getSyllabus/" + classCode, "myWindow", 'width=800,height=600');
	window.close();
}


function SearchCourse(studentId, page) {
	const data = {studentId,page};
	
	fetch(ctx + "/sugang/getDesireList", {
		method : "post",
		headers : {
			"Content-Type" : "application/json"
		},
		body : JSON.stringify(data)
	})
	.then(res => res.json())
	.then(map => {
		const desireList = map.desireList;
		const maxPage = map.maxPage;
		const signUpCredit = map.signUpCredit;
		const desireCredit = map.desireCredit;
		const totalNum = map.totalNum;
		
		document.querySelector("#desireId1").innerText = `\${totalNum}과목 / \${desireCredit }학점`;		
		document.querySelector("#signUpCreditId1").innerHTML = `<a class="nav-link">신청학점 : \${signUpCredit }</a>`;
		
		
		let courseOptions = ``;
		
		for(var course of desireList) {
			
			var desire = course.desire;
			var signUp = course.signUp;
			let signUpButton = ``;
			let deleteCourseDesireButton = ``;
			
			if(signUp == 'false') {
				signUpButton = `<button onclick="CourseSignUpConfirm(\${course.classCode}, \${studentId}, \${page})" class="btn btn-primary" value="\${course.classCode }">신청</button>`;
				if(desire == 'true') {
					deleteCourseDesireButton = `<button onclick="DeleteCourseDesire(\${course.classCode}, \${studentId}, \${page})" class="btn btn-danger" value="\${course.classCode }">삭제</button>`;
				}
			} 
			
			
			courseOptions += `
		<tr>
			<td>
				\${signUpButton}
			</td>
			<td>\${course.countSignUp }</td>
			<td>\${course.maxPersonnel }</td>
			<td>\${course.countDesire }</td>
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
			<td>
				\${deleteCourseDesireButton}
			</td>
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
		
		console.log(courseOptions);
		
		sugangList1.innerHTML = `
		<div class="row p-2">
			<div class="col">
				<table class="table table-bordered">
					<thead>
						<tr class="table-secondary">
							<th>수강신청</th>
							<th>신청인원</th>
							<th>제한인원</th>
							<th>희망인원</th>
							<th>이수구분</th>
							<th>수업번호</th>
							<th>학수번호</th>
							<th>교과목명</th>
							<th>희망삭제</th>
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


//signUp table에서 signUp false로 변경
function CancelCourseSignUpConfirm(classCode, studentId, page) {
	const data = {classCode, studentId};
	fetch(ctx + "/courseSignUp/cancelSignUp", {
		method : "put",
		headers : {
			"Content-Type" : "application/json"
		},
		body : JSON.stringify(data)
	})
	.then(res => res.json())
	.then(data => {
 		const signUpCredit = data.signUpCredit;
		
		document.querySelector("#signUpCreditId1").innerHTML = `<a class="nav-link">신청학점 : \${signUpCredit }</a>`;
		
		// 페이지 새로고침
		SearchCourse(studentId, page); 
		
		toastStrong1.innerText = data.message;
		toastBody1.innerText = "학번 : " + data.studentNumber + "님이 수업 코드 : " + data.classCode + " " + data.message;
		const toast = new bootstrap.Toast(toast1);
 		toast.show();
	});
};


//signUp table에서 signUp true로 변경
function CourseSignUpConfirm(classCode, studentId, page) {
	const data = {classCode, studentId};
	fetch(ctx + "/courseSignUp/signUp", {
		method : "put",
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


//signUp table에서 제거
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

</script>
</body>
</html>