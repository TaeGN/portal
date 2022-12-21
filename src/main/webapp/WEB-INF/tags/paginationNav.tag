<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
    <fmt:parseNumber var="bValue" integerOnly="true" value="${(page - 1) / 10}"></fmt:parseNumber>
    <fmt:parseNumber var="beginValue" integerOnly="true" value="${bValue * 10 + 1 }"></fmt:parseNumber>
    <c:forEach var="i" begin="${beginValue }" end="${beginValue + 9 < maxPage ? beginValue + 9 : maxPage}">
 	    <c:url value="${currentPageLink }" var="paginationLink">
	    	<c:param name="page" value="${i }"></c:param>
	    </c:url>
	   	<li class="page-item ${page eq i ? 'active' : ''}"><a class="page-link" href="${paginationLink}">${i }</a></li>
    </c:forEach>
 
  
     <fmt:parseNumber var="backPageValue" integerOnly="true" value="${beginValue + 10 }"></fmt:parseNumber>
     <li class="page-item ${backPageValue > maxPage ? 'disabled' : ''}">
    	 <c:url value="${currentPageLink }" var="backPageLink">
	    	<c:param name="page" value="${backPageValue }"></c:param>
	    </c:url>	
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