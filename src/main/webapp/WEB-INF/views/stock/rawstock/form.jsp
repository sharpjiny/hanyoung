<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

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
						<legend>재고입력</legend>
						<div class="control-group">
							<form:label path="stock.stockDate" cssClass="control-label">날짜</form:label>
							<div class="controls">
								<form:input path="stock.stockDate" class="input-xlarge date" title="날짜"/>
							</div>
						</div>
						<div class="control-group">
							<form:label path="stock.workType" cssClass="control-label">주/야간</form:label>
							<div class="controls inline">
								<form:radiobuttons path="stock.workType" items="${workTypes}" itemValue="code" itemLabel="name" title="주/야간"/>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">구분</label>
							<div class="controls">
								<form:select path="stock.stockGubun" id="stockGubun" title="구분">
									<form:option value="">구분</form:option>
									<form:options items="${stockGubuns}" itemValue="code" itemLabel="name" />
								</form:select>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">종류</label>
							<div class="controls">
								<select id="selectKind" class="selectVehicle" title="종류">
									<option value="">종류</option>
									<c:forEach items="${kinds}" var="item">
	                                    <c:set var="selected" value=""/>
										<c:if test='${item.kind==stockModel.stock.kind}'><c:set var="selected" value="selected"/></c:if>
										<option value="${item.kind}" ${selected}>${item.kind}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">차종</label>
							<div class="controls">
								<select id="selectModelCar" class="selectVehicle" title="차종">
									<option value="">차종</option>
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
							<label class="control-label" for="inputError">품명</label>
							<div class="controls">
								<select id="selectProductName" class="selectVehicle" title="품명">
									<option value="">품명</option>
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
						<div class="control-group">
							<label class="control-label" for="inputError">고유번호</label>
							<div class="controls"><span id="productId">${stockModel.stock.productId}</span></div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">고객사</label>
							<div class="controls"><span id="client">${stockModel.stock.client}</span></div>
						</div>
						<div class="control-group">
							<form:label path="stock.quantity" cssClass="control-label">수량</form:label>
							<div class="controls">
								<form:input path="stock.quantity" id="quantity" class="input-xlarge" title="수량" validate="number" />
							</div>
						</div>
						<div class="form-actions">
							<form:hidden path="stock.stockId" class="key" id="stockId"/>
							<form:hidden path="stock.vehicleId" class="key" id="vehicleId"/>
			                <a href="search"><button type="button" class="btn">목록</button></a>
							<c:if test="${stockModel.stock.stockId != null && stockModel.stock.stockId != '' }">
							<button type="button" class="btn btn-danger" id="inspectionDelete">삭제</button>
							</c:if>
							<button type="submit" class="btn btn-primary">저장</button>
						</div>
					</fieldset>
				</form:form>
			</div>
		</div>
	</div>
	<!-- /block -->
</div>
<link rel="stylesheet" type="text/css" href="<c:url value='/res/css/datepicker.css'/>" media="screen"/>
<script src="<c:url value='/res/js/plugin/bootstrap-datepicker.js'/>"></script>
<script src="<c:url value='/res/js/plugin/bootstrap-datepicker.kr.js'/>"></script>
<script>
var stockForm ={
	formChk : function(){
		// 유효성 체크
		if(!$('#stockModel').validation()){
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
			stockForm.selectVehicleInit();
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
	$('#inspectionDelete').click(stockForm.inspectionDelete);
	$('#selectKind').change(stockForm.selectKind);
	$('#selectModelCar').change(stockForm.selectModelCar);
	$('#selectProductName').change(stockForm.selectProductName);
	$('#selectLhRh').change(stockForm.selectLhRh);
	if(!$('#stockId').val()){
		$('.selectVehicle:not(#selectKind)').prop('disabled', true);
	}
	$('option[value="s006"]','#stockGubun').remove();

	$('#quantity').change(function(){
		var quantity = $(this).val();
		if(!quantity) $(this).val(0);
		if (!isNumeric(quantity,4)) {
			alert('숫자만 입력해주세요.');
			$(this).val(0).focus();
		}
		var stockGubun = $('#stockGubun').val();
		if(!stockGubun) return;
		if(stockGubun!='s001'){
			if(quantity > 0) $(this).val(quantity*-1);
		}
	});
	$('#stockGubun').change(function(){
		var stockGubun = $(this).val();
		var quantity = $('#quantity').val();
		if(quantity && stockGubun){
			if(quantity > 0) $('#quantity').val(quantity*-1);
		}
	});
});
</script>