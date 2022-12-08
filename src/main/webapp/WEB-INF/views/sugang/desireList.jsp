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
<div class="d-flex">
<div id="sugangListId1" class="container-md" data-studentId="${studentId }">
	<div class="row">
		<div class="col">
			<table class="table">
				<thead>
					<tr>
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
						<th>희망수업삭제</th>
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
											<button onclick="CourseSignUpConfirm(${course.classCode}, ${studentId})" class="btn btn-primary" value="${course.classCode }">신청</button>
										</c:if>
									</c:if>
								</sec:authorize>
							</td>
							<td>${course.countSignUp }</td>
							<td>${course.maxPersonnel }</td>
							<td>${course.countDesire }</td>
							<td>${course.courseInfo.courseClassification }</td>
							<td><a href="${getLink }">${course.classCode }</a></td>
							<td>${course.classNumber }</td>
							<td>${course.courseInfo.courseName }</td>
							<td>
								<sec:authorize access="isAuthenticated()">
									<c:if test="${hasStudentAdmin }">
										<c:if test="${course.desire eq 'true' and course.signUp eq 'false' }">
											<button onclick="DeleteCourseDesire(${course.classCode}, ${studentId})" class="btn btn-danger" value="${course.classCode }">삭제</button>
										</c:if>
									</c:if>
								</sec:authorize>
							</td>
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

<!-- cancelCourseSignUpConfirmToast -->
<div class="toast" id="cancelCourseSignUpConfirmToast">
    <div class="toast-header">
        <strong id="cancelCourseSignUpConfirmToastStrong" class="me-auto"><i class="bi-gift-fill"></i></strong>
        <small id="cancelCourseSignUpConfirmToastSmall">방금 전</small>
        <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
    </div>
    <div id="cancelCourseSignUpConfirmToastBody" class="toast-body">
    	
    </div>
</div>


<!-- courseSignUpConfirmToast -->
<div class="toast" id="courseSignUpConfirmToast">
    <div class="toast-header">
        <strong id="courseSignUpConfirmToastStrong" class="me-auto"><i class="bi-gift-fill"></i></strong>
        <small id="courseSignUpConfirmToastSmall">방금 전</small>
        <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
    </div>
    <div id="courseSignUpConfirmToastBody" class="toast-body">
    	
    </div>
</div>


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


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
const ctx = "${pageContext.request.contextPath}";


//signUp table에서 signUp false로 변경
function CancelCourseSignUpConfirm(classCode, studentId) {
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
/* 		document.querySelector("#cancelCourseSignUpConfirmToastStrong").innerText = data.message;
		document.querySelector("#cancelCourseSignUpConfirmToastBody").innerText = "학수 번호 : " + data.studentNumber + "님이 수업 코드 : " + data.classCode + " " + data.message;
		const cancelCourseSignUpConfirmToast = document.querySelector("#cancelCourseSignUpConfirmToast");
		const toast = new bootstrap.Toast(cancelCourseSignUpConfirmToast);
		toast.show(); */
		
		// 페이지 새로고침
		location.reload();
	});
};


//signUp table에서 signUp true로 변경
function CourseSignUpConfirm(classCode, studentId) {
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
/* 		document.querySelector("#courseSignUpConfirmToastStrong").innerText = data.message;
		document.querySelector("#courseSignUpConfirmToastBody").innerText = "학수 번호 : " + data.studentNumber + "님이 수업 코드 : " + data.classCode + " " + data.message;
		const courseSignUpConfirmToast = document.querySelector("#courseSignUpConfirmToast");
		const toast = new bootstrap.Toast(courseSignUpConfirmToast);
		toast.show(); */
		// 페이지 새로고침
		location.reload();
	});
};


//signUp table에서 제거
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
 		location.reload();
/* 		document.querySelector("#deleteCourseDesireToastStrong").innerText = data.message;
		document.querySelector("#deleteCourseDesireToastBody").innerText = "학수 번호 : " + data.studentNumber + "님이 수업 코드 : " + data.classCode + " " + data.message;
		

		const deleteCourseDesireToast = document.querySelector("#deleteCourseDesireToast");
		const toast = new bootstrap.Toast(deleteCourseDesireToast);
 		toast.show(); */
 		
	});
};

</script>
</body>
</html>