<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="row-fluid">
    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">코드 리스트</div>
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
									<td>CODE</td>
									<td >
										<select id="CODE" name="CODE" class="" title="코드" style="margin-bottom:0px;">
											<option value="">全部</option>
										</select>
									</td>
									<td>CODE_GROUP</td>
									<td>
										<select id="CODE_GROUP" name="CODE_GROUP" class="" title="코드그룹" style="margin-bottom:0px;">
											<option value="">全部</option>
										</select>
									</td>
									<td>CODE_NAME</td>
									<td>
										<select id="CODE_NAME" name="CODE_NAME" class="" title="코드명" style="margin-bottom:0px;">
											<option value="">全部</option>
										</select>
									</td>
								</tr>
							</table>
							</div>
							<div style="text-align:right;">
							<button type="button" class="btn btn-primary" id="searchBtn">Search</button>
							</div>
						</div>
					</fieldset>
					<%--//검색조건 --%>
				</div>
                <div class="table-toolbar" style="margin: 0px 5px 3px 0px; padding: 0px 30px 12px 0px; text-align:right">
                   <div class="btn-group">
                      <button type="button" class="btn btn-success" id="saveBtn" style="display:none">Save <i class="icon-plus icon-white"></i></button>
                      <button type="button" class="btn btn-success" id="addBtn" style="display:none">New Add <i class="icon-plus icon-white"></i></button>
                      <button type="button" class="btn btn-success" id="delBtn" style="display:none">Delete <i class="icon-plus icon-white"></i></button>
                      <button type="button" class="btn btn-success" id="editBtn">Edit <i class="icon-plus icon-white"></i></button>
                      <button type="button" class="btn btn-success" id="viewBtn" style="display:none">View <i class="icon-plus icon-white"></i></button>
                   </div>
                </div>
				<div id="codesInfoGridView"></div>
				<div id="codesInfoGridEdit" style="display:none"></div>
            </div>
        </div>
    </div>
    <!-- /block -->
</div>


<script>
var CodesInfoGrid = tui.Grid;
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

var gridView = new tui.Grid({
    el: document.getElementById('codesInfoGridView'),
    data: [],
    rowHeaders: ['rowNum'],//'checkbox', 'rowNum'
    header:{
    	height: 40
    },
    bodyHeight: 500,
    columns: [
        {header: 'code_group',      name: 'CODE_GROUP',        filter:{type:'text'},         	sortable:true,            align:'center'        },
        {header: 'code',		    name: 'CODE',          	   filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: 'code_name',     	name: 'CODE_NAME',         filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: 'code_sort',       name: 'CODE_SORT',         filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: 'code_etc',        name: 'CODE_ETC',          filter:{type:'text'},            sortable:true,            align:'center'        },
        {header: 'code_key',        name: 'CODE_KEY',          filter:{type:'text'},            sortable:true,            align:'center'        },
        {header: 'code_use',        name: 'CODE_USE',          filter:{type:'text'},            sortable:true,            align:'center'        },
        {header: 'created',       	name: 'CREATED',           filter:{type:'text'},          	sortable:true,            align:'center'        }
    ],
    columnOptions: {
    	resizable: true
    }
});

var gridEdit = new tui.Grid({
    el: document.getElementById('codesInfoGridEdit'),
    data: [],
    rowHeaders: ['checkbox', 'rowNum'],//'checkbox', 'rowNum'
    header:{
    	height: 40
    },
    bodyHeight: 500,
    columns: [
        {header: 'code_group',      name: 'CODE_GROUP',        filter:{type:'text'},         	sortable:true,            align:'center',       className:'clickable',        editor:'text', validation:{required:true}},
		{header: 'code',		    name: 'CODE',          	   filter:{type:'text'},          	sortable:true,            align:'center',       className:'clickable',        editor:'text', validation:{required:true}},
        {header: 'code_name',     	name: 'CODE_NAME',         filter:{type:'text'},          	sortable:true,            align:'center',       className:'clickable',        editor:'text', validation:{required:true}},
        {header: 'code_sort',       name: 'CODE_SORT',         filter:{type:'text'},          	sortable:true,            align:'center',       className:'clickable',        editor:'text', validation:{required:true}},
        {header: 'code_etc',        name: 'CODE_ETC',          filter:{type:'text'},            sortable:true,            align:'center',       className:'clickable',        editor:'text'},
        {header: 'code_key',        name: 'CODE_KEY',          filter:{type:'text'},            sortable:true,            align:'center', 		 disabled:true        },
        {header: 'code_use',        name: 'CODE_USE',          filter:{type:'text'},            sortable:true,            align:'center', 		 disabled:true        },
        {header: 'created',       	name: 'CREATED',           filter:{type:'text'},          	sortable:true,            align:'center', 		 disabled:true        }
    ],
    columnOptions: {
    	resizable: true
    }
});

var dataSet;
var codesInfo = {
	init:function(){
		console.log("[DEBUG] 콤보박스 초기화(세팅)");
		//this.comboList();
	},
	comboList:function(){
		var params = {};
		$.ajax({
		    url : "/set/codesInfo/comboList",
		    method :"POST",
		    data:params
		}).success(function(result) {
			dataSet = result;
			gridView.resetData(result);
			codesInfo.view();
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    });
	},
	search:function(){
		var params = {};
		$.ajax({
		    url : "/set/codesInfo/list",
		    method :"POST",
		    data:params
		}).success(function(result) {
			dataSet = result;
			gridView.resetData(result);
			codesInfo.view();
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    })/* .error(function(ev){
	    	alert('오류 : ' + ev);
	    }) */;
	},
	view:function(){
		$('#codesInfoGridEdit').hide();
		$('#codesInfoGridView').show();
		$('#editBtn').show();
		$('#saveBtn').hide();
		$('#delBtn').hide();
		$('#addBtn').hide();
		$('#viewBtn').hide();
	},
	edit:function(){
		$('#codesInfoGridView').hide();
		$('#codesInfoGridEdit').show();
		$('#viewBtn').show();
		$('#editBtn').hide();
		$('#saveBtn').show();
		$('#addBtn').show();
		$('#delBtn').show();
		
		gridEdit.resetData(dataSet);
		gridEdit.refreshLayout();
		
	},
	save:function(){
		let saveData = gridEdit.getModifiedRows();
		
		// 빈값 제거..
		saveData.createdRows = saveData.createdRows.filter(function(v){
	        return v['CODE'] != null && v['CODE'] != '';
	    });
		
		let chkLen = saveData.createdRows.length + saveData.updatedRows.length + saveData.deletedRows.length;
		
		if(chkLen > 0){
			$.ajax({
			    url : "/set/codesInfo/save",
			    contentType : "application/json",
			    method :"POST",
			    data:JSON.stringify(saveData)
			}).success(function(result) {
				alert(" ㅇ 추가 : " + result["insert"] + "건\n" + " ㅇ 수정 : " + result["update"] + "건\n" + " ㅇ 삭제 : " + result["delete"] + "건");
				codesInfo.search();
			}).fail(function(ev) {
		    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
		    });
		}else{
			alert("수정할 데이터가 없습니다.");
		}
	},
	del:function(){
		let chkLen = gridEdit.getCheckedRows().length;
		if(chkLen > 0){
			gridEdit.getCheckedRows().forEach(function(v, i){
				gridEdit.removeRow(v.rowKey);
			});
		}else{
			alert("선택된 row가 없습니다.");
		}
	},
	add:function(){
		gridEdit.prependRow([]);
	}
}

$(function(){
	
	$('#searchBtn').click(codesInfo.search);
	$('#viewBtn').click(codesInfo.view);
	$('#editBtn').click(codesInfo.edit);
	$('#saveBtn').click(codesInfo.save);
	$('#addBtn').click(codesInfo.add);
	$('#delBtn').click(codesInfo.del);
	
	dateUtil.init();
	codesInfo.init();
	codesInfo.search();
	
});
</script>

