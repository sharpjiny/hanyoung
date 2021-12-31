<%--
   화면명 : 원재료 입출고 리스트 - 페이징
 --%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<div class="row-fluid">
	<!-- block -->
	<div class="block">
		<div class="navbar navbar-inner block-header">
			<div class="muted pull-left">原材料出入库现况</div>
		</div>
		<div class="block-content collapse in">
			<div class="span12">
				<div class="alert alert-block">
					<form method="post" class="form-horizontal" action=""
						id="searchForm" onsubmit="return paging.submit(); return false;">
						<%-- 검색조건 --%>
						<fieldset>
							<div class="control-group">
								<label class="control-label" for="dateStart">日期</label>
								<div class="controls">
									<input class="input-small date" name="dateStart" id="dateStart"
										type="text" value="${pageParam.dateStart}"> ~ <input
										class="input-small date" name="dateEnd" id="dateEnd"
										type="text" value="${pageParam.dateEnd}">
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="workType0">区分</label>
								<div class="controls">
									<select id="selectStockGubun" name="stockGubun" class=""
										title="구분">
										<option value="">全部</option>
										<c:forEach items="${stockGubuns}" var="item">
											<option value="${item.code}"
												${item.code==pageParam.stockGubun ? 'selected="selected"' : ''}>${item.name}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="inputError">결산월</label>
								<div class="controls">
									<select id="settlementMonth" name="settlementMonth" class="" title="결산월">
										<option value="">결산월</option>
										<c:forEach items="${settlementMonth}" var="item">
											<c:set var="selected" value=""/>
											<c:if test='${item.code==pageParam.settlementMonth}'><c:set var="selected" value="selected"/></c:if>
											<option value="${item.code}" ${selected}>${item.name}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="inputError">种类</label>
								<div class="controls">
									<select id="selectKind" name="kind" class="selectRawStock"
										title="종류">
										<option value="">全部</option>
										<c:forEach items="${kinds}" var="item">
											<option value="${item.kind}"
												${item.kind==pageParam.kind ? 'selected="selected"' : ''}>${item.kind}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="inputError">品名</label>
								<div class="controls">
									<select id="selectProductName" name="productName"
										class="selectRawStock" title="품명">
										<option value="">全部</option>
										<c:forEach items="${productNames}" var="item">
											<option value="${item.code}"
												${item.code==pageParam.productName ? 'selected="selected"' : ''}>${item.code}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="inputError">入库社</label>
								<div class="controls">
									<select id="selectClient" name="client" title="입고처">
										<option value="">全部</option>
										<c:forEach items="${clients}" var="item">
											<option value="${item.code}"
												${item.code==pageParam.client ? 'selected="selected"' : ''}>${item.code}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="inputError">批号</label>
								<div class="controls">
									<input id="loftNumber" name="loftNumber" class="input-xlarge"
										title="로트번호" value="${pageParam.loftNumber}" />
								</div>
							</div>
							<div class="control-group btn-group">
								<input type="hidden" name="pageCut" value="10" /> <input
									type="hidden" name="pageNum" value="${pageParam.pageNum}" />
								<button type="submit" class="btn btn-primary"
									id="rawStockSearch">檢索</button>
							</div>
						</fieldset>
						<%--//검색조건 --%>
					</form>
				</div>
				<%--추가 버튼 --%>
				<p>
					<a href="#">
						<button type="button" class="btn btn-success" id="rawStockAdd">
							原材料出入库输入 <i class="icon-plus icon-white"></i>
						</button>
					</a>
				</p>
				<%--//추가 버튼 --%>

				<%--원재료 입출고 목록 --%>
				<!-- <table class="table table-striped table-bordered"> -->
				<table style="width:100%;" class="table-hover" >
					<thead>
						<tr>
							<th>NO</th>
							<th>日期</th>
							<th>결산월</th>
							<th>区分</th>
							<th>入库社</th>
							<th>种类</th>
							<th>品名</th>
							<th>批号</th>
							<th>포대重量</th>
							<th>포대수량</th>
							<th>重量</th>
							<th>单价</th>
							<th>金额</th>
							<th>备注</th>
							<th>确认</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${!empty pagingList}">
								<c:set var="loopIndex" value="${pageParam.startNum}" />
								<c:forEach items="${pagingList}" var="item" varStatus="loop">
									<tr>
										<td class="center"><span>${loopIndex+loop.count}</span></td>
										<td class="center"><a
											href="javascript:rawStockEdit('${item.idx}');">${item.created}</a>
										</td>
										<td class="center">${item.settlementMonth}</td>
										<td class="center">${item.rawGubun}</td>
										<td class="center">${item.client}</td>
										<td>${item.kind}</td>
										<td>${item.productName}</td>
										<td class="center">${item.loftNumber}</td>
										<td class="center"><fmt:formatNumber
                                                value="${item.pWeight}" pattern="#,###.00" /></td>
										<td class="center"><fmt:formatNumber
												value="${item.pNumber}" pattern="#,###" /></td>
												<td class="center"><fmt:formatNumber
												value="${item.weight}" pattern="#,###.00" /></td>
										<c:choose>
										  <c:when test="${item.price == 0}"><td class="center"><fmt:formatNumber value="${item.price}" pattern="0" /></td></c:when>
										  <c:otherwise><td class="center">${item.price}</td></c:otherwise>
										</c:choose>
										<c:choose>
										  <c:when test="${item.realPrice != 0}"><td class="center"><fmt:formatNumber value="${item.realPrice}" pattern="#,###.00" /></td></c:when>
										  <c:otherwise><td class="center"><fmt:formatNumber value="${item.realPrice}" pattern="0" /></td></c:otherwise>
										</c:choose>
										<td class="center">${item.bigo}</td>
										<td class="center" id="${item.idx}"><c:choose>
												<c:when test="${item.isCheck=='OK'}">
													${item.isCheck}
												</c:when>
												<c:otherwise>
													<a href="javascript:isCheckOk('${item.idx}');"
														class="isCheckBtn" >${item.isCheck}</a>
												</c:otherwise>
											</c:choose></td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td scope="col" colspan="15" class="center bin">데이터가 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<%--//원재료 입출고 목록 --%>
				<c:import url="../layout/paginate.jsp"></c:import>
			</div>
		</div>
	</div>
	<!-- /block -->
</div>

<%--원재료 입출고 등록 & 수정 & 삭제 팝업 --%>
<div class="modal fade modal-min hide" id="rawStockModal" tabindex="-1"
	role="dialog" aria-labelledby="rawStockModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">原材料出入库输入</h4>
			</div>
			<div class="modal-body">
				<form id="submitForm" class="form-horizontal"
					onsubmit="return false;">
					<fieldset>
						<div id="firstC">
							<div class="control-group">
								<label class="control-label" for="inputError">최초 등록일</label>
								<div class="controls">
									<input size=100 title="최초 등록일" id="firstCreatedPop" type="text"
										disabled>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="inputError">수정일</label>
								<div class="controls">
									<input size=100 title="최초 등록일" id="lastModifiedPop" type="text"
										disabled>
								</div>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="datePop">日期</label>
							<div class="controls">
								<input class="input-small date" title="입출고날짜" id="datePop"
									name="inputdate" type="text">
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">결산월</label>
							<div class="controls">
								<select id="settlementMonthPop" name="settlementMonth" class="" title="결산월">
									<option value="">결산월</option>
									<c:forEach items="${settlementMonth}" var="item">
										<option value="${item.code}">${item.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="workType0">区分</label>
							<div class="controls">
								<select id="selectStockGubunPop" name="rawGubun" class=""
									title="구분">
									<option value="">全部</option>
									<c:forEach items="${stockGubuns}" var="item">
										<option value="${item.code}">${item.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">种类</label>
							<div class="controls">
								<select id="selectKindPop" name="kind" class="selectRawStockPop"
									title="종류">
									<option value="">全部</option>
									<c:forEach items="${kinds}" var="item">
										<option value="${item.kind}">${item.kind}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">品名</label>
							<div class="controls">
								<select id="selectProductNamePop" name="productName"
									class="selectRawStockPop" title="품명">
									<option value="">全部</option>
									<c:forEach items="${productNames}" var="item">
										<option value="${item.code}">${item.code}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">入库社</label>
							<div class="controls">
								<select  id="selectClientPop" name="client"
									class="selectRawStockPop" title="입고처">
									<option value="">全部</option>
									<c:forEach items="${clients}" var="item">
										<option value="${item.code}">${item.code}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">批号</label>
							<div class="controls">
								<input id="loftNumberPop" name="loftNumber" class="input-large"
									title="로트번호" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">포대당중량</label>
							<div class="controls">
								<input class="input-xlarge focused" id="pWeightPop"
									name="pWeight" type="number" step="0.01" title="중량" placeholder="중량">
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">포대수량</label>
							<div class="controls">
								<input class="input-xlarge focused" id="pNumberPop"
									name="pNumber" type="number" title="중량" placeholder="중량">
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">重量</label>
							<div class="controls">
								<input class="input-xlarge focused" id="weightPop" name="weight"
									type="number" title="중량" placeholder="중량">
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">备注</label>
							<div class="controls">
								<input id="bigoPop" name="bigo" class="input-large skip"
									title="비고" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">单价</label>
							<div class="controls">
								<input id="pricePop" name="price" style="text-align: right;" title="단가"
									readonly />
							</div>
						</div>
					</fieldset>
					<input type="hidden" name="eventType" value="" /> 
					<input type="hidden" id="idxPop" name="idx" value="" /> 
					<input type="hidden" id="productIdPop" name="productId" value="" /> 
					<input type="hidden" id="isCheckPop" name="isCheck" value="" />
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn btn-info" id="rawStockDelete">删去</button>
				<button type="button" class="btn btn-primary" id="rawStockSave">输入</button>
			</div>
		</div>
	</div>
</div>
<%--//원재료 입출고 등록 & 수정 & 삭제 팝업 --%>

<link rel="stylesheet" type="text/css"
	href="<c:url value='/res/css/datepicker.css'/>" media="screen" />
<script src="<c:url value='/res/js/plugin/bootstrap-datepicker.js'/>"></script>
<script src="<c:url value='/res/js/plugin/bootstrap-datepicker.kr.js'/>"></script>


<script type="text/javascript">
	$(function() {
		$(document).on(
				'keyup',
				'#pWeightPop',
				function(e) {

					if ($("#pNumberPop").val() && $("#pWeightPop").val()) {
						
						var sum = parseFloat($("#pWeightPop").val())
								* parseInt($("#pNumberPop").val())
						$("#weightPop").val(sum);
					}
				});
		$(document).on(
				'keyup',
				'#pNumberPop',
				function(e) {
					if ($("#pNumberPop").val() && $("#pWeightPop").val()) {
						
						var sum = parseFloat($("#pWeightPop").val())
								* parseInt($("#pNumberPop").val())
						$("#weightPop").val(sum);
					}
				});
		$(document).on('keypress', '#pWeightPop', function(e) {
			console.log('===== keypress ====='); // 2番目に実行される
			console.log(e);
			console.log(e.keyCode);
			console.log(e.which);
		});
		
	    // 포대수량 이벤트 추가 
        $(document).on('keypress', '#pNumberPop', function(e) {
            console.log('===== keypress ====='); // 2番目に実行される
            console.log(e);
            console.log(e.keyCode);
            console.log(e.which);
        });
	});
	var tempProductName = "";
	var tempClient = "";

	$(function() {
		dateUtil.init();
<%-- 검색 - 종류 셀렉트 변경 --%>
	$('#selectKind').change(
				function() {
					var kind = $(this).val();

					if (kind) {
						$.ajax({
							url : '/rawProductName/selectRawProducts',
							type : 'POST',
							data : {
								kind : kind
							}
						}).success(
								function(data) {
									if (data.list) {
										var $selectProductName = $('#selectProductName').find('option:not(:eq(0))').remove().end();

										$.each(data.list, function(i, item) {
											$selectProductName.append($('<option/>').val(item.code).text(item.name));
										});

										$selectProductName.prop('disabled',false);
									}
								}).fail(
								function() {
									alert('데이터 조회에 실패했습니다');
									$('.selectRawStock:not(#selectKind)').prop('disabled', true).find('option:not(:eq(0))').remove();
								});
					} else {
						$('.selectRawStock:not(#selectKind)').prop('disabled',true).find('option:not(:eq(0))').remove();
					}
				});
<%-- 팝업 - 종류 셀렉트 변경 --%>
	$('#selectKindPop').change(
				function() {
					var kind = $(this).val();

					if (kind) {
						$.ajax({
							url : '/rawProductName/selectRawProducts',
							type : 'POST',
							data : {
								kind : kind
							}
						}).success(
								function(data) {
									if (data.list) {
										var $selectProductName = $(
												'#selectProductNamePop').find('option:not(:eq(0))').remove().end();
										$.each(data.list, function(i, item) {
											$selectProductName.append($('<option/>').val(item.code).text(item.name));
										});
										$selectProductName.prop('disabled',false);

										if (tempProductName != "") {
											$('#rawStockModal').find('#selectProductNamePop').val(tempProductName).trigger('change');
											tempProductName = "";
										}
									}
								}).fail(
								function() {
									alert('데이터 조회에 실패했습니다');
									$('.selectRawStockPop:not(#selectKindPop)').prop('disabled', true).find('option:not(:eq(0))').remove();
								});
					} else {
						$('.selectRawStockPop:not(#selectKindPop)').prop('disabled', true).find('option:not(:eq(0))').remove();
					}
				});
<%-- 팝업 - 품목 셀렉트 변경 --%>
	$('#selectProductNamePop').change(
				function() {
					var kind = $('#selectKindPop').val();
					var productName = $(this).val();

					if (kind && productName) {
						$.ajax({
							url : '/rawProductName/selectRawClient',
							type : 'POST',
							data : {
								kind : kind,
								productName : productName
							}
						}).success(
								function(data) {
									if (data.list) {
										var $selectClient = $('#selectClientPop').find('option:not(:eq(0))').remove().end();
										$.each(data.list, function(i, item) {
											$selectClient.append($('<option/>').val(item.code).text(item.code));
										});
										$selectClient.prop('disabled', false);

										if (tempClient != "") {
											$('#rawStockModal').find('#selectClientPop').val(tempClient).trigger('change');
											tempClient = "";
										}
									}
								}).fail(
								function() {
									alert('데이터 조회에 실패했습니다');
									$('#selectClientPop')
											.prop('disabled', true).find('option:not(:eq(0))')
											.remove();
								});
					} else {
						$('#selectClientPop').prop('disabled', true).find('option:not(:eq(0))').remove();
					}
				});
<%-- 팝업 - 입고처 셀렉트 변경 --%>
	$('#selectClientPop').change(
				function() {
					var kind = $('#selectKindPop').val();
					var productName = $('#selectProductNamePop').val();
					var client = $(this).val();

					if (kind && productName && client) {
						$.ajax({
							url : '/rawProductName/selectPrice',
							type : 'POST',
							data : {
								kind : kind,
								productName : productName,
								client : client
							}
						}).success(
								function(data) {
									if (data.obj) {
										$('#rawStockModal').find('[name=price]').val(data.obj.price).end()
												           .find('[name=productId]').val(data.obj.product_id).end()
									}
								}).fail(
								function() {
									alert('데이터 조회에 실패했습니다');
									$('#selectClientPop').prop('disabled', true).find('option:not(:eq(0))').remove();
								});
					} else {
						$('#selectClientPop').prop('disabled', true).find('option:not(:eq(0))').remove();
					}
				});
	
	<%-- 팝업 - 결산월 변경 --%>	
	$('#datePop').change(function(){
		var day = $(this).val().substr(5,2);
		$('#rawStockModal').find('[name=settlementMonth]').val(day).end()
	});
<%--  원재료등록 버튼 클릭 --%>
	$('#rawStockAdd').click(
				function() {
					$('#rawStockDelete').hide();
					$('#firstC').hide();
					$("#datePop").prop("disabled", false);
					$("#settlementMonthPop").prop("disabled", false);
					$("#selectStockGubunPop").prop("disabled", false);
					$("#selectKindPop").prop("disabled", false);
					$("#loftNumberPop").prop("disabled", false);
					$("#weightPop").prop("readonly", true);
					$("#bigoPop").prop("disabled", false);
					$("#pWeightPop").prop("disabled", false);
					$("#pNumberPop").prop("disabled", false);
					$("#selectProductNamePop").prop("disabled", false);
					$("#selectClientPop").prop("disabled", false);
					$('#rawStockSave').show();
					$('#rawStockModal').find('input:text, [type=number], [type=hidden]').val('').end()
				    .find('[name=eventType]').val('C').end()
				    .find('#idxPop').val('').end()
				    .find('#pricePop').val('').end()
				    .find('#productIdPop').val('').end()
				    .find('#datePop').val('').end()
				    .find('#settlementMonthPop').val('').end()
				    .find('#selectStockGubunPop').val('').end()
				    .find('#selectKindPop').val('').end()
				    .find('#selectProductNamePop').val('').end()
				    .find('#selectClientPop').val('').end()
				    .find('#loftNumberPop').val('').end()
				    .find('#weightPop').val('').end()
				    .find('#pWeightPop').val('').end()
				    .find('#pNumberPop').val('').end()
				    .find('#bigoPop').val('').end()
				    .find('#isCheckPop').val('').end().modal('show');
				});
<%--  저장 클릭 --%>
	$('#rawStockSave').click(function() {

			if(!$("#submitForm").validation()){
				return false;
			}
			
			$.ajax({
				url : '/stock/rowstock/rawStockSaveAjax',
				type : 'POST',
				data : $("#submitForm").serialize()
			}).success(function(data) {
				alert("저장되었습니다.");
				if (data.code == '0000') {
					location.reload();
				}
			}).fail(function() {
				alert('저장을 실패했습니다');
			});
		});
<%--  삭제 클릭 --%>
	$('#rawStockDelete').click(function() {
			var idx = $('#idxPop').val();
			if (!idx)
				return;
			if (!confirm('삭제하시겠습니까?'))
				return;

			$.ajax({
				url : '/stock/rowstock/rawStockDeleteAjax',
				type : 'POST',
				data : {
					idx : idx
				}
			}).success(function(data) {
				alert("삭제되었습니다.");
				if (data.code == '0000') {
					location.reload();
				}
			}).fail(function() {
				alert('삭제에 실패했습니다');
			});
		});
	});
<%-- 수정 클릭 --%>
	function rawStockEdit(idx) {
		if (!idx)
			return;
		$.ajax({
			url : '/stock/rowstock/getRawStockAjax',
			type : 'POST',
			data : {
				idx : idx
			}
		}).success(function(data) {
			rawStockUpdate(data.rawStock);
		}).fail(function() {
			alert('조회에 실패했습니다');
		});
	}
<%-- 수정화면 호출 list.jsp --%>
	function rawStockUpdate(rowData) {
		if (rowData) {
			$('#firstC').show();
			if (rowData.isCheck === 'OK' && 'bogoadmin' != '${userSession.id}') {
				$('#rawStockSave').hide();
				$('#rawStockDelete').hide();
				$("#datePop").prop("disabled", true);
				$("#settlementMonthPop").prop("disabled", true);
				$("#selectStockGubunPop").prop("disabled", true);
				$("#selectKindPop").prop("disabled", true);
				$("#loftNumberPop").prop("disabled", true);
				$("#weightPop").prop("disabled", true);
				$("#bigoPop").prop("disabled", true);
				$("#pWeightPop").prop("disabled", true);
				$("#pNumberPop").prop("disabled", true);
				$("#selectProductNamePop").prop("disabled", true);
                $("#selectClientPop").prop("disabled", true);

			} else {
				$("#datePop").prop("disabled", false);
				$("#settlementMonthPop").prop("disabled", false);
				$("#selectStockGubunPop").prop("disabled", false);
				$("#selectKindPop").prop("disabled", false);
				$("#loftNumberPop").prop("disabled", false);
				$("#weightPop").prop("readonly", true);
				$("#bigoPop").prop("disabled", false);
				$("#pWeightPop").prop("disabled", false);
				$("#pNumberPop").prop("disabled", false);
				$("#selectProductNamePop").prop("disabled", false);
				$("#selectClientPop").prop("disabled", false);
				$('#rawStockSave').show();
				$('#rawStockDelete').show();
			}

			tempProductName = rowData.productName;
			tempClient = rowData.client;
			var settlementMonth = rowData.settlementMonth;
			if(settlementMonth != null){
				settlementMonth = rowData.settlementMonth.substring(5);
			}

			$('#rawStockModal').find('[name=eventType]').val('U').end()
			.find('#idxPop').val(rowData.idx).end()
			.find('#pricePop').val(rowData.price).end()
			.find('#productIdPop').val(rowData.productId).end()
			.find('#datePop').val(rowData.created).end()
			.find('#settlementMonthPop').val(settlementMonth).end()
			.find('#loftNumberPop').val(rowData.loftNumber).end()
			.find('#pWeightPop').val(rowData.pWeight).end()
			.find('#pNumberPop').val(rowData.pNumber).end()
			.find('#weightPop').val(rowData.weight).end()
			.find('#bigoPop').val(rowData.bigo).end()
			.find('#isCheckPop').val(rowData.isCheck).end()
			.find('#firstCreatedPop').val(rowData.firstcreatedStr).end()
			.find('#lastModifiedPop').val(rowData.lastModifiedStr).end()
			
			
			if (rowData.isCheck === 'OK' && 'bogoadmin' != '${userSession.id}') {
				$('#rawStockModal').find('#selectStockGubunPop').val(rowData.rawGubunCd).end()
				$('#rawStockModal').find('#selectKindPop').val(rowData.kind).end()
				$('#rawStockModal').find('#selectProductNamePop').val(tempProductName).end()
				$('#rawStockModal').find('#selectClientPop').val(tempClient).end()

			} else {
				$('#rawStockModal').find('#selectStockGubunPop').val(rowData.rawGubunCd).trigger('change').end()
				$('#rawStockModal').find('#selectKindPop').val(rowData.kind).trigger('change').end()

			}
			
			$('#rawStockModal').modal('show');
		}
	}
<%-- 확인값 변경 --%>
	function isCheckOk(idx) {
	
		if (!idx)
			return;
		
		if('bogo01' == '${userSession.id}'){
            alert('没有权限!!!');
            return;
        }else if(!confirm('확인하시겠습니까?')) return;

		$.ajax({
			url : '/stock/rowstock/rawStockIsCheckOkAjax',
			type : 'POST',
			data : {
				idx : idx,
				eventType : "U",
				isCheck : "OK"
			}
		}).success(function(data) {
			alert("확인처리에 성공하였습니다.");
			if(data.code == '0000'){	
				$("#"+idx).text("OK");
			}
		}).fail(function() {
			alert('확인처리에 실패했습니다');
		});
	}
</script>