<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="row-fluid">
	<!-- block -->
	<div class="block">
		<div class="navbar navbar-inner block-header">
			<div class="muted pull-left">검사포장입력</div>
		</div>
		<div class="block-content collapse in editForm">
			<div class="span12">
				<div class="form-horizontal view">
					<fieldset>
						<div class="control-group">
							<label class="control-label" for="inputError">최초 등록일</label>
							<div class="controls"><fmt:formatDate value="${inspectionModel.inspection.created}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">수정일</label>
							<div class="controls"><fmt:formatDate value="${inspectionModel.inspection.lastModified}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">日期</label>
							<div class="controls">${inspectionModel.inspection.inspectionDate}</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">班</label>
							<div class="controls">${inspectionModel.inspection.jabClassName}</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">白/夜班</label>
							<div class="controls">${inspectionModel.inspection.workTypeName}</div>
						</div>
						<c:forEach items="${inspectionModel.produces}" var="produce" varStatus="loop">
						<div class="vehicleItem vehicle${loop.index}" index="${loop.index}">
						<p>작업_${loop.count}</p>
						<div class="control-group">
							<label class="control-label" for="selectKind${loop.index}">종류</label>
							<div class="controls">${produce.kind}</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="selectModelCar${loop.index}">차종</label>
							<div class="controls">${produce.modelCar}</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="selectProductName${loop.index}">품명</label>
							<div class="controls">${produce.productName}</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="selectLhRh${loop.index}">L/R</label>
							<div class="controls">${produce.lhRh}</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">고유번호</label>
							<div class="controls">${produce.productId}</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">전체생산수량</label>
							<div class="controls">${produce.production}</div>
						</div>
						<div class="control-group">
						<table class="table table-bordered">
							<thead>
								<tr><th colspan="12">断裂/滑牙</th></tr>
								<tr>
									<th>实验</th>
		                            <th>发黄/发彩</th>
		                            <th>炸丝</th>
		                            <th>水丝</th>
		                            <th>发白</th>
		                            <th>滑牙</th>
		                            <th>脏斑</th>
		                            <th>划伤</th>
		                            <th>白/黑点</th>
		                            <th>断裂</th>
		                            <th>多镀</th>
		                            <th>送检</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="center">${produce.faultyA}</td>
									<td class="center">${produce.faultyB}</td>
									<td class="center">${produce.faultyC}</td>
									<td class="center">${produce.faultyD}</td>
									<td class="center">${produce.faultyE}</td>
									<td class="center">${produce.faultyF}</td>
									<td class="center">${produce.faultyG}</td>
									<td class="center">${produce.faultyH}</td>
									<td class="center">${produce.faultyI}</td>
									<td class="center">${produce.faultyJ}</td>
									<td class="center">${produce.faultyK}</td>
									<td class="center">${produce.faultyL}</td>
								</tr>
							</tbody>
			            </table>
						</div>
						</div>
						</c:forEach>
						<div class="control-group">
							<label class="control-label" for="inputError">확인일/확인자</label>
							<div class="controls"><span id="productName"><fmt:formatDate value="${inspectionModel.inspection.checkDate}" pattern="yyyy-MM-dd HH:mm:ss"/> / ${inspectionModel.inspection.checkUser}</span></div>
						</div>
						<div class="form-actions">
							<input type="hidden" value="${inspectionModel.inspection.eId}" class="key" id="eId"/>
							<%-- <input type="hidden" value="${inspectionModel.inspection.faulty}" id="faulty"/> --%>
			                <a href="javascript: history.back();"><button type="button" class="btn">목록</button></a>
			                <c:if test="${userSession.id == 'bogoadmin'}">
			                	<button type="button" class="btn btn-danger" id="inspectionDelete">삭제</button>
			                </c:if>
						</div>
					</fieldset>
				</div>
			</div>
		</div>
	</div>
	<!-- /block -->
</div>
<script>
var inspectionForm ={
	inspectionDelete: function(){
		var inspectionId = $('#eId').val();
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
	}
}
$(function(){
	$('#inspectionDelete').click(inspectionForm.inspectionDelete);
});
</script>