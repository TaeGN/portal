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
<my:adminPageTopNav></my:adminPageTopNav>

<div class="d-flex">
<my:adminPageLeftNav></my:adminPageLeftNav>
	<div class="container-md">
		<div class="row">
			<div class="col">

				<h1>수업코드 ${course.classCode } - ${course.courseInfo.courseName } 정보 수정</h1>
				
				<form id="modifyForm" action="" method="post" enctype="multipart/form-data">
					<input type="hidden" name="id" value="${adminMember.id }">
					<!-- .mb-3*4>label.form-label+input.form-control -->
					
					<div class="mb-3">
						<label for="" class="form-label">학년</label>
						<select name="grade" class="form-select" aria-label="Default select example">
							<option value="1학년" selected="selected">1</option>
							<option value="2학년">2</option>
							<option value="3학년">3</option>
							<option value="4학년">4</option>
							<option value="5학년">5</option>
							<option value="전학년">전학년</option>
						</select>
					</div>
				
				<div class="mb-3">
					<label class="form-label">
						이수구분 
					</label>
					<input class="form-control" type="text" value="${course.courseInfo.courseClassification }" readonly>
				</div>	
				
				<div class="mb-3">
					<label class="form-label">
						수업번호 
					</label>
					<input class="form-control" type="text" value="${course.classCode }" readonly>
				</div>
				
				<div class="mb-3">
					<label class="form-label">
						학수번호 
					</label>
					<input class="form-control" type="text" value="${course.classNumber }" readonly>
				</div>
				
				<div class="mb-3">
					<label class="form-label">
						교과목명 
					</label>
					<input class="form-control" type="text" value="${course.courseInfo.courseName }" readonly>
				</div>
				
				<div class="mb-3">
					<label class="form-label">
						교강사 
					</label>
					<input class="form-control" type="text" value="${course.professor.name }" readonly>
				</div>
				
				<div class="mb-3">
					<label class="form-label">
						학점 
					</label>
					<input class="form-control" type="text" value="${course.courseInfo.credit }" readonly>
				</div>		
				
				<div class="mb-3">
					<label class="form-label">
						강의 
					</label>
					<input class="form-control" type="text" value="${course.courseInfo.theory }" readonly>
				</div>	
				
				<div class="mb-3">
					<label class="form-label">
						실습 
					</label>
					<input class="form-control" type="text" value="${course.courseInfo.practice }" readonly>
				</div>	
				
				<div class="mb-3">
					<label class="form-label">
						강의실 
					</label>
					<input class="form-control" type="text" value="${course.classroom }" readonly>
				</div>
				
				<div class="mb-3">
					<label class="form-label">
						수강정원 
					</label>
					<input class="form-control" type="text" value="${course.maxPersonnel }" readonly>
				</div>
				
				<div class="mb-3">
					<label class="form-label">
						관장학과 
					</label>
					<input class="form-control" type="text" value="${course.department.name }" readonly>
				</div>

				</form>
				<input class="btn btn-warning" type="submit" value="수정" data-bs-toggle="modal" data-bs-target="#modifyModal">
				<c:url value="/admin/remove" var="removeLink"/>
				<input class="btn btn-danger" type="submit" value="삭제" data-bs-toggle="modal" data-bs-target="#removeModal">
				
				<form id="removeForm" action="${removeLink }" method="post">
				<input type="hidden" name="id" value="${adminMember.id }">
				</form>

			</div>
		</div>
	</div>

	<!-- modify Modal -->
	<div class="modal fade" id="modifyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">수정 확인</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        수정하시겠습니까?
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button id="modifyConfirmButton" type="button" class="btn btn-primary">확인</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- remove Modal -->
	<div class="modal fade" id="removeModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">삭제 확인</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        삭제하시겠습니까?
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button id="removeConfirmButton" type="button" class="btn btn-danger">확인</button>
	      </div>
	    </div>
	  </div>
	</div>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
// 수정확인 버튼 클릭하면 수정 form 전송
document.querySelector("#modifyConfirmButton").addEventListener("click", function() {
	document.querySelector("#modifyForm").submit();
});

// 삭제확인 버튼 클릭하면 삭제 form 전송
document.querySelector("#removeConfirmButton").addEventListener("click", function() {
	document.querySelector("#removeForm").submit();
});
</script>
</body>
</html>