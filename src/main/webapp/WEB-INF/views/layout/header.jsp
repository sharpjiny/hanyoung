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
                   	   <li><a tabindex="-1" href="#" onclick="userForm.pop();" />비밀번호 변경</a></li>
                       <li class="divider"></li>
                       <li><a tabindex="-1" href="<c:url value="/logout" />">Logout</a></li>
                   </ul>
               </li>
           </ul>
           <ul class="nav">
           	   <c:if test="${userSession.id == 'hanadmin'}"> 
               <li class="dropdown">
                   <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">설정 <i class="caret"></i></a>
                   <ul class="dropdown-menu">
                   	   <li><a tabindex="-1" href="/set/mtrlsInfo/page">원자재/부자재 설정</a></li>
                   	   <li><a tabindex="-1" href="/set/prdtInfo/page">제품 설정</a></li>
                   	   <li><a tabindex="-1" href="/set/bomInfo/page">BOM 설정</a></li>
                   	   <li><a tabindex="-1" href="/set/codesInfo/page">Codes 설정</a></li>
                   	   <!-- <li><a tabindex="-1" href="/toastGrid/search">Grid Sample</a></li> -->
                   </ul>
               </li>
               </c:if>
               <li class="dropdown">
                   <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">구매관리<i class="caret"></i></a>
                   <ul class="dropdown-menu">
                       <li><a tabindex="-1" href="/inout/mtrls/page">원부자재 입출고</a></li>
                       <!-- <li><a tabindex="-1" href="/set/mtrlsUsage/page">원부자재 사용량</a></li> -->
                   </ul>
               </li>
               <li class="dropdown">
                   <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">생산관리<i class="caret"></i></a>
                   <ul class="dropdown-menu">
                       <li><a tabindex="-1" href="/production/prod/page">용접일보</a></li>
                       <li><a tabindex="-1" href="/production/coating/page">코팅일보</a></li>
                       <!-- <li><a tabindex="-1" href="/production/welding/page">용접일보</a></li> -->
                       <li><a tabindex="-1" href="/production/packing/page">포장일보</a></li>
                       <li><a tabindex="-1" href="/production/quality/page">품질일보</a></li>
                       <li><a tabindex="-1" href="/production/prdtRepair/page">제품수리일보</a></li>
                       <li><a tabindex="-1" href="/production/repair/page">설비수리일보</a></li>
                       <!-- <li><a tabindex="-1" href="/set/hgoodsUsage/page">반제품/완성품 생산량</a></li> --> 
                   </ul>
               </li>
               <!-- <li class="dropdown">
                   <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">생산현황<i class="caret"></i></a>
                   <ul class="dropdown-menu">
                       <li><a tabindex="-1" href="/plan/produce/page">생산</a></li>
                   </ul>
               </li> -->
               <li class="dropdown">
                   <a href="/stock/search" role="button" class="dropdown-toggle" data-toggle="dropdown">재고관리<i class="caret"></i></a>
                   <ul class="dropdown-menu">
                       <li><a tabindex="-1" href="/inout/prdt/page">제품 입출고 현황</a></li>
                       <li><a tabindex="-1" href="/inout/outs/page">외주원부자재</a></li>
                       <li><a tabindex="-1" href="/stock/prdt/page">완성품/반성품</a></li>
                       <li><a tabindex="-1" href="/stock/mtrls/page">원자재/부자재</a></li>
                       <!-- <li><a tabindex="-1" href="/set/hgoodsOutStock/page">반제품(외주)</a></li> -->
                   </ul>
               </li>
               <li class="dropdown">
                   <a href="/stock/search" role="button" class="dropdown-toggle" data-toggle="dropdown">수출<i class="caret"></i></a>
                   <ul class="dropdown-menu">
                       <li><a tabindex="-1" href="/plan/export/page">수출계획표</a></li>
                   </ul>
               </li>
           </ul>
       </div>
       <!--/.nav-collapse -->
    </div>
</div>
