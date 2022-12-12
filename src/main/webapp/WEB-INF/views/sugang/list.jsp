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
<form action="" method="get" >
<div class="d-flex">
		조직
	<div class="me-3">
		<select name="organization" id="organizationId1" class="form-select" aria-label="Default select example">
		  <option value="대학(학부/서울)" selected>대학(학부/서울)</option>
		  <option value="대학원">대학원</option>
<!-- 		  <option value="2">Two</option>
		  <option value="3">Three</option> -->
		</select>
	</div>
		년도
	<div class="me-3">
		<select name="year" id="yearId1" class="form-select" aria-label="Default select example">
			<c:set var="nowYear" value="2022"></c:set>
			<c:forEach var="i" begin="2000" end="${nowYear }" step="1">
			  <option value="${nowYear - i + 2000 }">${nowYear - i + 2000 }</option>
			</c:forEach>
		</select>
	</div>
		학기
	<div class="me-3">
		<select name="semester" id="semesterId1" class="form-select" aria-label="Default select example">
		  <option value="1학기">1학기</option>
		  <option value="여름학기">여름학기</option>
		  <option value="2학기">2학기</option>
		  <option value="겨울학기" selected="selected">겨울학기</option>
		</select>
	</div>
		학년
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
	
	<input id="submitButton1" type="submit" value="조회">
	<!-- <button type="button" class="btn btn-primary">Primary</button> -->
	</div>
	
	<div class="d-flex">
	이수구분
	<div class="me-3">
		<select name="courseClassification" class="form-select" aria-label="Default select example">
		  <option value="전공심화" selected >전공심화</option>
		  <option value="1">1</option>
		  <option value="2">2</option>
		  <option value="3">3</option>
		  <option value="4">4</option>
		  <option value="5">5</option>
		</select>
	</div>
	</div>
</form>

<hr>

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
				<tbody>
					<c:forEach items="${courseList }" var="course" begin="${(page - 1) * 20 + 1 }" end="${page * 20 + 1 }">
						<tr>
							<input type="hidden" name="studentId" value="${studentId }">
							<c:url value="/course/getByClassCode" var="getByClassCodeLink">
								<c:param name="classCode" value="${course.classCode }"></c:param>
							</c:url>
							<c:url value="/course/getByClassNumber" var="getByClassNumberLink">
								<c:param name="classNumber" value="${course.classNumber }"></c:param>
							</c:url>
							<sec:authorize access="isAuthenticated()">
								<c:if test="${hasStudentAdmin }">
									<c:if test="${course.desire eq 'false'}">
										<td><button onclick="InsertCourseDesire(${course.classCode}, ${studentId})" class="btn btn-primary" value="${course.classCode }">신청</button></td>
									</c:if>
									<c:if test="${course.desire eq 'true' }">
										<td><button onclick="DeleteCourseDesire(${course.classCode}, ${studentId})" class="btn btn-danger" value="${course.classCode }">취소</button></td>
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
								<%-- <button onclick="GetCourseInfo('${course.classNumber }')" id="classNumberButton" class="btn btn-light" data-classNumber="${course.classNumber }" data-courseName="${course.courseInfo.courseName }" data-courseClassification="${course.courseInfo.courseClassification }" data-credit="${course.courseInfo.credit }" data-theory="${course.courseInfo.theory }" data-practice="${course.courseInfo.practice }" data-summary="${course.courseInfo.summary }" data-bs-toggle="modal" data-bs-target="#courseInfoModal">
								  ${course.classNumber } <i class="fa-solid fa-magnifying-glass"></i>
								</button> --%>
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
							<td>
								<c:forEach items="${course.courseSchedule }" var="courseSchedule">
									${courseSchedule.day } ${courseSchedule.startTime }-${courseSchedule.endTime } <br>
								</c:forEach>
							</td>
							<td>${course.classroom }</td>
							<td>${course.department.name }</td>
						</tr>
					</c:forEach>				
				</tbody>
			</table>
		</div>
	</div>
</div>

<!-- courseInfoModal -->
<div class="modal fade" id="courseInfoModal" tabindex="-1" aria-labelledby="courseInfoModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="courseInfoModalLabel">Modal title</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div id="modalBodyId1" class="modal-body modal-dialog modal-dialog-scrollable">
        <div class="container-md">
				<div class="row">
					<div class="col">
						<table class="table">
						<input id="courseInfoModalBody" type="hidden" name="courseInfo" >
							<tr>
								<td rowspan="4">과목</td>
								<td rowspan="2">CourseName</td>
								<td id="courseNameId" rowspan="2">${courseName }</td>
								<td>과목구분</td>
								<td>${courseInfo.courseClassification }</td>
							</tr>
							<tr>
								<td>학점</td>
								<td>${courseInfo.credit }</td>
							</tr>
							<tr>
								<td rowspan="2">Department</td>
								<td rowspan="2">${courseInfo.department.name }</td>
								<td>강의</td>
								<td>${courseInfo.theory }</td>
							</tr>
							<tr>
								<td>실습</td>
								<td>${courseInfo.practice }</td>
							</tr>
	
						</table>
					</div>
				</div>
			</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>

<nav aria-label="Page navigation example">
  <ul class="pagination justify-content-center">
    <li class="page-item disabled">
      <a class="page-link">Previous</a>
    </li>
    <c:forEach var="i" begin="${page > 5 ? page - 4 : 1 }" end="${page < maxPage - 4 ? page + 4 : maxPage}">
    <c:url value="#" var="paginationLink">
    	<c:param name="page" value="${i }"></c:param>
    </c:url>
   	 <li class="page-item"><a class="page-link" href="${paginationLink }">1</a></li>
    </c:forEach>
      <a class="page-link" href="#">Next</a>
    </li>
  </ul>
</nav>



<!-- deleteCourseDesireToast -->
<div class="toast" id="deleteCourseDesireToast">
    <div class="toast-header">
        <strong id="deleteCourseDesireToastStrong" class="me-auto"><i class="bi-gift-fill"></i></strong>
        <small id="deleteCourseDesireToastSmall">방금 전</small>
        <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
    </div>
    <div id="deleteCourseDesireToastBody" class="toast-body">
    	
    </div>
</div>

<!-- insertCourseDesireToast -->
<div class="toast" id="insertCourseDesireToast">
    <div class="toast-header">
        <strong id="insertCourseDesireToastStrong" class="me-auto"><i class="bi-gift-fill"></i></strong>
        <small id="insertCourseDesireToastSmall">방금 전</small>
        <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
    </div>
    <div id="insertCourseDesireToastBody" class="toast-body">
    	
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
const ctx = "${pageContext.request.contextPath}";


function GetCourseInfo(classNumber) {
	window.open(ctx + "/courseInfo/getCourseInfo/" + classNumber, "myWindow", 'width=800,height=600');
	window.close();
}


function GetSyllabus(classCode) {
	window.open(ctx + "/course/getSyllabus/" + classCode, "myWindow", 'width=800,height=600');
	window.close();
}

// signUp table에서 제거
function DeleteCourseDesire(classCode, studentId) {
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
		document.querySelector("#deleteCourseDesireToastStrong").innerText = data.message;
		document.querySelector("#deleteCourseDesireToastBody").innerText = "학수 번호 : " + data.studentNumber + "님이 수업 코드 : " + data.classCode + " " + data.message;
		
 		location.reload(); 

		const deleteCourseDesireToast = document.querySelector("#deleteCourseDesireToast");
		const toast = new bootstrap.Toast(deleteCourseDesireToast);
 		toast.show();
	});
};


// signUp table에 추가
function InsertCourseDesire(classCode, studentId) {
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
		document.querySelector("#insertCourseDesireToastStrong").innerText = data.message;
		document.querySelector("#insertCourseDesireToastBody").innerText = "학수 번호 : " + data.studentNumber + "님이 수업 코드 : " + data.classCode + " " + data.message;
	
		// 페이지 새로고침
		location.reload();
		
		const insertCourseDesireToast = document.querySelector("#insertCourseDesireToast");
		const toast = new bootstrap.Toast(insertCourseDesireToast);
 		toast.show();
	});
};


</script>

</body>
</html>