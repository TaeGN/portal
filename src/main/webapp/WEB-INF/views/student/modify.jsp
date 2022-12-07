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
<my:studentAdminNav></my:studentAdminNav>
<div class="container-md">
		<div class="row">
			<div class="col">

				<h1>${student.studentNumber } ${student.studentName }의 정보 수정</h1>
				
				<form id="modifyForm" action="" method="post" enctype="multipart/form-data">
					<input type="hidden" name="id" value="${board.id }">
					<!-- .mb-3*4>label.form-label+input.form-control -->
					<div class="mb-3">
						<label for="" class="form-label">제목</label>
						<input type="text" name="title" class="form-control" value="${board.title }">
					</div>
					<div class="mb-3">
						<label for="" class="form-label">본문</label>
						<textarea rows="5" name="content" class="form-control">${board.content }</textarea>
					</div>
					
					<%-- 이미지 출력 --%>
					<div class="mb-3">
						<c:forEach items="${board.fileName }" var="name" varStatus="status">
							<div class="row">
								<div class="col-2 d-flex justify-content-center align-items-center">
									<%-- 삭제 여부 체크박스 --%>
									
									<div class="form-check form-switch text-danger">
									  <input name="removeFiles" value="${name }" class="custom-check form-check-input" type="checkbox" role="switch" id="flexSwitchCheckChecked${status.count }" >
									  <label class="form-check-label" for="flexSwitchCheckChecked${status.count }"><i class="fa-regular fa-trash-can"></i></label>
									</div>
									
								</div>
								<div class="col-10">
									<div>
										<img class="img-fluid img-thumbnail" src="${imgUrl }/${board.id }/${URLEncoder.encode(name, 'utf-8')}" alt="">
									</div>
								</div>
							</div>
						</c:forEach>		
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">파일 추가</label>
						<input multiple type="file" accept="image/*" class="form-control" name="files">
						<div class="form-text" id="addFileInputText"></div>
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">작성자</label>
						<input readonly="readonly" type="text" class="form-control" value="${board.writer }">
					</div>
					<div class="mb-3">
						<label for="" class="form-label">작성일시</label>
						<input type="text" class="form-control" value="${board.inserted }" readonly>
					</div>
				</form>
				<input class="btn btn-warning" type="submit" value="수정" data-bs-toggle="modal" data-bs-target="#modifyModal">
				<c:url value="/board/remove" var="removeLink"/>
				<input class="btn btn-danger" type="submit" value="삭제" data-bs-toggle="modal" data-bs-target="#removeModal">
				
				<form id="removeForm" action="${removeLink }" method="post">
				<input type="hidden" name="id" value="${board.id }">
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>