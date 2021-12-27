<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 <div class="row-fluid">
    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">공정흐름표</div>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
				<div class="alert alert-block">
					<form method="get" class="form-horizontal" action="" id="searchForm" onsubmit="return paging.submit(); return false;">
						<fieldset>
							<div class="control-group">
								<label class="control-label" for="dateStart">日期</label>
								<div class="controls">
									<input class="input-small date" name="dateStart" id="dateStart" type="text" value="${pageParam.dateStart}">
									~
									<input class="input-small date" name="dateEnd" id="dateEnd" type="text" value="${pageParam.dateEnd}">
								</div>
							</div>
							<div class="control-group btn-group">
								<button type="submit" class="btn btn-primary">Search</button>
							</div>
						</fieldset>
					</form>
				</div>
				<div class="tableScroll">
                <table cellpadding="0" style="width:100%" class="table-hover table-striped" >
                    <thead >
                        <tr>
                            <th>NO</th>
                            <th>종류</th>
                            <th>고객사</th>
                            <th>車型</th>
                            <th>품명</th>
                            <th>L/R</th>
                            <th>품호</th>
                            <th>사출생산품수량</th>
                            <th>사출양품수량</th>
                            <th>사출불량수량</th>
                            <th>증착양품수량</th>
                            <th>조립포장수량</th>
                            <th>조립포장불량수량</th>
                            <th>조립포장양품수량</th>
                            <th>실제창고입고수량</th>
                            <th>납품수량</th>
                            <th>차이</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:choose>
						<c:when test="${!empty list}">
						<c:set var="p1" value="0"/>
						<c:set var="a1" value="0"/>
						<c:set var="f1" value="0"/>
						<c:set var="p2" value="0"/>
						<c:set var="p3" value="0"/>
						<c:set var="f2" value="0"/>
						<c:set var="a2" value="0"/>
						<c:set var="p4" value="0"/>
						<c:set var="p5" value="0"/>
						<c:set var="d1" value="0"/>
						<c:set var="prevCode" value=""/>
							<c:forEach items="${list}" var="item" varStatus="loop">
						<c:set var="t" value="${item.kind}${item.client}${item.model_car}${item.product_name}"/>
					            <tr>
					                <td class="center"><span>${loopIndex+loop.count}</span></td>
					                <c:if test="${prevCode!=t}">
					                <td rowspan="${item.cnt}" style="vertical-align: middle; text-align: center">${item.kind}</td>
					                <td rowspan="${item.cnt}" style="vertical-align: middle; text-align: center">${item.client}</td>
					                <td rowspan="${item.cnt}" style="vertical-align: middle; text-align: center">${item.model_car}</td>
					                <td rowspan="${item.cnt}" style="vertical-align: middle; text-align: center">${item.product_name}</td>
					                </c:if>
					                <td>${item.lh_rh}</td>
					                <td>${item.vehicle_id}</td>
					                <td><fmt:formatNumber value="${item.p1}" pattern="#,###" /></td>
					                <td><fmt:formatNumber value="${item.a1}" pattern="#,###" /></td>
					                <td><fmt:formatNumber value="${item.f1}" pattern="#,###" /></td>
					                <td><fmt:formatNumber value="${item.p2}" pattern="#,###" /></td>
					                <td><fmt:formatNumber value="${item.p3}" pattern="#,###" /></td>
					                <td><fmt:formatNumber value="${item.f2}" pattern="#,###" /></td>
					                <td><fmt:formatNumber value="${item.a2}" pattern="#,###" /></td>
					                <td><fmt:formatNumber value="${item.p4}" pattern="#,###" /></td>
					                <td><fmt:formatNumber value="${item.p5}" pattern="#,###" /></td>
					                <td><fmt:formatNumber value="${item.d1}" pattern="#,###" /></td>
					            </tr>
					            <c:set var="p1" value="${p1 + item.p1}"/>
					            <c:set var="a1" value="${a1 + item.a1}"/>
					            <c:set var="f1" value="${f1 + item.f1}"/>
					            <c:set var="p2" value="${p2 + item.p2}"/>
					            <c:set var="p3" value="${p3 + item.p3}"/>
					            <c:set var="f2" value="${f2 + item.f2}"/>
					            <c:set var="a2" value="${a2 + item.a2}"/>
					            <c:set var="p4" value="${p4 + item.p4}"/>
					            <c:set var="p5" value="${p5 + item.p5}"/>
					            <c:set var="d1" value="${d1 + item.d1}"/>
					            <c:set var="prevCode" value="${item.kind}${item.client}${item.model_car}${item.product_name}"/>
					        </c:forEach>
					        <tr style="background-color: #f2dede">
                                    <td class="center" colspan="7">합계</td>
                                    <td class="center"><fmt:formatNumber value="${p1}" pattern="#,###" /></td>
                                    <td class="center"><fmt:formatNumber value="${a1}" pattern="#,###" /></td>
                                    <td class="center"><fmt:formatNumber value="${f1}" pattern="#,###" /></td>
                                    <td class="center"><fmt:formatNumber value="${p2}" pattern="#,###" /></td>
                                    <td class="center"><fmt:formatNumber value="${p3}" pattern="#,###" /></td>
                                    <td class="center"><fmt:formatNumber value="${f2}" pattern="#,###" /></td>
                                    <td class="center"><fmt:formatNumber value="${a2}" pattern="#,###" /></td>
                                    <td class="center"><fmt:formatNumber value="${p4}" pattern="#,###" /></td>
                                    <td class="center"><fmt:formatNumber value="${p5}" pattern="#,###" /></td>
                                    <td class="center"><fmt:formatNumber value="${d1}" pattern="#,###" /></td>
                            </tr>
						</c:when>
						<c:otherwise>
							<tr>
								<td scope="col" colspan="30" class="center bin">NO DATA.</td>
							</tr>
						</c:otherwise>
					</c:choose>
                    </tbody>
                </table>
                </div>
               <c:import url="../layout/paginate.jsp"></c:import>
            </div>
        </div>
    </div>
    <!-- /block -->
</div>
<link rel="stylesheet" type="text/css" href="<c:url value='/res/css/datepicker.css'/>" media="screen"/>
<script src="<c:url value='/res/js/plugin/bootstrap-datepicker.js'/>"></script>
<script src="<c:url value='/res/js/plugin/bootstrap-datepicker.kr.js'/>"></script>
<script>

$(function(){
	dateUtil.init();
});
</script>