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
<my:adminNavBar></my:adminNavBar>
	<div class="container-md">
		<div class="row">
			<div class="col">
				<div class="d-flex">
					<h1 class="me-auto">학생 정보</h1>
					<c:url value="/student/modify" var="modifyLink">
						<c:param name="studentNumber" value="${student.studentNumber }"></c:param>
					</c:url>
					<a class="btn btn-warning" href="${modifyLink }">
						<i class="fa-solid fa-pen-to-square">학생 정보 수정</i>
					</a>
				</div>
			
				<div class="d-flex">
					<h1 class="me-auto">
						 
						
						<!-- <sec:authentication property="name" var="username" /> -->
						
						<%-- 작성자와 authentication.name 같으면 보여줌 --%>
					<%-- 	<c:if test="${board.writer == username}"> --%>
							<%-- <a class="btn btn-warning" href="${modifyLink }">
								<i class="fa-solid fa-pen-to-square"></i>
							</a> --%>
					<%-- 	</c:if> --%>
						
					</h1>
<%-- 					<h1>
						<span
							
							<sec:authorize access="not isAuthenticated()">
								style="pointer-events: none;"
							</sec:authorize>
							id="likeButton">
							<c:if test="${board.liked }">
								<i class="fa-solid fa-thumbs-up"></i>
							</c:if>
							<c:if test="${not board.liked }">
								<i class="fa-regular fa-thumbs-up"></i>
							</c:if>
						</span> 						
						<span id="likeCount">
							${board.countLike }
						</span>	
					</h1> --%>
				</div>
			
				<div class="mb-3">
					<label class="form-label">
						학번 
					</label>
					<input class="form-control" type="number" value="${student.studentNumber }" readonly>
				</div>	
				
				<div class="mb-3">
					<label class="form-label">
						학부 
					</label>
					<input class="form-control" type="text" value="${student.department }" readonly>
				</div>	
				
				<div class="mb-3">
					<label class="form-label">
						학년 
					</label>
					<input class="form-control" type="number" value="${student.grade }" readonly>
				</div>	
				
				<div class="mb-3">
					<label class="form-label">
						이름 
					</label>
					<input class="form-control" type="text" value="${student.studentName }" readonly>
				</div>	
				
				<div class="mb-3">
					<label class="form-label">
						아이디 
					</label>
					<input class="form-control" type="text" value="${student.id }" readonly>
				</div>
				
				<div class="mb-3">
					<label class="form-label">
						패스워드 
					</label>
					<input class="form-control" type="number" value="${student.password }" readonly>
				</div>
				
				<div class="mb-3">
					<label class="form-label">
						주민등록번호 
					</label>
					<input class="form-control" type="text" value="${student.firstResidentId }-${student.firstResidentId }" readonly>
				</div>
				
				<%-- 
				<div class="mb-3">
					<label for="" class="form-label">
					본문 
					</label>
					<textarea rows="5" class="form-control" readonly>${board.content }</textarea>
				</div>
				 --%>
				<%-- 이미지 출력 --%>
<%-- 				<div>
					<c:forEach items="${board.fileName }" var="name">
						<div>
							<img class="img-fluid img-thumbnail" src="${imgUrl }/${board.id }/${URLEncoder.encode(name, 'utf-8')}" alt="">
						</div>
					</c:forEach>		
				</div> --%>
<%-- 				
				<div class="mb-3">
					<label for="" class="form-label">
						작성자 
					</label>
					<input class="form-control" type="text" value="${board.writer }" readonly>
				</div>
				
				<div class="mb-3">
					<label for="" class="form-label">
						작성일시 
					</label>
					<input class="form-control" type="datetime-local" value="${board.inserted }" readonly>
				</div> --%>
	
	
			</div>
		</div>
	</div>
	
	<hr>
<%-- 	
	댓글 메시지 토스트
	<div id="replyMessageToast" class="toast align-items-center top-0 start-50 translate-middle-x position-fixed" role="alert" aria-live="assertive" aria-atomic="true">
	  <div class="d-flex">
	    <div id="replyMessage1" class="toast-body">
	      Hello, world! This is a toast message.
	    </div>
	    <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
	  </div>
	</div>
	
	<div class="container-md">
		<div class="row">
			<div class="col">
				<h3><i class="fa-solid fa-comments"></i></h3>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<input type="hidden" id="boardId" value="${board.id }">
				<sec:authorize access="isAuthenticated()">
				댓글 작성
					<div class="input-group">
						<input type="text" class="form-control" id="replyInput1">
						<button class="btn btn-outline-secondary" id="replySendButton1"><i class="fa-solid fa-reply"></i></button>
					</div>
				</sec:authorize>
				<sec:authorize access="not isAuthenticated()">
					<div class="alert alert-light">
						댓글을 작성하시려면 로그인을 해주세요.
					</div>
				</sec:authorize>				
			</div>
		</div>
		
		<div class="row mt-3">
			<div class="col">
				<div class="list-group" id="replyListContainer">
					댓글 리스트 출력되는 곳
				</div>
			</div>
		</div>
	</div>
	
	
	댓글 삭제 확인 모달
	<!-- Modal -->
	<div class="modal fade" id="removeReplyConfirmModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">댓글 삭제 확인</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        댓글을 삭제하시겠습니까?
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	        <button type="button" data-bs-dismiss="modal" id="removeConfirmModalSubmitButton" class="btn btn-danger">삭제</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	댓글 수정 모달
	<!-- Modal -->
	<div class="modal fade" id="modifyReplyFormModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5">댓글 수정 양식</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <input type="text" class="form-control" id="modifyReplyInput">
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	        <button type="button" data-bs-dismiss="modal" id="modifyFormModalSubmitButton" class="btn btn-primary">수정</button>
	      </div>
	    </div>
	  </div>
	</div> --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</body>
</html>