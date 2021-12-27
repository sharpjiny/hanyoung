<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="row-fluid">
    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">실적현황</div>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
            <div class="alert alert-block">
           	<form method="get" class="form-horizontal" action="" id="searchForm" onsubmit="return paging.submit(); return false;">
					<fieldset>
						<div class="control-group">
							<label class="control-label" for="planDate">日期</label>
							<div class="controls">
								<input class="input-small date" name="planDate" id="planDate" type="text" value="${pageParam.planDate}">
							</div>
						</div>
						<div class="control-group">
                            <label class="control-label" for="inputError">入库社</label>
                            <div class="controls">
                                <select id="selectClients" name="clients" class="" title="镀铝机号">
                                    <option value="">入库社</option>
                                    <c:forEach items="${clients}" var="item">
	                                    <c:set var="selected" value=""/>
										<c:if test='${item.client==pageParam.clients}'><c:set var="selected" value="selected"/></c:if>
                                        <option value="${item.client}" ${selected}>${item.client}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="inputError">车种</label>
                            <div class="controls">
                                <select id="selectModelCar" name="modelCar" class="selectVehicle" title="车种">
                                    <option value="">车种</option>
                                    <c:forEach items="${modelCars}" var="item">
	                                    <c:set var="selected" value=""/>
										<c:if test='${item.model_car==pageParam.modelCar}'><c:set var="selected" value="selected"/></c:if>
                                        <option value="${item.model_car}" ${selected}>${item.model_car}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="inputError">品名</label>
                            <div class="controls">
                                <select id="selectProductName" name="productName" class="selectVehicle" title="品名">
                                    <option value="">品名</option>
                                    <c:forEach items="${productNames}" var="item">
	                                    <c:set var="selected" value=""/>
										<c:if test='${item.product_name==pageParam.productName}'><c:set var="selected" value="selected"/></c:if>
                                        <option value="${item.product_name}" ${selected}>${item.product_name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
						<div class="control-group btn-group">
							<button type="submit" class="btn btn-primary">Search</button>
						</div>
					</fieldset>
					<div class="table-toolbar">
	                  <div class="btn-group">
						<input type="hidden" name="pageCut" value="10"/>
						<input type="hidden" name="pageNum" value="${pageParam.pageNum}"/>
	                  </div>
	               </div>
				</form>
            </div>
            <div style="height:700px; overflow:auto">
               <table style="width:100%" class="table-hover">
                   <thead>
                       <tr>
                           <th rowspan="2">NO</th>
                           <th rowspan="2">入库社</th>
                           <th rowspan="2">車种</th>
                           <th rowspan="2">品名</th>
                           <th rowspan="2">L/R</th>
                           <th rowspan="2">品号</th>
                           <th rowspan="2">库存</th>
                           <th rowspan="2">计划</br>共计</th>
                           <th rowspan="2">出库</br>共计</th>
                           <th rowspan="2">计划对比出库</br>(出库-计划)</th>
                           <th rowspan="2">生产需求数量</br>(出库-计划+库存)</th>
                           <c:choose>
							<c:when test="${!empty pagingList}">
								<c:forEach items="${pagingList}" var="item" varStatus="loop">
								<c:if test='${loop.count==1}'>
	                            <th style="background-color:orange;">${item.day1}</th>
	                            <th colspan="2">${item.day2}</th>
	                            <th style="background-color:orange;">${item.day2}</th>
	                            <th colspan="2">${item.day3}</th>
	                            <th style="background-color:orange;">${item.day3}</th>
	                            <th colspan="2">${item.day4}</th>
	                            <th style="background-color:orange;">${item.day4}</th>
	                            <th colspan="2">${item.day5}</th>
	                            <th style="background-color:orange;">${item.day5}</th>
	                            <th colspan="2">${item.day6}</th>
	                            <th style="background-color:orange;">${item.day6}</th>
	                            <th colspan="2">${item.day7}</th>
	                            <th style="background-color:orange;">${item.day7}</th>
	                            <th colspan="2">${item.day8}</th>
	                            <th style="background-color:orange;">${item.day8}</th>
	                            <th colspan="2">${item.day9}</th>
	                            <th style="background-color:orange;">${item.day9}</th>
	                            <th colspan="2">${item.day10}</th>
	                            <th style="background-color:orange;">${item.day10}</th>
	                            <th colspan="2">${item.day11}</th>
	                            </c:if>
	                            </c:forEach>
                        	</c:when>
                        </c:choose>
                       </tr>
                       <tr>
                       	<th style="background-color:orange;">出库</th>
                       	<th>白班</th>
                       	<th>夜班</th>
                       	<th style="background-color:orange;">出库</th>
                       	<th>白班</th>
                       	<th>夜班</th>
                       	<th style="background-color:orange;">出库</th>
                       	<th>白班</th>
                       	<th>夜班</th>
                       	<th style="background-color:orange;">出库</th>
                       	<th>白班</th>
                       	<th>夜班</th>
                       	<th style="background-color:orange;">出库</th>
                       	<th>白班</th>
                       	<th>夜班</th>
                       	<th style="background-color:orange;">出库</th>
                       	<th>白班</th>
                       	<th>夜班</th>
                       	<th style="background-color:orange;">出库</th>
                       	<th>白班</th>
                       	<th>夜班</th>
                       	<th style="background-color:orange;">出库</th>
                       	<th>白班</th>
                       	<th>夜班</th>
                       	<th style="background-color:orange;">出库</th>
                       	<th>白班</th>
                       	<th>夜班</th>
                       	<th style="background-color:orange;">出库</th>
                       	<th>白班</th>
                       	<th>夜班</th>
                       </tr>
                   </thead>
                   <tbody>
                   <c:choose>
					<c:when test="${!empty pagingList}">
					<c:set var="stockSum" value="0"/>
					<c:set var="outputSum" value="0"/>
					<c:set var="planSum" value="0"/>
					<c:set var="gapSum1" value="0"/>
					<c:set var="gapSum2" value="0"/>
					<c:set var="stockDay1" value="0"/>
					<c:set var="planDayW1" value="0"/>
					<c:set var="planDayL1" value="0"/>
					<c:set var="stockDay2" value="0"/>
					<c:set var="planDayW2" value="0"/>
					<c:set var="planDayL2" value="0"/>
					<c:set var="stockDay3" value="0"/>
					<c:set var="planDayW3" value="0"/>
					<c:set var="planDayL3" value="0"/>
					<c:set var="stockDay4" value="0"/>
					<c:set var="planDayW4" value="0"/>
					<c:set var="planDayL4" value="0"/>
					<c:set var="stockDay5" value="0"/>
					<c:set var="planDayW5" value="0"/>
					<c:set var="planDayL5" value="0"/>
					<c:set var="stockDay6" value="0"/>
					<c:set var="planDayW6" value="0"/>
					<c:set var="planDayL6" value="0"/>
					<c:set var="stockDay7" value="0"/>
					<c:set var="planDayW7" value="0"/>
					<c:set var="planDayL7" value="0"/>
					<c:set var="stockDay8" value="0"/>
					<c:set var="planDayW8" value="0"/>
					<c:set var="planDayL8" value="0"/>
					<c:set var="stockDay9" value="0"/>
					<c:set var="planDayW9" value="0"/>
					<c:set var="planDayL9" value="0"/>
					<c:set var="stockDay10" value="0"/>
					<c:set var="planDayW10" value="0"/>
					<c:set var="planDayL10" value="0"/>
						<c:forEach items="${pagingList}" var="item" varStatus="loop">
				            <tr>
				                <td class="center"><span>${loopIndex+loop.count}</span></td>
				                <td>${item.client}</td>
				                <td>${item.model_car}</td>
				                <td>${item.product_name}</td>
				                <td>${item.lh_rh}</td>
				                <td>${item.product_id}</td>
				                <td><fmt:formatNumber value="${item.tot}" pattern="#,###" /></td>
				                <td><fmt:formatNumber value="${item.tot_plan}" pattern="#,###" /></td>
				                <td><fmt:formatNumber value="${item.tot_output}" pattern="#,###" /></td>
				                
				                <c:choose>
				                <c:when test="${item.tot_gap2 < 0}">
				                <td style="background-color:red"><fmt:formatNumber value="${item.tot_gap2}" pattern="#,###" /></td>
				                </c:when>
				                <c:otherwise>
				                <td><fmt:formatNumber value="${item.tot_gap2}" pattern="#,###" /></td>
				                </c:otherwise>
				                </c:choose>
				                
				                <c:choose>
				                <c:when test="${item.tot_gap1 < 0}">
				                <td style="background-color:red"><fmt:formatNumber value="${item.tot_gap1}" pattern="#,###" /></td>
				                </c:when>
				                <c:otherwise>
				                <td><fmt:formatNumber value="${item.tot_gap1}" pattern="#,###" /></td>
				                </c:otherwise>
				                </c:choose>
				                
				                <td style="background-color:#736AFF"><fmt:formatNumber value="${item.stock_day1}" pattern="#,###" /></td>
				                
				                <c:choose>
				                <c:when test="${item.work_type=='W'}">
				                <td><fmt:formatNumber value="${item.plan_day2}" pattern="#,###" /></td><td></td>
				                </c:when>
				                <c:otherwise>
                                   <td></td><td><fmt:formatNumber value="${item.plan_day2}" pattern="#,###" /></td>
                                   </c:otherwise>
				                </c:choose>
				                
				                <td style="background-color:#736AFF"><fmt:formatNumber value="${item.stock_day2}" pattern="#,###" /></td>
				                
				                <c:choose>
				                <c:when test="${item.work_type=='W'}">
				                <td><fmt:formatNumber value="${item.plan_day3}" pattern="#,###" /></td><td></td>
				                </c:when>
				                <c:otherwise>
                                   <td></td><td><fmt:formatNumber value="${item.plan_day3}" pattern="#,###" /></td>
                                   </c:otherwise>
				                </c:choose>
				                
				                <td style="background-color:#736AFF"><fmt:formatNumber value="${item.stock_day3}" pattern="#,###" /></td>
				                
				                <c:choose>
				                <c:when test="${item.work_type=='W'}">
				                <td><fmt:formatNumber value="${item.plan_day4}" pattern="#,###" /></td><td></td>
				                </c:when>
				                <c:otherwise>
                                   <td></td><td><fmt:formatNumber value="${item.plan_day4}" pattern="#,###" /></td>
                                   </c:otherwise>
				                </c:choose>
				                
				                <td style="background-color:#736AFF"><fmt:formatNumber value="${item.stock_day4}" pattern="#,###" /></td>
				                
				                <c:choose>
				                <c:when test="${item.work_type=='W'}">
				                <td><fmt:formatNumber value="${item.plan_day5}" pattern="#,###" /></td><td></td>
				                </c:when>
				                <c:otherwise>
                                   <td></td><td><fmt:formatNumber value="${item.plan_day5}" pattern="#,###" /></td>
                                   </c:otherwise>
				                </c:choose>
				                
				                <td style="background-color:#736AFF"><fmt:formatNumber value="${item.stock_day5}" pattern="#,###" /></td>
				                
				                <c:choose>
				                <c:when test="${item.work_type=='W'}">
				                <td><fmt:formatNumber value="${item.plan_day6}" pattern="#,###" /></td><td></td>
				                </c:when>
				                <c:otherwise>
                                   <td></td><td><fmt:formatNumber value="${item.plan_day6}" pattern="#,###" /></td>
                                   </c:otherwise>
				                </c:choose>
				                
				                <td style="background-color:#736AFF"><fmt:formatNumber value="${item.stock_day6}" pattern="#,###" /></td>
				                
				                <c:choose>
				                <c:when test="${item.work_type=='W'}">
				                <td><fmt:formatNumber value="${item.plan_day7}" pattern="#,###" /></td><td></td>
				                </c:when>
				                <c:otherwise>
                                   <td></td><td><fmt:formatNumber value="${item.plan_day7}" pattern="#,###" /></td>
                                   </c:otherwise>
				                </c:choose>
				                
				                <td style="background-color:#736AFF"><fmt:formatNumber value="${item.stock_day7}" pattern="#,###" /></td>
				                
				                <c:choose>
				                <c:when test="${item.work_type=='W'}">
				                <td><fmt:formatNumber value="${item.plan_day8}" pattern="#,###" /></td><td></td>
				                </c:when>
				                <c:otherwise>
                                   <td></td><td><fmt:formatNumber value="${item.plan_day8}" pattern="#,###" /></td>
                                   </c:otherwise>
				                </c:choose>
				                
				                <td style="background-color:#736AFF"><fmt:formatNumber value="${item.stock_day8}" pattern="#,###" /></td>
				                
				                <c:choose>
				                <c:when test="${item.work_type=='W'}">
				                <td><fmt:formatNumber value="${item.plan_day9}" pattern="#,###" /></td><td></td>
				                </c:when>
				                <c:otherwise>
                                   <td></td><td><fmt:formatNumber value="${item.plan_day9}" pattern="#,###" /></td>
                                   </c:otherwise>
				                </c:choose>
				                
				                <td style="background-color:#736AFF"><fmt:formatNumber value="${item.stock_day9}" pattern="#,###" /></td>
				                
				                <c:choose>
				                <c:when test="${item.work_type=='W'}">
				                <td><fmt:formatNumber value="${item.plan_day10}" pattern="#,###" /></td><td></td>
				                </c:when>
				                <c:otherwise>
                                   <td></td><td><fmt:formatNumber value="${item.plan_day10}" pattern="#,###" /></td>
                                   </c:otherwise>
				                </c:choose>
				                
				                <td style="background-color:#736AFF"><fmt:formatNumber value="${item.stock_day10}" pattern="#,###" /></td>
				                
				                <c:choose>
				                <c:when test="${item.work_type=='W'}">
				                <td><fmt:formatNumber value="${item.plan_day11}" pattern="#,###" /></td><td></td>
				                </c:when>
				                <c:otherwise>
                                   <td></td><td><fmt:formatNumber value="${item.plan_day11}" pattern="#,###" /></td>
                                   </c:otherwise>
				                </c:choose>
				            </tr>
				            <c:set var="stockSum" value="${stockSum + item.tot}"/>
				            <c:set var="outputSum" value="${outputSum + item.tot_output}"/>
				            <c:set var="planSum" value="${planSum + item.tot_plan}"/>
				            <c:set var="gapSum1" value="${gapSum1 + item.tot_gap1}"/>
				            <c:set var="gapSum2" value="${gapSum2 + item.tot_gap2}"/>
				            <c:set var="stockDay1" value="${stockDay1 + item.stock_day1}"/>
				            <c:set var="stockDay2" value="${stockDay2 + item.stock_day2}"/>
							<c:set var="stockDay3" value="${stockDay3 + item.stock_day3}"/>
							<c:set var="stockDay4" value="${stockDay4 + item.stock_day4}"/>
							<c:set var="stockDay5" value="${stockDay5 + item.stock_day5}"/>
							<c:set var="stockDay6" value="${stockDay6 + item.stock_day6}"/>
							<c:set var="stockDay7" value="${stockDay7 + item.stock_day7}"/>
							<c:set var="stockDay8" value="${stockDay8 + item.stock_day8}"/>
							<c:set var="stockDay9" value="${stockDay9 + item.stock_day9}"/>
							<c:set var="stockDay10" value="${stockDay10 + item.stock_day10}"/>
				            <c:choose>
				                <c:when test="${item.work_type=='W'}">
								<c:set var="planDayW2" value="${planDayW2 + item.plan_day2}"/>
								<c:set var="planDayW3" value="${planDayW3 + item.plan_day3}"/>
								<c:set var="planDayW4" value="${planDayW4 + item.plan_day4}"/>
								<c:set var="planDayW5" value="${planDayW5 + item.plan_day5}"/>
								<c:set var="planDayW6" value="${planDayW6 + item.plan_day6}"/>
								<c:set var="planDayW7" value="${planDayW7 + item.plan_day7}"/>
								<c:set var="planDayW8" value="${planDayW8 + item.plan_day8}"/>
								<c:set var="planDayW9" value="${planDayW9 + item.plan_day9}"/>
								<c:set var="planDayW10" value="${planDayW10 + item.plan_day10}"/>
								<c:set var="planDayW11" value="${planDayW11 + item.plan_day11}"/>
								</c:when>
								<c:otherwise>
								<c:set var="planDayL2" value="${planDayL2 + item.plan_day2}"/>
								<c:set var="planDayL3" value="${planDayL3 + item.plan_day3}"/>
								<c:set var="planDayL4" value="${planDayL4 + item.plan_day4}"/>
								<c:set var="planDayL5" value="${planDayL5 + item.plan_day5}"/>
								<c:set var="planDayL6" value="${planDayL6 + item.plan_day6}"/>
								<c:set var="planDayL7" value="${planDayL7 + item.plan_day7}"/>
								<c:set var="planDayL8" value="${planDayL8 + item.plan_day8}"/>
								<c:set var="planDayL9" value="${planDayL9 + item.plan_day9}"/>
								<c:set var="planDayL10" value="${planDayL10 + item.plan_day10}"/>
								<c:set var="planDayL11" value="${planDayL11 + item.plan_day11}"/>
								</c:otherwise>
							</c:choose>
				        </c:forEach>
				        <tr style="background-color: #f2dede">
			                <td class="center" colspan="6">共计</td>
			                <td class="center"><fmt:formatNumber value="${stockSum}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${outputSum}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${planSum}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${gapSum1}" pattern="#,###"/></td>
			                <td class="center"><fmt:formatNumber value="${gapSum2}" pattern="#,###"/></td>
			                <td class="center"><fmt:formatNumber value="${stockDay1}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${planDayW2}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${planDayL2}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${stockDay2}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${planDayW3}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${planDayL3}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${stockDay3}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${planDayW4}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${planDayL4}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${stockDay4}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${planDayW5}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${planDayL5}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${stockDay5}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${planDayW6}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${planDayL6}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${stockDay6}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${planDayW7}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${planDayL7}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${stockDay7}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${planDayW8}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${planDayL8}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${stockDay8}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${planDayW9}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${planDayL9}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${stockDay9}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${planDayW10}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${planDayL10}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${stockDay10}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${planDayW11}" pattern="#,###" /></td>
			                <td class="center"><fmt:formatNumber value="${planDayL11}" pattern="#,###" /></td>
			        	</tr>
					</c:when>
					<c:otherwise>
						<tr class="bin">
							<td scope="col" colspan="41" class="center bin">데이터가 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
                   </tbody>
               </table>
            </div>
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
	/* const nav = document.getElementById('headerNav');
	const top = nav.getBoundingClientRect().top;
	// nav.offsetTop nav.scrollTop top
	nav.addEventListener('scroll', function(x, y){
		if(nav.scrollTop < nav.offsetTop){
			nav.style.postion = 'fixed';
			nav.style.top = 0;
		}else{
			nav.style.position = 'static';
			nav.style.top = '';
		}
	}); */
	
	dateUtil.init();
	
	var data = '<c:out value="${pagingList}"/>'; // 데이터가 없을 시, String 값임 > [] 그래서 length 2임.
	$('thead tr').eq(0).children().addClass("fixedHeaderTop0");
	if(data.length <= 2){
		$('thead tr').eq(1).children().addClass("fixedHeaderTop0");
	}else{
		$('thead tr').eq(1).children().addClass("fixedHeaderTop10");
	}
});
</script>