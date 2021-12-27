﻿<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="row-fluid">
	<!-- block -->
	<div class="block">
		<div class="navbar navbar-inner block-header">
			<div class="muted pull-left">사출입력</div>
		</div>
		<div class="block-content collapse in editForm">
			<div class="span12">
				<div class="form-horizontal view">
					<fieldset>
						<div class="control-group">
							<label class="control-label" for="inputError">최초 등록일</label>
							<div class="controls"><fmt:formatDate value="${ejectionModel.ejection.created}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">수정일</label>
							<div class="controls"><fmt:formatDate value="${ejectionModel.ejection.lastModified}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">날짜</label>
							<div class="controls">${ejectionModel.ejection.ejectionDate}</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">주/야간</label>
							<div class="controls">${ejectionModel.ejection.workTypeName}</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">반</label>
							<div class="controls">${ejectionModel.ejection.ejectionGroupName}</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">사출호기</label>
							<div class="controls">${ejectionModel.ejection.ejectionName}</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">시작시간</label>
							<div class="controls">${ejectionModel.ejection.startTime}</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">종료시간</label>
							<div class="controls">${ejectionModel.ejection.endTime}</div>
						</div>
						<%--
						<div class="control-group">
							<label class="control-label" for="inputError">사이클타임</label>
							<div class="controls">${ejectionModel.ejection.cycleTime}</div>
						</div>
						<div class="control-group">
						<table class="table table-bordered" style="width: 400px">
							<tbody>
								<tr><th rowspan="3" class="center">중량(g)</th>
									<th class="center">초</th>
									<td class="center">${ejectionModel.ejection.weight1}</td>
								</tr>
								<tr>
									<th class="center">중</th>
									<td class="center">${ejectionModel.ejection.weight2}</td>
								</tr>
								<tr>
									<th class="center">고</th>
									<td class="center">${ejectionModel.ejection.weight3}</td>
								</tr>
							</tbody>
			            </table>
						</div> 
					    --%>
						<div class="control-group">
							<label class="control-label" for="inputError">원재료종류</label>
							<div class="controls">${ejectionModel.ejection.rawKind}</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">원재료품명</label>
							<div class="controls">${ejectionModel.ejection.rawProductName}</div>
						</div>
						<c:forEach items="${ejectionModel.produces}" var="produce" varStatus="loop">
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
							<label class="control-label" for="inputError">고객사</label>
							<div class="controls">${produce.client}</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">전체생산수량</label>
							<div class="controls">${produce.production}</div>
						</div>
						<div class="control-group">
						<table class="table table-bordered">
							<thead>
								<tr><th colspan="11">불량유형</th></tr>
								<tr>
									<th>开机不良</th>
		                            <th>调机不良</th>
		                            <th>未成形</th>
		                            <th>银丝</th>
		                            <th>气泡</th>
		                            <th>擦模</th>
		                            <th>黑点</th>
		                            <th>杂料</th>
		                            <th>油斑/气斑</th>
                                    <th>断裂</th>
                                    <th>脏斑</th>
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
								</tr>
							</tbody>
			            </table>
						</div>
						</div>
						</c:forEach>
						<div class="control-group">
							<label class="control-label" for="inputError">확인일/확인자</label>
							<div class="controls"><span id="productName"><fmt:formatDate value="${ejectionModel.ejection.checkDate}" pattern="yyyy-MM-dd HH:mm:ss"/> / ${ejectionModel.ejection.checkUser}</span></div>
						</div>
						<div class="form-actions">
							<input type="hidden" value="${ejectionModel.ejection.eId}" class="key" id="eId"/>
			                <a href="javascript: history.back();"><button type="button" class="btn">목록</button></a>
			                <c:if test="${userSession.id == 'bogoadmin'}">
			                <button type="button" class="btn btn-danger" id="ejectionDelete">삭제</button>
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
var ejectionForm ={
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
	}
}
$(function(){
	$('#ejectionDelete').click(ejectionForm.ejectionDelete);
});
</script>