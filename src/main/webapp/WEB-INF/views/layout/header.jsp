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
                       <li><a tabindex="-1" href="#">비밀번호 변경1</a></li>
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
                   	   <li><a tabindex="-1" href="/toastGrid/search">toast grid test</a></li>
                   </ul>
               </li>
               </c:if>
               <li class="dropdown">
                   <a href="/production/inspection/search" role="button" class="dropdown-toggle" data-toggle="dropdown">生产 <i class="caret"></i></a>
                   <ul class="dropdown-menu">
                   </ul>
               </li>
               <li class="dropdown">
                   <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">品质<i class="caret"></i></a>
                   <ul class="dropdown-menu">
                   </ul>
               </li>
               <li class="dropdown">
                   <a href="/stock/search" role="button" class="dropdown-toggle" data-toggle="dropdown">产品 <i class="caret"></i></a>
                   <ul class="dropdown-menu">
                   </ul>
               </li>
               <li class="dropdown">
                   <a href="/stock/search" role="button" class="dropdown-toggle" data-toggle="dropdown">原材料<i class="caret"></i></a>
                   <ul class="dropdown-menu">
                   </ul>
               </li>
               <li class="dropdown">
                   <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">纳品计划 <i class="caret"></i></a>
                   <ul class="dropdown-menu">
                   </ul>
               </li>
               <li class="dropdown">
                   <a href="/sales/search" role="button" class="dropdown-toggle" data-toggle="dropdown">买卖 <i class="caret"></i></a>
                   <ul class="dropdown-menu">
                       
                   </ul>
               </li>
           </ul>
       </div>
       <!--/.nav-collapse -->
    </div>
</div>