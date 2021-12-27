<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="row-fluid">
    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">주요부자재 리스트</div>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
				<form method="get" action="" id="searchForm" onsubmit="return paging.submit(); return false;">
	               <div class="table-toolbar">
	                  <div class="btn-group">
						<input type="hidden" name="pageCut" value="10"/>
						<input type="hidden" name="pageNum" value="${pageParam.pageNum}"/>
	                     <a href="#"><button type="button" class="btn btn-success" id="subMatAdd">Add New <i class="icon-plus icon-white"></i></button></a>
	                  </div>
	               </div>
				</form>
                <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th>NO</th>
                            <th>종류</th>
                            <th>품명</th>
                            <th>단위</th>
                            <th>사용부문</th>                            
                            <th>사진</th>
                            <th>단가</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:choose>
						<c:when test="${!empty pagingList}">
							<c:forEach items="${pagingList}" var="item" varStatus="loop">
					            <tr>
					                <td class="center"><a href="javascript: subMat.subMatEdit('${item.subMatId}');">${pageParam.startNum+loop.count}</a></td>
					                <td>${item.kind}</td>
					                <td>${item.productName}</td>
					                <td>${item.unit}</td>
					                <td>${item.usePlace}</td>
					                <td>${item.photo}</td>
					                <td><fmt:formatNumber value="${item.price}" type="pattern" pattern="0.0000" /></td>
					            </tr>
					        </c:forEach>
						</c:when>
						<c:otherwise>
							<tr class="bin">
								<td scope="col" colspan="9" class="center bin">데이터가 없습니다.</td>
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
<div class="modal fade modal-min hide" id="subMatModal" tabindex="-1" role="dialog" aria-labelledby="subMatModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">주요부자재 입력</h4>
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
	           <label class="col-sm-2 control-label" for="unit">단위</label>
	           <div class="controls">
	             <input class="input-xlarge focused" id="unit" name="unit" type="text" title="단위" placeholder="단위">
	           </div>
	         </div>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="usePlace">사용부문</label>
	           <div class="controls">
	             <input class="input-xlarge focused skip" id="usePlace" name="usePlace" type="text" title="사용처" placeholder="사용처">
	           </div>
	         </div>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="photo">사진</label>
	           <div class="controls">
	             <input class="input-xlarge focused" id="photo" name="photo" type="text" title="入库社" placeholder="사진">
	           </div>
	         </div>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="price">단가</label>
	           <div class="controls">
	             <input class="input-xlarge focused skip" id="price" name="price" type="number" title="单价" placeholder="단가" validate="number">
	           </div>
	         </div>
	       </fieldset>
			<input type="hidden" name="eventType" value=""/>
			<input type="hidden" name="subMatId" value=""/>
	     </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn btn-info" id="subMatDelete">Save Delete</button>
        <button type="button" class="btn btn-primary" id="subMatSave">Save changes</button>
      </div>
    </div>
  </div>
</div>
<script>
var subMat ={
	subMatSave : function(){
		// 유효성 체크
		if(!$("#submitForm").validation()){
			return false;
		}
		$.ajax({
			url: '/set/subMatSaveAjax',
			type: 'POST',
			data: $("#submitForm :input[value!='']").serialize()
		}).success(function( data ) {
		    alert( data.message );
			if(data.code == '0000'){
				location.reload();
			}
		}).fail(function() {
	    	alert( '등록을 실패했습니다' );
	    });
	},

	subMatAdd: function(){
		$('#subMatDelete').hide();
		$('#subMatModal')
			.find('input:text, [type=number], [type=hidden]').val('').end()
			.find('[name=eventType]').val('C').end()
			.find('#subMatId').val('').prop('readonly', false).end()
			.modal('show');
	},

	subMatEdit: function(subMatId){
		if(!subMatId) return;

		$.ajax({
			url: '/set/getSubMatAjax',
			type: 'POST',
			data: {subMatId: subMatId }
		}).success(function( data ) {
			if(data.subMat){
				$('#subMatDelete').show();
				$('#subMatModal')
					.find('[name=subMatId]').val(subMatId).prop('readonly', true).end()
					.find('#kind').val(data.subMat.kind).end()
					.find('#unit').val(data.subMat.unit).end()
					.find('#productName').val(data.subMat.productName).end()
					.find('#usePlace').val(data.subMat.usePlace).end()
					.find('#price').val(data.subMat.price).end()
					.find('#photo').val(data.subMat.photo).end()
					.find('[name=eventType]').val('U').end()
					.modal('show');
			}else{
		    	alert( '조회에 실패했습니다' );
			}
		}).fail(function() {
	    	alert( '조회에 실패했습니다' );
	    });
	},

	subMatDelete: function(){
		var subMatId = $('#subMatModal').find('[name=subMatId]').val();
		if(!subMatId) return;
		if(!confirm('삭제하시겠습니까?')) return;

		$.ajax({
			url: '/set/subMatDelAjax',
			type: 'POST',
			data: {subMatId: subMatId}
		}).success(function( data ) {
		    alert( data.message );
			if(data.code == '0000'){
				location.reload();
			}
		}).fail(function() {
	    	alert( '삭제에 실패했습니다' );
	    });
	}
}
$(function(){
	$('#subMatAdd').click(subMat.subMatAdd);
	$('#subMatSave').click(subMat.subMatSave);
	$('#subMatDelete').click(subMat.subMatDelete);
});
</script>