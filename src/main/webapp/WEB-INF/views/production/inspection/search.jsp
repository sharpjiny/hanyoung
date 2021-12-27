﻿<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <div class="row-fluid">
    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">组装/包装</div>
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
								<label class="control-label" for="jabClass0">班</label>
								<div class="controls">
								<label for="workType" class="radio inline"><input type="radio" name="jabClass" value="" id="jabClass" <c:if test='${pageParam.jabClass == null || pageParam.jabClass == ""}'>checked="true"</c:if>/>全部</label>
								<c:forEach items="${jabClasss}" var="item">
								<label for="workType${item.code}" class="radio inline"><input type="radio" name="jabClass" value="${item.code}" id="jabClass${item.code}" <c:if test='${item.code==pageParam.jabClass}'>checked="true"</c:if> />${item.name}</label>
								</c:forEach>
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
                            <label class="control-label" for="inputError">种类</label>
                            <div class="controls">
                                <select id="selectKind" name="kind" class="selectVehicle" title="种类">
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
	                                <select id="selectModelCar" name="modelCar" class="selectVehicle" title="車种">
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
							<div class="control-group btn-group">
								<button type="submit" class="btn btn-primary">Search</button>
							</div>
						</fieldset>
					</form>
				</div>
				<p>
					<a href="form"><button type="button" class="btn btn-success">Add New <i class="icon-plus icon-white"></i></button></a>
				</p>
                <!-- <table cellpadding="1" cellspacing="1" border="1" style="border-color:#ddd; width:100%;" class="table-hover table-striped"> -->
                <table style="width:100%;" class="table-hover" >
                    <thead>
                        <tr>
                            <th rowspan="2">NO</th>
                            <th rowspan="2">日期</th>
                            <th rowspan="2">班</th>
                            <th rowspan="2">白<br>/<br>夜<br>班</th>
                            <th rowspan="2">车种</th>
                            <th rowspan="2">品名</th>
                            <th rowspan="2">L/R</th>
                            <th rowspan="2">品号</th>
                            <th rowspan="2">生产<br>数量</th>
                            <th rowspan="2">良品<br>数量</th>
                            <th rowspan="2">不良<br>数量</th>
                            <th rowspan="2">不<br>良<br>率</th>
                            <th colspan="12">不良类型</th>
                            <th rowspan="2">确认</th>
                        </tr>
                        <tr>
                            <th>实验</th>
                            <th>发黄<br>/<br>发彩</th>
                            <th>炸丝</th>
                            <th>水丝</th>
                            <th>发白</th>
                            <th>滑牙</th>
                            <th>脏斑</th>
                            <th>划伤</th>
                            <th>白<br>/<br>黑点</th>
                            <th>断裂</th>
                            <th>多镀</th>
                            <th>送检</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:choose>
						<c:when test="${!empty list}">
							<c:set var="production" value="0"/>
							<c:set var="complete" value="0"/>
							<c:set var="faulty" value="0"/>
							<c:set var="faultyA" value="0"/>
							<c:set var="faultyB" value="0"/>
							<c:set var="faultyC" value="0"/>
							<c:set var="faultyD" value="0"/>
							<c:set var="faultyE" value="0"/>
							<c:set var="faultyF" value="0"/>
							<c:set var="faultyG" value="0"/>
							<c:set var="faultyH" value="0"/>
							<c:set var="faultyI" value="0"/>
							<c:set var="faultyJ" value="0"/>
							<c:set var="faultyK" value="0"/>
							<c:set var="faultyL" value="0"/>
							<c:set var="prevCode" value=""/>
							<c:forEach items="${list}" var="item" varStatus="loop">
					            <tr>
					                <td class="center"><span>${loop.count}</span></td>
					                <td class="center">
					                <c:choose>
                                    <c:when test="${userSession.id == 'bogoadmin'}">
                                     <a href="form?eId=${item.e_id}">${item.inspection_date}</a>
                                    </c:when>
                                    <c:otherwise>
                                    ${item.inspection_date}
                                    </c:otherwise>
                                    </c:choose>
					                </td>
					                <td class="center">${item.jab_class_name}</td>
					                <td class="center">${item.work_type_name}</td>
					                <td class="center">${item.model_car}</td>
					                <td>${item.product_name}</td>
					                <td class="center">${item.lh_rh}</td>
					                <td class="center">${item.product_id}</td>
					                <td class="center"><fmt:formatNumber value="${item.production}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.complete}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.faulty}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.faulty/item.production*100}" pattern="#.##"/>%</td>
					                <td class="center"><fmt:formatNumber value="${item.faulty_a}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.faulty_b}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.faulty_c}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.faulty_d}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.faulty_e}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.faulty_f}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.faulty_g}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.faulty_h}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.faulty_i}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.faulty_j}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.faulty_k}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.faulty_l}" pattern="#,###" /></td>
					                <td class="center">
					                <c:choose>
					                <c:when test="${item.is_check=='OK'}">${item.is_check}</c:when>
					                <c:otherwise><a href="javascript:void();" class="isCheckBtn" eId="${item.e_id}">${item.is_check}</a></c:otherwise>
					                </c:choose>
					                </td>
					            </tr>
								<c:set var="production" value="${production + item.production}"/>
								<c:set var="complete" value="${complete + item.complete}"/>
								<c:set var="faulty" value="${faulty + item.faulty}"/>
								<c:set var="faultyA" value="${faultyA + item.faulty_a}"/>
								<c:set var="faultyB" value="${faultyB + item.faulty_b}"/>
								<c:set var="faultyC" value="${faultyC + item.faulty_c}"/>
								<c:set var="faultyD" value="${faultyD + item.faulty_d}"/>
								<c:set var="faultyE" value="${faultyE + item.faulty_e}"/>
								<c:set var="faultyF" value="${faultyF + item.faulty_f}"/>
								<c:set var="faultyG" value="${faultyG + item.faulty_g}"/>
								<c:set var="faultyH" value="${faultyH + item.faulty_h}"/>
								<c:set var="faultyI" value="${faultyI + item.faulty_i}"/>
								<c:set var="faultyJ" value="${faultyJ + item.faulty_j}"/>
								<c:set var="faultyK" value="${faultyK + item.faulty_k}"/>
								<c:set var="faultyL" value="${faultyL + item.faulty_l}"/>
					        </c:forEach>
					        	<tr style="background-color: #f2dede">
					                <td class="center" colspan="8">합계</td>
					                <td class="center"><fmt:formatNumber value="${production}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${complete}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${faulty}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${faulty/production*100}" pattern="#.##"/>%</td>
					                <td class="center"><fmt:formatNumber value="${faultyA}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${faultyB}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${faultyC}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${faultyD}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${faultyE}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${faultyF}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${faultyG}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${faultyH}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${faultyI}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${faultyJ}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${faultyK}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${faultyL}" pattern="#,###" /></td>
					                <td class="center"></td>
					        	</tr>
						</c:when>
						<c:otherwise>
							<tr>
								<td scope="col" colspan="25" class="center bin">NO DATA.</td>
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
		var inspectionId = $this.attr('eId');
		if(!inspectionId) return;
		if(!confirm('확인하시겠습니까?')) return;

		$.ajax({
			url: '/inspection/inspectionCheckAjax',
			type: 'POST',
			data: {eId: inspectionId}
		}).success(function( data ) {
		    alert( data.message );
			if(data.code == '0000'){
				$this.closest('td').text('OK');
			}
		}).fail(function() {
	    	alert( '확인에 실패했습니다' );
	    });
	},

	selectKind : function(){
	    var kind = $(this).val();
	    inspectionList.selectVehicleInit();
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
        inspectionList.selectVehicleInit();
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
        var kind = $('#selectKind').val();
        var modelCar = $('#selectModelCar').val();
        var productName = $(this).val();
        inspectionList.selectVehicleInit();
        if(kind && modelCar && productName){
            $.ajax({
                url: '/vehicle/selectlhRhsAjax',
                type: 'POST',
                data: {kind: kind, modelCar : modelCar, productName : productName}
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
    },

    selectLhRh : function(){
        var lhRh = $(this).val();
        var $this = $('option[value="'+lhRh+'"]','#selectLhRh');
        var productId = $this.attr('productId');
        var client = $this.attr('client');
        var vehicleId = $this.attr('vehicleId');
        if(vehicleId){
            $('#productId').text(productId);
            $('#client').text(client);
            $('#vehicleId').val(vehicleId);
        }else{
        	inspectionList.selectVehicleInit();
        }
    },

	selectVehicleInit: function(){
        $('#productId').text('');
        $('#client').text('');
        $('#vehicleId').val('');
    }
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