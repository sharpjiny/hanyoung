<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.hanManager.web.util.CommonUtil" %>
 <div class="row-fluid">
    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">매출 현황</div>
<!-- 	        <button type="button" class="btn btn-warning btn-excel" onclick="paging.excel('statisticsExcel')" style="margin-left: 10px;">엑셀다운로드 <i class="icon-download-alt icon-white"></i></button> -->
        </div>

        <div class="block-content collapse in">
            <div class="span12">
            	<div class="alert alert-block">
					<form method="get" class="form-horizontal" action="" id="searchForm" onsubmit="return paging.submit(); return false;">
						<fieldset>
							<div class="control-group">
								<label class="control-label" for="dateStart">날짜</label>
								<div class="controls">
									<input class="input-small month" name="yearMonth" id="yearMonth" type="text" value="${pageParam.yearMonth}">
								</div>
							</div>
	                        <div class="control-group">
	                            <label class="control-label" for="selectClient">고객사</label>
	                            <div class="controls">
	                                <select id="selectClient" name="vehicleId" title="고객사">
	                                    <option value="">고객사</option>
	                                    <c:forEach items="${clients}" var="item">
		                                    <c:set var="selected" value=""/>
											<c:if test='${item.vehicle_id==pageParam.vehicleId}'><c:set var="selected" value="selected"/></c:if>
	                                        <option value="${item.vehicle_id}" ${selected}>${item.client}</option>
	                                    </c:forEach>
	                                </select>
	                            </div>
	                        </div>
							<div class="control-group btn-group">
								<input type="hidden" name="pageCut" value="10"/>
								<input type="hidden" name="pageNum" value="${pageParam.pageNum}"/>
								<button type="submit" class="btn btn-primary">검색</button>
							</div>
						</fieldset>
					</form>
				</div>
				<div id="table-listing">
					<div class="table-scrollable">
		                <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered" data-count-fixed-columns="8" >
		                    <thead>
		                        <tr>
		                            <th>고객사</th>
		                            <th>차종</th>
		                            <th>품명</th>
		                            <th>L/R</th>
		                            <th>단가</th>
		                            <th>총금액</th>
                            		<th>구분</th>
		                            <th>총수량</th>
		                            <c:forEach begin="1" end="${lastDay}" var="itemDay">
		                            	<th>${itemDay}</th>
		                            </c:forEach>
		                        </tr>
		                    </thead>
		                    <tbody>
		                    <c:choose>
								<c:when test="${!empty list}">
									<c:forEach items="${list}" var="item" varStatus="loop">
		                            	<%
											HashMap<String, Object> itemMap = (HashMap<String, Object>) pageContext.getAttribute("item");
										%>
										<c:set var="changeCnt" value="1" />
										<c:if test="${item.stock_gubun != 's004'}"><c:set var="changeCnt" value="-1"/></c:if>
							            <tr>
							            	<td class="center"><c:if test="${!empty item.itemCnt && item.itemCnt > 0}">${item.client}</c:if></td>
							                <td class="center"><c:if test="${!empty item.itemCnt && item.itemCnt > 0}">${item.model_car}</c:if></td>
							                <td><c:if test="${!empty item.itemCnt && item.itemCnt > 0}">${item.product_name}</c:if></td>
							                <td class="center"><c:if test="${!empty item.itemCnt && item.itemCnt > 0}">${item.lh_rh}</c:if></td>
							                <td class="center"><c:if test="${!empty item.itemCnt && item.itemCnt > 0}"><fmt:formatNumber value="${item.price}" pattern="#,###" /></c:if></td>
							                <td class="center ${item.stock_gubun}"><fmt:formatNumber value="${item.price*item.total*changeCnt}" pattern="#,###" /></td>
							                <td class="center ${item.stock_gubun}">${item.stock_gubun_name}</td>
							                <td class="center"><fmt:formatNumber value="${item.total*changeCnt}" pattern="#,###" /></td>
				                            <c:forEach begin="1" end="${lastDay}" var="itemDay">
				                            	<%
													Integer key = (Integer) pageContext.getAttribute("itemDay");
				                            		String stock_gubun = (String) itemMap.get("stock_gubun");
				                            		int changeCnt = 1;
				                            		if(!"s004".equals(stock_gubun)) changeCnt = -1;
				                            		String strKey = Integer.toString(key);
				                            		if(key < 10) strKey = "0"+strKey;
				                            		Integer num = (Integer) itemMap.get(strKey+"2")*changeCnt;
				                            		String cssClass = num == 0 ? "": stock_gubun;
				                            		String value = num == 0 ? "": String.valueOf(num);
												%>
				                            	<td class="<%=cssClass%>"><%=value %></td>
				                            </c:forEach>
							            </tr>
							        </c:forEach>
								</c:when>
								<c:when test="${!empty pageParam.client}">
									<td scope="col" colspan='<c:out value="${8+lastDay}"/>' class="center bin">조회 하실 데이터를 입력하세요.</td>
								</c:when>
								<c:otherwise>
									<tr>
										<td scope="col" colspan='<c:out value="${8+lastDay}"/>' class="center bin">데이터가 없습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
		                    </tbody>
		                </table>
		            </div>
	            </div>
            </div>
        </div>
    </div>
    <!-- /block -->
</div>
<link rel="stylesheet" type="text/css" href="<c:url value='/res/css/datepicker.css'/>" media="screen"/>
<script src="<c:url value='/res/js/plugin/bootstrap-datepicker.js'/>"></script>
<script src="<c:url value='/res/js/plugin/bootstrap-datepicker.kr.js'/>"></script>
<c:if test="${!empty list}">
<script>
$(function(){
	app_handle_listing_horisontal_scroll($('#table-listing'))
});
</script>
</c:if>
<script>
$(function(){
	dateUtil.initMonth();
});
</script>