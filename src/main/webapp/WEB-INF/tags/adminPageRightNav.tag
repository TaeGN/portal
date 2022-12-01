<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


	<div class="row">
		<div class="col">
			<table class="table">
				<h3>관리자 로그</h3>
				<thead>
					<tr>
						<th>#</th>
						<th>카테고리</th>
						<th>로그</th>
						<th>관리자명</th>
						<th>시간</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${adminLogList }" var="adminLog">
						<tr>
							<td>${adminLog.id }</td>
							<td>${adminLog.menu } - ${adminLog.category }</td>
							<td>${adminLog.log }</td>
							<td>${adminLog.adminId }-${adminLog.adminName }</td>
							<td>${adminLog.inserted }</td>
						</tr>
					</c:forEach>				
				</tbody>
			</table>
		</div>
	</div>