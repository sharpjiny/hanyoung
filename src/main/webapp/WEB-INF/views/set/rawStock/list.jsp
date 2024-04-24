<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="row-fluid">
    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">설정 > 원부자재 info.</div>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
				<form method="get" action="" id="searchForm" onsubmit="return paging.submit(); return false;">
	               <div class="table-toolbar">
	                  <div class="btn-group">
						<input type="hidden" name="pageCut" value="100"/>
						<input type="hidden" name="pageNum" value="${pageParam.pageNum}"/>
	                     <a href="#"><button type="button" class="btn btn-success" id="rawStockAdd">Add New <i class="icon-plus icon-white"></i></button></a>
	                  </div>
	               </div>
				</form>
                <!-- <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered"> -->
                <table style="width:100%;" class="table-hover" >
                    <thead>
                        <tr>
                            <th>NO</th>
                            <th>종류</th>
                            <th>품명</th>
                            <th>고객사</th>
                            <th>단가</th>
                            <th>비고</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:choose>
						<c:when test="${!empty pagingList}">
							<c:forEach items="${pagingList}" var="item" varStatus="loop">
					            <tr>
					                <td class="center"><a href="javascript: rawStock.rawStockEdit('${item.rawId}');">${pageParam.startNum+loop.count}</a></td>
					                <td>${item.kind}</td>
					                <td>${item.productName}</td>
					                <td>${item.client}</td>
					                <%-- <td><fmt:formatNumber value="${item.price}" type="pattern" pattern="0.0000" /></td> --%>
					                <c:choose>
					                   <c:when test="${item.price != 0}">
					                   <td>${item.price}</td>
					                   </c:when>
					                   <c:otherwise>
					                   <td><fmt:formatNumber value="${item.price}" type="pattern" pattern="0" /></td>
					                   </c:otherwise>
					                </c:choose>
					                
					                <td>${item.productId}</td>
					            </tr>
					        </c:forEach>
						</c:when>
						<c:otherwise>
							<tr class="bin">
								<td scope="col" colspan="7" class="center bin">데이터가 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
                    </tbody>
                </table>
<%--                 <c:import url="../layout/paginate.jsp"></c:import> --%>
            </div>
        </div>
    </div>
    <!-- /block -->
</div>
<div class="modal fade modal-min hide" id="rawStockModal" tabindex="-1" role="dialog" aria-labelledby="rawStockModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">원재료 입력</h4>
      </div>
      <div class="modal-body">
	      <form id="submitForm" class="form-horizontal" onsubmit="return false;">
	       <fieldset>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="kind">종류</label>
	           <div class="controls">
	             <input class="input-xlarge focused" id="kind" name="kind" type="text" title="종류" placeholder="종류">
	           </div>
	         </div>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="productName">품명</label>
	           <div class="controls">
	             <input class="input-xlarge focused" id="productName" name="productName" type="text" title="품명" placeholder="품명">
	           </div>
	         </div>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="client">고객사</label>
	           <div class="controls">
	             <input class="input-xlarge focused" id="client" name="client" type="text" title="고객사" placeholder="고객사">
	           </div>
	         </div>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="price">단가</label>
	           <div class="controls">
	             <input class="input-xlarge focused" id="price" name="price" type="number" title="단가" placeholder="단가" validate="number">
	           </div>
	         </div>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="productId">비고</label>
	           <div class="controls">
	             <input class="input-xlarge focused skip" id="productId" name="productId" type="text" title="비고" placeholder="비고">
	           </div>
	         </div>
	       </fieldset>
			<input type="hidden" name="eventType" value=""/>
			<input type="hidden" class="input-xlarge focused" id="rawId" name="rawId" title="품호" placeholder="품호">
	     </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn btn-info" id="rawStockDelete">Save Delete</button>
        <button type="button" class="btn btn-primary" id="rawStockSave">Save changes</button>
      </div>
    </div>
  </div>
</div>
<script>
var rawStock ={
	rawStockSave : function(){
		// 유효성 체크
		if(!$("#submitForm").validation()){
			return false;
		}

		$.ajax({
			url: '/set/rawStockSaveAjax',
			type: 'POST',
			data: $("#submitForm").serialize()
		}).success(function( data ) {
		    alert( data.message );
			if(data.code == '0000'){
				location.reload();
			}
		}).fail(function() {
	    	alert( '등록을 실패했습니다' );
	    });
	},

	rawStockAdd: function(){
		$('#rawStockDelete').hide();
		$('#rawStockModal')
			.find('input:text, [type=number], [type=hidden]').val('').end()
			.find('[name=eventType]').val('C').end()
			.find('#rawId').val('').prop('readonly', false).end()
			.modal('show');
	},

	rawStockEdit: function(rawId){
		if(!rawId) return;

		$.ajax({
			url: '/set/getRawStockAjax',
			type: 'POST',
			data: {rawId: rawId }
		}).success(function( data ) {
			if(data.rawStock){
				$('#rawStockDelete').show();
				$('#rawStockModal')
					.find('#rawId').val(rawId).prop('readonly', true).end()
					.find('#kind').val(data.rawStock.kind).end()
					.find('#productName').val(data.rawStock.productName).end()
					.find('#client').val(data.rawStock.client).end()
					.find('#price').val(data.rawStock.price).end()
					.find('#productId').val(data.rawStock.productId).end()
					.find('[name=eventType]').val('U').end()
					.modal('show');
			}else{
		    	alert( '조회에 실패했습니다' );
			}
		}).fail(function() {
	    	alert( '조회에 실패했습니다' );
	    });
	},

	rawStockDelete: function(){
		var rawId = $('#rawId').val();
		if(!rawId) return;
		if(!confirm('삭제하시겠습니까?')) return;

		$.ajax({
			url: '/set/rawStockDelAjax',
			type: 'POST',
			data: {rawId: rawId}
		}).success(function( data ) {
		    alert( data.message );
			if(data.code == '0000'){
				paging.init();
			}
		}).fail(function() {
	    	alert( '삭제에 실패했습니다' );
	    });
	}
}
$(function(){
	$('#rawStockAdd').click(rawStock.rawStockAdd);
	$('#rawStockSave').click(rawStock.rawStockSave);
	$('#rawStockDelete').click(rawStock.rawStockDelete);
});
</script>