<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
 <div class="row-fluid">
    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">부자재 리스트</div>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
				<div class="alert alert-block">
					<form method="get" class="form-horizontal" action="" id="searchForm" onsubmit="return paging.submit(); return false;">
						<fieldset>
							<div class="control-group">
								<label class="control-label" for="dateStart">日期</label>
								<div class="controls">
									<input class="input-small date" name="dateStart" id="dateStart" type="text" value="${pageParam.dateStart}">
									~
									<input class="input-small date" name="dateEnd" id="dateEnd" type="text" value="${pageParam.dateEnd}">
								</div>
							</div>
							<div class="control-group">
								<label class="control-label" for="goodsGubun">종류</label>
								<div class="controls">
	                                <select id="selectGoodsGubun" name="goodsGubun" class="" title="종류">
	                                    <option value="">구분</option>
	                                    <c:forEach items="${goodsGubuns}" var="item">
		                                    <c:set var="selected" value=""/>
											<c:if test='${item.code==pageParam.goodsGubun}'><c:set var="selected" value="selected"/></c:if>
	                                        <option value="${item.code}" ${selected}>${item.name}</option>
	                                    </c:forEach>
	                                </select>
	                            </div>
							</div>
	                        <div class="control-group">
	                            <label class="control-label" for="selectUsePlace">사용처</label>
	                            <div class="controls">
	                                <select id="selectUsePlace" name="usePlace" title="사용처">
	                                    <option value="">사용처</option>
	                                    <c:forEach items="${usePlaces}" var="item">
		                                    <c:set var="selected" value=""/>
											<c:if test='${item.usePlace==pageParam.usePlace}'><c:set var="selected" value="selected"/></c:if>
	                                        <option value="${item.usePlace}" ${selected}>${item.usePlace}</option>
	                                    </c:forEach>
	                                </select>
	                            </div>
	                        </div>
							<div class="control-group">
                            <label class="control-label" for="inputError">종류</label>
                            <div class="controls">
                                <select id="selectKind" name="kind" title="종류">
                                    <option value="">종류</option>
                                    <c:forEach items="${kinds}" var="item">
	                                    <c:set var="selected" value=""/>
										<c:if test='${item.kind==pageParam.kind}'><c:set var="selected" value="selected"/></c:if>
                                        <option value="${item.kind}" ${selected}>${item.kind}</option>
                                    </c:forEach>
                                </select>
                            </div>
	                        </div>
	                        <div class="control-group">
	                            <label class="control-label" for="inputError">단위</label>
	                            <div class="controls">
	                                <select id="selectUnit" name="unit" title="단위">
	                                    <option value="">단위</option>
	                                    <c:forEach items="${unit}" var="item">
		                                    <c:set var="selected" value=""/>
											<c:if test='${item.units==pageParam.unit}'><c:set var="selected" value="selected"/></c:if>
	                                        <option value="${item.unit}" ${selected}>${item.unit}</option>
	                                    </c:forEach>
	                                </select>
	                            </div>
	                        </div>
	                        <div class="control-group">
	                            <label class="control-label" for="inputError">품명</label>
	                            <div class="controls">
	                                <select id="selectProductName" name="productName" class="selectVehicle" title="품명">
	                                    <option value="">품명</option>
	                                    <c:forEach items="${productNames}" var="item">
		                                    <c:set var="selected" value=""/>
											<c:if test='${item.product_name==pageParam.productName}'><c:set var="selected" value="selected"/></c:if>
	                                        <option value="${item.product_name}" ${selected}>${item.product_name}</option>
	                                    </c:forEach>
	                                </select>
	                            </div>
	                        </div>
	                        <div class="control-group">
	                            <label class="control-label" for="inputError">확인</label>
	                            <div class="controls">
	                                <select id="selectIsCheck" name="isCheck" class="selectVehicle" title="확인">
	                                    <option value="">확인</option>
	                                    <c:forEach items="${isCheck}" var="item">
		                                    <c:set var="selected" value=""/>
											<c:if test='${item.code==pageParam.isCheck}'><c:set var="selected" value="selected"/></c:if>
	                                        <option value="${item.code}" ${selected}>${item.name}</option>
	                                    </c:forEach>
	                                </select>
	                            </div>
	                        </div>
							<div class="control-group btn-group">
								<input type="hidden" name="pageCut" value="10"/>
								<input type="hidden" name="pageNum" value="${pageParam.pageNum}"/>
								<button type="submit" class="btn btn-primary">검색</button>
							</div>
						</fieldset>
					</form>
				</div>
				<p>
					<a href="form"><button type="button" class="btn btn-success">Add New <i class="icon-plus icon-white"></i></button></a>
					<button type="button" class="btn btn-excel btn-warning" onclick="paging.excel()">엑셀다운로드 <i class="icon-download-alt icon-white"></i></button>
				</p>
                <!-- <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered"> -->
                <table style="width:100%;" class="table-hover" >
                    <thead>
                        <tr>
                            <th>NO</th>
                            <th>일자</th>
                            <th>종류</th>
                            <th>상품명</th>
                            <th>사용처</th>
                            <th>단위</th>
                            <th>품명</th>
                            <th>아이디</th>
                            <th>합계</th>
                            <th>确认</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:choose>
						<c:when test="${!empty pagingList}">
						<c:set var="loopIndex" value="${pageParam.startNum}"/>
							<c:forEach items="${pagingList}" var="item" varStatus="loop">
					            <tr>
					                <td class="center"><span>${loopIndex+loop.count}</span></td>
					                <td class="center"><a href="form?goodsId=${item.goods_id}">${item.goods_date}</a></td>
					                <td class="center">${item.kind}</td>
					                <td class="center">${item.goods_gubun_name}</td>
					                <td class="center">${item.use_place}</td>
					                <td class="center">${item.unit}</td>
					                <td class="center">${item.product_name}</td>
					                <td class="center">${item.sub_mat_id}</td>
					                <td class="center"><fmt:formatNumber value="${item.quantity2}" pattern="#,###" /></td>
					                <td class="center">
					                <c:choose>
					                <c:when test="${item.is_check=='OK'}">${item.is_check}</c:when>
					                <c:otherwise><a href="javascript:void(0);" class="isCheckBtn" goodsId="${item.goods_id}">${item.is_check}</a></c:otherwise>
					                </c:choose>
					                </td>
					            </tr>
					        </c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td scope="col" colspan="12" class="center bin">데이터가 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
                    </tbody>
                </table>
               <c:import url="../layout/paginate.jsp"></c:import>
            </div>
        </div>
    </div>
    <!-- /block -->
</div>
<link rel="stylesheet" type="text/css" href="<c:url value='/res/css/datepicker.css'/>" media="screen"/>
<script src="<c:url value='/res/js/plugin/bootstrap-datepicker.js'/>"></script>
<script src="<c:url value='/res/js/plugin/bootstrap-datepicker.kr.js'/>"></script>
<script>
var inspectionList ={
	inspectionCheck: function(){
		var $this = $(this);
		var goodsId = $this.attr('goodsId');
		if(!goodsId) return;
		
		if('bogo01' == '${userSession.id}'){
			alert('没有权限!!!');
			return;
		}else if(!confirm('확인하시겠습니까?')) return;

		$.ajax({
			url: '/goods/goodsCheckAjax',
			type: 'POST',
			data: {goodsId: goodsId}
		}).success(function( data ) {
		    alert( data.message );
			if(data.code == '0000'){
				$this.closest('td').text('OK');
			}
		}).fail(function() {
	    	alert( '삭제에 실패했습니다' );
	    });
	},   
    
    selectKind : function(){
		var kind = $(this).val();
		inspectionList.selectSubMatInit();
		if(kind){
			$.ajax({
				url: '/subMat/selectUnitAjax',
				type: 'POST',
				data: {kind: kind}
			}).success(function( data ) {
				if(data.list){
					var $selectUnit = $('#selectUnit').find('option:not(:eq(0))').remove().end();
					$.each(data.list, function(i, item){
						$selectUnit.append($('<option/>').val(item.unit).text(item.unit));
					});
					$selectUnit.prop('disabled', false);
					$('.selectSubMat:not(#selectKind):not(#selectUnit)').prop('disabled', true).find('option[value=""]').prop('selected', true);
				}
			}).fail(function() {
		    	alert( '데이터 조회에 실패했습니다' );
				$('.selectSubMat:not(#selectKind)').prop('disabled', true).find('option:not(:eq(0))').remove();
		    });
		}else{
			$('.selectSubMat:not(#selectKind)').prop('disabled', true).find('option:not(:eq(0))').remove();
		}
	},
	
	selectUnit : function(){
		var kind = $('#selectKind').val();
		var unit = $(this).val();
		inspectionList.selectSubMatInit();
		if(kind && unit){
			$.ajax({
				url: '/subMat/selectMatProductNamesAjax',
				type: 'POST',
				data: {kind: kind, unit : unit}
			}).success(function( data ) {
				if(data.list){
					var $selectProductName = $('#selectProductName').find('option:not(:eq(0))').remove().end();
					$.each(data.list, function(i, item){
						$selectProductName.append($('<option/>').val(item.product_name).text(item.product_name));
					});
					$selectProductName.prop('disabled', false);
					//$('#selectLhRh').prop('disabled', true).find('option:not(:eq(0))').remove();
				}
			}).fail(function() {
		    	alert( '데이터 조회에 실패했습니다' );
				$('#selectProductName, #selectLhRh').prop('disabled', true).find('option:not(:eq(0))').remove();
		    });
		}else{
			$('#selectProductName, #selectLhRh').prop('disabled', true).find('option:not(:eq(0))').remove();
		}
	},

	selectProductName : function(){
        var productName = $(this).val();
        if(productName){
            $.ajax({
                url: '/subMat/selectlhRhsAjax',
                type: 'POST',
                data: {productName : productName}
            }).success(function( data ) {
                if(data.list){
                    /* var $selectLhRh = $('#selectLhRh').find('option:not(:eq(0))').remove().end();
                    $.each(data.list, function(i, item){
                        $selectLhRh.append($('<option client="'+item.client+'" vehicleId="'+item.vehicle_id+'"/>').val(item.lh_rh).text(item.lh_rh));
                    });
                    $selectLhRh.prop('disabled', false); */
                }
            })/* .fail(function() {
                alert( '데이터 조회에 실패했습니다' );
                $('#selectLhRh').prop('disabled', true).find('option:not(:eq(0))').remove();
            }) */;
        }/* else{
            $('#selectLhRh').prop('disabled', true).find('option:not(:eq(0))').remove();
        } */
    },

    selectSubMatInit: function(){
		$('#unit').text('');
		$('#subMatId').val('');
	}
}

$(function(){
	dateUtil.init();
	$('.isCheckBtn').click(inspectionList.inspectionCheck);
    $('#selectKind').change(inspectionList.selectKind);
	$('#selectUnit').change(inspectionList.selectUnit);
	$('#selectProductName').change(inspectionList.selectProductName);
});
</script>