<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="row-fluid">
	<!-- block -->
	<div class="block">
		<div class="navbar navbar-inner block-header">
			<div class="muted pull-left">재고입력</div>
		</div>
		<div class="block-content collapse in editForm">
			<div class="span12">
				<form:form modelAttribute="stockModel" cssClass="form-horizontal" method="post" action="" onsubmit="return stockForm.formChk(); return false;">
					<fieldset>						
						<c:if test="${stockModel.stock.stockId != null && stockModel.stock.stockId != '' }">
						<div class="control-group">
							<label class="control-label" for="inputError">최초 등록일</label>
							<div class="controls"><fmt:formatDate value="${stockModel.stock.created}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">수정일</label>
							<div class="controls"><fmt:formatDate value="${stockModel.stock.lastModified}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
						</div>
						</c:if>
						<div class="control-group">
							<form:label path="stock.stockDate" cssClass="control-label">日期</form:label>
							<div class="controls">
								<form:input path="stock.stockDate" id="stockDate" class="input-xlarge date" title="日期"/>
							</div>
						</div>
                        <%-- <div class="control-group">
							<label class="control-label" for="inputError">결산월</label>
							<div class="controls">
								<form:select path="stock.settlementMonth" id="settlementMonth" title="결산월">
									<form:option value="">결산월</form:option>
									<form:options items="${settlementMonth}" itemValue="code" itemLabel="name" />
								</form:select>
							</div>
						</div> --%>
						<div class="control-group">
                            <form:label path="stock.stockTime" cssClass="control-label">出入库时间</form:label>
                            <div class="controls">
                                <form:input path="stock.stockTime" id="stockTime" class="input-large skip" title="出入库时间"/>
                            </div>
                        </div>
						<div class="control-group">
							<form:label path="stock.workType" cssClass="control-label">白/夜班</form:label>
							<div class="controls inline">
								<form:radiobuttons path="stock.workType" items="${workTypes}" itemValue="code" itemLabel="name" title="白/夜班"/>
							</div>
						</div>
						<div class="control-group">
                            <form:label path="stock.carNum" cssClass="control-label">目的地</form:label>
                            <div class="controls">
                                <form:input path="stock.carNum" class="input-large skip" title="目的地"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <form:label path="stock.stockCnt" cssClass="control-label">回數</form:label>
                            <div class="controls">
                                <form:input path="stock.stockCnt" class="input-large skip" title="回數"/>
                            </div>
                        </div>
						<div class="control-group">
							<label class="control-label" for="inputError">区分</label>
							<div class="controls">
								<form:select path="stock.stockGubun" id="stockGubun" title="区分">
									<form:option value="">区分</form:option>
									<form:options items="${stockGubuns}" itemValue="code" itemLabel="name" />
								</form:select>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">种类</label>
							<div class="controls">
								<select id="selectKind" class="selectVehicle" title="种类">
									<option value="">种类</option>
									<c:forEach items="${kinds}" var="item">
	                                    <c:set var="selected" value=""/>
										<c:if test='${item.kind==stockModel.stock.kind}'><c:set var="selected" value="selected"/></c:if>
										<option value="${item.kind}" ${selected}>${item.kind}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">車种</label>
							<div class="controls">
								<select id="selectModelCar" class="selectVehicle" title="車种">
									<option value="">車种</option>
									<c:if test="${stockModel.stock.vehicleId != ''}">
									<c:forEach items="${modelCars}" var="item">
	                                    <c:set var="selected" value=""/>
										<c:if test='${item.model_car==stockModel.stock.modelCar}'><c:set var="selected" value="selected"/></c:if>
										<option value="${item.model_car}" ${selected}>${item.model_car}</option>
									</c:forEach>
									</c:if>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">品名</label>
							<div class="controls">
								<select id="selectProductName" class="selectVehicle" title="品名">
									<option value="">品名</option>
									<c:if test="${stockModel.stock.vehicleId != ''}">
									<c:forEach items="${productNames}" var="item">
	                                    <c:set var="selected" value=""/>
										<c:if test='${item.product_name==stockModel.stock.productName}'><c:set var="selected" value="selected"/></c:if>
										<option value="${item.product_name}" ${selected}>${item.product_name}</option>
									</c:forEach>
									</c:if>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">L/R</label>
							<div class="controls">
								<select id="selectLhRh" class="selectVehicle" title="L/R">
									<option value="">L/R</option>
									<c:if test="${stockModel.stock.vehicleId != ''}">
									<c:forEach items="${lhRhs}" var="item">
	                                    <c:set var="selected" value=""/>
										<c:if test='${item.lh_rh==stockModel.stock.lhRh}'><c:set var="selected" value="selected"/></c:if>
										<option value="${item.lh_rh}" client="${item.client}" vehicleId="${item.vehicle_id}" productId="${item.product_id}" ${selected}>${item.lh_rh}</option>
									</c:forEach>
									</c:if>
								</select>
							</div>
						</div>
						<%--
						<div class="control-group">
							<label class="control-label" for="inputError">品號1</label>
							<div class="controls"><span id="vehicleIdTxt">${stockModel.stock.vehicleId}</span></div>
						</div>
						--%>
						<div class="control-group">
							<label class="control-label" for="inputError">品號</label>
							<div class="controls"><span id="vehicleIdTxt">${stockModel.stock.productId}</span></div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">入库社</label>
							<div class="controls"><span id="client">${stockModel.stock.client}</span></div>
						</div>
						<div class="control-group">
                            <label class="control-label"  for="inputError">纳品形式</label>
                            <div class="controls">
                                <form:select path="stock.form" id="stockForm" title="纳品形式">
                                    <form:option value="n/a">N/A</form:option>
                                    <form:option value="box">箱子</form:option>
                                    <form:option value="car">台车</form:option>
                                    <form:option value="etc">其他</form:option>
                                </form:select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="inputError">每箱/每台数量</label>
                            <div class="controls">
                                <form:input path="stock.perBoxNum" class="input-xlarge focused skip" id="perBoxNum"
                                   type="number" title="每箱/每台数量" placeholder="每箱/每台数量" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="inputError">箱子/台车数量</label>
                            <div class="controls">
                                <form:input path="stock.boxNum" class="input-xlarge focused skip" id="boxNum"
                                  type="number" title="箱子/台车数量" placeholder="箱子/台车数量"/>
                            </div>
                        </div>
						<div class="control-group">
							<form:label path="stock.quantity" cssClass="control-label">数量</form:label>
							<div class="controls">
								<form:hidden path="stock.quantity" id="quantity" class="input-xlarge" title="数量" validate="number" />
								<form:input path="stock.quantity2" id="quantity2" class="input-xlarge" title="数量" validate="number" />
							</div>
						</div>
						<div class="control-group">
                            <form:label path="stock.inOutMan" cssClass="control-label">担当者</form:label>
                            <div class="controls">
                                <form:input path="stock.inOutMan" id="inOutMan" class="input-xlarge" title="担当者"/>
                            </div>
                        </div>
						<div class="form-actions">
							<form:hidden path="stock.stockId" class="key" id="stockId"/>
							<form:hidden path="stock.vehicleId" class="key" id="vehicleId"/>
			                <a href="javascript: history.back();"><button type="button" class="btn">목록</button></a>
							<c:if test="${stockModel.stock.stockId != null && stockModel.stock.stockId != '' && userSession.id != 'bogo01'}">
							<button type="button" class="btn btn-danger" id="inspectionDelete">삭제</button>
							</c:if>
							<c:choose>
							<c:when test="${stockModel.stock.stockId == null || stockModel.stock.stockId == ''}">
                                <button type="submit" id="save" class="btn btn-primary">저장</button>
                            </c:when>
							<c:when test="${stockModel.stock.stockId != null && stockModel.stock.stockId != '' && userSession.id != 'bogo01'}">
                                <button type="submit" id="save" class="btn btn-primary">저장</button>
                            </c:when>
							</c:choose>
							
						</div>
					</fieldset>
				</form:form>
			</div>
		</div>
	</div>
	<!-- /block -->
</div>
<link rel="stylesheet" type="text/css" href="<c:url value='/res/css/datepicker.css'/>" media="screen"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/res/css/jquery.datetimepicker.css'/>" media="screen"/>
<script src="<c:url value='/res/js/plugin/bootstrap-datepicker.js'/>"></script>
<script src="<c:url value='/res/js/plugin/bootstrap-datepicker.kr.js'/>"></script>
<script src="<c:url value='/res/js/plugin/jquery.datetimepicker.full.min.js'/>"></script>
<script>
var stockForm ={
	formChk : function(){
		// 유효성 체크
		if(!$('#stockModel').validation()){
			return false;
		}
		
		if($('#stockGubun').val() == 's001' && '${userSession.id}' == 'bogo01'){
			alert('没有权限!!!'); 
			return false;
		}
		
		return true;
	},

	inspectionDelete: function(){
		var stockId = $('#stockId').val();
		if(!stockId) return;
		if(!confirm('삭제하시겠습니까?')) return;

		$.ajax({
			url: '/stock/stockDelAjax',
			type: 'POST',
			data: {stockId: stockId}
		}).success(function( data ) {
		    alert( data.message );
			if(data.code == '0000'){
				location.href = "search";
			}
		}).fail(function() {
	    	alert( '삭제에 실패했습니다' );
	    });
	},

	selectKind : function(){
		var kind = $(this).val();
		stockForm.selectVehicleInit();
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
		stockForm.selectVehicleInit();
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
		stockForm.selectVehicleInit();
		if(kind && modelCar && productName){
			$.ajax({
				url: '/vehicle/selectlhRhsAjax',
				type: 'POST',
				data: {kind: kind, modelCar : modelCar, productName : productName}
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
			stockForm.selectVehicleInit();
		}
	},

	selectVehicleInit: function(){
		$('#productId').text('');
		$('#client').text('');
		$('#vehicleId').val('');
	},

	numberCheck: function(stockGubun){
		if(stockGubun=='s005' || stockGubun=='s004' || stockGubun=='s007' || stockGubun=='s010' || stockGubun=='s011' || stockGubun=='s012')
			return true;
		return false;
	}
}

$(function(){
	$(document).on(
            'keyup',
            '#perBoxNum',
            function(e) {

                if ($("#boxNum").val() && $("#perBoxNum").val()) {
                    var product = parseInt($("#perBoxNum").val())
                            * parseInt($("#boxNum").val())
                    $("#quantity").val(product);
                    $("#quantity2").val(product);
                    $('#quantity2').change();
                }
                
            });
    $(document).on(
            'keyup',
            '#boxNum',
            function(e) {
                if ($("#boxNum").val() && $("#perBoxNum").val()) {
                    var product = parseInt($("#perBoxNum").val())
                            * parseInt($("#boxNum").val())
                    $("#quantity").val(product);
                    $("#quantity2").val(product);
                    $('#quantity2').change();
                }
            });
});
$(function(){
	
	dateUtil.init();
	
	$.datetimepicker.setLocale('ko');

    $('#stockTime').datetimepicker({
        format: 'Y-m-d H:i',
        mask:'9999-19-39 29:59'
        , step:10
    });
	
    $('#save').click(stockForm.formChk);
	$('#inspectionDelete').click(stockForm.inspectionDelete);
	$('#selectKind').change(stockForm.selectKind);
	$('#selectModelCar').change(stockForm.selectModelCar);
	$('#selectProductName').change(stockForm.selectProductName);
	$('#selectLhRh').change(stockForm.selectLhRh);
	if(!$('#stockId').val()){
		$('.selectVehicle:not(#selectKind)').prop('disabled', true);
	}

	$('#quantity2').change(function(){
		var stockGubun = $('#stockGubun').val();
		var quantity = $.trim($(this).val());
		if(!quantity) $(this).val(0);
		if (!isNumeric(quantity, 4)) {
			alert('숫자만 입력해주세요.');
			$(this).val(0).focus();
			return;
		}
		$(this).val(quantity);

		if(!stockGubun) return;
		if(stockGubun!='s001' || stockGubun!='s003' || stockGubun!='s009'){
			if(stockForm.numberCheck(stockGubun)){
				if(quantity > 0) quantity = quantity*-1;
			}else{
				if(quantity < 0) quantity = quantity*1;
			}
		}
		$('#quantity').val(quantity);
	});
	$('#stockGubun').change(function(){
		
		var stockGubun = $(this).val();
		var quantity = $.trim($('#quantity2').val());
		$('#quantity2').val(quantity);
		if((stockGubun!='s001' || stockGubun!='s003'|| stockGubun!='s009') && quantity && stockGubun){
			if(stockForm.numberCheck(stockGubun)){
				quantity = quantity*-1;
			}else{
				quantity = quantity*1;
			}
		}
		$('#quantity').val(quantity);
		
	});

	if(!$('#vehicleId').val() && $('#selectKind').val()){
		$('#selectKind').trigger('change');
	}
	$('#stockDate').change(function(){
		var day = $(this).val().substr(5,2);
		$('#settlementMonth').val(day);
		/* $.each($('#settlementMonth > option'), function(i, v){
			if(day == v.value){
				$(this).attr("selected", "selected");
			}
		}); */
	});
});
</script>