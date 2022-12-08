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
<style type="text/css">
.text-align-center {
	text-align: center;
}
</style>
</head>
<body>
<div class="container-md">
				<div class="row">
					<div class="col">
						<table class="table table-bordered align-middle">
							<tr>
								<td class="text-align-center" rowspan="3">과목</td>
								<td class="text-align-center" rowspan="2">CourseName</td>
								<td rowspan="2">${courseInfo.courseName }</td>
								<td class="text-align-center">학점</td>
								<td>${courseInfo.credit }</td>
							</tr>
							<tr>
								<td class="text-align-center">강의</td>
								<td>${courseInfo.theory }</td>
							</tr>
							<tr>
								<td class="text-align-center">과목구분</td>
								<td>${courseInfo.courseClassification }</td>
								<td class="text-align-center">실습</td>
								<td>${courseInfo.practice }</td>
							</tr>
						</table>
						<table class="table table-bordered align-middle">
							<tr>
								<td class="text-align-center">Course Description</td>
								<td>${courseInfo.summary }</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>