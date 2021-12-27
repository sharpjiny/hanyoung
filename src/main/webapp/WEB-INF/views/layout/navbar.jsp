<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
<c:when test="${menuType == 'set'}">
<ul class="nav nav-list bs-docs-sidenav nav-collapse collapse">
    <li><a href="/set/vehicle/search"><i class="icon-chevron-right"></i>차종품명품호 관리</a></li>
    <li><a href="#"><i class="icon-chevron-right"></i>원재료 관리</a></li>
    <li><a href="#"><i class="icon-chevron-right"></i>주요부자재 관리</a></li>
    <li><a href="#"><i class="icon-chevron-right"></i>공인 관리</a></li>
    <li><a href="#"><i class="icon-chevron-right"></i>비밀번호 관리</a></li>
</ul>
</c:when>
<c:when test="${menuType == 'production'}">
<ul class="nav nav-list bs-docs-sidenav nav-collapse collapse">
	<li><a href="#"><i class="icon-chevron-right"></i>사출 관리</a></li>
	<li><a href="#"><i class="icon-chevron-right"></i>증착 관리</a></li>
	<li><a href="#"><i class="icon-chevron-right"></i>도장 관리</a></li>
	<li class="active"><a href="/production/inspection/search"><i class="icon-chevron-right"></i>검사 관리</a></li>
	<li><a href="#"><i class="icon-chevron-right"></i>종합생산현황</a></li>
</ul>
</c:when>
</c:choose>
