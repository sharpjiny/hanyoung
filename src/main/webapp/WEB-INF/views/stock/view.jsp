<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="row-fluid">
	<!-- block -->
	<div class="block">
		<div class="navbar navbar-inner block-header">
			<div class="muted pull-left">재고입력</div>
		</div>
		<div class="block-content collapse in editForm">
			<div class="span12">
				<div class="form-horizontal view">
					<fieldset>
						
						<div class="control-group">
							<label class="control-label" for="inputError">최초 등록일</label>
							<div class="controls"><fmt:formatDate value="${stockModel.stock.created}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">수정일</label>
							<div class="controls"><fmt:formatDate value="${stockModel.stock.lastModified}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">날짜</label>
							<div class="controls">${stockModel.stock.stockDate}</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">주/야간</label>
							<div class="controls">${stockModel.stock.workTypeName}</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">구분</label>
							<div class="controls">${stockModel.stock.stockGubunName}</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">종류</label>
							<div class="controls">${stockModel.stock.kind}</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">차종</label>
							<div class="controls">${stockModel.stock.modelCar}</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">품명</label>
							<div class="controls"><span id="productName">${stockModel.stock.productName}</span></div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">L/R</label>
							<div class="controls"><span id="productName">${stockModel.stock.lhRh}</span></div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">품호</label>
							<div class="controls"><span id="productId">${stockModel.stock.vehicleId}</span></div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">고객사</label>
							<div class="controls"><span id="client">${stockModel.stock.client}</span></div>
						</div>
						<div class="control-group">
							<label class="control-label" for="inputError">수량</label>
							<div class="controls"><span id="client">${stockModel.stock.quantity2}</span></div>
						</div>
						<div class="form-actions">
			                <a href="javascript: history.back();"><button type="button" class="btn">목록</button></a>
						</div>
					</fieldset>
				</div>
			</div>
		</div>
	</div>
	<!-- /block -->
</div>