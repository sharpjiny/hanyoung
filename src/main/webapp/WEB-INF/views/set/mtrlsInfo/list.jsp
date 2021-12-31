<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="row-fluid">
    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">원부자재 기준정보 리스트</div>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
				<form method="get" action="" id="searchForm" onsubmit="return paging.submit(); return false;">
	               <div class="table-toolbar">
	                  <div class="btn-group">
						<input type="hidden" name="pageCut" value="10"/>
						<input type="hidden" name="pageNum" value="${pageParam.pageNum}"/>
	                     <a href="#"><button type="button" class="btn btn-success" id="vehicleAdd">Add New <i class="icon-plus icon-white"></i></button></a>
	                  </div>
	               </div>
				</form>
                <table style="width:100%;" class="table-hover" >
                    <thead>
                        <tr>
                            <th>NO</th>
                            <!-- <th>상태</th> -->
                            <th>种类</th>
                            <th>入库社</th>
                            <th>車种</th>
                            <th>品名</th>
                            <th>L/R</th>
                            <th>BOGO品號</th>
                            <th>品號</th>
                            <th>제품번호</th>
                            <th>중량</th>
                            <th>게이트중량</th>
                            <th>BOM C/T</th>                          
                            <th>원재료종류</th>                          
                            <th>원재료품명</th>
                            <th>单价</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:choose>
						<c:when test="${!empty pagingList}">
							<c:forEach items="${pagingList}" var="item" varStatus="loop">
					            <tr>
					                <td class="center"><a href="javascript: vehicle.vehicleEdit('${item.vehicleId}');">${pageParam.startNum+loop.count}</a></td>
					                <%-- <td>${item.status}</td> --%>
					                <td>${item.kind}</td>
					                <td>${item.client}</td>
					                <td>${item.modelCar}</td>
					                <td>${item.productName}</td>
					                <td class="center">${item.lhRh}</td>
					                <td>${item.vehicleId}</td>
					                <td>${item.productId}</td>
					                <td>${item.productNo}</td>
					                <td>${item.weight}</td>
					                <td>${item.gateWeight}</td>
					                <td>${item.bom}</td>
					                <td>${item.rawKind}</td>
					                <td>${item.rawProductName}</td>
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
            </div>
        </div>
    </div>
    <!-- /block -->
</div>
<div class="modal fade modal-min hide" id="vehicleModal" tabindex="-1" role="dialog" aria-labelledby="vehicleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">차종품명품호 입력</h4>
      </div>
      <div class="modal-body">
	      <form id="submitForm" class="form-horizontal" onsubmit="return false;">
	       <fieldset>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="kind">种类</label>
	           <div class="controls">
	             <input class="input-xlarge focused" id="kind" name="kind" type="text" title="种类" placeholder="种类">
	           </div>
	         </div>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="modelCar">車种</label>
	           <div class="controls">
	             <input class="input-xlarge focused" id="modelCar" name="modelCar" type="text" title="車种" placeholder="車种">
	           </div>
	         </div>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="productName">品名</label>
	           <div class="controls">
	             <input class="input-xlarge focused" id="productName" name="productName" type="text" title="品名" placeholder="品名">
	           </div>
	         </div>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="focusedInput">L/R</label>
	           <div class="controls">
	           <c:forEach items="${gubunLhRh}" var="item">
	           	<label class="radio inline" for="lhRh_${item.code}">
				  <input type="radio" name="lhRh" id="lhRh_${item.code}" value="${item.code}" checked="checked"> ${item.name}
				</label>
	           </c:forEach>
	           </div>
	         </div>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="vehicleId" >BOGO品號</label>
	           <div class="controls">
	             <input class="input-xlarge focused" id="vehicleId" name="vehicleId" type="text" title="BOGO品號" placeholder="BOGO品號">
	           </div>
	         </div>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="productId">品號</label>
	           <div class="controls">
	             <input class="input-xlarge focused skip" id="productId" name="productId" type="text" title="品號" placeholder="品號">
	           </div>
	         </div>
	         <div class="control-group">
               <label class="col-sm-2 control-label" for="productNo">제품번호</label>
               <div class="controls">
                 <input class="input-xlarge focused skip" id="productNo" name="productNo" type="text" title="제품번호" placeholder="제품번호">
               </div>
             </div>
             <div class="control-group">
               <label class="col-sm-2 control-label" for="weight">중량</label>
               <div class="controls">
                 <input class="input-xlarge focused skip" id="weight" name="weight" type="text" type="number" title="중량" placeholder="중량">
               </div>
             </div>
             <div class="control-group">
               <label class="col-sm-2 control-label" for="gateWeight">게이트중량</label>
               <div class="controls">
                 <input class="input-xlarge focused skip" id="gateWeight" name="gateWeight" type="text" type="number" title="게이트중량" placeholder="게이트중량">
               </div>
             </div>
             <div class="control-group">
               <label class="col-sm-2 control-label" for="bom">BOM C/T</label>
               <div class="controls">
                 <input class="input-xlarge focused skip" id="bom" name="bom" type="text" title="BOM C/T" placeholder="BOM C/T">
               </div>
             </div>
             <div class="control-group">
                <label class="control-label" for="inputError">种类</label>
                <div class="controls">
                    <select id="selectKindPop" name="rawKind" class="selectRawStockPop skip"
                        title="종류">
                        <option value="">全部</option>
                        <c:forEach items="${kinds}" var="item">
                            <option value="${item.vehicleId}">${item.kind}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="inputError">品名</label>
                <div class="controls ">
                    <select id="selectProductNamePop" name="rawId"
                        class="selectRawStockPop skip" title="품명">
                        <option value="">全部</option>
                        <c:forEach items="${productNames}" var="item">
                            <option value="${item.code}">${item.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="client">入库社</label>
	           <div class="controls">
	             <input class="input-xlarge focused" id="client" name="client" type="text" title="入库社" placeholder="入库社">
	           </div>
	         </div>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="price">单价</label>
	           <div class="controls">
	             <input class="input-xlarge focused skip" id="price" name="price" type="number" title="单价" placeholder="单价" validate="number">
	           </div>
	         </div>
	         <div class="control-group">
                <label class="control-label" for="inputError">상태</label>
                <div class="controls ">
                    <select id="status" name="status"  class="skip"  title="상태">
                        <option value="">선택</option>
                        <option value="量产">量产</option>
                        <option value="AS">AS</option>
                    </select>
                </div>
            </div>	         
	       </fieldset>
			<input type="hidden" name="eventType" value=""/>
	     </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn btn-info" id="vehicleDelete">Save Delete</button>
        <button type="button" class="btn btn-primary" id="vehicleSave">Save changes</button>
      </div>
    </div>
  </div>
</div>
<script>
var vehicle ={
	vehicleSave : function(){
		// 유효성 체크
		if(!$("#submitForm").validation()){
			return false;
		}

		$.ajax({
			url: '/set/vehicleSaveAjax',
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

	vehicleAdd: function(){
		$('#vehicleDelete').hide();
		$('#vehicleModal')
			.find('input:text, [type=number], [type=hidden]').val('').end()
			.find('[name=eventType]').val('C').end()
			.find('#vehicleId').val('').prop('readonly', false).end()
			.find('[name=lhRh]:eq(0)').prop('checked', true).end()
			.modal('show');
	},

	vehicleEdit: function(vehicleId){
		if(!vehicleId) return;
		$.ajax({
			url: '/set/getVehicleAjax',
			type: 'POST',
			data: {vehicleId: vehicleId }
		}).success(function( data ) {
			if(data.vehicle){
				$('#vehicleDelete').show();
				var rawKind = data.vehicle.rawKind;
				var rawId = data.vehicle.rawId;
				$.each($('#vehicleModal').find('#selectKindPop option'), function(i, item) {
					if(item.text == rawKind){
						item.setAttribute("selected", "selected");
					}
                   // $selectKindPop.append($('<option/>').val(item.code).text(item.name));
                });
				$.each($('#vehicleModal').find('#selectProductNamePop option'), function(i, item) {
                    if(item.value == rawId){
                        item.setAttribute("selected", "selected");
                    }
                   // $selectKindPop.append($('<option/>').val(item.code).text(item.name));
                });
				$('#vehicleModal')
					.find('#vehicleId').val(vehicleId).prop('readonly', true).end()
					.find('#kind').val(data.vehicle.kind).end()
					.find('#modelCar').val(data.vehicle.modelCar).end()
					.find('#productName').val(data.vehicle.productName).end()
					.find('#client').val(data.vehicle.client).end()
					.find('#price').val(data.vehicle.price).end()
					.find('#productId').val(data.vehicle.productId).end()
					.find('#productNo').val(data.vehicle.productNo).end()
					.find('#weight').val(data.vehicle.weight).end()
					.find('#gateWeight').val(data.vehicle.gateWeight).end()
					.find('#bom').val(data.vehicle.bom).end()
					.find('#status').val(data.vehicle.status).end()
                    
					//.find('#selectKindPop').val(data.vehicle.rawKind).end()
					//.find('#selectProductNamePop').val(data.vehicle.rawProductName).end()
					
					.find('[name=lhRh][value="'+data.vehicle.lhRh+'"]').prop('checked', true).end()
					.find('[name=eventType]').val('U').end()
					
					.modal('show');
			}else{
		    	alert( '조회에 실패했습니다' );
			}
		}).fail(function() {
	    	alert( '조회에 실패했습니다' );
	    });
	},

	vehicleDelete: function(){
		var vehicleId = $('#vehicleId').val();
		if(!vehicleId) return;
		if(!confirm('삭제하시겠습니까?')) return;

		$.ajax({
			url: '/set/vehicleDelAjax',
			type: 'POST',
			data: {vehicleId: vehicleId}
		}).success(function( data ) {
		    alert( data.message );
			if(data.code == '0000'){
				//paging.init();
				location.reload();
			}
		}).fail(function() {
	    	alert( '삭제에 실패했습니다' );
	    });
	}
}

$(function(){
	$('#vehicleAdd').click(vehicle.vehicleAdd);
	$('#vehicleSave').click(vehicle.vehicleSave);
	$('#vehicleDelete').click(vehicle.vehicleDelete);
	
	
	<%-- 팝업 - 종류 셀렉트 변경 --%>
    $('#selectKindPop').change(function() {
        var kind = $(this).find('option:selected').text();

        if (kind) {
            $.ajax({
                url : '/set/rawStock/getComboRawStocksAjax',
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

                            /* if (tempProductName != "") {
                                $('#rawStockModal').find('#selectProductNamePop').val(tempProductName).trigger('change');
                                tempProductName = "";
                            } */
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
    
});
</script>