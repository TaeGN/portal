<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav aria-label="Page navigation example">
  <ul class="pagination justify-content-center">

    <li class="page-item ${page eq 1 ? 'disabled' : ''}">
    	<c:url value="${currentPageLink }" var="startPageLink">
	    	<c:param name="page" value="1"></c:param>
	    </c:url>	
      <a class="page-link" href="${startPageLink }"><i class="fa-solid fa-angles-left"></i></a>
    </li>

    <li class="page-item ${page <= 10 ? 'disabled' : ''}">
     	<c:url value="${currentPageLink }" var="aheadPageLink">
	    	<c:param name="page" value="${(page - 1) - (page - 1) % 10 }"></c:param>
	    </c:url>	
      <a class="page-link" href="${aheadPageLink }"><i class="fa-solid fa-angle-left"></i></a>
    </li> 
    
    <c:forEach var="i" begin="${(page - 1) / 10 + 1 }" end="${page + 9 < maxPage ? page + 9 : maxPage}">
<%-- 	     <c:url value="${currentPageLink }" var="paginationLink">
	    	<c:param name="page" value="${i }"></c:param>
	    </c:url>  --%>
	    <button onclick="SearchCourse(${studentId}, ${i})" class="page-link"></button>
	   	<li class="page-item ${page eq i ? 'active' : ''}"><a class="page-link" href="${currentPageLink}">${i }</a></li>
    </c:forEach>
 
  
     <li class="page-item ${((page - 1) / 10) * 10 + 11 > maxPage ? 'disabled' : ''}">
    	<%-- <c:url value="${currentPageLink }" var="backPageLink">
	    	<c:param name="page" value="${((page - 1) / 10) * 10 + 11 }"></c:param>
	    </c:url> --%>	
    	<a class="page-link" href="${backPageLink }"><i class="fa-solid fa-angle-right"></i></a>
    </li>
    
    <li class="page-item ${page eq maxPage ? 'disabled' : ''}">
    	<c:url value="${currentPageLink }" var="endPageLink">
	    	<c:param name="page" value="${maxPage }"></c:param>
	    </c:url>	
    	<a class="page-link" href="${endPageLink }"><i class="fa-solid fa-angles-right"></i></a>
    </li>

  </ul>
</nav>