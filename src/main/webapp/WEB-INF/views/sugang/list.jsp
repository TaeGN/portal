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
<form action="" method="get" >
<div class="d-flex">
		조직
	<div class="me-3">
		<select name="organization" id="organizationId1" class="form-select" aria-label="Default select example">
		  <option selected>대학(학부/서울)</option>
		  <option value="대학원">대학원</option>
<!-- 		  <option value="2">Two</option>
		  <option value="3">Three</option> -->
		</select>
	</div>
		년도
	<div class="me-3">
		<select name="year" id="yearId1" class="form-select" aria-label="Default select example">
		  <option value="2022">2022</option>
		  <option value="2021">2021</option>
		  <option value="2020">2020</option>
		  <option value="2019">2019</option>
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
		  <option selected value="0">전체</option>
		  <option value="1">1</option>
		  <option value="2">2</option>
		  <option value="3">3</option>
		  <option value="4">4</option>
		  <option value="5">5</option>
		  <option >전학년</option>
		</select>
	</div>
	
	<input id="submitButton1" type="submit" value="조회">
	<!-- <button type="button" class="btn btn-primary">Primary</button> -->
	</div>
	
	<div class="d-flex">
	이수구분
	<div class="me-3">
		<select name="courseClassification" class="form-select" aria-label="Default select example">
		  <option selected >전공심화</option>
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

<div id="sugangListId1" class="container-md">
	<div class="row">
		<div class="col">
			<table class="table">
				<thead>
					<tr>
						<th>학년</th>
						<th>이수구분</th>
						<th>수업번호</th>
						<th>학수번호</th>
						<th>교과목명</th>
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
					<c:forEach items="${courseList }" var="course">
						<tr>
							<input type="hidden" name="studentId" value="${studentId }">
							<c:url value="/course/get" var="getLink">
								<c:param name="classCode" value="${course.classCode }"></c:param>
							</c:url>
							<sec:authorize access="isAuthenticated()">
								<c:if test="${hasStudentAdmin }">
								<td><button onclick="CourseSignUp(${course.classCode}, ${studentId})" class="btn btn-primary" value="${course.classCode }">신청</button></td>
								</c:if>
							</sec:authorize>
							<td>${course.grade }</td>
							<td>${course.courseInfo.courseClassification }</td>
							<td><a href="${getLink }">${course.classCode }</a></td>
							<td>${course.classNumber }</td>
							<td>${course.courseInfo.courseName }</td>
							<td>${course.courseInfo.credit }</td>
							<td>${course.courseInfo.theory }</td>
							<td>${course.courseInfo.practice }</td>
							<td>${course.maxPersonnel }</td>
							<td>${course.startTime } - ${course.endTime }</td>
							<td>${course.classroom }</td>
							<td>${course.department.name }</td>
						</tr>
					</c:forEach>				
				</tbody>
			</table>
		</div>
	</div>
</div>

<!-- courseSignUpToast -->
<div class="toast" id="courseSignUpToast">
    <div class="toast-header">
        <strong id="courseSignUpToastStrong" class="me-auto"><i class="bi-gift-fill"></i></strong>
        <small id="courseSignUpToastSmall">방금 전</small>
        <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
    </div>
    <div id="courseSignUpToastBody" class="toast-body">
    	
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
const ctx = "${pageContext.request.contextPath}";

function CourseSignUp(classCode, studentId) {
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
		document.querySelector("#courseSignUpToastStrong").innerText = data.message;
		document.querySelector("#courseSignUpToastBody").innerText = "학수 번호 : " + data.studentNumber + "님이 수업 코드 : " + data.classCode + " " + data.message;


		const courseSignUpToast = document.querySelector("#courseSignUpToast");
		const toast = new bootstrap.Toast(courseSignUpToast);
 		toast.show();
	});
};

/* // 희망수업 등록 및 토스트 출력
document.querySelector("#courseSignUp").addEventListener("click", function() {
	const classCode = document.querySelector("#courseSignUp").value;
	const studentId = document.querySelector("#getStudentId").value;
	CourseSignUp(classCode, studentId);
}); */

/* const selectSemesterId1 = document.querySelector("#selectSemesterId1");
selectSemesterId1.addEventListener("change", function() {
	const selected = selectSemesterId1.value;
	if(selected == "2" || selected == "4") {
		document.querySelector("#radioId1").innerHTML = "disabled";
	}
}); */

/*   document.querySelector("#submitButton1").addEventListener("click", function() {
	const organization = document.querySelector("#organizationId1 option:selected").value;
	const year = document.querySelector("#yearId1").value;
	const semester = document.querySelector("#semesterId1").value;
	const grade = document.querySelector("#gradeId1").value;
	const data = {organization, year, semester, grade};
	fetch(ctx + "/sugang/list", {
		headers : {
			"Content-Type" : "application/json"
		},
		body : JSON.stringify(data)
	});
});  */

</script>

</body>
</html>