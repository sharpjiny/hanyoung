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
               <div class="table-toolbar" style="text-align:right">
                  <div class="btn-group">
                     <button type="button" class="btn btn-success" id="addBtn" style="display:none">Add <i class="icon-plus icon-white"></i></button>
                     <button type="button" class="btn btn-success" id="saveBtn" style="display:none">Save <i class="icon-plus icon-white"></i></button>
                     <button type="button" class="btn btn-success" id="delBtn" style="display:none">Delete <i class="icon-plus icon-white"></i></button>
                     <button type="button" class="btn btn-success" id="editBtn">Edit <i class="icon-plus icon-white"></i></button>
                     <button type="button" class="btn btn-success" id="viewBtn" style="display:none">View <i class="icon-plus icon-white"></i></button>
                     <button type="button" class="btn btn-success" id="searchBtn">Search <i class="icon-plus icon-white"></i></button><!-- btn-inverse, btn-info -->
                  </div>
               </div>
				<div id="mtrlsInfoGridView"></div>
				<div id="mtrlsInfoGridEdit" style="display:none"></div>
            </div>
        </div>
    </div>
    <!-- /block -->
</div>


<script>
var MtrlsInfoGrid = tui.Grid;
var gridView = new tui.Grid({
    el: document.getElementById('mtrlsInfoGridView'),
    data: [],
    rowHeaders: ['rowNum'],//'checkbox', 'rowNum'
    header:{
    	height: 50
    },
    columns: [
        {header: 'PROD_ID',		           name: 'PROD_ID',          	   filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: 'KIND',         		   name: 'KIND',          		   filter:{type:'text'},         	sortable:true,            align:'center'        },
        {header: 'PROD_NM',     		   name: 'PROD_NM',          	   filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '단가',       			   name: 'COST',          		   filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: 'PROD_WEIGHT',            name: 'PROD_WEIGHT',            filter:{type:'text'},            sortable:true,            align:'center'        },
        {header: 'CREATE_DATE',            name: 'CREATE_DATE',            filter:{type:'text'},            sortable:true,            align:'center'        },
        {header: 'CREATE_USER',            name: 'CREATE_USER',            filter:{type:'text'},            sortable:true,            align:'center'        },
        {header: 'UPDATE_DATE',            name: 'UPDATE_DATE',            filter:{type:'text'},            sortable:true,            align:'center'        },
        {header: 'UPDATE_USER',            name: 'UPDATE_USER',            filter:{type:'text'},            sortable:true,            align:'center'        }
    ]
});

var gridEdit = new tui.Grid({
    el: document.getElementById('mtrlsInfoGridEdit'),
    data: [],
    rowHeaders: ['checkbox', 'rowNum'],//'checkbox', 'rowNum'
    header:{
    	height: 50
    },
    columns: [
		{header: 'PROD_ID',		           name: 'PROD_ID',          	   filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: 'KIND',         		   name: 'KIND',          		   filter:{type:'text'},         	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: 'PROD_NM',     		   name: 'PROD_NM',          	   filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: '단가',       			   name: 'COST',          		   filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: 'PROD_WEIGHT',            name: 'PROD_WEIGHT',            filter:{type:'text'},            sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: 'CREATE_DATE',            name: 'CREATE_DATE',            filter:{type:'text'},            sortable:true,            align:'center'        },
		{header: 'CREATE_USER',            name: 'CREATE_USER',            filter:{type:'text'},            sortable:true,            align:'center'        },
		{header: 'UPDATE_DATE',            name: 'UPDATE_DATE',            filter:{type:'text'},            sortable:true,            align:'center'        },
		{header: 'UPDATE_USER',            name: 'UPDATE_USER',            filter:{type:'text'},            sortable:true,            align:'center'        }
    ]
});

var dataSet;
var mtrlsInfo = {
	init:function(){
		this.search();
	},
	search:function(){
		var params = {'prod_id':'test'};
		
		$.ajax({
		    url : "/set/mtrlsInfo/list",
		    method :"POST",
		    data:params
		}).success(function(result) {
			dataSet = result;
			gridView.resetData(result);
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    })/* .error(function(ev){
	    	alert('오류 : ' + ev);
	    }) */;
	},
	view:function(){
		$('#mtrlsInfoGridEdit').hide();
		$('#mtrlsInfoGridView').show();
		$('#editBtn').show();
		$('#saveBtn').hide();
		$('#delBtn').hide();
		$('#addBtn').hide();
		$('#viewBtn').hide();
	},
	edit:function(){
		$('#mtrlsInfoGridView').hide();
		$('#mtrlsInfoGridEdit').show();
		$('#viewBtn').show();
		$('#editBtn').hide();
		$('#saveBtn').show();
		$('#addBtn').show();
		$('#delBtn').show();
		
		gridEdit.resetData(dataSet);
		gridEdit.refreshLayout();
		
	},
	save:function(){
		let chkLen = gridEdit.getCheckedRows().length;
		if(chkLen > 0){
			let params = {'params':gridEdit.getCheckedRows()};
			$.ajax({
			    url : "/set/mtrlsInfo/save",
			    method :"POST",
			    data:params
			}).success(function(result) {
				alert("success save");
				init();
			}).fail(function(ev) {
		    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
		    });
			
			alert("save");
		}else{
			alert("선택된 row가 없습니다.");
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
		gridEdit.appendRow([]);
	}
}

$(function(){
	
	$('#searchBtn').click(mtrlsInfo.search);
	$('#viewBtn').click(mtrlsInfo.view);
	$('#editBtn').click(mtrlsInfo.edit);
	$('#saveBtn').click(mtrlsInfo.save);
	$('#addBtn').click(mtrlsInfo.add);
	$('#delBtn').click(mtrlsInfo.del);
	
	mtrlsInfo.init();
	
});
</script>

