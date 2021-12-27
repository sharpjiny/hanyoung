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
			<div class="muted pull-left">사출입력</div>
		</div> -->
		<div class="block-content collapse in editForm">
			<div class="span12">
				<form:form modelAttribute="ejectionModel" cssClass="form-horizontal" method="post" action="" onsubmit="return ejectionForm.formChk(); return false;">
					<fieldset>
						<legend>注塑입력</legend>
						<c:if test="${ejectionModel.ejection.eId != null && ejectionModel.ejection.eId != '' }">
						<div class="control-group">
							<label class="control-label" for="inputError">최초 등록일</label>
							<div class="controls"><fmt:formatDate value="${ejectionModel.ejection.created}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">수정일</label>
							<div class="controls"><fmt:formatDate value="${ejectionModel.ejection.lastModified}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
						</div>
						</c:if>
						<div class="control-group">
							<form:label path="ejection.ejectionDate" cssClass="control-label">日期</form:label>
							<div class="controls">
								<form:input path="ejection.ejectionDate" class="input-large date" title="日期"/>
							</div>
						</div>
						<div class="control-group">
							<form:label path="ejection.workType" cssClass="control-label">白/夜班</form:label>
							<div class="controls inline">
								<form:radiobuttons path="ejection.workType" items="${workTypes}" itemValue="code" itemLabel="name" title="白/夜班"/>
							</div>
						</div>
						<div class="control-group">
							<form:label path="ejection.ejectionGroup" cssClass="control-label">班</form:label>
							<div class="controls inline">
								<form:select path="ejection.ejectionGroup" title="班">
									<form:option value="">班</form:option>
									<form:options items="${ejectionGroups}" itemValue="code" itemLabel="name" />
								</form:select>
							</div>
						</div>
						<div class="control-group">
							<form:label path="ejection.ejection" cssClass="control-label">注塑机号</form:label>
							<div class="controls inline">
								<form:select path="ejection.ejection" title="注塑机号">
									<form:option value="" label="注塑机号"/>
									<form:options items="${ejections}" itemValue="code" itemLabel="name" />
								</form:select>
							</div>
						</div>
						<div class="control-group">
							<form:label path="ejection.planStartTime" cssClass="control-label">계획시작시간</form:label>
							<div class="controls">
								<form:input path="ejection.planStartTime" id="planStartTime" class="input-large" title="계획시작시간"/>
							</div>
						</div>
						<div class="control-group">
							<form:label path="ejection.planEndTime" cssClass="control-label">계획종료시간</form:label>
							<div class="controls">
								<form:input path="ejection.planEndTime" id="planEndTime" class="input-large" title="계획종료시간"/>
							</div>
						</div>
						<div class="control-group">
							<form:label path="ejection.startTime" cssClass="control-label">开始时间</form:label>
							<div class="controls">
								<form:input path="ejection.startTime" id="startTime" class="input-large" title="开始时间"/>
							</div>
						</div>
						<div class="control-group">
							<form:label path="ejection.endTime" cssClass="control-label">结束时间</form:label>
							<div class="controls">
								<form:input path="ejection.endTime" id="endTime" class="input-large" title="结束时间"/>
							</div>
						</div>
						<div class="control-group">
							<form:label path="ejection.ct" cssClass="control-label">CT(초)</form:label>
							<div class="controls">
								<form:input path="ejection.ct" class="input-large" title="CT(초)" />
							</div>
						</div>
						<%--<div class="control-group">
							<form:label path="ejection.cycleTime" cssClass="control-label">사이클타임</form:label>
							<div class="controls">
								<form:input path="ejection.cycleTime" class="input-large number" validate="number" title="사이클타임"/>
							</div>
						</div>
						<div class="control-group">
						<table class="table table-bordered" style="width: 400px">
							<tbody>
								<tr><th rowspan="3" class="center">중량(g)</th>
									<th class="center">초</th>
									<td class="center"><form:input path="ejection.weight1" class="input-mini number" title="중량(g) 초" validate="number" /></td>
								</tr>
								<tr>
									<th class="center">중</th>
									<td class="center"><form:input path="ejection.weight2" class="input-mini number" title="중량(g) 중" validate="number" /></td>
								</tr>
								<tr>
									<th class="center">고</th>
									<td class="center"><form:input path="ejection.weight3" class="input-mini number" title="중량(g) 고" validate="number" /></td>
								</tr>
							</tbody>
			            </table>
						</div> --%>
						<div class="control-group">
							<form:label path="ejection.rawKind" cssClass="control-label">原材料种类</form:label>
							<div class="controls inline">
							    <form:select path="ejection.rawKind" title="原材料种类" id="selectRawKind">
                                    <option value="">种类</option>
                                    <c:forEach items="${rawKinds}" var="item">
                                        <c:set var="selected" value=""/>
                                        <c:if test='${item.kind==ejectionModel.ejection.rawKind}'><c:set var="selected" value="selected"/></c:if>
                                        <option value="${item.kind}" ${selected}>${item.kind}</option>
                                    </c:forEach>
                                </form:select>
							</div>
						</div>
						<div class="control-group">
							<form:label path="ejection.rawId" cssClass="control-label">原材料品名</form:label>
							<div class="controls inline">
								<form:select path="ejection.rawId" title="原材料品名" id="selectRawProduct">
								    <option value="">原材料品名</option>
                                    <c:forEach items="${rawProducts}" var="item">
                                        <c:set var="selected" value=""/>
                                        <c:if test='${item.code==ejectionModel.ejection.rawId}'><c:set var="selected" value="selected"/></c:if>
                                        <option value="${item.code}" ${selected}>${item.name}</option>
                                    </c:forEach>
                                    
									<%-- <form:option value="" label="원재료품명"/>
									<form:options items="${rawProducts}" itemValue="code" itemLabel="name" /> --%>
								</form:select>
							</div>
						</div>
						<div class="control-group">
							<form:label path="ejection.gateWeight" cssClass="control-label">게이트중량(g)</form:label>
							<div class="controls">
								<form:input path="ejection.gateWeight" class="input-large ${skipClass}" title="게이트중량(g)" />
							</div>
						</div>
						<div class="control-group">
							<form:label path="ejection.workMan1" cssClass="control-label">작업자1</form:label>
							<div class="controls">
								<form:input path="ejection.workMan1" class="input-large" title="작업자1" />
							</div>
						</div>
						<div class="control-group">
							<form:label path="ejection.workMan2" cssClass="control-label">작업자2</form:label>
							<div class="controls">
								<form:input path="ejection.workMan2" class="input-large skip" title="작업자2" />
							</div>
						</div>
						<c:forEach items="${ejectionModel.produces}" var="produce" varStatus="loop">
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
						<%-- <div class="control-group">
							<label class="control-label" for="inputError">品号</label>
							<div class="controls"><span class="productId">${produce.productId}</span></div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">入库社</label>
							<div class="controls"><span class="client">${produce.client}</span></div>
						</div> --%>
						<div class="control-group">
							<form:label path="produces[${loop.index}].weight" cssClass="control-label">제품중량(g)</form:label>
							<div class="controls">
								<form:input path="produces[${loop.index}].weight" class="input-large number ${skipClass}" title="작업_${loop.count} 제품중량(g)" validate="number" />
							</div>
						</div>
						<div class="control-group">
							<form:label path="produces[${loop.index}].cvt" cssClass="control-label">CVT</form:label>
							<div class="controls">
								<form:input path="produces[${loop.index}].cvt" class="input-large number ${skipClass}" title="작업_${loop.count} CVT" validate="number" />
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
								<tr><th colspan="11">不良类型</th></tr>
								<tr>
									<th><form:label path="produces[${loop.index}].faultyA">开机不良</form:label></th>
									<th><form:label path="produces[${loop.index}].faultyB">调机不良</form:label></th>
									<th><form:label path="produces[${loop.index}].faultyC">未成形</form:label></th>
									<th><form:label path="produces[${loop.index}].faultyD">银丝</form:label></th>
									<th><form:label path="produces[${loop.index}].faultyE">气泡</form:label></th>
									<th><form:label path="produces[${loop.index}].faultyF">擦模</form:label></th>
									<th><form:label path="produces[${loop.index}].faultyG">黑点</form:label></th>
									<th><form:label path="produces[${loop.index}].faultyH">杂料</form:label></th>
									<th><form:label path="produces[${loop.index}].faultyI">油斑/气斑</form:label></th>
									<th><form:label path="produces[${loop.index}].faultyJ">断裂</form:label></th>
									<th><form:label path="produces[${loop.index}].faultyK">脏斑</form:label></th>
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
								</tr>
							</tbody>
			            </table>
						</div>
						</div>
						</c:forEach>
						<div class="form-actions">
							<form:hidden path="ejection.eId" class="key" id="eId"/>
							<form:hidden path="ejection.totalProduction" class="key" id="totalProduction"/>
			                <a href="javascript: history.back();"><button type="button" class="btn">목록</button></a>
							<c:if test="${ejectionModel.ejection.eId != null}">
							<button type="button" class="btn btn-danger" id="ejectionDelete">삭제</button>
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
var ejectionForm ={
	formChk : function(){
		// 유효성 체크
		if(!$('#ejectionModel').validation()){
			return false;
		}
		var retCode = true;
		var totalProduction = 0;
		var eachJobProduction = 0;
		$('.vehicleItem').each(function(){
			var $this = $(this);
			var faulty = 0;
			if($this.find('.vehicleId').val()){
				var production = $this.find('.production').val();
				/* if(!production) {
					alert($this.find('.production').attr("title")+"을(를) 입력하세요.");
					$this.find('.production').focus();
					retCode = false;
					return false;
				} */
				if(production){
					production = parseInt(production, 10);
				}
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
				totalProduction += production;
			}
			$this.find('.totalFaulty').val(faulty);
		});
		if(!retCode) return false;
		$('#totalProduction').val(totalProduction);
		
		return true;
	},

	ejectionDelete: function(){
		var eId = $('#eId').val();
		if(!eId) return;
		if(!confirm('삭제하시겠습니까?')) return;

		$.ajax({
			url: '/ejection/ejectionDelAjax',
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
		var $base = $(this).closest('.vehicleItem');
		var kind = $(this).val();
		$("#selectKind1").val(kind);
		ejectionForm.selectVehicleInit($base);
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
						$("#selectModelCar1").append($('<option/>').val(item.model_car).text(item.model_car));
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
		$("#selectModelCar1").val(modelCar);
		$("#selectModelCar1").prop('disabled', false);
		ejectionForm.selectVehicleInit($base);
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
						$("#selectProductName1").append($('<option/>').val(item.product_name).text(item.product_name));
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
		$("#selectProductName1").val(productName);
		$("#selectProductName1").prop('disabled', false);
		ejectionForm.selectVehicleInit($base);
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
						$("#selectLhRh1").append($('<option client="'+item.client+'" vehicleId="'+item.vehicle_id+'" productId="'+item.product_id+'"/>').val(item.lh_rh).text(item.lh_rh));
					});
					$selectLhRh.find('option :eq(1)').prop('selected', true).trigger('change');
					$("#selectLhRh1").find('option :eq(2)').prop('selected', true).trigger('change');
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
		
		$("#selectLhRh1").prop('disabled', false);
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
			ejectionForm.selectVehicleInit($base);
		}
	},

	selectVehicleInit: function($base){
		$base.find('.selectLhRh').attr('tempCode', '');
		$base.find('.productId').text('');
		$base.find('.client').text('');
		$base.find('.vehicleId').val('');
	},

	selectRawKind: function(){
		var kind = $(this).val();
		if(kind){
			$.ajax({
				url: '/set/rawStock/getComboRawStocksAjax',
				type: 'POST',
				data: {kind: kind}
			}).success(function( data ) {
				if(data.list){
					var $selectRawProduct = $('#selectRawProduct').find('option:not(:eq(0))').remove().end();
					$.each(data.list, function(i, item){
						$selectRawProduct.append($('<option/>').val(item.code).text(item.name));
					});
					$selectRawProduct.prop('disabled', false);
				}
			}).fail(function() {
		    	alert( '데이터 조회에 실패했습니다' );
		    	$('#selectRawProduct').prop('disabled', true).find('option:not(:eq(0))').remove();
		    });
		}else{
			$('#selectRawProduct').prop('disabled', true).find('option:not(:eq(0))').remove();
		}
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
    $('#planStartTime').datetimepicker({
    	format: 'Y-m-d H:i',
    	mask:'9999-19-39 29:59'
    	, step:10
   		, onChangeDateTime : function( currentDateTime ){
       		$('#planEndTime').datetimepicker({
       			minDate : currentDateTime
       		});
       	}
    });
    $('#planEndTime').datetimepicker({
    	format: 'Y-m-d H:i',
    	mask:'9999-19-39 29:59'
   		, step:10
     	, onChangeDateTime : function( currentDateTime ){
    		$('#planStartTime').datetimepicker({
    			maxDate : currentDateTime
    		});
    	}
    });

	$('#ejectionDelete').click(ejectionForm.ejectionDelete);
	$('.selectKind').change(ejectionForm.selectKind);
	$('.selectModelCar').change(ejectionForm.selectModelCar);
	$('.selectProductName').change(ejectionForm.selectProductName);
	$('.selectLhRh').change(ejectionForm.selectLhRh);
	$('.vehicleId').each(function(i){
		if(!$(this).val()){
			$('.selectVehicle:not(.selectKind)', '.vehicle'+i).prop('disabled', true);
		}
	});

	$('#selectRawKind').change(ejectionForm.selectRawKind);

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