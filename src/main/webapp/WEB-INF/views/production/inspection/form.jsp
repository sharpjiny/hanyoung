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
			<div class="muted pull-left">검사포장입력</div>
		</div>
		<div class="block-content collapse in editForm">
			<div class="span12">
				<form:form modelAttribute="inspectionModel" cssClass="form-horizontal" method="post" action="" onsubmit="return inspectionForm.formChk(); return false;">
					<fieldset>
						<!-- <legend>검사포장입력</legend> -->
						<c:if test="${inspectionModel.inspection.eId != null && inspectionModel.inspection.eId != '' }">
						<div class="control-group">
							<label class="control-label" for="inputError">최초 등록일</label>
							<div class="controls"><fmt:formatDate value="${inspectionModel.inspection.created}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">수정일</label>
							<div class="controls"><fmt:formatDate value="${inspectionModel.inspection.lastModified}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
						</div>
						</c:if>
						<div class="control-group">
							<form:label path="inspection.inspectionDate" cssClass="control-label">日期</form:label>
							<div class="controls">
								<form:input path="inspection.inspectionDate" class="input-xlarge date" title="날짜"/>
							</div>
						</div>
						<div class="control-group">
							<form:label path="inspection.jabClass" cssClass="control-label">班</form:label>
							<div class="controls inline">
								<form:select path="inspection.jabClass" title="班">
									<form:option value="">班</form:option>
									<form:options items="${jabClasss}" itemValue="code" itemLabel="name" />
								</form:select>
							</div>
						</div>
						<%-- <div class="control-group">
							<form:label path="inspection.jabClass" cssClass="control-label">班</form:label>
							<div class="controls inline">
								<form:radiobuttons path="inspection.jabClass" items="${jabClasss}" itemValue="code" itemLabel="name"/>
							</div>
						</div> --%>
						<div class="control-group">
							<form:label path="inspection.workType" cssClass="control-label">白/夜班</form:label>
							<div class="controls inline">
								<form:radiobuttons path="inspection.workType" items="${workTypes}" itemValue="code" itemLabel="name"/>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">작업자</label>&nbsp;&nbsp;&nbsp;&nbsp;
								<form:input path="inspection.workMan1" class="input-mini workMan1 skip" title="작업자1" />
								<form:input path="inspection.workMan2" class="input-mini workMan2 skip" title="작업자2" />
								<form:input path="inspection.workMan3" class="input-mini workMan3 skip" title="작업자3" />
								<form:input path="inspection.workMan4" class="input-mini workMan4 skip" title="작업자4" />
								<form:input path="inspection.workMan5" class="input-mini workMan5 skip" title="작업자5" />
						</div>
						<%-- <div class="control-group">
							<label class="control-label" for="inputError">种类</label>
							<div class="controls">
								<select id="selectKind" class="selectVehicle" title="种类">
									<option value="">种类</option>
									<c:forEach items="${kinds}" var="item">
	                                    <c:set var="selected" value=""/>
										<c:if test='${item.kind==inspectionModel.inspection.kind}'><c:set var="selected" value="selected"/></c:if>
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
									<c:if test="${inspectionModel.inspection.vehicleId != ''}">
									<c:forEach items="${modelCars}" var="item">
	                                    <c:set var="selected" value=""/>
										<c:if test='${item.model_car==inspectionModel.inspection.modelCar}'><c:set var="selected" value="selected"/></c:if>
										<option value="${item.model_car}"  ${selected}>${item.model_car}</option>
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
									<c:if test="${inspectionModel.inspection.vehicleId != ''}">
									<c:forEach items="${productNames}" var="item">
	                                    <c:set var="selected" value=""/>
										<c:if test='${item.product_name==inspectionModel.inspection.productName}'><c:set var="selected" value="selected"/></c:if>
										<option value="${item.product_name}"  ${selected}>${item.product_name}</option>
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
									<c:if test="${inspectionModel.inspection.vehicleId != ''}">
									<c:forEach items="${lhRhs}" var="item">
	                                    <c:set var="selected" value=""/>
										<c:if test='${item.lh_rh==inspectionModel.inspection.lhRh}'><c:set var="selected" value="selected"/></c:if>
										<option value="${item.lh_rh}" client="${item.client}" vehicleId="${item.vehicle_id}" productId="${item.product_id}" ${selected}>${item.lh_rh}</option>
									</c:forEach>
									</c:if>
								</select>
							</div>
						</div> --%>
						<%-- <div class="control-group">
								<label class="control-label" for="inputError">고유번호</label>
								<div class="controls"><span id="productId">${inspectionModel.inspection.productId}</span></div>
							</div>
							<div class="control-group">
								<label class="control-label" for="inputError">고객사</label>
								<div class="controls"><span id="client">${inspectionModel.inspection.client}</span></div>
							</div> --%>
						<c:forEach items="${inspectionModel.produces}" var="produce" varStatus="loop">
						<c:set var="skipClass" value=""/>
						<c:if test="${loop.index > 0}"><c:set var="skipClass" value="skip"/></c:if>
						<div class="vehicleItem vehicle${loop.index}" index="${loop.index}">
						<p>작업_${loop.count}</p>
						<div class="control-group">
							<label class="control-label" for="selectKind${loop.index}">种类</label>
							<div class="controls">
								<form:select path="produces[${loop.index}].kind" id="selectKind${loop.index}" class="selectKind selectVehicle ${skipClass}" title="작업_${loop.count} 种类">
									<form:option value="">种类</form:option>
									<c:forEach items="${produce.kinds}" var="item">
										<c:set var="selected" value=""/>
										<c:if test='${item.kind==produce.kind}'><c:set var="selected" value="selected"/></c:if>
										<form:option value="${item.kind}">${item.kind}</form:option>
									</c:forEach>
								</form:select>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="selectModelCar${loop.index}">车种</label>
							<div class="controls">
								<form:select path="produces[${loop.index}].modelCar" id="selectModelCar${loop.index}" class="selectModelCar selectVehicle ${skipClass}" title="작업_${loop.count} 车种">
									<form:option value="">车种</form:option>
									<c:if test="${produce.vehicleId != ''}">
									<c:forEach items="${produce.modelCars}" var="item">
										<c:set var="selected" value=""/>
										<form:option value="${item.model_car}">${item.model_car}</form:option>
									</c:forEach>
									</c:if>
								</form:select>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="selectProductName${loop.index}">品名</label>
							<div class="controls">
								<form:select path="produces[${loop.index}].productName" id="selectProductName${loop.index}" class="selectProductName selectVehicle ${skipClass}" title="작업_${loop.count} 品名">
									<form:option value="">品名</form:option>
									<c:if test="${produce.vehicleId != ''}">
									<c:forEach items="${produce.productNames}" var="item">
										<c:set var="selected" value=""/>
										<form:option value="${item.product_name}">${item.product_name}</form:option>
									</c:forEach>
									</c:if>
								</form:select>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="selectLhRh${loop.index}">L/R</label>
							<div class="controls">
								<form:hidden path="produces[${loop.index}].vehicleId" class="key vehicleId"/>
								<form:hidden path="produces[${loop.index}].faulty" class="key totalFaulty"/>
								<form:select path="produces[${loop.index}].lhRh" id="selectLhRh${loop.index}" class="selectLhRh selectVehicle ${skipClass}" title="작업_${loop.count} L/R">
									<form:option value="">L/R</form:option>
									<c:if test="${produce.vehicleId != ''}">
									<c:forEach items="${produce.lhRhs}" var="item">
										<c:set var="selected" value=""/>
										<form:option value="${item.lh_rh}" client="${item.client}" vehicleId="${item.vehicle_id}" productId="${item.product_id}">${item.lh_rh}</form:option>
									</c:forEach>
									</c:if>
								</form:select>
							</div>
						</div>
						<div class="control-group">
							<form:label path="produces[${loop.index}].production" cssClass="control-label">生产数量</form:label>
							<div class="controls">
								<form:input path="produces[${loop.index}].production" class="production input-large number ${skipClass}" title="작업_${loop.count} 生产数量" validate="number" />
							</div>
						</div>
						<div class="control-group">
						<table class="table table-bordered">
							<thead>
								<tr><th colspan="12">不良类型</th></tr>
								<tr>
									<th><form:label path="produces[${loop.index}].faultyA">实验</form:label></th>
									<th><form:label path="produces[${loop.index}].faultyB">发黄/发彩</form:label></th>
									<th><form:label path="produces[${loop.index}].faultyC">炸丝</form:label></th>
									<th><form:label path="produces[${loop.index}].faultyD">水丝</form:label></th>
									<th><form:label path="produces[${loop.index}].faultyE">发白</form:label></th>
									<th><form:label path="produces[${loop.index}].faultyF">滑牙</form:label></th>
									<th><form:label path="produces[${loop.index}].faultyG">脏斑</form:label></th>
									<th><form:label path="produces[${loop.index}].faultyH">划伤</form:label></th>
									<th><form:label path="produces[${loop.index}].faultyI">白点/黑点</form:label></th>
									<th><form:label path="produces[${loop.index}].faultyJ">断裂</form:label></th>
									<th><form:label path="produces[${loop.index}].faultyK">多镀</form:label></th>
									<th><form:label path="produces[${loop.index}].faultyL">送检</form:label></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><form:input path="produces[${loop.index}].faultyA" class="input-mini faulty number skip" title="작업_${loop.count} 조립불량 A" validate="number" /></td>
									<td><form:input path="produces[${loop.index}].faultyB" class="input-mini faulty number skip" title="작업_${loop.count} 조립불량 B" validate="number" /></td>
									<td><form:input path="produces[${loop.index}].faultyC" class="input-mini faulty number skip" title="작업_${loop.count} 조립불량 C" validate="number" /></td>
									<td><form:input path="produces[${loop.index}].faultyD" class="input-mini faulty number skip" title="작업_${loop.count} 조립불량 D" validate="number" /></td>
									<td><form:input path="produces[${loop.index}].faultyE" class="input-mini faulty number skip" title="작업_${loop.count} 조립불량 E" validate="number" /></td>
									<td><form:input path="produces[${loop.index}].faultyF" class="input-mini faulty number skip" title="작업_${loop.count} 조립불량 F" validate="number" /></td>
									<td><form:input path="produces[${loop.index}].faultyG" class="input-mini faulty number skip" title="작업_${loop.count} 조립불량 G" validate="number" /></td>
									<td><form:input path="produces[${loop.index}].faultyH" class="input-mini faulty number skip" title="작업_${loop.count} 조립불량 H" validate="number" /></td>
									<td><form:input path="produces[${loop.index}].faultyI" class="input-mini faulty number skip" title="작업_${loop.count} 조립불량 I" validate="number" /></td>
									<td><form:input path="produces[${loop.index}].faultyJ" class="input-mini faulty number skip" title="작업_${loop.count} 조립불량 J" validate="number" /></td>
									<td><form:input path="produces[${loop.index}].faultyK" class="input-mini faulty number skip" title="작업_${loop.count} 조립불량 K" validate="number" /></td>
									<td><form:input path="produces[${loop.index}].faultyL" class="input-mini faulty number skip" title="작업_${loop.count} 조립불량 L" validate="number" /></td>
								</tr>
							</tbody>
			            </table>
						</div>
						</div>
						</c:forEach>
						<div class="form-actions">
							<form:hidden path="inspection.eId" class="key" id="eId"/>
							<%-- <form:hidden path="inspection.totalProduction" class="key" id="totalProduction"/> --%>
							<%-- <form:hidden path="inspection.faulty" id="faulty"/> --%>
			                <a href="search"><button type="button" class="btn">목록</button></a>
							<c:if test="${inspectionModel.inspection.eId != null && inspectionModel.inspection.eId != '' }">
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
var inspectionForm ={
	formChk : function(){
		// 유효성 체크
		if(!$('#inspectionModel').validation()){
			return false;
		}
		var retCode = true;
		$('.vehicleItem').each(function(){
			var $this = $(this);
			var faulty = 0;
			if($this.find('.vehicleId').val()){
				var production = $this.find('.production').val();
				if(!production) {
					alert($this.find('.production').attr("title")+"을(를) 입력하세요.");
					$this.find('.production').focus();
					retCode = false;
					return false;
				}
				production = parseInt(production, 10);
				$this.find('input.faulty').each(function(){
					var val = $(this).val();
					if(!val) {
						val = 0;
						$(this).val(val);
						//alert($(this).attr("title")+"을(를) 입력하세요.");
						//$(this).focus();
						//retCode = false;
						//return false;
					}
					
					faulty += parseInt(val, 10);
				});
				if(!retCode) return false;

				if(production < faulty){
					alert('전체생산수량보다 불량수량이 높을 수 없습니다.');
					$this.find('.production').focus();
					retCode = false;
					return false;
				}
			}
			$this.find('.totalFaulty').val(faulty);
		});
		if(!retCode) return false;
		return true;
	},

	inspectionDelete: function(){
		var inspectionId = $('#eId').val();
		alert(inspectionId);
		if(!inspectionId) return;
		if(!confirm('삭제하시겠습니까?')) return;

		$.ajax({
			url: '/inspection/inspectionDelAjax',
			type: 'POST',
			data: {eId: inspectionId}
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
		var $base = $(this).closest('.vehicleItem');
		var kind = $(this).val();
		inspectionForm.selectVehicleInit($base);
		if(kind){
			$.ajax({
				url: '/vehicle/selectModelCarsAjax',
				type: 'POST',
				data: {kind: kind}
			}).success(function( data ) {
				if(data.list){
					var $selectModelCar = $base.find('.selectModelCar').find('option:not(:eq(0))').remove().end();
					$.each(data.list, function(i, item){
						$selectModelCar.append($('<option/>').val(item.model_car).text(item.model_car));
					});
					$selectModelCar.prop('disabled', false);
					$base.find('.selectVehicle:not(.selectKind):not(.selectModelCar)').prop('disabled', true).find('option[value=""]').prop('selected', true);
				}
			}).fail(function() {
		    	alert( '데이터 조회에 실패했습니다' );
		    	$base.find('.selectVehicle:not(.selectKind)').prop('disabled', true).find('option:not(:eq(0))').remove();
		    });
		}else{
			$base.find('.selectVehicle:not(.selectKind)').prop('disabled', true).find('option:not(:eq(0))').remove();
		}
	},

	selectModelCar : function(){
		var $base = $(this).closest('.vehicleItem');
		var kind = $base.find('.selectKind').val();
		var modelCar = $(this).val();
		inspectionForm.selectVehicleInit($base);
		if(kind && modelCar){
			$.ajax({
				url: '/vehicle/selectProductNamesAjax',
				type: 'POST',
				data: {kind: kind, modelCar : modelCar}
			}).success(function( data ) {
				if(data.list){
					var $selectProductName = $base.find('.selectProductName').find('option:not(:eq(0))').remove().end();
					$.each(data.list, function(i, item){
						$selectProductName.append($('<option/>').val(item.product_name).text(item.product_name));
					});
					$selectProductName.prop('disabled', false);
					$base.find('.selectLhRh').prop('disabled', true).find('option:not(:eq(0))').remove();
				}
			}).fail(function() {
		    	alert( '데이터 조회에 실패했습니다' );
		    	$base.find('.selectProductName, .selectLhRh').prop('disabled', true).find('option:not(:eq(0))').remove();
		    });
		}else{
			$base.find('.selectProductName, .selectLhRh').prop('disabled', true).find('option:not(:eq(0))').remove();
		}
	},

	selectProductName : function(){
		var $base = $(this).closest('.vehicleItem');
		var kind = $base.find('.selectKind').val();
		var modelCar = $base.find('.selectModelCar').val();
		var productName = $(this).val();
		inspectionForm.selectVehicleInit($base);
		if(kind && modelCar && productName){
			$.ajax({
				url: '/vehicle/selectlhRhsAjax',
				type: 'POST',
				data: {kind: kind, modelCar : modelCar, productName : productName}
			}).success(function( data ) {
				if(data.list){
					var $selectLhRh = $base.find('.selectLhRh').find('option:not(:eq(0))').remove().end();
					$.each(data.list, function(i, item){
						$selectLhRh.append($('<option client="'+item.client+'" vehicleId="'+item.vehicle_id+'" productId="'+item.product_id+'"/>').val(item.lh_rh).text(item.lh_rh));
					});
					$selectLhRh.prop('disabled', false);
				}
			}).fail(function() {
		    	alert( '데이터 조회에 실패했습니다' );
		    	$base.find('.selectLhRh').prop('disabled', true).find('option:not(:eq(0))').remove();
		    });
		}else{
			$base.find('.selectLhRh').prop('disabled', true).find('option:not(:eq(0))').remove();
		}
	},

	selectLhRh : function(){
		var $base = $(this).closest('.vehicleItem');
		var lhRh = $(this).val();
		var $this = $base.find('.selectLhRh').find('option[value="'+lhRh+'"]');
		var productId = $this.attr('productId');
		var client = $this.attr('client');
		var vehicleId = $this.attr('vehicleId');
		if(vehicleId){
			var retCode = true;
			var loop = $base.attr('index');
			$('.vehicleItem').each(function(i){
				if(loop!=i){
					var selectedId = $(this).find('.selectLhRh option:selected').attr('vehicleId');
					if(vehicleId == selectedId && $(this).find('.selectLhRh option:selected').val() != 'NA'){
				    	alert( '이미 선택한 차품종입니다' );
				    	retCode = false;
				    	return false;
					}
				}
			});
			if(!retCode) {
				var tempCode = $base.find('.selectLhRh').attr('tempCode');
				$base.find('.selectLhRh').find('option[value="'+tempCode+'"]').prop('selected', true).trigger('change');
				return false;
			}
			$base.find('.selectLhRh').attr('tempCode', vehicleId);
			$base.find('.productId').text(productId);
			$base.find('.client').text(client);
			$base.find('.vehicleId').val(vehicleId);
		}else{
			inspectionForm.selectVehicleInit($base);
		}
	},

	selectVehicleInit: function($base){
		$base.find('.selectLhRh').attr('tempCode', '');
		$base.find('.productId').text('');
		$base.find('.client').text('');
		$base.find('.vehicleId').val('');
	}
}
$(function(){
	dateUtil.init();
	$('#inspectionDelete').click(inspectionForm.inspectionDelete);
	$('.selectKind').change(inspectionForm.selectKind);
	$('.selectModelCar').change(inspectionForm.selectModelCar);
	$('.selectProductName').change(inspectionForm.selectProductName);
	$('.selectLhRh').change(inspectionForm.selectLhRh);
	$('.vehicleId').each(function(i){
		if(!$(this).val()){
			$('.selectVehicle:not(.selectKind)', '.vehicle'+i).prop('disabled', true);
		}
	});

	$('[validate="number"]').change(function(){
		var num = $(this).val();
		if(!num) $(this).val(0);
		if (!isNumeric(num,4)) {
			alert('숫자만 입력해주세요.');
			$(this).val(0).focus();
		}
	});
});
</script>