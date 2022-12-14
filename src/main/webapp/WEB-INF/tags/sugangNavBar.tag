<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:url value="/sugang/signUpNotice" var="signUpNoticeLink"></c:url>
<c:url value="/sugang/list" var="listLink"></c:url>
<c:url value="/sugang/login" var="loginLink"></c:url>
<c:url value="/sugang/logout" var="logoutLink"></c:url>
<c:url value="/sugang/desireList" var="desireLink"></c:url>
<c:url value="/sugang/signUpList" var="signUpLink"></c:url>
<c:url value="/admin/board" var="adminLink"></c:url>

<sec:authorize access="isAuthenticated()" var="loggedIn" />
<sec:authorize access="hasAnyAuthority('admin','member','course','courseInfo')" var="admin" />

<nav class="navbar navbar-expand-lg bg-light">
  <div class="container-fluid d-flex">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0 flex-row">
        <li class="nav-item">
          <h1>Portal</h1>
        </li>
        <li class="nav-item mt-4 ms-2">
          수강신청
        </li>
      </ul>
      <ul class="navbar-nav mb-2 mb-lg-0 flex-row">
<%--        <li class="nav-item me-3">
         <sec:authentication property="name" var="username"/>
        <c:url value="/admin/get" var="getLink">
        	<c:param name="username" value="${username }"></c:param>
        </c:url>
          <a class="nav-link active" aria-current="page" href="${getLink }">내정보</a>
        </li> --%>
        <c:if test="${loggedIn }">
	        <li class="nav-item">
	          <a class="nav-link" href="${logoutLink }">로그아웃</a>
	        </li>
        </c:if>
        <c:if test="${not loggedIn }">
	        <li class="nav-item">
	        	<c:url value="/sugang/login" var="loginLink"></c:url>
	          <a class="nav-link" href="${loginLink }">로그인</a>
	        </li>
        </c:if>
      </ul>
  </div>
</nav>


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