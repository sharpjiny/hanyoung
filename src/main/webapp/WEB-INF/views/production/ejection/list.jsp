<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
 <div class="row-fluid">
    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">注塑</div>
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
								<label class="control-label" for="workType0">白/夜班</label>
								<div class="controls">
								<label for="workType" class="radio inline"><input type="radio" name="workType" value="" id="workType" <c:if test='${pageParam.workType == null || pageParam.workType == ""}'>checked="true"</c:if>/>全部</label>
								<c:forEach items="${workTypes}" var="item">
								<label for="workType${item.code}" class="radio inline"><input type="radio" name="workType" value="${item.code}" id="workType${item.code}" <c:if test='${item.code==pageParam.workType}'>checked="true"</c:if> />${item.name}</label>
								</c:forEach>
								</div>
							</div>
							<div class="control-group">
	                            <label class="control-label" for="inputError">班</label>
	                            <div class="controls">
	                                <select id="selectGroup" name="ejectionGroup" class="" title="班">
	                                    <option value="">班</option>
	                                    <c:forEach items="${ejectionGroups}" var="item">
		                                    <c:set var="selected" value=""/>
											<c:if test='${item.code==pageParam.ejectionGroup}'><c:set var="selected" value="selected"/></c:if>
	                                        <option value="${item.code}" ${selected}>${item.name}</option>
	                                    </c:forEach>
	                                </select>
	                            </div>
	                        </div>
							<div class="control-group">
	                            <label class="control-label" for="inputError">注塑机号</label>
	                            <div class="controls">
	                                <select id="selectEjection" name="ejection" class="" title="注塑机号">
	                                    <option value="">注塑机号</option>
	                                    <c:forEach items="${ejections}" var="item">
		                                    <c:set var="selected" value=""/>
											<c:if test='${item.code==pageParam.ejection}'><c:set var="selected" value="selected"/></c:if>
	                                        <option value="${item.code}" ${selected}>${item.name}</option>
	                                    </c:forEach>
	                                </select>
	                            </div>
	                        </div>
							<div class="control-group">
	                            <label class="control-label" for="inputError">种类</label>
	                            <div class="controls">
	                                <select id="selectKind" name="kind" class="selectVehicle" title="种类">
	                                    <option value="">种类</option>
	                                    <c:forEach items="${kinds}" var="item">
		                                    <c:set var="selected" value=""/>
											<c:if test='${item.kind==pageParam.kind}'><c:set var="selected" value="selected"/></c:if>
	                                        <option value="${item.kind}" ${selected}>${item.kind}</option>
	                                    </c:forEach>
	                                </select>
	                            </div>
	                        </div>
	                        <div class="control-group">
	                            <label class="control-label" for="inputError">車种</label>
	                            <div class="controls">
	                                <select id="selectModelCar" name="modelCar" class="selectVehicle" title="車种">
	                                    <option value="">車种</option>
	                                    <c:forEach items="${modelCars}" var="item">
		                                    <c:set var="selected" value=""/>
											<c:if test='${item.model_car==pageParam.modelCar}'><c:set var="selected" value="selected"/></c:if>
	                                        <option value="${item.model_car}" ${selected}>${item.model_car}</option>
	                                    </c:forEach>
	                                </select>
	                            </div>
	                        </div>
	                        <div class="control-group">
	                            <label class="control-label" for="inputError">品名</label>
	                            <div class="controls">
	                                <select id="selectProductName" name="productName" class="selectVehicle" title="品名">
	                                    <option value="">品名</option>
	                                    <c:forEach items="${productNames}" var="item">
		                                    <c:set var="selected" value=""/>
											<c:if test='${item.product_name==pageParam.productName}'><c:set var="selected" value="selected"/></c:if>
	                                        <option value="${item.product_name}" ${selected}>${item.product_name}</option>
	                                    </c:forEach>
	                                </select>
	                            </div>
	                        </div>
	                        <div class="control-group">
	                            <label class="control-label" for="inputError">L/R</label>
	                            <div class="controls">
	                                <select id="selectLhRh" name="lhRh" class="selectVehicle" title="L/R">
	                                    <option value="">L/R</option>
	                                    <c:forEach items="${lhRhs}" var="item">
		                                    <c:set var="selected" value=""/>
											<c:if test='${item.lh_rh==pageParam.lhRh}'><c:set var="selected" value="selected"/></c:if>
	                                        <option value="${item.lh_rh}" ${selected}>${item.lh_rh}</option>
	                                    </c:forEach>
	                                </select>
	                            </div>
	                        </div>
	                        <%-- <div class="control-group">
	                            <label class="control-label" for="inputError">원재료</label>
	                            <div class="controls">
	                                <select id="selectRawStock" name="rawId" class="selectVehicle" title="원재료">
	                                    <option value="">원재료</option>
	                                    <c:forEach items="${rawStocks}" var="item">
		                                    <c:set var="selected" value=""/>
											<c:if test='${item.raw_id==pageParam.rawId}'><c:set var="selected" value="selected"/></c:if>
	                                        <option value="${item.raw_id}" ${selected}>${item.raw_product_name}</option>
	                                    </c:forEach>
	                                </select>
	                            </div>
	                        </div> --%>
							<div class="control-group btn-group">
								<input type="hidden" name="pageCut" value="10"/>
								<input type="hidden" name="pageNum" value="${pageParam.pageNum}"/>
								<button type="submit" class="btn btn-primary">Search</button>
							</div>
						</fieldset>
					</form>
				</div>
				<p>
					<a href="form"><button type="button" class="btn btn-success">Add New <i class="icon-plus icon-white"></i></button></a>
				</p>
				<div class="tableScroll">
				<!-- <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered"> -->
                <!-- <table cellpadding="3" border="1" style="border-color:#ddd; width:100%;" class="table-hover table-striped"> -->
                <table style="width:100%;" class="table-hover" >
                    <thead>
                        <tr>
                            <th rowspan="2">NO</th>
                            <th rowspan="2">日期</th>
                            <th rowspan="2">白班<br>/<br>夜班</th>
                            <th rowspan="2">班</th>
                            <th rowspan="2">注塑<br>机号</th>
                            <th rowspan="2">开始<br>时间</th>
                            <th rowspan="2">结束<br>时间</th>
                            <th rowspan="2">工作<br>时间</th>
                            <th rowspan="2">种类</th>
                            <th rowspan="2">车种</th>
                            <th rowspan="2">品名</th>
                            <th rowspan="2">L/R</th>
                            <th rowspan="2">品号</th>
                            <!-- <th rowspan="2">원재료종류</th>
                            <th rowspan="2">원재료명</th> -->
                            <th rowspan="2">生产<br>数量</th>
                            <th rowspan="2">良品<br>数量</th>
                            <th rowspan="2">不良<br>数量</th>
                            <th rowspan="2">不<br>良<br>率</th>
                            <th colspan="11">不良类型</th>
                            <th rowspan="2">确认</th>
                        </tr>
                        <tr>
                        	<th>开机<br>不良</th>
                        	<th>调机<br>不良</th>
                        	<th>未<br>成形</th>
                        	<th>银丝</th>
                        	<th>气泡</th>
                        	<th>擦模</th>
                        	<th>黑点</th>
                        	<th>杂料</th>
                        	<th>油斑<br>/<br>气斑</th>
                        	<th>断裂</th>
                        	<th>脏斑</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:choose>
						<c:when test="${!empty pagingList}">
						<c:set var="loopIndex" value="${pageParam.startNum}"/>
							<c:set var="prevCode" value=""/>
							<c:forEach items="${pagingList}" var="item" varStatus="loop">
					            <tr>
					                <td class="center"><span>${loopIndex+loop.count}</span></td>
									<c:if test="${prevCode!=item.e_id}">
					                <td rowspan="${item.cnt}" style="vertical-align: middle; text-align: center">
					                <c:choose>
                                    <c:when test="${userSession.id == 'bogoadmin'}">
                                    <a href="form?eId=${item.e_id}">${item.ejection_date}</a>
                                    </c:when>
                                    <c:otherwise>
                                    ${item.ejection_date}
                                    </c:otherwise>
                                    </c:choose>
					                </td>
					                <td rowspan="${item.cnt}" style="vertical-align: middle; text-align: center">${item.work_type_name}</td>
					                <td rowspan="${item.cnt}" style="vertical-align: middle; text-align: center">${item.ejection_group_name}</td>
					                <td rowspan="${item.cnt}" style="vertical-align: middle; text-align: center">${item.ejection_name}</td>
					                <td rowspan="${item.cnt}" style="vertical-align: middle; text-align: center">${item.start_time}</td>
					                <td rowspan="${item.cnt}" style="vertical-align: middle; text-align: center">${item.end_time}</td>
					                <td rowspan="${item.cnt}" style="vertical-align: middle; text-align: center">${item.d_time}</td>
						            </c:if>
					                <td>${item.kind}</td>
					                <td>${item.model_car}</td>
					                <td>${item.product_name}</td>
					                <td class="center">${item.lh_rh}</td>
					                <td>${item.product_id}</td>
									<%-- <td>${item.raw_kind}</td>
					                <td>${item.raw_product_name}</td> --%>
					                <td class="center"><fmt:formatNumber value="${item.production}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.complete}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.faulty}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.defect_rate}" pattern="#.##"/>%</td>
					                <td class="center"><fmt:formatNumber value="${item.faulty_a}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.faulty_b}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.faulty_c}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.faulty_d}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.faulty_e}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.faulty_f}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.faulty_g}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.faulty_h}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.faulty_i}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.faulty_j}" pattern="#,###" /></td>
					                <td class="center"><fmt:formatNumber value="${item.faulty_k}" pattern="#,###" /></td>
					                <c:choose>
									<c:when test="${prevCode!=item.e_id}">
					                <td rowspan="${item.cnt}" style="vertical-align: middle" class="center">
										<c:choose>
							                <c:when test="${item.is_check=='OK'}">${item.is_check}</c:when>
							                <c:otherwise><a href="javascript:void();" class="isCheckBtn" eId="${item.e_id}">${item.is_check}</a></c:otherwise>
						                </c:choose>
					                </td>
						            </c:when>
									</c:choose>
					            </tr>
					            <c:set var="prevCode" value="${item.e_id}"/>
					        </c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td scope="col" colspan="30" class="center bin">NO DATA.</td>
							</tr>
						</c:otherwise>
					</c:choose>
                    </tbody>
                </table>
                </div>
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
var ejectionList ={
	ejectionCheck: function(){
		var $this = $(this);
		var eId = $this.attr('eId');
		if(!eId) return;
		if('bogo01' == '${userSession.id}'){
            alert('没有权限!!!');
            return;
        }else if(!confirm('확인하시겠습니까?')) return;

		$.ajax({
			url: '/ejection/ejectionCheckAjax',
			type: 'POST',
			data: {eId: eId}
		}).success(function( data ) {
		    alert( data.message );
			if(data.code == '0000'){
				$this.closest('td').text('OK');
			}
		}).fail(function() {
	    	alert( '확인에 실패했습니다' );
	    });
	},

	selectKind : function(){
	    var kind = $(this).val();
	    if(kind){
	        $.ajax({
	            url: '/vehicle/selectModelCarsAjax',
	            type: 'POST',
	            data: {kind: kind}
	        }).success(function( data ) {
	            if(data.list){
	                var $selectModelCar = $('#selectModelCar').find('option:not(:eq(0))').remove().end();
	                $.each(data.list, function(i, item){
	                    $selectModelCar.append($('<option/>').val(item.model_car).text(item.model_car));
	                });
	                $selectModelCar.prop('disabled', false);
	                $('.selectVehicle:not(#selectKind):not(#selectModelCar)').prop('disabled', true).find('option[value=""]').prop('selected', true);
	            }
	        }).fail(function() {
	            alert( '데이터 조회에 실패했습니다' );
	            $('.selectVehicle:not(#selectKind)').prop('disabled', true).find('option:not(:eq(0))').remove();
	        });
	    }else{
	        $('.selectVehicle:not(#selectKind)').prop('disabled', true).find('option:not(:eq(0))').remove();
	    }
	},

	selectModelCar : function(){
        var kind = $('#selectKind').val();
        var modelCar = $(this).val();
        if(kind && modelCar){
            $.ajax({
                url: '/vehicle/selectProductNamesAjax',
                type: 'POST',
                data: {kind: kind, modelCar : modelCar}
            }).success(function( data ) {
                if(data.list){
                    var $selectProductName = $('#selectProductName').find('option:not(:eq(0))').remove().end();
                    $.each(data.list, function(i, item){
                        $selectProductName.append($('<option/>').val(item.product_name).text(item.product_name));
                    });
                    $selectProductName.prop('disabled', false);
                    $('#selectLhRh').prop('disabled', true).find('option:not(:eq(0))').remove();
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
        var kind = $('#selectKind').val();
        var modelCar = $('#selectModelCar').val();
        var productName = $(this).val();
        if(kind && modelCar && productName){
            $.ajax({
                url: '/vehicle/selectlhRhsAjax',
                type: 'POST',
                data: {kind: kind, modelCar : modelCar, productName : productName}
            }).success(function( data ) {
                if(data.list){
                    var $selectLhRh = $('#selectLhRh').find('option:not(:eq(0))').remove().end();
                    $.each(data.list, function(i, item){
                        $selectLhRh.append($('<option client="'+item.client+'" vehicleId="'+item.vehicle_id+'"/>').val(item.lh_rh).text(item.lh_rh));
                    });
                    $selectLhRh.prop('disabled', false);
                }
            }).fail(function() {
                alert( '데이터 조회에 실패했습니다' );
                $('#selectLhRh').prop('disabled', true).find('option:not(:eq(0))').remove();
            });
        }else{
            $('#selectLhRh').prop('disabled', true).find('option:not(:eq(0))').remove();
        }
    },

    selectLhRh : function(){
        var kind = $('#selectKind').val();
        var modelCar = $('#selectModelCar').val();
        var productName = $('#selectProductName').val();
        var lhRh = $(this).val();
        if(kind && modelCar && productName && lhRh){
            $.ajax({
                url: '/production/ejection/selectRawStocksAjax',
                type: 'POST',
                data: {kind: kind, modelCar : modelCar, productName : productName, lhRh : lhRh}
            }).success(function( data ) {
                if(data.list){
                    var $selectRawStock = $('#selectRawStock').find('option:not(:eq(0))').remove().end();
                    $.each(data.list, function(i, item){
                        $selectRawStock.append($('<option/>').val(item.raw_product_id).text(item.raw_product_name));
                    });
                    $selectRawStock.prop('disabled', false);
                }
            }).fail(function() {
                alert( '데이터 조회에 실패했습니다' );
                $('#selectRawStock').prop('disabled', true).find('option:not(:eq(0))').remove();
            });
        }else{
            $('#selectRawStock').prop('disabled', true).find('option:not(:eq(0))').remove();
        }
    }
}

$(function(){
	dateUtil.init();
	$('.isCheckBtn').click(ejectionList.ejectionCheck);
	$('#selectKind').change(ejectionList.selectKind);
    $('#selectModelCar').change(ejectionList.selectModelCar);
    $('#selectProductName').change(ejectionList.selectProductName);
    $('#selectLhRh').change(ejectionList.selectLhRh);
});
</script>