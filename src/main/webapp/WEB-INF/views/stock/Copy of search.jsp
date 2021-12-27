<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
 <div class="row-fluid">
    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">입출고현황 리스트</div>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
				<div class="alert alert-block">
					<form method="get" class="form-horizontal" action="" id="searchForm" onsubmit="return paging.submit(); return false;">
						<fieldset>
							<div class="control-group">
								<label class="control-label" for="dateStart">날짜</label>
								<div class="controls">
									<input class="input-small date" name="dateStart" id="dateStart" type="text" value="${pageParam.dateStart}">
									~
									<input class="input-small date" name="dateEnd" id="dateEnd" type="text" value="${pageParam.dateEnd}">
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="workType0">주/야간</label>
								<div class="controls">
								<label for="workType" class="radio inline"><input type="radio" name="workType" value="" id="workType" <c:if test='${pageParam.workType == null || pageParam.workType == ""}'>checked="true"</c:if>/>전체</label>
								<c:forEach items="${workTypes}" var="item">
								<label for="workType${item.code}" class="radio inline"><input type="radio" name="workType" value="${item.code}" id="workType${item.code}" <c:if test='${item.code==pageParam.workType}'>checked="true"</c:if> />${item.name}</label>
								</c:forEach>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="stockGubun">구분</label>
								<div class="controls">
	                                <select id="selectStockGubun" name="stockGubun" class="" title="구분">
	                                    <option value="">구분</option>
	                                    <c:forEach items="${stockGubuns}" var="item">
		                                    <c:set var="selected" value=""/>
											<c:if test='${item.code==pageParam.stockGubun}'><c:set var="selected" value="selected"/></c:if>
	                                        <option value="${item.code}" ${selected}>${item.name}</option>
	                                    </c:forEach>
	                                </select>
	                            </div>
							</div>
	                        <div class="control-group">
	                            <label class="control-label" for="selectClient">고객사</label>
	                            <div class="controls">
	                                <select id="selectClient" name="client" title="고객사">
	                                    <option value="">고객사</option>
	                                    <c:forEach items="${clients}" var="item">
		                                    <c:set var="selected" value=""/>
											<c:if test='${item.client==pageParam.client}'><c:set var="selected" value="selected"/></c:if>
	                                        <option value="${item.client}" ${selected}>${item.client}</option>
	                                    </c:forEach>
	                                </select>
	                            </div>
	                        </div>
							<div class="control-group">
                            <label class="control-label" for="inputError">종류</label>
                            <div class="controls">
                                <select id="selectKind" name="kind" title="종류">
                                    <option value="">종류</option>
                                    <c:forEach items="${kinds}" var="item">
	                                    <c:set var="selected" value=""/>
										<c:if test='${item.kind==pageParam.kind}'><c:set var="selected" value="selected"/></c:if>
                                        <option value="${item.kind}" ${selected}>${item.kind}</option>
                                    </c:forEach>
                                </select>
                            </div>
	                        </div>
	                        <div class="control-group">
	                            <label class="control-label" for="inputError">차종</label>
	                            <div class="controls">
	                                <select id="selectModelCar" name="modelCar" title="차종">
	                                    <option value="">차종</option>
	                                    <c:forEach items="${modelCars}" var="item">
		                                    <c:set var="selected" value=""/>
											<c:if test='${item.model_car==pageParam.modelCar}'><c:set var="selected" value="selected"/></c:if>
	                                        <option value="${item.model_car}" ${selected}>${item.model_car}</option>
	                                    </c:forEach>
	                                </select>
	                            </div>
	                        </div>
	                        <div class="control-group">
	                            <label class="control-label" for="inputError">품명</label>
	                            <div class="controls">
	                                <select id="selectProductName" name="productName" class="selectVehicle" title="품명">
	                                    <option value="">품명</option>
	                                    <c:forEach items="${productNames}" var="item">
		                                    <c:set var="selected" value=""/>
											<c:if test='${item.product_name==pageParam.productName}'><c:set var="selected" value="selected"/></c:if>
	                                        <option value="${item.product_name}" ${selected}>${item.product_name}</option>
	                                    </c:forEach>
	                                </select>
	                            </div>
	                        </div>
	                        <div class="control-group">
	                            <label class="control-label" for="inputError">L/R</label>
	                            <div class="controls">
	                                <select id="selectLhRh" name="lhRh" class="selectVehicle" title="L/R">
	                                    <option value="">L/R</option>
	                                    <c:forEach items="${lhRhs}" var="item">
		                                    <c:set var="selected" value=""/>
											<c:if test='${item.lh_rh==pageParam.lhRh}'><c:set var="selected" value="selected"/></c:if>
	                                        <option value="${item.lh_rh}" client="${item.client}" vehicleId="${item.vehicle_id}" productId="${item.product_id}" ${selected}>${item.lh_rh}</option>
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
				<p>
					<a href="form"><button type="button" class="btn btn-success">Add New <i class="icon-plus icon-white"></i></button></a>
					<button type="button" class="btn btn-excel btn-warning" onclick="paging.excel()">엑셀다운로드 <i class="icon-download-alt icon-white"></i></button>
				</p>
                <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th>NO</th>
                            <th>날짜</th>
                            <th>주/야간</th>
                            <th>종류</th>
                            <th>구분</th>
                            <th>차종</th>
                            <th>품명</th>
                            <th>L/R</th>
                            <th>품호</th>
                            <th>입고수량</th>
                            <th>확인</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:choose>
						<c:when test="${!empty list}">
						<c:set var="loopIndex" value="${pageParam.startNum}"/>
							<c:set var="totalQuantity" value="0"/>
							<c:forEach items="${list}" var="item" varStatus="loop">
					            <tr>
					                <td class="center"><span>${loopIndex+loop.count}</span></td>
					                <td><a href="form?stockId=${item.stock_id}">${item.stock_date}</a></td>
					                <td class="center">${item.work_type_name}</td>
					                <td class="center">${item.kind}</td>
					                <td class="center">${item.stock_gubun_name}</td>
					                <td>${item.model_car}</td>
					                <td>${item.product_name}</td>
					                <td class="center">${item.lh_rh}</td>
					                <td>${item.vehicle_id}</td>
					                <td class="center"><fmt:formatNumber value="${item.quantity2}" pattern="#,###" /></td>
					                <td class="center">
					                <c:choose>
					                <c:when test="${item.is_check=='OK'}">${item.is_check}</c:when>
					                <c:otherwise><a href="javascript:void(0);" class="isCheckBtn" stockId="${item.stock_id}">${item.is_check}</a></c:otherwise>
					                </c:choose>
					                </td>
					            </tr>
					            <c:if test="${item.stock_gubun!='s005'}">
					            <c:set var="totalQuantity" value="${totalQuantity + item.quantity2}"/>				                
								</c:if>
					        </c:forEach>
					        <tr class="error">
				                <td class="center" colspan="9">합계</td>
					        	<td class="center"><fmt:formatNumber value="${totalQuantity}" pattern="#,###" /></td>
					        	<td></td>
					        </tr>
						</c:when>
						<c:otherwise>
							<tr>
								<td scope="col" colspan="11" class="center bin">데이터가 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!-- /block -->
</div>
<link rel="stylesheet" type="text/css" href="<c:url value='/res/css/datepicker.css'/>" media="screen"/>
<script src="<c:url value='/res/js/plugin/bootstrap-datepicker.js'/>"></script>
<script src="<c:url value='/res/js/plugin/bootstrap-datepicker.kr.js'/>"></script>
<script>
var inspectionList ={
	inspectionCheck: function(){
		var $this = $(this);
		var stockId = $this.attr('stockId');
		if(!stockId) return;
		if('bogo01' == '${userSession.id}'){
			alert('没有权限!!!');
			return;
		}else if(!confirm('확인하시겠습니까?')) return;

		$.ajax({
			url: '/stock/stockCheckAjax',
			type: 'POST',
			data: {stockId: stockId}
		}).success(function( data ) {
		    alert( data.message );
			if(data.code == '0000'){
				$this.closest('td').text('OK');
			}
		}).fail(function() {
	    	alert( '삭제에 실패했습니다' );
	    });
	},

   selectProductName : function(){
        var productName = $(this).val();
        if(productName){
            $.ajax({
                url: '/vehicle/selectlhRhsAjax',
                type: 'POST',
                data: {productName : productName}
            }).success(function( data ) {
                if(data.list){
                    var $selectLhRh = $('#selectLhRh').find('option:not(:eq(0))').remove().end();
                    $.each(data.list, function(i, item){
                        $selectLhRh.append($('<option client="'+item.client+'" vehicleId="'+item.vehicle_id+'" productId="'+item.product_id+'"/>').val(item.lh_rh).text(item.lh_rh));
                    });
                    $selectLhRh.prop('disabled', false);
                }
            }).fail(function() {
                alert( '데이터 조회에 실패했습니다' );
                $('#selectLhRh').prop('disabled', true).find('option:not(:eq(0))').remove();
            });
        }else{
            $('#selectLhRh').prop('disabled', true).find('option:not(:eq(0))').remove();
        }
    }
}

$(function(){
	dateUtil.init();
	$('.isCheckBtn').click(inspectionList.inspectionCheck);
    $('#selectProductName').change(inspectionList.selectProductName);
});
</script>