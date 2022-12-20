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
					<h5><i class="fa-solid fa-angle-right mt-3"></i> 신청과목시간표</h5>
					<table class="table table-bordered border-dark">
					<thead>
						<tr class="table-secondary">
							<th>교시</th>
							<th>월요일</th>
							<th>화요일</th>
							<th>수요일</th>
							<th>목요일</th>
							<th>금요일</th>
							<th>토요일</th>
							<th>일요일</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
						<c:forEach items="${signUpSchedule }" var="schedule" varStatus="status" >
							<tr>
								<td>${status.index + 1 }. ${schedule.time }</td>
								<td class="${schedule.monday eq '' ? '' : 'table-primary' }">${schedule.monday }</td>
								<td class="${schedule.tuesday eq '' ? '' : 'table-primary' }">${schedule.tuesday }</td>
								<td class="${schedule.wednesday eq '' ? '' : 'table-primary' }">${schedule.wednesday }</td>
								<td class="${schedule.thursday eq '' ? '' : 'table-primary' }">${schedule.thursday }</td>
								<td class="${schedule.friday eq '' ? '' : 'table-primary' }">${schedule.friday }</td>
								<td class="${schedule.saturday eq '' ? '' : 'table-primary' }">${schedule.saturday }</td>
								<td class="${schedule.sunday eq '' ? '' : 'table-primary' }">${schedule.sunday }</td>
							</tr>
						</c:forEach>

					</table>


				</div>
			</div>
		</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>