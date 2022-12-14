<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:url value="/admin/board" var="boardLink"></c:url>
<c:url value="/admin/list" var="listLink"></c:url>
<c:url value="/student/list" var="studentLink"></c:url>
<c:url value="/professor/list" var="professorLink"></c:url>
<c:url value="/course/list" var="courseLink"></c:url>
<c:url value="/courseInfo/list" var="courseInfoLink"></c:url>
<c:url value="/signUpNotice/list" var="signUpNoticeLink"></c:url>
<sec:authorize access="hasAnyAuthority('admin','courseInfo')" var="hasCourseInfo"></sec:authorize>
<sec:authorize access="hasAnyAuthority('admin','member')" var="hasMember"></sec:authorize>
<sec:authorize access="hasAnyAuthority('admin','course')" var="hasCourse"></sec:authorize>
<sec:authorize access="hasAnyAuthority('admin','sugang')" var="hasSugang"></sec:authorize>
<sec:authorize access="hasAuthority('admin')" var="hasAdmin"></sec:authorize>

<nav class="navbar navbar-expand-lg bg-light">
  <div class="container-fluid">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0 flex-column">
      <c:if test="${hasAdmin }">
        <li class="nav-item">
		  <a class="btn btn-light" href="${listLink }">
		    관리자 계정 관리
		  </a>
        </li>
        
        <hr>
      </c:if>
        
        <li class="nav-item">
		  <a class="btn btn-light" href="${boardLink }">
		    대시보드
		  </a>
        </li>
        
        <hr>
      <c:if test="${hasMember }">
        <li class="nav-item">
		  <button class="btn btn-light" type="button" >
		    회원
			<i class="fa-solid fa-angle-down"></i>
		  </button>
        </li>
	 	<li class="nav-item ms-4">
	      <a id="memberCollapse" class="nav-link" aria-current="page" href="${studentLink }">학생 관리</a>
	    </li>
	 	<li class="nav-item ms-4">
	      <a id="memberCollapse" class="nav-link" aria-current="page" href="${professorLink }">교수 관리</a>
	    </li>	
	    	    
	    <hr>
      </c:if>        
        
        <c:if test="${hasCourse or hasCourseInfo }">
        <li class="nav-item">
		  <button class="btn btn-light" type="button" data-bs-toggle="collapse" data-bs-target="#courseCollapse" aria-expanded="false" aria-controls="courseCollapse">
		    강의
			<i class="fa-solid fa-angle-down"></i>
		  </button>
        </li>
        </c:if>  
        
        <c:if test="${hasCourse }">
	 	<li class="nav-item ms-4">
	      <a id="courseCollapse" class="nav-link" aria-current="page" href="${courseLink }">강의 관리</a>
	    </li>
        </c:if> 
         
	    <c:if test="${hasCourseInfo }">
	 	<li class="nav-item ms-4">
	      <a id="courseCollapse" class="nav-link" aria-current="page" href="${courseInfoLink }">교과목 관리</a>
	    </li>		        
        <hr>
        
	    </c:if>  
        
      <c:if test="${hasSugang }">
        <li class="nav-item">
		  <button class="btn btn-light" type="button" >
		    수강
			<i class="fa-solid fa-angle-down"></i>
		  </button>
        </li>
	 	<li class="nav-item ms-4">
	      <a id="memberCollapse" class="nav-link" aria-current="page" href="${signUpNoticeLink }">수강 안내</a>
	    </li>

	  </c:if>	
     	
<%--      <li class="nav-item">
		  <button class="btn btn-light" type="button" data-bs-toggle="collapse" data-bs-target="#memberCollapse" aria-expanded="false" aria-controls="memberCollapse">
		    회원
			<i class="fa-solid fa-angle-down"></i>
		  </button>
        </li>
	 	<li class="nav-item ms-4">
	      <a id="memberCollapse" class="nav-link collapse" aria-current="page" href="${studentLink }">학생관리</a>
	    </li>
	 	<li class="nav-item ms-4">
	      <a id="memberCollapse" class="nav-link collapse" aria-current="page" href="${professorLink }">교수관리</a>
	    </li>	
	 	<li class="nav-item ms-4">
	      <a id="memberCollapse" class="nav-link collapse" aria-current="page" href="#">수강신청</a>
	    </li>	
	    	    
	    <hr>
        
        <li class="nav-item">
		  <button class="btn btn-light" type="button" data-bs-toggle="collapse" data-bs-target="#courseCollapse" aria-expanded="false" aria-controls="courseCollapse">
		    강의
			<i class="fa-solid fa-angle-down"></i>
		  </button>
        </li>
	 	<li class="nav-item ms-4">
	      <a id="courseCollapse" class="nav-link collapse" aria-current="page" href="${courseLink }">강의 관리</a>
	    </li>
	 	<li class="nav-item ms-4">
	      <a id="courseCollapse" class="nav-link collapse" aria-current="page" href="${courseInfoLink }">강의 정보 관리</a>
	    </li>		        
 	 	<li class="nav-item ms-4">
	      <a id="courseCollapse" class="nav-link collapse" aria-current="page" href="#">.......</a>
	    </li>
	    	    
	    <hr>
        
        <li class="nav-item">
		  <button class="btn btn-light" type="button" data-bs-toggle="collapse" data-bs-target="#settingCollapse" aria-expanded="false" aria-controls="settingCollapse">
		    설정
			<i class="fa-solid fa-angle-down"></i>
		  </button>
        </li>
	 	<li class="nav-item ms-4">
	      <a id="settingCollapse" class="nav-link collapse" aria-current="page" href="#">....관리</a>
	    </li>
	 	<li class="nav-item ms-4">
	      <a id="settingCollapse" class="nav-link collapse" aria-current="page" href="#">.......</a>
	    </li>		        
 	 	<li class="nav-item ms-4">
	      <a id="settingCollapse" class="nav-link collapse" aria-current="page" href="#">.......</a>
	    </li> --%>
      
  </div>
</nav>

