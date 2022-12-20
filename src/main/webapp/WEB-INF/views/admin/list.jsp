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
	<div class="row">
		<div class="col">
			<table class="table">
				<div class="d-flex">
					<div class="mt-3 ms-3 mb-3 me-auto">
						<h3><i class="fa-solid fa-angle-right"></i> 관리자 정보</h3>
					</div>
					
					<hr>
					<c:url value="/admin/register" var="registerLink"></c:url>
					<a href="${registerLink }">새 관리자 등록</a>
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
					<c:forEach items="${adminMemberList }" var="adminMember" begin="${startNum }" end="${endNum }">
						<tr>
							<c:url value="/admin/get" var="getLink">
								<c:param name="username" value="${adminMember.adminMemberId }"></c:param>
							</c:url>
							<td>${adminMember.id }</td>
							<td><a href="${getLink }">${adminMember.name }</a></td>
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
	<div class="ms-auto" id="adminLogId1"></div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script>
const ctx = "${pageContext.request.contextPath}";
const adminLog1 = document.querySelector("#adminLogId1");



/* <tr>
<td>\${adminLog.id }</td>
<td>\${adminLog.menu } - \${adminLog.category }</td>
<td>\${adminLog.log }</td>
<td>\${adminLog.adminId }-\${adminLog.adminName }</td>
<td>\${adminLog.inserted }</td>
</tr> */

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