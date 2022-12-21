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
<div>
	<div class="row p-2">
		<div class="col">
			<table class="table">
				<div class="d-flex">
					<div class="mt-3 ms-3 mb-3 me-auto">
						<h3><i class="fa-solid fa-angle-right"></i> 관리자 정보</h3>
					</div>
					
					<hr>
					
					<button onclick="RegisterAdminMember()" class="btn btn-link">새 관리자 등록</button>
					<%-- <c:url value="/admin/register" var="registerLink"></c:url>
					<a href="${registerLink }">새 관리자 등록</a> --%>
				</div>
				<c:if test="${not empty message }">
					<div class="alert alert-success">
						${message }
					</div>
				</c:if>
				<thead>
					<tr>
						<th>#</th>
						<th>관리자명</th>
						<th>아이디</th>
						<th>비밀번호</th>
						<th>권한</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${adminMemberList }" var="adminMember">
						<tr>
							<%-- <c:url value="/admin/get" var="getLink">
								<c:param name="username" value="${adminMember.adminMemberId }"></c:param>
							</c:url> --%>
							<td>${adminMember.id }</td>
							<td>
								<button onclick="GetAdminMember(this.value)" value="${adminMember.id }" class="btn btn-link">${adminMember.name }</button>
								<%-- <a href="${getLink }">${adminMember.name }</a> --%>
							</td>
							<td>${adminMember.adminMemberId }</td>
							<td>*******</td>
							<td>
								<c:forEach items="${adminMember.authorityList }" var="authority">
									${authority } 
								</c:forEach>
							</td>
						</tr>
					</c:forEach>				
				</tbody>
			</table>
		</div>
		<div id="paginationId1">
		<c:url value="/admin/list" var="currentPageLink"></c:url>
		<my:paginationNav></my:paginationNav>
		</div>
	</div>
</div>
	<div class="ms-5" id="adminInfoId1"></div>
	<div class="ms-5" id="modifyAdminId1"></div>
	<div class="ms-auto" id="adminLogId1"></div>
</div>


	<!-- modify Modal -->
	<div class="modal fade" id="modifyModal" tabindex="-1" aria-labelledby="modifyModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="modifyModalLabel">수정 확인</h1>
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
<script>
const ctx = "${pageContext.request.contextPath}";
const adminLog1 = document.querySelector("#adminLogId1");
const adminInfo1 = document.querySelector("#adminInfoId1");
const modifyAdmin1 = document.querySelector("#modifyAdminId1");

//수정확인 버튼 클릭하면 수정 form 전송
document.querySelector("#modifyConfirmButton").addEventListener("click", function() {
	document.querySelector("#modifyForm").submit();
});

// 삭제확인 버튼 클릭하면 삭제 form 전송
document.querySelector("#removeConfirmButton").addEventListener("click", function() {
	document.querySelector("#removeForm").submit();
});



function GetAdminMember(id) {
	adminLog1.innerHTML = ``;
	modifyAdmin1.innerHTML = ``;
	
	fetch(ctx + "/admin/get/" + id)
	.then(res => res.json())
	.then(adminMember => {	
		/* const fileList = adminMember.fileList;
		console.log(adminMember);
		
		let fileOptions = ``;
		
		for(var file of fileList) {
			fileOptions += `<img class="img-fluid img-thumbnail" src="\${imgUrl }/${file.memberId }/${URLEncoder.encode(file.name, 'utf-8')}" alt="">`
		} */
		
	
		adminInfo1.innerHTML = `
			<div class="row p-2">
			<div class="col">
			
				<div class="d-flex">
					<div class="mt-3 mb-3 me-auto">
						<h3><i class="fa-solid fa-angle-right"></i> \${adminMember.id }. \${adminMember.name }</h3>
					</div>
					<button onclick="ModifyAdminMember(this.value)" value="\${adminMember.id}" class="btn btn-link">
					<i class="fa-solid fa-pen-to-square">관리자 정보 수정</i>
					</button>
				</div>
				
				<div class="mb-3">
					<label class="form-label">
						닉네임 
					</label>
					<input class="form-control" type="text" value="\${adminMember.name }" readonly>
				</div>
				
				<div class="mb-3">
					<label class="form-label">
						아이디 
					</label>
					<input class="form-control" type="text" value="\${adminMember.adminMemberId }" readonly>
				</div>	
				
				<div class="mb-3">
					<label class="form-label">
						비밀번호 
					</label>
					<input class="form-control" type="password" value="\${adminMember.password }" readonly>
				</div>
				
				<div class="mb-3">
					<label class="form-label">
						권한 
					</label>
					<input class="form-control" type="text" value="\${adminMember.authorityList }" readonly>
				</div>	
				
				<%-- 이미지 출력 --%>
				<%-- 	<div class="mb-3">
					<c:forEach items="${adminMember.fileList }" var="file">
						<div>
							<img class="img-fluid img-thumbnail" src="${imgUrl }/${file.memberId }/${URLEncoder.encode(file.name, 'utf-8')}" alt="">
						</div>
					</c:forEach>		
				</div> --%>
	
	
			</div>
		</div>
		`
	});
}


function RegisterAdminMember() {
	adminLog1.innerHTML = ``;
	modifyAdmin1.innerHTML = ``;
	adminInfoId1.innerHTML = `	
	<div class="row">
	<div class="col">
		<div class="mt-3 mb-3 me-auto">
			<h3><i class="fa-solid fa-angle-right"></i> 관리자 등록</h3>
		</div>
		<form id="registerForm1" action="\${ctx}/admin/register" method="post" enctype="multipart/form-data">
			<div class="mb-3">
				<label for="" class="form-label">닉네임</label>
				<input required="required" type="text" class="form-control" name="name">
			</div>
			
			<div class="mb-3">
				<label for="" class="form-label">아이디</label>
				<input required="required" type="text" class="form-control" name="adminMemberId">
			</div>
			
			<div class="mb-3">
				<label for="" class="form-label">비밀번호</label>
				<input required="required" type="text" class="form-control" name="password">
			</div>

			
			<label for="" class="form-label">권한</label>
			<div class="form-check">
			  <input class="form-check-input" type="checkbox" value="member" id="checkbox1" name="authorityList">
			  <label class="form-check-label" for="flexCheckDefault1">
			    member
			  </label>
			</div>
			<div class="form-check">
			  <input class="form-check-input" type="checkbox" value="course" id="checkbox2" name="authorityList">
			  <label class="form-check-label" for="flexCheckDefault2">
			    course
			  </label>
			</div>
			<div class="form-check">
			  <input class="form-check-input" type="checkbox" value="courseInfo" id="checkbox2" name="authorityList">
			  <label class="form-check-label" for="flexCheckDefault3">
			    courseInfo
			  </label>
			</div>
			<div class="form-check">
				 <input class="form-check-input" type="checkbox" value="sugang" name="authorityList">
				 <label class="form-check-label" for="flexCheckDefault3">
				   sugang
				 </label>
			</div>
			<input id="submitButton1" class="btn btn-primary" type="submit" value="등록">
		</form>
	</div>
</div>`
}

function ModifyAdminMember(id) {
	fetch(ctx + "/admin/get/" + id)
	.then(res => res.json())
	.then(adminMember => {

		modifyAdmin1.innerHTML = `

			<div class="row p-2">
			<div class="col">
				<div class="mt-3 mb-3">
					<h3><i class="fa-solid fa-angle-right"></i> \${adminMember.id }. \${adminMember.name } 정보 수정</h3>
				</div>
				
				<form id="modifyForm" action="\${ctx}/admin/modify" method="post" enctype="multipart/form-data">
					<input type="hidden" name="id" value="\${adminMember.id }">
					
					<div class="mb-3">
						<label for="" class="form-label">닉네임</label>
						<input type="text" name="name" class="form-control" value="\${adminMember.name }">
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">아이디</label>
						<input type="text" name="adminMemberId" class="form-control" value="\${adminMember.adminMemberId }">
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">비밀번호</label>
						<input type="password" name="password" class="form-control" value="">
					</div>
							
					<div class="mb-3">
						
						<label for="" class="form-label">권한</label>
						<div class="form-check">
						  <input class="form-check-input" type="checkbox" value="member" name="authorityList">
						  <label class="form-check-label" for="flexCheckDefault1">
						    member
						  </label>
						</div>
						<div class="form-check">
						  <input class="form-check-input" type="checkbox" value="course" name="authorityList">
						  <label class="form-check-label" for="flexCheckDefault2">
						    course
						  </label>
						</div>
						<div class="form-check">
						  <input class="form-check-input" type="checkbox" value="courseInfo" name="authorityList">
						  <label class="form-check-label" for="flexCheckDefault3">
						    courseInfo
						  </label>
						</div>
						<div class="form-check">
						  <input class="form-check-input" type="checkbox" value="sugang" name="authorityList">
						  <label class="form-check-label" for="flexCheckDefault3">
						    sugang
						  </label>
						</div>
					
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
		`;
	});
}


function GetAdminLog(page) {
	fetch(ctx + "/admin/getAdminLog/" + page)
	.then(res => res.json())
	.then(data => {
		const adminLogList = data.adminLogList;
		const maxPage = data.maxPage;
		
		let adminLogBody = ``;
		
		for(var adminLog of adminLogList) {
			adminLogBody += `
				<tr>
					<td>\${adminLog.id }. \${adminLog.log }</td>
					<td>\${adminLog.adminId }-\${adminLog.adminName }</td>
				</tr>			
			`;
		}
		
		
		const startPage = parseInt((page - 1) / 10) + 1;
		const endPage = (page + 9) < maxPage ? page + 9 : maxPage;
		
		var val2 = '';
		var val3 = '';
		var val4 = '';
		var val5 = '';
		
		if(page == 1) {
			var val2 = 'disabled';
		}
		
		if(page <= 10) {
			var val3 = 'disabled';
		} 		
		
		if(((page - 1) / 10) * 10 + 11 > maxPage) {
			var val4 = 'disabled';
		} 
		
		if(page == maxPage) {
			var val5 = 'disabled';
		} 		

		
		let pageOptions = ``;
		for(var i = startPage; i <= endPage; i++ ) {
			var val1 = ``;
			if(page == i) {
				var val1 = 'active'
			}
			
			pageOptions += `
				<li class="page-item \${val1}">
				<button onclick="GetAdminLog(\${i})" class="page-link">\${i }</button>
			    </li>`;
		}
		
		
		let pagination1 = `
			<nav aria-label="Page navigation example">
			  <ul class="pagination justify-content-center">

			    <li class="page-item \${val2}">
				    <button onclick="GetAdminLog(1)" class="page-link"><i class="fa-solid fa-angles-left"></i></button>
			    </li>

			    <li class="page-item \${val3}">
				    <button onclick="GetAdminLog(\${(page - 1) - (page - 1) % 10 })" class="page-link"><i class="fa-solid fa-angle-left"></i></button>
			    </li> 
			    
			    \${pageOptions}
			  
			     <li class="page-item \${val4}">
				    <button onclick="GetAdminLog(\${((page - 1) / 10) * 10 + 11 })" class="page-link"><i class="fa-solid fa-angle-right"></i></button>
			    </li>
			    
			    <li class="page-item \${val5}">
				    <button onclick="GetAdminLog(\${maxPage })" class="page-link"><i class="fa-solid fa-angles-right"></i></button>
			    </li>
			  </ul>
			</nav>		
		`;
		
		adminLog1.innerHTML = `
		<div class="row">
			<div class="col">
				<table class="table">
					<div class="mt-3 ms-3 mb-3 me-auto">
						<h3><i class="fa-solid fa-angle-right"></i> 관리자 로그</h3>
					</div>			
					<thead>
						<tr>
							<th>로그</th>
							<th>관리자명</th>
						</tr>
					</thead>
					<tbody>
						\${adminLogBody}				
					</tbody>
				</table>
			</div>
			\${pagination1}
		</div>`;	

		
	});
}
</script>


</body>
</html>