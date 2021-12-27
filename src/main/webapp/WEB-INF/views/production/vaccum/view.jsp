<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="row-fluid">
	<!-- block -->
	<div class="block">
		<div class="navbar navbar-inner block-header">
			<div class="muted pull-left">증착입력</div>
		</div>
		<div class="block-content collapse in editForm">
			<div class="span12">
				<div class="form-horizontal view">
					<fieldset>
						<div class="control-group">
							<label class="control-label" for="inputError">최초 등록일</label>
							<div class="controls"><fmt:formatDate value="${vaccumModel.vaccum.created}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">수정일</label>
							<div class="controls"><fmt:formatDate value="${vaccumModel.vaccum.lastModified}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">날짜</label>
							<div class="controls">${vaccumModel.vaccum.vaccumDate}</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">주/야간</label>
							<div class="controls">${vaccumModel.vaccum.workTypeName}</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">반</label>
							<div class="controls">${vaccumModel.vaccum.vaccumGroupName}</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">증착호기</label>
							<div class="controls">${vaccumModel.vaccum.vaccumName}</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">시작시간</label>
							<div class="controls">${vaccumModel.vaccum.startTime}</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">종료시간</label>
							<div class="controls">${vaccumModel.vaccum.endTime}</div>
						</div>
						<div class="control-group">
                            <label class="control-label" for="inputError">텅스텐사용량</label>
                            <div class="controls">${vaccumModel.vaccum.tuncUsed}</div>
                        </div>
						<c:forEach items="${vaccumModel.produces}" var="produce" varStatus="loop">
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
							<label class="control-label" for="inputError">생산수량</label>
							<div class="controls">${produce.production}</div>
						</div>
						<div class="control-group">
                            <label class="control-label" for="inputError">고유번호</label>
                            <div class="controls">${produce.productId}</div>
                        </div>
						</div>
						</c:forEach>
						<div class="control-group">
							<label class="control-label" for="inputError">확인일/확인자</label>
							<div class="controls"><span id="productName"><fmt:formatDate value="${vaccumModel.vaccum.checkDate}" pattern="yyyy-MM-dd HH:mm:ss"/> / ${vaccumModel.vaccum.checkUser}</span></div>
						</div>
						<div class="form-actions">
							<input type="hidden" value="${vaccumModel.vaccum.eId}" class="key" id="eId"/>
			                <a href="javascript: history.back();"><button type="button" class="btn">목록</button></a>
<!-- 							<button type="button" class="btn btn-danger" id="vaccumDelete">삭제</button> -->
						</div>
					</fieldset>
				</div>
			</div>
		</div>
	</div>
	<!-- /block -->
</div>
<script>
var vaccumForm ={
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
	}
}
$(function(){
	$('#vaccumDelete').click(vaccumForm.vaccumDelete);
});
</script>