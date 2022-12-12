<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<div class="row">
		<div class="col">
			<table class="table">
				<div class="d-flex">
					<h1 class="me-auto">강의리스트</h1>
					<c:url value="/course/register" var="registerLink"></c:url>
					<a href="${registerLink }">새 강의 등록</a>
				</div>
				<c:if test="${not empty message }">
					<div class="alert alert-success">
						${message }
					</div>
				</c:if>
				<thead>
					<tr>
						<th>학년</th>
						<th>이수구분</th>
						<th>수업번호</th>
						<th>학수번호</th>
						<th>교과목명</th>
						<th>교강사</th>
						<th>학점</th>
						<th>강의</th>
						<th>실습</th>
						<th>수업시간</th>
						<th>강의실</th>
						<th>수강정원</th>
						<th>관장학과</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${courseList }" var="course">
						<tr>
							<c:url value="/course/get" var="getLink">
								<c:param name="classCode" value="${course.classCode }"></c:param>
							</c:url>
							<td>${course.grade }</td>
							<td>${course.courseInfo.courseClassification }</td>
							<td>
								<button id="classCodeButtonId1" type="button" class="btn btn-link" data-bs-toggle="modal" data-bs-target="#classInfoModal">
								  ${course.classCode }
								</button>
							</td>
							<td>
								<button id="classNumberButtonId1" type="button" class="btn btn-link" data-bs-toggle="modal" data-bs-target="#courseInfoModal">
								  ${course.classNumber }
								</button>
							</td>
							<td>${course.courseInfo.courseName }</td>
							<td>${course.professor.name }</td>
							<td>${course.courseInfo.credit }</td>
							<td>${course.courseInfo.theory }</td>
							<td>${course.courseInfo.practice }</td>
							<td>
								<c:forEach items="${course.courseSchedule }" var="courseSchedule">
									${courseSchedule.day } ${courseSchedule.startTime }-${courseSchedule.endTime }
								</c:forEach>
							</td>
							<td>${course.classroom }</td>
							<td>${course.maxPersonnel }</td>
							<td>${course.department.name }</td>
							<td><a href="${getLink }" class="btn btn-primary">수정</a></td>
						</tr>
					</c:forEach>				
				</tbody>
			</table>
		</div>
	</div>
</div>


<!-- 학수번호 Modal -->
<div class="modal fade" id="courseInfoModal" tabindex="-1" aria-labelledby="courseInfoModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="courseInfoModalLabel">교과목 개요서</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div id="classNumberModalBodyId1" class="modal-body modal-dialog modal-dialog-scrollable">
		<div class="container-md">
			<div class="row">
				<div class="col">
					<div class="table">
						<thead>
							<tr>
								<th>과목</th>
							</tr>
						</thead>
						<tbody>
							
						</tbody>
					</div>
		
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


<!-- 수업번호 Modal -->
<div class="modal fade" id="classInfoModal" tabindex="-1" aria-labelledby="classInfoModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="classInfoModalLabel">Modal title</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script type="text/javascript">
const ctx = "${pageContext.request.contextPath}";

/* const classNumberButton1 = document.querySelector("#classNumberButtonId1");
classNumberButton1.addEventListener("click", function() {
	const classNumber = classNumberButton1.value;
	fetch(ctx + "/courseInfo/getInfo", {
		headers : {
			"Content-Type" : "application/json"
		},
		body : JSON.stringify(classNumber)
	})
	.then(res => res.json())
	.then(data => {
		
	})
}); */
</script>
</body>
</html>