<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<c:choose>
<c:when test="${code=='0000'}">
<script>
	alert('${message}');
	location.href = '${url}';
</script>
</c:when>
<c:otherwise>
<a href="${contextPath}/home">홈으로 이동</a>
</c:otherwise>
</c:choose>
