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

<!-- toast -->
<div aria-live="polite" aria-atomic="true" class="position-relative ms-auto">
  <div class="toast-container top-0 end-0 p-3">
	<div id="toastId1" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
	    <div class="toast-header">
	        <strong id="toastStrongId1" class="me-auto"><i class="bi-gift-fill"></i></strong>
	        <small id="toastSmallId1">방금 전</small>
	        <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
	    </div>
	    <div id="toastBodyId1" class="toast-body">
	    	
	    </div>
	</div>
  </div>
</div>

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
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link" href="${signUpNoticeLink }">수강안내</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${listLink }">수강편람</a>
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
     <ul class="navbar-nav mb-2 mb-lg-0">
    	<li class="nav-item">
          <a class="nav-link">최소학점 : 6</a>
        </li>
    	<li class="nav-item">
          <a class="nav-link">최대학점 : 20</a>
        </li>
     	<li id="signUpCreditId1" class="nav-item">
          <a class="nav-link">신청학점 : ${signUpCredit }</a>
        </li>               
     </ul>
    </div>
    
  </div>
</nav>

