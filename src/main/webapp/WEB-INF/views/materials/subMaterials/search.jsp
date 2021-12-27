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
								<label class="control-label" for="dateStart">日期</label>
								<div class="controls">
									<input class="input-small date" name="dateStart" id="dateStart" type="text" value="${pageParam.dateStart}">
									~
									<input class="input-small date" name="dateEnd" id="dateEnd" type="text" value="${pageParam.dateEnd}">
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="workType0">白/夜班</label>
								<div class="controls">
								<label for="workType" class="radio inline"><input type="radio" name="workType" value="" id="workType" <c:if test='${pageParam.workType == null || pageParam.workType == ""}'>checked="true"</c:if>/>全部</label>
								<c:forEach items="${workTypes}" var="item">
								<label for="workType${item.code}" class="radio inline"><input type="radio" name="workType" value="${item.code}" id="workType${item.code}" <c:if test='${item.code==pageParam.workType}'>checked="true"</c:if> />${item.name}</label>
								</c:forEach>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="stockGubun">区分</label>
								<div class="controls">
	                                <select id="selectStockGubun" name="stockGubun" class="" title="区分">
	                                    <option value="">区分</option>
	                                    <c:forEach items="${stockGubuns}" var="item">
		                                    <c:set var="selected" value=""/>
											<c:if test='${item.code==pageParam.stockGubun}'><c:set var="selected" value="selected"/></c:if>
	                                        <option value="${item.code}" ${selected}>${item.name}</option>
	                                    </c:forEach>
	                                </select>
	                            </div>
							</div>
	                        <div class="control-group">
	                            <label class="control-label" for="selectClient">入库社</label>
	                            <div class="controls">
	                                <select id="selectClient" name="client" title="入库社">
	                                    <option value="">入库社</option>
	                                    <c:forEach items="${clients}" var="item">
		                                    <c:set var="selected" value=""/>
											<c:if test='${item.client==pageParam.client}'><c:set var="selected" value="selected"/></c:if>
	                                        <option value="${item.client}" ${selected}>${item.client}</option>
	                                    </c:forEach>
	                                </select>
	                            </div>
	                        </div>
							<div class="control-group">
                            <label class="control-label" for="inputError">种类</label>
                            <div class="controls">
                                <select id="selectKind" name="kind" title="种类">
                                    <option value="">种类</option>
                                    <c:forEach items="${kinds}" var="item">
	                                    <c:set var="selected" value=""/>
										<c:if test='${item.kind==pageParam.kind}'><c:set var="selected" value="selected"/></c:if>
                                        <option value="${item.kind}" ${selected}>${item.kind}</option>
                                    </c:forEach>
                                </select>
                            </div>
	                        </div>
	                        <div class="control-group">
	                            <label class="control-label" for="inputError">車种</label>
	                            <div class="controls">
	                                <select id="selectModelCar" name="modelCar" title="車种">
	                                    <option value="">車种</option>
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
	                        <div class="control-group">
	                            <label class="control-label" for="inputError">确认</label>
	                            <div class="controls">
	                                <select id="selectIsCheck" name="isCheck" class="selectVehicle" title="确认">
	                                    <option value="">确认</option>
	                                    <c:forEach items="${isCheck}" var="item">
		                                    <c:set var="selected" value=""/>
											<c:if test='${item.code==pageParam.isCheck}'><c:set var="selected" value="selected"/></c:if>
	                                        <option value="${item.code}" ${selected}>${item.name}</option>
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
					<button type="button" class="btn btn-excel btn-warning" onclick="paging.excel()">EXCEL DOWN <i class="icon-download-alt icon-white"></i></button>
				</p>
                <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th>NO</th>
                            <th>日期</th>
                            <th>白/夜班</th>
                            <th>种类</th>
                            <th>区分</th>
                            <th>入库社</th>
                            <th>車种</th>
                            <th>品名</th>
                            <th>L/R</th>
                            <th>品號1</th>
                            <th>品號2</th>
                            <th>数量</th>
                            <th>确认</th>
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
					                <td class="center"><a href="form?stockId=${item.stock_id}">${item.stock_date}</a></td>
					                <td class="center">${item.work_type_name}</td>
					                <td class="center">${item.kind}</td>
					                <td class="center">${item.stock_gubun_name}</td>
					                <td class="center">${item.client}</td>
					                <td class="center">${item.model_car}</td>
					                <td class="center">${item.product_name}</td>
					                <td class="center">${item.lh_rh}</td>
					                <td class="center">${item.vehicle_id}</td>
					                <td class="center">${item.product_id}</td>
					                <td class="center"><fmt:formatNumber value="${item.quantity2}" pattern="#,###" /></td>
					                <td class="center">
					                <c:choose>
					                <c:when test="${item.is_check=='OK'}">${item.is_check}</c:when>
					                <c:otherwise><a href="javascript:void(0);" class="isCheckBtn" stockId="${item.stock_id}">${item.is_check}</a></c:otherwise>
					                </c:choose>
					                </td>
					            </tr>
					            <c:set var="totalQuantity" value="${totalQuantity + item.quantity2}"/>
					            <%-- 
					            <c:if test="${item.stock_gubun!='s003' && item.stock_gubun!='s005' && item.stock_gubun!='s004' && item.stock_gubun!='s007' && item.stock_gubun!='s010' && item.stock_gubun!='s011'}">
								</c:if>
								 --%>
					        </c:forEach>
					        <tr class="error">
				                <td class="center" colspan="11">合計</td>
					        	<td class="center"><fmt:formatNumber value="${totalQuantity}" pattern="#,###" /></td>
					        	<td></td>
					        </tr>
						</c:when>
						<c:otherwise>
							<tr>
								<td scope="col" colspan="13" class="center bin">데이터가 없습니다.</td>
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
		var chkId = 'bogo01';
		var stockId = $this.attr('stockId');
		if(!stockId) return;
		if(chkId == '${userSession.id}'){
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

    selectKind : function(){
		var kind = $(this).val();
		//inspectionList.selectVehicleInit();
		if(kind){
			$.ajax({
				url: '/vehicle/selectModelCarsAjax',
				type: 'POST',
				data: {kind: kind}
			}).success(function( data ) {
				if(data.list){
					var $selectModelCar = $('#selectModelCar').find('option:not(:eq(0))').remove().end();
					$.each(data.list, function(i, item){
						$selectModelCar.append($('<option/>').val(item.model_car).text(item.model_car));
					});
					$selectModelCar.prop('disabled', false);
					$('.selectVehicle:not(#selectKind):not(#selectModelCar)').prop('disabled', true).find('option[value=""]').prop('selected', true);
				}
			}).fail(function() {
		    	alert( '데이터 조회에 실패했습니다' );
				$('.selectVehicle:not(#selectKind)').prop('disabled', true).find('option:not(:eq(0))').remove();
		    });
		}else{
			$('.selectVehicle:not(#selectKind)').prop('disabled', true).find('option:not(:eq(0))').remove();
		}
	},
	
	selectModelCar : function(){
		var kind = $('#selectKind').val();
		var modelCar = $(this).val();
		//inspectionList.selectVehicleInit();
		if(kind && modelCar){
			$.ajax({
				url: '/vehicle/selectProductNamesAjax',
				type: 'POST',
				data: {kind: kind, modelCar : modelCar}
			}).success(function( data ) {
				if(data.list){
					var $selectProductName = $('#selectProductName').find('option:not(:eq(0))').remove().end();
					$.each(data.list, function(i, item){
						$selectProductName.append($('<option/>').val(item.product_name).text(item.product_name));
					});
					$selectProductName.prop('disabled', false);
					$('#selectLhRh').prop('disabled', true).find('option:not(:eq(0))').remove();
				}
			}).fail(function() {
		    	alert( '데이터 조회에 실패했습니다' );
				$('#selectProductName, #selectLhRh').prop('disabled', true).find('option:not(:eq(0))').remove();
		    });
		}else{
			$('#selectProductName, #selectLhRh').prop('disabled', true).find('option:not(:eq(0))').remove();
		}
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
                        $selectLhRh.append($('<option client="'+item.client+'" vehicleId="'+item.vehicle_id+'"/>').val(item.lh_rh).text(item.lh_rh));
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
    },

	selectLhRh : function(){
		var lhRh = $(this).val();
		var $this = $('option[value="'+lhRh+'"]','#selectLhRh');
		var productId = $this.attr('productId');
		var client = $this.attr('client');
		var vehicleId = $this.attr('vehicleId');
		if(vehicleId){
			$('#vehicleIdTxt').text(vehicleId);
			$('#client').text(client);
			$('#vehicleId').val(vehicleId);
		}else{
			inspectionList.selectVehicleInit();
		}
	},
	
	/*selectVehicleInit: function(){
		 $('#productId').text('');
		$('#client').text('');
		$('#vehicleId').val('');
	} */
}

$(function(){
	dateUtil.init();
	$('.isCheckBtn').click(inspectionList.inspectionCheck);
	$('#selectKind').change(inspectionList.selectKind);
	$('#selectModelCar').change(inspectionList.selectModelCar);
	$('#selectProductName').change(inspectionList.selectProductName);
	$('#selectLhRh').change(inspectionList.selectLhRh);    
});
</script>