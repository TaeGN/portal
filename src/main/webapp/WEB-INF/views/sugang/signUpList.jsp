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
	<h5><i class="fa-solid fa-angle-right"></i> 신청내역</h5>
	<button onclick="GetSignUpSchedule(this.value)" value="${studentId }" type="button" class="btn btn-primary ms-auto">신청과목시간표보기</button>
</div>
<hr>
<div class="d-flex">
<div id="sugangListId1" data-studentId="${studentId }">
	<div class="row p-2">
		<div class="col">
			<table class="table table-bordered">
				<thead id="theadId1">
					<tr class="table-secondary">
						<sec:authorize access="isAuthenticated()">
							<c:if test="${hasStudentAdmin }">
								<th>수강취소</th>
							</c:if>
						</sec:authorize>
						<th>이수구분</th>
						<th>수업번호</th>
						<th>학수번호</th>
						<th>교과목명</th>
						<th>교강사</th>
						<th>학점</th>
						<th>강의</th>
						<th>실습</th>
						<th>수강 / 정원</th>
						<th>수업시간</th>
						<th>강의실</th>
						<th>관장학과</th>
					</tr>
				</thead>
				<tbody>
					<input id="getStudentId" type="hidden" name="studentId" value="${studentId }">
					<c:forEach items="${signUpList }" var="course">
						<tr>
							<td>
								<sec:authorize access="isAuthenticated()">
									<c:if test="${hasStudentAdmin and course.signUp eq 'true'}">
										<button onclick="CancelCourseSignUpConfirm(${course.classCode}, ${studentId})" class="btn btn-danger" value="${course.classCode }">취소</button>
									</c:if>
								</sec:authorize>
							</td>
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
							<td>${course.countSignUp } / ${course.maxPersonnel }</td>
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



<c:url value="/sugang/signUpList" var="currentPageLink"></c:url>

<my:paginationNav></my:paginationNav>

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




<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
const ctx = "${pageContext.request.contextPath}";

function GetSignUpSchedule(studentId) {
	window.open(ctx + "/courseSignUp/getSignUpSchedule/" + studentId, "myWindow", 'width=800,height=600');
	window.close();
}

function GetCourseInfo(classNumber) {
	window.open(ctx + "/courseInfo/getCourseInfo/" + classNumber, "myWindow", 'width=800,height=600');
	window.close();
}


function GetSyllabus(classCode) {
	window.open(ctx + "/course/getSyllabus/" + classCode, "myWindow", 'width=800,height=600');
	window.close();
}

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
		const signUpCredit = data.signUpCredit;
		
		document.querySelector("#signUpCreditId1").innerHTML = `<a class="nav-link">신청학점 : \${signUpCredit }</a>`;
		
		document.querySelector("#cancelCourseSignUpConfirmToastStrong").innerText = data.message;
		document.querySelector("#cancelCourseSignUpConfirmToastBody").innerText = "학수 번호 : " + data.studentNumber + "님이 수업 코드 : " + data.classCode + " " + data.message;
		
		// 페이지 새로고침
		location.reload();

		const cancelCourseSignUpConfirmToast = document.querySelector("#cancelCourseSignUpConfirmToast");
		const toast = new bootstrap.Toast(cancelCourseSignUpConfirmToast);
		toast.show();
	});
};
</script>
</body>
</html>