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
<my:navBar></my:navBar>
<form action="" method="post" class="d-flex">
		조직
	<div class="me-3">
		<select class="form-select" aria-label="Default select example">
		  <option selected>select menu</option>
		  <option value="1">One</option>
		  <option value="2">Two</option>
		  <option value="3">Three</option>
		</select>
	</div>
		년도
	<div class="me-3">
		<select class="form-select" aria-label="Default select example">
		  <option selected>select menu</option>
		  <option value="1">One</option>
		  <option value="2">Two</option>
		  <option value="3">Three</option>
		</select>
	</div>
		학기
	<div class="me-3">
		<select class="form-select" aria-label="Default select example">
		  <option selected>select menu</option>
		  <option value="1">One</option>
		  <option value="2">Two</option>
		  <option value="3">Three</option>
		</select>
	</div>
		학년
	<div class="me-3">
		<select class="form-select" aria-label="Default select example">
		  <option selected>select menu</option>
		  <option value="1">One</option>
		  <option value="2">Two</option>
		  <option value="3">Three</option>
		</select>
	</div>
	
	<div class="form-check">
	  <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
	  <label class="form-check-label" for="flexCheckDefault">
	    checkbox
	  </label>
	</div>
	<div class="form-check">
	  <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
	  <label class="form-check-label" for="flexCheckDefault">
	    checkbox
	  </label>
	</div>	
	<div class="form-check">
	  <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
	  <label class="form-check-label" for="flexCheckDefault">
	    checkbox
	  </label>
	</div>	
	<div class="form-check">
	  <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
	  <label class="form-check-label" for="flexCheckDefault">
	    checkbox
	  </label>
	</div>
	
	<div class="d-flex ms-auto">
	<div class="form-check">
	  <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1">
	  <label class="form-check-label" for="flexRadioDefault1">
	    radio
	  </label>
	</div>
	<div class="form-check">
	  <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1">
	  <label class="form-check-label" for="flexRadioDefault1">
	    radio
	  </label>
	</div>
	<div class="form-check">
	  <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1">
	  <label class="form-check-label" for="flexRadioDefault1">
	    radio
	  </label>
	</div>
	</div>
		
	<input type="submit" value="전송">
	<!-- <button type="button" class="btn btn-primary">Primary</button> -->
</form>

<hr>

<div class="container-md">
	<div class="row">
		<div class="col">
			<table class="table">
				<thead>
					<tr>
						<th>수업코드</th>
						<th>학수번호</th>
						<th>교과목명</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${courseList }" var="course">
						<tr>
							<td>${course.classCode }</td>
							<td>${course.classNumber }</td>
							<td>${course.courseName }</td>
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