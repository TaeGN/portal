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

<my:sugangNavBar></my:sugangNavBar>
<div class="d-flex">
<div id="sugangListId1" class="container-md" data-studentId="${studentId }">
	<div class="row">
		<div class="col">
			<table class="table">
				<thead>
					<tr>
						<sec:authorize access="isAuthenticated()">
							<th>수강신청</th>
						</sec:authorize>
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
					<input id="getStudentId" type="hidden" name="studentId" value="${studentId }">
					<c:forEach items="${signUpCourseList }" var="course">
						<tr>
							<sec:authorize access="isAuthenticated()">
								<td><button onclick="CourseSignUp(${course.classCode}, ${studentId})" class="btn btn-primary" value="${course.classCode }">신청</button></td>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>