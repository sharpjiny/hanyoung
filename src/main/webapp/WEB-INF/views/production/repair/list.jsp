<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src=""></script>
<style>
.tui-timepicker-select {
	padding: 0px 0 5px 9px;
}
</style>
<div class="row-fluid">
    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">수리 일보</div>
        </div>
        <div class="block-content collapse in">
            <div class="span12">
            	<div class="alert alert-block" style="border:0px;background-color:#fffff0">
					<%-- 검색조건 --%>
					<fieldset>
						<div class="control-group">
						<div style="float:left;">
							<table>
								<tr>
									<td width='70px'>주/야</td>
									<td>
										<select id="WORK_TYPE" name="WORK_TYPE" class="" title="주/야" style="margin-bottom:0px;">
											<option value="">주/야</option>
										</select>
									</td>
									<td width='70px'>설비호기</td>
									<td>
										<select id="EQP_ID" name="EQP_ID" class="" title="설비호기" style="margin-bottom:0px;">
											<option value="">설비호기</option>
										</select>
									</td>
									<td width='70px'>생산일자</td>
									<td>
										<input class="date" name="dateStart" id="dateStart" type="text" style="margin-bottom:0px;">
										~
										<input class="date" name="dateEnd" id="dateEnd" type="text" style="margin-bottom:0px;">
									</td>
								</tr>
							</table>
						</div>
						</div>
					</fieldset>
					<%--//검색조건 --%>
				</div>
                <div class="table-toolbar" style="margin: 0px 5px 3px 0px; padding: 0px 30px 12px 0px; text-align:right">
                   <div class="btn-group">
                      <button type="button" class="btn btn-success" id="addBtn">New Add <i class="icon-plus icon-white"></i></button>
                      <button type="button" class="btn btn-success" id="delBtn">Delete <i class="icon-plus icon-white"></i></button>
                      <button type="button" class="btn btn-success" id="editBtn">Edit <i class="icon-plus icon-white"></i></button>
                      <span style="margin-left:20px;">
                      <button type="button" class="btn btn-primary" id="searchBtn" >Search </button>
                      </span>
                   </div>
                </div>
            </div>
        </div>
        <div style="height:525px;">
			<div id="prdtRepairGridView" ></div>
		</div>
    </div>
    <!-- /block -->
</div>
<div class="modal fade modal-min hide" style="width:700px; left:45%; position: fixed;" id="repairModal" tabindex="-1" role="dialog" aria-labelledby="repairModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">수리일보 등록/수정</h4>
      </div>
      <div class="modal-body">
	      <form id="submitForm" name="submitForm" class="form-horizontal" method="post" enctype="multipart/form-data">
	       <fieldset>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="prdtDate">日期</label>
	           <div class="controls">
	             <input class="input-xlarge focused date" id="prdtDate" name="prdtDate" type="text" title="日期" placeholder="日期">
	           </div>
	         </div>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="workType">白班/夜班</label>
	           <div class="controls">
	           		<select id="workType" name="workType" class="" title="白班/夜班">
					</select>
	           </div>
	         </div>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="eqpId">设备</label>
	           <div class="controls">
	           		<select id="eqpId" name="eqpId" class="" title="设备">
					</select>
	           </div>
	         </div>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="stTime">开始时间</label>
	           <div class="controls">
	             <input class="input-xlarge focused time skip" id="stTime" name="stTime" type="text" title="开始时间" placeholder="开始时间">
	           </div>
	         </div>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="edTime">结束时间</label>
	           <div class="controls">
	             <input class="input-xlarge focused time skip" id="edTime" name="edTime" type="text" title="结束时间" placeholder="结束时间">
	           </div>
	         </div>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="stoppingTime">故障时间</label>
	           <div class="controls">
	             <input class="input-xlarge focused skip" id="stoppingTime" name="stoppingTime" type="number" title="故障时间" placeholder="故障时间" validate="number">
	           </div>
	         </div>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="brokenPart">故障部位</label>
	           <div class="controls">
	           		<select id="brokenPart" name="brokenPart" class="" title="故障部位">
	           		</select>
	           </div>
	         </div>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="imgUrl">照片</label>
	           <div class="controls">
	             <input class="input-xlarge focused" id="file" name="file" type="file" title="照片" placeholder="照片">
	           </div>
	         </div>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="reason">故障原因</label>
	           <div class="controls">
	             <input class="input-xlarge focused skip" id="reason" name="reason" type="text" title="故障原因" placeholder="故障原因">
	           </div>
	         </div>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="method">处理方法</label>
	           <div class="controls">
	             <input class="input-xlarge focused skip" id="method" name="method" type="text" title="处理方法" placeholder="处理方法">
	           </div>
	         </div>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="man1">工作工人1</label>
	           <div class="controls">
	             <input class="input-xlarge focused skip" id="man1" name="man1" type="text" title="工作工人1" placeholder="工作工人1">
	           </div>
	         </div>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="man2">工作工人2</label>
	           <div class="controls">
	             <input class="input-xlarge focused skip" id="man2" name="man2" type="text" title="工作工人2" placeholder="工作工人2">
	           </div>
	         </div>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="repairMan">担当者</label>
	           <div class="controls">
	             <input class="input-xlarge focused skip" id="repairMan" name="repairMan" type="text" title="担当者" placeholder="担当者">
	           </div>
	         </div>
	         <div class="control-group">
	           <label class="col-sm-2 control-label" for="bigo">备注</label>
	           <div class="controls">
	             <input class="input-xlarge focused skip" id="bigo" name="bigo" type="text" title="备注" placeholder="备注">
	           </div>
	         </div>
	         <!-- <div class="control-group">
	           <label class="col-sm-2 control-label" for="isCheck">确认</label>
	           <div class="controls">
	             <input class="input-xlarge focused skip" id="isCheck" name="isCheck" type="text" title="确认" placeholder="确认">
	           </div>
	         </div> -->
	       </fieldset>
			<input type="hidden" name="eventType" value=""/>
			<input type="hidden" name="fileSeq" value=""/>
	     </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="saveBtn">Save changes</button>
      </div>
    </div>
  </div>
</div>

<script>
//var PrdtRepairGrid = tui.Grid;
tui.Grid.applyTheme('default', {
	  cell: {
	     evenRow: {
	      background: '#f8f8ff',
	    },
	    oddRow: {
	      background: '#f5fffa'
	    } 
	  }
	});

var workTypeList = [{value:'', text:'-선택-'}];
var eqpIdList = [{value:'', text:'-선택-'}];
var brokenParts = [{value:'', text:'-선택-'}];

var gridView = new tui.Grid({
    el: document.getElementById('prdtRepairGridView'),
    data: [],
    rowHeaders: [
        {
        	type:'checkbox'
        	,minRowHeight:'100'
        },
    	{
        	type:'rowNum'
        	,minRowHeight:'100'
    	}], //'checkbox', 'rowNum'
    header:{
    	height: 40
    },
    bodyHeight: 500,
    rowHeight: 230,
    columns: [
		{header: '日期',    		name: 'PRDT_DATE',      filter:{type:'text'},          	sortable:true,            align:'center', formatter:function(v) { // 추가
		      return v.value.substring(2, v.value.length);
	    }},
		{header: '白班/夜班',     	name: 'WORK_TYPE', 		filter:{type:'text'},         	sortable:true,            align:'center'},
		{header: '设备',     		name: 'EQP_ID',   	  	filter:{type:'text'},         	sortable:true,            align:'center'},
		{header: '开始时间',    	name: 'ST_TIME',      	filter:{type:'text'},         	sortable:true,            align:'center'},
		{header: '结束时间',   	name: 'ED_TIME',  		filter:{type:'text'},         	sortable:true,            align:'center'},
		{header: '故障时间',    	name: 'STOPPING_TIME',  filter:{type:'text'},         	sortable:true,            align:'center'},
		{header: '故障部位',    	name: 'BROKEN_PART',    filter:{type:'text'},         	sortable:true,            align:'center'},
		{header: '照片',  		name: 'IMG',      		filter:{type:'text'},         	sortable:true,            align:'center'},
		{header: 'FILE_SEQ', 	name: 'FILE_SEQ',       filter:{type:'text'},         	sortable:true,            align:'center', 		hidden: true},
		{header: '이미지-NAME', name: 'FILE_NAME',      filter:{type:'text'},         	sortable:true,            align:'center', 		hidden: true},
		{header: '이미지-PATH', name: 'FILE_PATH',      filter:{type:'text'},         	sortable:true,            align:'center', 		hidden: true},
		{header: '故障原因',      	name: 'REASON',      	filter:{type:'text'},         	sortable:true,            align:'center'},
		{header: '处理方法',      	name: 'METHOD',      	filter:{type:'text'},         	sortable:true,            align:'center'},
		{header: '工作工人1',     name: 'MAN1',           filter:{type:'text'},         	sortable:true,            align:'center'},
		{header: '工作工人2',     name: 'MAN2',           filter:{type:'text'},         	sortable:true,            align:'center'},
		{header: '担当者',      	name: 'REPAIR_MAN',     filter:{type:'text'},         	sortable:true,            align:'center'},
		{header: '备注',       	name: 'BIGO',         	filter:{type:'text'},         	sortable:true,            align:'center'},
		{header: '确认',       	name: 'IS_CHECK',     	filter:{type:'text'},         	sortable:true,            align:'center'},
		{header: '생성일자',    name: 'CREATE_DATE',  	filter:{type:'text'},         	sortable:true,            align:'center',		hidden: true},
		{header: '생성자',      name: 'CREATE_USER',  	filter:{type:'text'},         	sortable:true,            align:'center',		hidden: true},
		{header: '수정일자',    name: 'UPDATE_DATE',  	filter:{type:'text'},         	sortable:true,            align:'center',		hidden: true},
		{header: '수정자',      name: 'UPDATE_USER',  	filter:{type:'text'},         	sortable:true,            align:'center',		hidden: true}
    ],
    columnOptions: {
    	resizable: true
    }
});

gridView.on('dblclick', function(ev){
	
	if(ev.columnName == "IMG"){
		var url = gridView.getValue(ev.rowKey, "FILE_PATH")+"/"+gridView.getValue(ev.rowKey, "FILE_NAME");
		
		var img=new Image();
		img.src=url;
		var img_width=img.width;
		var win_width=img.width+25;
		var img_height=img.height;
		var win=img.height+30;
		var OpenWindow=window.open('','_blank', 'width='+img_width+', height='+img_height+', menubars=no, scrollbars=auto');
		
		OpenWindow.document.write("<style>body{margin:0px;}</style><img src='"+url+"' width='"+win_width+"'>");
		
	}else{
		return;
	}
	
});

var dataSet;
var comboSet;

var prdtRepair = {
	init:function(){
		this.eqpIdSets();
		this.workTypeSets();
		this.brokenParts();
	},
	eqpIdSets:function(){
		var params = {"code_group":"eqp_id"};
		$.ajax({
		    url : "/production/repair/eqpIdSets",
		    method :"POST",
		    data:params
		}).success(function(result) {
			$.each(result["EQP_ID"], function(i, item){
				$('#eqpId').append($('<option/>').val(item.CODE).text(item.NAME));
				$('#EQP_ID').append($('<option/>').val(item.CODE).text(item.NAME));
				eqpIdList.push({value:item.CODE, text:item.NAME});
			});
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    });
	},
	brokenParts:function(){
		var params = {"code_group":"broken_part"};
		$.ajax({
		    url : "/production/repair/brokenParts",
		    method :"POST",
		    data:params
		}).success(function(result) {
			$.each(result["BROKEN_PARTS"], function(i, item){
				$('#brokenPart').append($('<option/>').val(item.CODE).text(item.NAME));
				brokenParts.push({value:item.CODE, text:item.NAME});
			});
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    });
	},
	workTypeSets:function(){
		var params = {"code_group":"work_type"};
		$.ajax({
		    url : "/production/repair/workTypeSets",
		    method :"POST",
		    data:params
		}).success(function(result) {
			$.each(result["WORK_TYPE"], function(i, item){
				$('#workType').append($('<option/>').val(item.CODE).text(item.NAME));
				$('#WORK_TYPE').append($('<option/>').val(item.CODE).text(item.NAME));
				workTypeList.push({value:item.CODE, text:item.NAME});
			});
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    });
	},
	search:function(p){
		var params = {
			'WORK_TYPE':$('#WORK_TYPE option:selected').val(),
			'EQP_ID':$('#EQP_ID option:selected').val(),
			'dateStart':$('#dateStart').val(),
			'dateEnd':$('#dateEnd').val()
		};
		$.ajax({
		    url : "/production/repair/list",
		    method :"POST",
		    data:params
		}).success(function(result) {
			// summary : 최초 숨기고 있음.
			if(p == "init"){
				$(".tui-grid-summary-area").hide();
			}else{
				$(".tui-grid-summary-area").show();
			}
			
			dataSet = result;
			gridView.resetData(result);
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    })
	},
	save:function(){
		// 유효성 체크
		if(!$("#submitForm").validation()){
			return false;
		}
		var params = {
				PRDT_DATE: $("#prdtDate").val()
	            , WORK_TYPE: $("#workType").val()
	            , EQP_ID: $("#eqpId").val()
	            , ST_TIME: $("#stTime").val().substr(2, $("#stTime").val().length)
	            , ED_TIME: $("#edTime").val().substr(2, $("#edTime").val().length)
	            , STOPPING_TIME: $("#stoppingTime").val()
	            , BROKEN_PART: $("#brokenPart").val()
	            , FILE_SEQ: $('[name=fileSeq]').val()
	            , REASON: $("#reason").val()
	            , METHOD: $("#method").val()
	            , MAN1: $("#man1").val()
	            , MAN2: $("#man2").val()
	            , REPAIR_MAN: $("#repairMan").val()
	            , BIGO: $("#bigo").val()
	            , IS_CHECK: $("#isCheck").val()
	            , EVENT_TYPE : $('[name=eventType]').val()
	            , BASE_PATH: "C:\\DEV\\imgUpload\\" // /work/file_dir/
		};
		
		var form =$('#submitForm')[0];
		var formData = new FormData(form);
		formData.append('file', $('#file'));
		formData.append('params', new Blob([JSON.stringify(params)] , {type: "application/json"}));
		
		$.ajax({
            type: 'POST',
            url: '/production/repair/save',
            processData: false,
            contentType:false,
            data: formData,
        }).done(function() {
        	alert("저장되었습니다.");
        	$('#repairModal').modal('hide');
        	prdtRepair.search();
        }).fail(function (error) {
            alert(JSON.stringify(error));
		});
		
	},
	edit:function(){
		var checkRows = gridView.getCheckedRows();
		if(checkRows.length == 0){
			alert("수정할 데이터를 선택해 주세요.");
		}else if(checkRows.length > 1){
			alert("수정은 한 건씩만 할 수 있습니다.");
		}else{
			$('#repairModal')
			.find('#prdtDate').val(checkRows[0]["PRDT_DATE"]).prop('disabled', true).end()
			.find('#workType').val(checkRows[0]["WORK_TYPE"]).prop('disabled', true).end()
			.find('#eqpId').val(checkRows[0]["EQP_ID"]).prop('disabled', true).end()
			.find('#stTime').val("20"+checkRows[0]["ST_TIME"]).end()
			.find('#edTime').val("20"+checkRows[0]["ED_TIME"]).end()
			.find('#stoppingTime').val(checkRows[0]["STOPPING_TIME"]).prop('disabled', true).end()
			.find('#brokenPart').val(checkRows[0]["BROKEN_PART"]).end()
			.find('#reason').val(checkRows[0]["REASON"]).end()
			.find('#method').val(checkRows[0]["METHOD"]).end()
			.find('#man1').val(checkRows[0]["MAN1"]).end()
			.find('#man2').val(checkRows[0]["MAN2"]).end()
			.find('#repairMan').val(checkRows[0]["REPAIR_MAN"]).end()
			.find('#bigo').val(checkRows[0]["BIGO"]).end()
			.find('#isCheck').val(checkRows[0]["IS_CHECK"]).end()
			.find('[name=eventType]').val('U').end()
			.modal('show');
			
			$('[name=fileSeq]').val(checkRows[0]["FILE_SEQ"]);
		}
	},
	del:function(){
		var checkRows = gridView.getCheckedRows();
		if(checkRows.length == 0){
			alert("삭제할 데이터를 선택해 주세요.");
		}else{
			if (!confirm('삭제하시겠습니까?'))
				return;

			$.ajax({
				url : '/production/repair/del',
				type : 'POST',
				contentType:'application/json',
				data : JSON.stringify(checkRows)
			}).success(function(data) {
				alert(data.rtn + "건 삭제되었습니다.");
				location.reload();
			}).fail(function() {
				alert('삭제에 실패했습니다');
			});
		}
	},
	add:function(){
		$('#repairModal')
		.find('input:text, [type=number], [type=hidden]').val('').end()
		.find('[name=prdtDate]').val('').prop('disabled', false).end()
		.find('[name=workType]').val('').prop('disabled', false).end()
		.find('[name=eqpId]').val('').prop('disabled', false).end()
		.find('[name=stoppingTime]').val('').prop('disabled', true).end()
		.find('[name=eventType]').val('C').end()
		.find('[name=fileSeq]').val('').end()
		.find('#file').val('').end()
		.modal('show');
	}
}

$(function(){
	// 그리드 제어용
	$('#searchBtn').click(prdtRepair.search);
	$('#editBtn').click(prdtRepair.edit);
	$('#saveBtn').click(prdtRepair.save);
	$('#addBtn').click(prdtRepair.add);
	$('#delBtn').click(prdtRepair.del);
	
	dateUtil.init();
	prdtRepair.init();
	prdtRepair.search('init');
	
});
</script>

