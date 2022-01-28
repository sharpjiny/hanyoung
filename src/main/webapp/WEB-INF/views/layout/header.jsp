<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.net.URLEncoder" %>
<div class="navbar-inner">
   <div class="container-fluid">
       <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"> <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
       </a>
       <a class="brand" href="/">HAN YOUNG EPR</a>
       <div class="nav-collapse collapse">
           <ul class="nav pull-right">
               <li class="dropdown">
                   <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown"> <i class="icon-user"></i> ${userSession.name} <i class="caret"></i></a>
                   <ul class="dropdown-menu">
                       <li><a tabindex="-1" href="#">비밀번호 변경</a></li>
                       <li class="divider"></li>
                       <li><a tabindex="-1" href="<c:url value="/logout" />">Logout</a></li>
                   </ul>
               </li>
           </ul>
           <ul class="nav">
           	   <c:if test="${userSession.id == 'hanadmin'}"> 
               <li class="dropdown">
                   <a href="/set/vehicle/search" role="button" class="dropdown-toggle" data-toggle="dropdown">設定 <i class="caret"></i></a>
                   <ul class="dropdown-menu">
                   	   <li><a tabindex="-1" href="/set/mtrlsInfo/page">원부자재 설정</a></li>
                   	   <li><a tabindex="-1" href="/set/productInfo/page">제품 설정</a></li>
                   	   <li><a tabindex="-1" href="/set/bomInfo/page">BOM 설정(조립매핑)</a></li>
                   	   <li><a tabindex="-1" href="/set/codesInfo/page">Codes Info.</a></li>
                   	   <li><a tabindex="-1" href="/toastGrid/search">Grid Sample</a></li>
                   </ul>
               </li>
               </c:if>
               <li class="dropdown">
                   <a href="/production/inspection/search" role="button" class="dropdown-toggle" data-toggle="dropdown">구매관리<i class="caret"></i></a>
                   <ul class="dropdown-menu">
                       <li><a tabindex="-1" href="/set/mtrlsInoutOut/page">원부자재 입출고(외주)</a></li>
                       <li><a tabindex="-1" href="/set/mtrlsUsage/page">원부자재 사용량</a></li>
                   </ul>
               </li>
               <li class="dropdown">
                   <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">생산관리<i class="caret"></i></a>
                   <ul class="dropdown-menu">
                       <li><a tabindex="-1" href="/set/productAll/page">용접/코팅/포장/수리</a></li>
                       <li><a tabindex="-1" href="/set/hgoodsUsage/page">반제품/완성품 생산량</a></li>
                       <li><a tabindex="-1" href="/set/hproductInoutOut/page">반제품 입출고(외주)</a></li>
                   </ul>
               </li>
               <li class="dropdown">
                   <a href="/stock/search" role="button" class="dropdown-toggle" data-toggle="dropdown">재고관리<i class="caret"></i></a>
                   <ul class="dropdown-menu">
                       <li><a tabindex="-1" href="/set/hgoodsStock/page">반제품/완성품</a></li>
                       <li><a tabindex="-1" href="/set/mtrlsStock/page">원부자재</a></li>
                       <li><a tabindex="-1" href="/set/hgoodsOutStock/page">반제품(외주)</a></li>
                   </ul>
               </li>
           </ul>
       </div>
       <!--/.nav-collapse -->
    </div>
</div>