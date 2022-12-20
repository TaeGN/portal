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

<sec:authorize access="hasAnyAuthority('admin','courseInfo')" var="hasAuthority"></sec:authorize>

<my:adminPageTopNav></my:adminPageTopNav>

<div class="d-flex">
<my:adminPageLeftNav></my:adminPageLeftNav>
<div class="me-5">
	<div class="row">
		<div class="col">
			<table class="table">
				<div class="d-flex">
					<div class="mb-3 mt-3 ms-3 me-auto">
						<h3><i class="fa-solid fa-angle-right"></i> 교과목 정보</h3>
					</div>
					<button onclick="RegisterCourseInfo()" class="btn btn-link" type="button">
						새 강의 정보 등록
					</button>
				</div>
				<c:if test="${not empty message }">
					<div class="alert alert-success">
						${message }
					</div>
				</c:if>
				<thead>
					<tr>
						<th>학수번호</th>
						<th>교과목명</th>
						<th>과목구분</th>
						<th>학점</th>
						<th>강의</th>
						<th>실습</th>
						<th>수업 개요</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${courseInfoList }" var="courseInfo">
						<tr>
							<td>
								<button onclick='GetCourseInfo("${courseInfo.classNumber}")' type="button" class="btn btn-light">
								  ${courseInfo.classNumber } <i class="fa-solid fa-magnifying-glass"></i>
								</button>
							</td>
							<td>${courseInfo.courseName }</td>
							<td>${courseInfo.courseClassification }</td>
							<td>${courseInfo.credit }</td>
							<td>${courseInfo.theory }</td>
							<td>${courseInfo.practice }</td>
							<td>${courseInfo.summary }</td>
						</tr>
					</c:forEach>				
				</tbody>
			</table>
		</div>
		<div id="paginationId1">
		<c:url value="/courseInfo/list" var="currentPageLink"></c:url>
		<my:paginationNav></my:paginationNav>
		</div>
	</div>
</div>
	
	


<c:if test="${hasAuthority }">
	<div class="me-5" id="CourseInfoByCourseNumber">
	
	</div>
	
	<div id="modifyCourseInfoId1"></div>
</c:if>

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
<script type="text/javascript">
const ctx = "${pageContext.request.contextPath}";

const modifyCourseInfo1 = document.querySelector("#modifyCourseInfoId1");
const CourseInfoByCourseNumber = document.querySelector("#CourseInfoByCourseNumber");


/* function GetCourseInfo(classNumber) {
	window.open(ctx + "/courseInfo/getCourseInfo/" + classNumber, "myWindow", 'width=800,height=600');
	window.close();
} */


//수정확인 버튼 클릭하면 수정 form 전송
document.querySelector("#modifyConfirmButton").addEventListener("click", function() {
	document.querySelector("#modifyForm").submit();
});

//삭제확인 버튼 클릭하면 삭제 form 전송
document.querySelector("#removeConfirmButton").addEventListener("click", function() {
	document.querySelector("#removeForm").submit();
});

const adminLog1 = document.querySelector("#adminLogId1");
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

function GetCourseInfo(classNumber) {
	modifyCourseInfo1.innerHTML = "";
	fetch(ctx + "/courseInfo/get/" + classNumber)
	.then(res => res.json())
	.then(courseInfo => {	
		CourseInfoByCourseNumber.innerHTML = `
			<div class="row">
				<div class="col">
					<div class="d-flex">
						<div class="mb-3 mt-3 me-auto">
							<h3><i class="fa-solid fa-angle-right"></i> \${courseInfo.classNumber} 정보</h3>
						</div>
						<button onclick="ModifyCourseInfo(this.value)" value="\${courseInfo.classNumber }" class="btn btn-link" type="button">
							<i class="fa-solid fa-pen-to-square">수정</i>
						</button>
					</div>

					<div class="mb-3">
						<label class="form-label">
							학수번호 
						</label>
						<input class="form-control" type="text" value="\${courseInfo.classNumber }" readonly>
					</div>	
					
					<div class="mb-3">
						<label class="form-label">
							교과목명 
						</label>
						<input class="form-control" type="text" value="\${courseInfo.courseName }" readonly>
					</div>	
					
					<div class="mb-3">
						<label class="form-label">
							과목구분 
						</label>
						<input class="form-control" type="text" value="\${courseInfo.courseClassification }" readonly>
					</div>	

					
					<div class="mb-3">
						<label class="form-label">
							학점
						</label>
						<input class="form-control" type="number" value="\${courseInfo.credit }" readonly>
					</div>
					
					<div class="mb-3">
						<label class="form-label">
							강의
						</label>
						<input class="form-control" type="number" value="\${courseInfo.theory }" readonly>
					</div>
				
					<div class="mb-3">
						<label class="form-label">
							실습
						</label>
						<input class="form-control" type="number" value="\${courseInfo.practice }" readonly>
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">수업개요</label>
						<textarea rows="5" class="form-control" name="summary" value="\${courseInfo.summary }"  readonly>강의 열심히 들으세요.</textarea>
					</div>					
					
				</div>
			</div>
		`
	});
}

function ModifyCourseInfo(classNumber) {
	fetch(ctx + "/courseInfo/get/" + classNumber)
	.then(res => res.json())
	.then(courseInfo => {
		modifyCourseInfo1.innerHTML = `

			<div class="row">
				<div class="col">
					<div class="mb-3 mt-3 me-auto">
						<h3><i class="fa-solid fa-angle-right"></i> \${courseInfo.classNumber} 수정</h3>
					</div>
				<form id="modifyForm" action="\${ctx}/courseInfo/modify" method="post" enctype="multipart/form-data">
					<div class="mb-3">
						<label for="" class="form-label">학수번호</label>
						<input required="required" type="text" class="form-control" value="\${courseInfo.classNumber }" name="classNumber">
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">교과목명</label>
						<input required="required" type="text" class="form-control" value="\${courseInfo.courseName }" name="courseName">
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">과목구분</label>
						<select name="courseClassification" class="form-select" value="\${courseInfo.courseClassification }" aria-label="Default select example">
							<option value="전공기초">전공기초</option>
							<option value="전공심화">전공심화</option>
							<option value="전공핵심">전공핵심</option>
							<option value="핵심교양">핵심교양</option>
							<option value="일반교양">일반교양</option>
							<option value="교양필수">교양필수</option>
						</select>
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">학점</label>
						<input required="required" type="number" class="form-control" value="\${courseInfo.credit }" name="credit">
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">강의</label>
						<input required="required" type="number" class="form-control" value="\${courseInfo.theory }" name="theory">
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">실습</label>
						<input required="required" type="number" class="form-control" value="\${courseInfo.practice }" name="practice">
					</div>
					
					<div class="mb-3">
						<label for="" class="form-label">수업개요</label>
						<textarea required="required" rows="5" class="form-control" value="\${courseInfo.summary }" name="summary">강의 열심히 들으세요.</textarea>
					</div>
					</form>
					
					<input class="btn btn-warning" type="submit" value="수정" data-bs-toggle="modal" data-bs-target="#modifyModal">
					<input class="btn btn-danger" type="submit" value="삭제" data-bs-toggle="modal" data-bs-target="#removeModal">
					
					<form id="removeForm" action="\${ctx }/courseInfo/remove" method="post">
					<input type="hidden" name="classNumber" value="\${courseInfo.classNumber }">
					</form>
				</div>
			</div>
		`;

	});
}

function RegisterCourseInfo() {
	modifyCourseInfo1.innerHTML = "";
		CourseInfoByCourseNumber.innerHTML = `
			<div class="row">
				<div class="col">
					<div class="mb-3 mt-3 me-auto">
						<h3><i class="fa-solid fa-angle-right"></i>새 강의 정보 등록</h3>
					</div>
					<form id="registerForm1" action="\${ctx}/courseInfo/register" method="post" enctype="multipart/form-data">
						<div class="mb-3">
							<label for="" class="form-label">학수번호</label>
							<input required="required" type="text" class="form-control" name="classNumber">
						</div>
						
						<div class="mb-3">
							<label for="" class="form-label">교과목명</label>
							<input required="required" type="text" class="form-control" name="courseName">
						</div>
						
						<div class="mb-3">
							<label for="" class="form-label">과목구분</label>
							<select name="courseClassification" class="form-select" aria-label="Default select example">
								<option value="전공기초">전공기초</option>
								<option value="전공심화">전공심화</option>
								<option value="전공핵심">전공핵심</option>
								<option value="핵심교양">핵심교양</option>
								<option value="일반교양">일반교양</option>
								<option value="교양필수">교양필수</option>
							</select>
						</div>
						
						<div class="mb-3">
							<label for="" class="form-label">학점</label>
							<input required="required" type="number" class="form-control" name="credit">
						</div>
						
						<div class="mb-3">
							<label for="" class="form-label">강의</label>
							<input required="required" type="number" class="form-control" name="theory">
						</div>
						
						<div class="mb-3">
							<label for="" class="form-label">실습</label>
							<input required="required" type="number" class="form-control" name="practice">
						</div>
						
						<div class="mb-3">
							<label for="" class="form-label">수업개요</label>
							<textarea required="required" rows="5" class="form-control" name="summary">강의 열심히 들으세요.</textarea>
						</div>
						
						<input id="submitButton1" class="btn btn-primary" type="submit" value="등록">
					</form>
				</div>
			</div>
		`;
}




</script>
</body>
</html>