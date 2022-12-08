<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:url value="/sugang/signUpNotice" var="signUpNoticeLink"></c:url>
<c:url value="/sugang/list" var="listLink"></c:url>
<c:url value="/sugang/login" var="loginLink"></c:url>
<c:url value="/sugang/desireList" var="desireLink"></c:url>
<c:url value="/sugang/signUpList" var="signUpLink"></c:url>
<c:url value="/admin/board" var="adminLink"></c:url>

<sec:authorize access="isAuthenticated()" var="loggedIn" />
<sec:authorize access="hasAnyAuthority('admin','member','course','courseInfo')" var="admin" />

<div class="d-flex">
	<h3>수강신청 페이지</h3>
	<sec:authorize access="!isAuthenticated()">
		<a href="${loginLink }">로그인 하러 가기</a>
	</sec:authorize>
 	<sec:authorize access="isAuthenticated()">
		<a href="${loginLink }">로그아웃</a>
	</sec:authorize> 
	<div class="ms-auto">
		<c:if test="${admin }">
			<a href="${adminLink }">관리자 페이지로 이동</a>
		</c:if>
	</div>
</div>
<nav class="navbar navbar-expand-lg bg-light">
  <div class="container-fluid">
    <!-- <a class="navbar-brand" href="#">Navbar</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button> -->
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
<!--         <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="#">Home</a>
        </li> -->
        <li class="nav-item">
          <a class="nav-link" href="${listLink }">수강편람</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${signUpNoticeLink }">수강안내</a>
        </li>
        <c:if test="${loggedIn }">
	        <li class="nav-item">
	          <a class="nav-link" href="${desireLink }">희망수업</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="${signUpLink }">신청내역</a>
	        </li>
        </c:if>
      </ul>
      <form class="d-flex" role="search">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form>
    </div>
  </div>
</nav>