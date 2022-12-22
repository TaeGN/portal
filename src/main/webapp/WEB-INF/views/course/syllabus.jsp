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



<div class="container-md">
			<div class="row">
				<div class="col">
					<div class="mt-3 ms-3 mb-3 me-auto">
						<h5><i class="fa-solid fa-angle-right"></i> 강의계획서</h5>
					</div>
					<table class="table table-bordered border-dark">
						<tr>
							<td rowspan="5" class="table-primary">교과목정보</td>
							<td class="table-primary">수업년도</td>
							<td>${syllabus.year }</td>
							<td class="table-primary">수업학기</td>
							<td>${syllabus.semester }</td>
							<td class="table-primary">학수번호</td>
							<td>${syllabus.classNumber }</td>
							<td class="table-primary">수업코드</td>
							<td>${syllabus.classCode }</td>
						</tr>
						<tr>
							<td class="table-primary">교과목명</td>
							<td colspan="3">${syllabus.courseInfo.courseName }</td>
							<td class="table-primary">과목구분</td>
							<td colspan="3">${syllabus.courseInfo.courseClassification }</td>
						</tr>
						<tr>
							<td class="table-primary">학점</td>
							<td>${syllabus.courseInfo.credit }</td>
							<td class="table-primary">강의</td>
							<td>${syllabus.courseInfo.theory }</td>
							<td class="table-primary">실습</td>
							<td colspan="3">${syllabus.courseInfo.practice }</td>
						</tr>
						<tr>
							<td class="table-primary">설강조직</td>
							<td colspan="3">${syllabus.department.college.organization.name }</td>
							<td class="table-primary">관장조직</td>
							<td colspan="3">${syllabus.department.name }</td>
						</tr>
						<tr>
							<td class="table-primary">강의시간</td>
							<td colspan="7">
							${syllabus.dayTime }
<%-- 								<c:forEach items="${course.courseSchedule }" var="courseSchedule">
									${courseSchedule.day } ${courseSchedule.startTime }-${courseSchedule.endTime }
								</c:forEach> --%>
							</td>
						</tr>

					</table>
					
					<table class="table table-bordered">
						<tr>
							<td rowspan="3">교강사정보</td>
							<td>소속</td>
							<td>${syllabus.professor.department.name }</td>
							<td>성명</td>
							<td>${syllabus.professor.name }</td>
						</tr>
						<tr>
							<td>연락처</td>
							<td>${syllabus.professor.contact }</td>
							<td>E-MAIL</td>
							<td>${syllabus.professor.email }</td>
						</tr>
						<tr>
							<td>홈페이지</td>
							<td colspan="3">${syllabus.professor.homepage }</td>
						</tr>
					</table>
					
					<table class="table table-bordered">
						<tr>
							<td>교과목개요</td>
							<td>${syllabus.courseInfo.summary }</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>