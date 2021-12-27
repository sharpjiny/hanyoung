<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="row-fluid">
	<!-- block -->
	<div class="block">
		<!-- <div class="navbar navbar-inner block-header">
			<div class="muted pull-left">증착입력</div>
		</div> -->
		<div class="block-content collapse in editForm">
			<div class="span12">
				<form:form modelAttribute="vaccumModel" cssClass="form-horizontal" method="post" action="" onsubmit="return vaccumForm.formChk(); return false;">
					<fieldset>
						<legend>증착입력</legend>
						<c:if test="${vaccumModel.vaccum.eId != null && vaccumModel.vaccum.eId != '' }">
						<div class="control-group">
							<label class="control-label" for="inputError">최초 등록일</label>
							<div class="controls"><fmt:formatDate value="${vaccumModel.vaccum.created}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">수정일</label>
							<div class="controls"><fmt:formatDate value="${vaccumModel.vaccum.lastModified}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
						</div>
						</c:if>
						<div class="control-group">
							<form:label path="vaccum.vaccumDate" cssClass="control-label">날짜</form:label>
							<div class="controls">
								<form:input path="vaccum.vaccumDate" class="input-large date" title="날짜"/>
							</div>
						</div>
						<div class="control-group">
							<form:label path="vaccum.workType" cssClass="control-label">주/야간</form:label>
							<div class="controls inline">
								<form:radiobuttons path="vaccum.workType" items="${workTypes}" itemValue="code" itemLabel="name" title="주/야간"/>
							</div>
						</div>
						<div class="control-group">
							<form:label path="vaccum.vaccumGroup" cssClass="control-label">반</form:label>
							<div class="controls inline">
								<form:select path="vaccum.vaccumGroup" title="반">
									<form:option value="">반</form:option>
									<form:options items="${vaccumGroups}" itemValue="code" itemLabel="name" />
								</form:select>
							</div>
						</div>
						<div class="control-group">
							<form:label path="vaccum.vaccum" cssClass="control-label">증착호기</form:label>
							<div class="controls inline">
								<form:select path="vaccum.vaccum" title="증착호기">
									<form:option value="" label="증착호기"/>
									<form:options items="${vaccums}" itemValue="code" itemLabel="name" />
								</form:select>
							</div>
						</div>
						<div class="control-group">
							<form:label path="vaccum.startTime" cssClass="control-label">시작시간</form:label>
							<div class="controls">
								<form:input path="vaccum.startTime" id="startTime" class="input-large" title="시작시간"/>
							</div>
						</div>
						<div class="control-group">
							<form:label path="vaccum.endTime" cssClass="control-label">종료시간</form:label>
							<div class="controls">
								<form:input path="vaccum.endTime" id="endTime" class="input-large" title="시작시간"/>
							</div>
						</div>
						<div class="control-group">
                            <form:label path="vaccum.tuncUsed" cssClass="control-label">텅스텐사용량</form:label>
                            <div class="controls">
                                <form:input path="vaccum.tuncUsed" class="production input-large number" title="텅스텐사용량" validate="number" />
                            </div>
                        </div>
						<c:forEach items="${vaccumModel.produces}" var="produce" varStatus="loop">
						<c:set var="skipClass" value=""/>
						<c:if test="${loop.index > 0}"><c:set var="skipClass" value="skip"/></c:if>
						<div class="content1_wrap s-horizon_wrap vehicleItem1 vehicle${loop.index}" index="${loop.index}">
						<p>작업_${loop.count}</p>
						<div class="content1 s-horizon">
							<label class="control-label" for="selectKind${loop.index}">종류</label>
							<div>
								<form:select path="produces[${loop.index}].kind" id="selectKind${loop.index}" class="selectKind selectVehicle ${skipClass}" title="작업_${loop.count} 종류">
									<form:option value="">종류</form:option>
									<c:forEach items="${produce.kinds}" var="item">
										<c:set var="selected" value=""/>
										<c:if test='${item.kind==produce.kind}'><c:set var="selected" value="selected"/></c:if>
										<form:option value="${item.kind}">${item.kind}</form:option>
									</c:forEach>
								</form:select>
							</div>
						</div>
						<div class="content1 s-horizon">
							<label class="control-label" for="selectModelCar${loop.index}">차종</label>
							<div>
								<form:select path="produces[${loop.index}].modelCar" id="selectModelCar${loop.index}" class="selectModelCar selectVehicle ${skipClass}" title="작업_${loop.count} 차종">
									<form:option value="">차종</form:option>
									<c:if test="${produce.vehicleId != ''}">
									<c:forEach items="${produce.modelCars}" var="item">
										<c:set var="selected" value=""/>
										<form:option value="${item.model_car}">${item.model_car}</form:option>
									</c:forEach>
									</c:if>
								</form:select>
							</div>
						</div>
						<div class="content1 s-horizon">
							<label class="control-label" for="selectProductName${loop.index}">품명</label>
							<div>
								<form:select path="produces[${loop.index}].productName" id="selectProductName${loop.index}" class="selectProductName selectVehicle ${skipClass}" title="작업_${loop.count} 품명">
									<form:option value="">품명</form:option>
									<c:if test="${produce.vehicleId != ''}">
									<c:forEach items="${produce.productNames}" var="item">
										<c:set var="selected" value=""/>
										<form:option value="${item.product_name}">${item.product_name}</form:option>
									</c:forEach>
									</c:if>
								</form:select>
							</div>
						</div>
						<div class="content1 s-horizon">
							<label class="control-label" for="selectLhRh${loop.index}">L/R</label>
							<div>
								<form:hidden path="produces[${loop.index}].vehicleId" class="key vehicleId"/>
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
						<div class="content1 s-horizon">
							<form:label path="produces[${loop.index}].production" cssClass="control-label">생산수량</form:label>
							<div>
								<form:input path="produces[${loop.index}].production" class="production input-large number ${skipClass}" title="작업_${loop.count} 전체생산수량" validate="number" />
							</div>
						</div>
						<%-- <div class="content1 s-horizon">
                            <label class="control-label" for="inputError">고유번호</label>
                            <div class="center"><span class="productId">${produce.productId}</span></div>
                        </div> --%>
						</div>
						</c:forEach>
						<div class="form-actions">
							<form:hidden path="vaccum.eId" class="key" id="eId"/>
							<form:hidden path="vaccum.totalProduction" class="key" id="totalProduction"/>
			                <a href="javascript: history.back();"><button type="button" class="btn">목록</button></a>
							<c:if test="${vaccumModel.vaccum.eId != null}">
							<button type="button" class="btn btn-danger" id="vaccumDelete">삭제</button>
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
<link rel="stylesheet" type="text/css" href="<c:url value='/res/css/jquery.datetimepicker.css'/>" media="screen"/>
<script src="<c:url value='/res/js/plugin/bootstrap-datepicker.js'/>"></script>
<script src="<c:url value='/res/js/plugin/bootstrap-datepicker.kr.js'/>"></script>
<script src="<c:url value='/res/js/plugin/jquery.datetimepicker.full.min.js'/>"></script>
<script>
var vaccumForm ={
	formChk : function(){
		// 유효성 체크
		if(!$('#vaccumModel').validation()){
			return false;
		}
		var retCode = true;
		var totalProduction = 0;
		$('.vehicleItem1').each(function(){
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
				/* $this.find('input.faulty').each(function(){
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
				}); */
				if(!retCode) return false;

				/* if(production < faulty){
					alert('전체생산수량보다 불량수량이 높을 수 없습니다.');
					$this.find('.production').focus();
					retCode = false;
					return false;
				} */
				totalProduction += production;
			}
			$this.find('.totalFaulty').val(faulty);
		});
		if(!retCode) return false;
		$('#totalProduction').val(totalProduction);
		return true;
	},

	vaccumDelete: function(){
		var eId = $('#eId').val();
		if(!eId) return;
		if(!confirm('삭제하시겠습니까?')) return;

		$.ajax({
			url: '/vaccum/vaccumDelAjax',
			type: 'POST',
			data: {eId: eId}
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
		var $base = $(this).closest('.vehicleItem1');
		var kind = $(this).val();
		vaccumForm.selectVehicleInit($base);
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
		var $base = $(this).closest('.vehicleItem1');
		var kind = $base.find('.selectKind').val();
		var modelCar = $(this).val();
		vaccumForm.selectVehicleInit($base);
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
		var $base = $(this).closest('.vehicleItem1');
		var kind = $base.find('.selectKind').val();
		var modelCar = $base.find('.selectModelCar').val();
		var productName = $(this).val();
		vaccumForm.selectVehicleInit($base);
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
		var $base = $(this).closest('.vehicleItem1');
		var lhRh = $(this).val();
		var $this = $base.find('.selectLhRh').find('option[value="'+lhRh+'"]');
		var productId = $this.attr('productId');
		var client = $this.attr('client');
		var vehicleId = $this.attr('vehicleId');
		if(vehicleId){
			var retCode = true;
			var loop = $base.attr('index');
			$('.vehicleItem1').each(function(i){
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
			vaccumForm.selectVehicleInit($base);
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
	$.datetimepicker.setLocale('ko');

    $('#startTime').datetimepicker({
    	format: 'Y-m-d H:i',
    	mask:'9999-19-39 29:59'
    	, step:10
   		, onChangeDateTime : function( currentDateTime ){
       		$('#endTime').datetimepicker({
       			minDate : currentDateTime
       		});
       	}
    });
    $('#endTime').datetimepicker({
    	format: 'Y-m-d H:i',
    	mask:'9999-19-39 29:59'
   		, step:10
     	, onChangeDateTime : function( currentDateTime ){
    		$('#startTime').datetimepicker({
    			maxDate : currentDateTime
    		});
    	}
    });

	$('#vaccumDelete').click(vaccumForm.vaccumDelete);
	$('.selectKind').change(vaccumForm.selectKind);
	$('.selectModelCar').change(vaccumForm.selectModelCar);
	$('.selectProductName').change(vaccumForm.selectProductName);
	$('.selectLhRh').change(vaccumForm.selectLhRh);
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