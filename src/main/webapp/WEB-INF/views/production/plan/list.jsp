<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
.filebox input[type="file"] { 
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0; margin: -1px;
	overflow: hidden;
	clip:rect(0,0,0,0);
	border: 0; 
}
.filebox label { 
	display: inline-block;
	padding: .5em .75em;
	color: #999;
	font-size: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #fdfdfd;
	cursor: pointer;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em; 
}
/* named upload */
.filebox .upload-name { 
	display: inline-block; 
	padding: .5em .75em; 
	/* label의 패딩값과 일치 */ font-size: inherit; 
	font-family: inherit; 
	line-height: normal; 
	vertical-align: middle; 
	background-color: #f5f5f5; 
	border: 1px solid #ebebeb; 
	border-bottom-color: #e2e2e2; 
	border-radius: .25em; 
	-webkit-appearance: none; 
	/* 네이티브 외형 감추기 */ -moz-appearance: none; 
	appearance: none; 
}

</style>
<div class="row-fluid">
    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">생산계획</div>
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
                            <label class="control-label" for="inputError">入库社</label>
                            <div class="controls">
                                <select id="selectClients" name="clients" class="" title="镀铝机号">
                                    <option value="">入库社</option>
                                    <c:forEach items="${clients}" var="item">
	                                    <c:set var="selected" value=""/>
										<c:if test='${item.client==pageParam.clients}'><c:set var="selected" value="selected"/></c:if>
                                        <option value="${item.client}" ${selected}>${item.client}</option>
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
                            <label class="control-label" for="inputError">车种</label>
                            <div class="controls">
                                <select id="selectModelCar" name="modelCar" class="selectVehicle" title="车种">
                                    <option value="">车种</option>
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
										<c:if test='${item.code==pageParam.lhRh}'><c:set var="selected" value="selected"/></c:if>
                                        <option value="${item.code}" ${selected}>${item.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
						<div class="control-group btn-group">
							<button type="submit" class="btn btn-primary">Search</button>
						</div>
					</fieldset>
					<div class="table-toolbar">
	                  <div class="btn-group">
						<input type="hidden" name="pageCut" value="10"/>
						<input type="hidden" name="pageNum" value="${pageParam.pageNum}"/>
	                  </div>
	               </div>
				</form>
            </div>
            
				<form name="excelUpForm" id="excelUpForm" enctype="multipart/form-data" method="POST" action="./excelDown.do">
				<div class="filebox"> 
					<input class="upload-name" value="파일선택" disabled="disabled"> 
					<input type="file" id="ex_filename" name="excleFile" class="upload-hidden">
					<label for="ex_filename">불러오기</label> 
				<button type="button" class="btn btn-primary" id="excelUpload">업로드</button>
				<c:if test="${userSession.id == 'bogoadmin'}">
				<div style="float:right;">
				<button type="button" class="btn btn-danger" id="deleteAll">전체삭제</button>
				</div>
				</c:if>
				</div>
				</form>
                <!-- <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered"> -->
                <table style="width:100%;" class="table-hover" >
                    <thead>
                        <tr>
                            <th>NO</th>
                            <th>日期</th>
                            <th>白/夜</th>
                            <th>入库社</th>
                            <th>車种</th>
                            <th>品名</th>
                            <th>L/R</th>
                            <th>品號</th>
                            <th>纳品数量</th>
                            <th>단가</th>
                            <th>금액</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:choose>
						<c:when test="${!empty pagingList}">
						<c:set var="planSum" value="0"/>
						<c:set var="priceSum" value="0"/>
						<c:set var="totPriceSum" value="0"/>
							<c:forEach items="${pagingList}" var="item" varStatus="loop">
					            <tr>
					                <td class="center"><a href="javascript: plan.planEdit('${item.product_id}', '${item.plan_date}', '${item.work_type}');">${pageParam.startNum+loop.count}</a></td>
					                <td>${item.plan_date}</td>
					                <td>${item.work_type_name}</td>
					                <td>${item.client}</td>
					                <td>${item.model_car}</td>
					                <td>${item.product_name}</td>
					                <td>${item.lh_rh}</td>
					                <td>${item.product_id}</td>
					                <td><fmt:formatNumber value="${item.quantity}" pattern="#,###" /></td>
					                <td><fmt:formatNumber value="${item.price}" pattern="#,###.##" /></td>
					                <td><fmt:formatNumber value="${item.tot}" pattern="#,###.##" /></td>
					            </tr>
					        <c:set var="planSum" value="${planSum + item.quantity}"/>
				            <c:set var="priceSum" value="${priceSum + item.price}"/>
				            <c:set var="totPriceSum" value="${totPriceSum + item.tot}"/>    
					        </c:forEach>
					        <tr style="background-color: #f2dede">
				                <td class="center" colspan="8">합계</td>
				                <td class="center"><fmt:formatNumber value="${planSum}" pattern="#,###" /></td>
				                <td class="center"><fmt:formatNumber value="${priceSum}" pattern="#,###.##" /></td>
				                <td class="center"><fmt:formatNumber value="${totPriceSum}" pattern="#,###.##" /></td>
				            </tr>
						</c:when>
						<c:otherwise>
							<tr class="bin">
								<td scope="col" colspan="11" class="center bin">데이터가 없습니다.</td>
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
<!-- <div class="modal fade modal-min hide" id="planModal" tabindex="-1" role="dialog" aria-labelledby="planModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">생산계획</h4>
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
	       </fieldset>
			<input type="hidden" name="eventType" value=""/>
	     </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn btn-info" id="planDelete">Save Delete</button>
        <button type="button" class="btn btn-primary" id="planSave">Save changes</button>
      </div>
    </div>
  </div>
</div> -->
<script>
var plan ={
	/* planSave : function(){
		// 유효성 체크
		if(!$("#submitForm").validation()){
			return false;
		}

		$.ajax({
			url: '/set/planSaveAjax',
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

	planAdd: function(){
		$('#planDelete').hide();
		$('#planModal')
			.find('input:text, [type=number], [type=hidden]').val('').end()
			.find('[name=eventType]').val('C').end()
			.find('#planId').val('').prop('readonly', false).end()
			.find('[name=lhRh]:eq(0)').prop('checked', true).end()
			.modal('show');
	},

	planEdit: function(planId){
		if(!planId) return;
		$.ajax({
			url: '/set/getPlanAjax',
			type: 'POST',
			data: {planId: planId }
		}).success(function( data ) {
			if(data.plan){
				$('#planDelete').show();
				var rawKind = data.plan.rawKind;
				var rawId = data.plan.rawId;
				$.each($('#planModal').find('#selectKindPop option'), function(i, item) {
					if(item.text == rawKind){
						item.setAttribute("selected", "selected");
					}
                   // $selectKindPop.append($('<option/>').val(item.code).text(item.name));
                });
				$.each($('#planModal').find('#selectProductNamePop option'), function(i, item) {
                    if(item.value == rawId){
                        item.setAttribute("selected", "selected");
                    }
                   // $selectKindPop.append($('<option/>').val(item.code).text(item.name));
                });
				$('#planModal')
					.find('#planId').val(planId).prop('readonly', true).end()
					.find('#kind').val(data.plan.kind).end()
					.find('#modelCar').val(data.plan.modelCar).end()
					.find('#productName').val(data.plan.productName).end()
					.find('#client').val(data.plan.client).end()
					.modal('show');
			}else{
		    	alert( '조회에 실패했습니다' );
			}
		}).fail(function() {
	    	alert( '조회에 실패했습니다' );
	    });
	},

	planDelete: function(){
		var planId = $('#planId').val();
		if(!planId) return;
		if(!confirm('삭제하시겠습니까?')) return;

		$.ajax({
			url: '/set/planDelAjax',
			type: 'POST',
			data: {planId: planId}
		}).success(function( data ) {
		    alert( data.message );
			if(data.code == '0000'){
				//paging.init();
				location.reload();
			}
		}).fail(function() {
	    	alert( '삭제에 실패했습니다' );
	    });
	}, */
	
	deleteAll: function(){
		if(!confirm('삭제하시겠습니까?')) return;

		$.ajax({
			url: '/production/plan/deleteAll',
			type: 'POST'
		}).success(function( data ) {
			if(data.success == "OK" ){
				alert( "삭제되었습니다");
				location.reload();
			}
		}).fail(function() {
	    	alert( '삭제에 실패했습니다' );
	    });
	},
	
	excelUpload : function(){
    	var form = $("#excelUpForm")[0];

        var data = new FormData(form);
        $.ajax({
           enctype:"multipart/form-data",
           method:"POST",
           url: './excelUp.do',
           processData: false,   
           contentType: false,
           cache: false,
           data: data,
           success: function(result){
        	   alert("success excel upload");
        	   location.reload();
           },
           error: function (){
        	   alert("Fail");
           },
           fail: function(){
        	   alert("Error");
           }
        });
    }
}

$(function(){
	/* $('#planAdd').click(plan.planAdd);
	$('#planSave').click(plan.planSave);
	$('#planDelete').click(plan.planDelete); */
	$('#deleteAll').click(plan.deleteAll);
	
	$('#excelUpload').click(plan.excelUpload);
	var fileTarget = $('.filebox .upload-hidden');
    fileTarget.on('change', function(){ 
    	// 값이 변경되면 
    	if(window.FileReader){ 
    		// modern browser 
    		var filename = $(this)[0].files[0].name; } 
    	else { 
    		// old IE 
    		var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출 
    	} // 추출한 파일명 삽입 
    	$(this).siblings('.upload-name').val(filename); 
    });
	
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

s                        }
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