<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.net.URLEncoder" %>
<div class="navbar-inner">
   <div class="container-fluid">
       <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"> <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
       </a>
       <a class="brand" href="/">BOGO EPR</a>
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
           		<c:if test="${userSession.id == 'bogoadmin'}"> 
               <li class="dropdown">
                   <a href="/set/vehicle/search" role="button" class="dropdown-toggle" data-toggle="dropdown">設定 <i class="caret"></i></a>
                   <ul class="dropdown-menu">
                       <li><a tabindex="-1" href="/set/vehicle/search">车型品名品号管理</a></li>
                       <li><a tabindex="-1" href="/set/rawStock/search">原材料管理</a></li>
                       <!-- <li><a tabindex="-1" href="/set/submat/search">주요부자재 관리</a></li> -->
                       <li><a tabindex="-1" href="#">工人管理</a></li>
                       <li><a tabindex="-1" href="#">密码管理</a></li>
                   </ul>
               </li>
               </c:if>
               <li class="dropdown">
                   <a href="/production/inspection/search" role="button" class="dropdown-toggle" data-toggle="dropdown">生产 <i class="caret"></i></a>
                   <ul class="dropdown-menu">
                       <li><a tabindex="-1" href="/production/ejection/search">注塑不良管理</a></li>
                       <li><a tabindex="-1" href="/production/ejectionRaw/search">注塑原材料管理</a></li>
                       <li><a tabindex="-1" href="#">注塑达成率管理</a></li>
                       <li><a tabindex="-1" href="/production/vaccum/search">镀铝管理</a></li>
                       <!-- <li><a tabindex="-1" href="#">도장 관리</a></li> -->
                       <li><a tabindex="-1" href="/production/inspection/search">组装包装管理</a></li>
                       <li><a tabindex="-1" href="/production/totalView/search">生产日报</a></li>
                       <!-- <li><a tabindex="-1" href="/production/flow/search">공정흐름표</a></li> -->
                       <!-- <li><a tabindex="-1" href="#">실적현황</a></li>
                       <li><a tabindex="-1" href="#">생산계획</a></li> -->
                   </ul>
               </li>
               <li class="dropdown">
                   <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">品 <i class="caret"></i></a>
                   <ul class="dropdown-menu">
                       <li><a tabindex="-1" href="#">不良现状</a></li>
                   </ul>
               </li>
               <li class="dropdown">
                   <a href="/stock/search" role="button" class="dropdown-toggle" data-toggle="dropdown">产品 <i class="caret"></i></a>
                   <ul class="dropdown-menu">
                       <li><a tabindex="-1" href="/stock/search">产品出入库现状</a></li>
                       <c:url var="suri" value="完成品"/>
                       <li><a tabindex="-1" href="/stock/statistics?kind=<%=URLEncoder.encode("完成品", "UTF-8")%>">产品库存</li></a>
                   </ul>
               </li>
               <li class="dropdown">
                   <a href="/stock/search" role="button" class="dropdown-toggle" data-toggle="dropdown">原材料<i class="caret"></i></a>
                   <ul class="dropdown-menu">
                       <c:if test="${userSession.id != 'bogo00'}"> <li><a tabindex="-1" href="/stock/rawstock/search">原材料出入库现状</a></li></c:if>
                       <li><a tabindex="-1" href="/stock/rawstock/statistics">原材料库存</a></li>
                   </ul>
               </li>
               <li class="dropdown">
                   <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">纳品计划 <i class="caret"></i></a>
                   <ul class="dropdown-menu">
                       <li><a tabindex="-1" href="/production/state/search">生产计划</a></li>
                       <li><a tabindex="-1" href="/production/plan/search">纳品实绩现状</a></li>
                   </ul>
               </li>
               <li class="dropdown">
                   <a href="/sales/search" role="button" class="dropdown-toggle" data-toggle="dropdown">买卖出 <i class="caret"></i></a>
                   <ul class="dropdown-menu">
                       <li><a tabindex="-1" href="/sales/search">买卖出现状</a></li>
                   </ul>
               </li>
               <!-- <li class="dropdown">
                   <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">재무 <i class="caret"></i></a>
                   <ul class="dropdown-menu">
                       <li><a tabindex="-1" href="#">운영비 현황</a></li>
                   </ul>
               </li> -->
               <!-- <li class="dropdown">
                   <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">자재 <i class="caret"></i></a>
                   <ul class="dropdown-menu">
                       <li><a tabindex="-1" href="#">원재료 관리</a></li>
                       <li><a tabindex="-1" href="/subMats/search">부자재 리스트</a></li>
                   </ul>
               </li> -->
               <!-- <li class="dropdown">
                   <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">인사 <i class="caret"></i></a>
                   <ul class="dropdown-menu">
                       <li><a tabindex="-1" href="#">인원현황</a></li>
                       <li><a tabindex="-1" href="#">출퇴근현황</a></li>
                       <li><a tabindex="-1" href="#">급여계산</a></li>
                   </ul>
               </li> -->
           </ul>
       </div>
       <!--/.nav-collapse -->
    </div>
</div>