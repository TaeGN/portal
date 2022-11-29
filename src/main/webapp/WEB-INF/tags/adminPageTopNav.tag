<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<nav class="navbar navbar-expand-lg bg-light">
  <div class="container-fluid d-flex">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0 flex-row">
        <li class="nav-item">
          <h1>Portal</h1>
        </li>
        <li class="nav-item mt-4 ms-2">
          관리자
        </li>
      </ul>
      <ul class="navbar-nav mb-2 mb-lg-0 flex-row">
        <li class="nav-item me-3">
        <sec:authentication property="name" var="username"/>
        <c:url value="/admin/get" var="getLink">
        	<c:param name="username" value="${username }"></c:param>
        </c:url>
          <a class="nav-link active" aria-current="page" href="${getLink }">내정보</a>
        </li>
        <li class="nav-item">
        	<c:url value="/admin/logout" var="logoutLink"></c:url>
          <a class="nav-link" href="${logoutLink }">로그아웃</a>
        </li>
      </ul>
       
<!--       <form class="d-flex" role="search">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form> -->

  </div>
</nav>


<hr>