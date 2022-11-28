<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:url value="/admin/member" var="memberLink"></c:url>
<c:url value="/admin/student" var="studentLink"></c:url>

<nav class="navbar navbar-expand-lg bg-light">
  <div class="container-fluid">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
		  <a class="btn btn-light" href="${memberLink }">
		    관리자 계정 관리
		  </a>
        </li>
        
        <hr>
        
        <li class="nav-item">
		  <button class="btn btn-light" type="button" data-bs-toggle="collapse" data-bs-target="#memberCollapse" aria-expanded="false" aria-controls="memberCollapse">
		    회원
			<i class="fa-solid fa-angle-down"></i>
		  </button>
        </li>
	 	<li class="nav-item ms-4">
	      <a id="memberCollapse" class="nav-link collapse" aria-current="page" href="${studentLink }">학생관리</a>
	    </li>
	 	<li class="nav-item ms-4">
	      <a id="memberCollapse" class="nav-link collapse" aria-current="page" href="#">수강신청</a>
	    </li>	
	 	<li class="nav-item ms-4">
	      <a id="memberCollapse" class="nav-link collapse" aria-current="page" href="#">.......</a>
	    </li>	
	    	    
	    <hr>
        
        <li class="nav-item">
		  <button class="btn btn-light" type="button" data-bs-toggle="collapse" data-bs-target="#courseCollapse" aria-expanded="false" aria-controls="courseCollapse">
		    강의
			<i class="fa-solid fa-angle-down"></i>
		  </button>
        </li>
	 	<li class="nav-item ms-4">
	      <a id="courseCollapse" class="nav-link collapse" aria-current="page" href="#">강의관리</a>
	    </li>
	 	<li class="nav-item ms-4">
	      <a id="courseCollapse" class="nav-link collapse" aria-current="page" href="#">.......</a>
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
	    </li>		    	       
<!--         <li class="nav-item">
          <a class="nav-link disabled">Disabled</a>
        </li> -->
      </ul>
      <form class="d-flex" role="search">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form>
     
      
  </div>
</nav>
