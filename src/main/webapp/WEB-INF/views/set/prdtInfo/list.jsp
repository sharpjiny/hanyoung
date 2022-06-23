<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="row-fluid">
    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">제품 기준정보 리스트</div>
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
									<td>품호</td>
									<td >
										<select id="PROD_ID" name="PROD_ID" class="" title="품호" style="margin-bottom:0px;">
											<option value="">全部</option>
										</select>
									</td>
									<td>종류</td>
									<td>
										<select id="KIND" name="KIND" class="" title="종류" style="margin-bottom:0px;">
											<option value="">全部</option>
										</select>
									</td>
									<td>품명</td>
									<td>
										<select id="PROD_NM" name="PROD_NM" class="" title="품명" style="margin-bottom:0px;">
											<option value="">全部</option>
										</select>
									</td>
									<td>일자</td>
									<td>
										<input class="date" name="dateStart" id="dateStart" type="text" style="margin-bottom:0px;">
										~
										<input class="date" name="dateEnd" id="dateEnd" type="text" style="margin-bottom:0px;">
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
                      <!-- <button type="button" class="btn btn-success" id="searchBtn">Search <i class="icon-plus icon-white"></i></button> -->
                      <!-- btn-inverse, btn-info -->
                   </div>
                </div>
				<div id="prdtInfoGridView"></div>
				<div id="prdtInfoGridEdit" style="display:none"></div>
            </div>
        </div>
    </div>
    <!-- /block -->
</div>


<script>
var PrdtInfoGrid = tui.Grid;
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
    el: document.getElementById('prdtInfoGridView'),
    //scrollX: true,
    //scrollY: true,
    data: [],
    rowHeaders: ['rowNum'],//'checkbox', 'rowNum'
    header:{
    	height: 40
    },
    columns: [
        {header: '종류',         	name: 'KIND',          		   filter:{type:'text'},         	sortable:true,            align:'center'        },
        {header: '품명',     		name: 'PROD_NM',          	   filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '상세품명',       	name: 'PROD_DTL_NM',           filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '품호',		    name: 'PROD_ID',          	   filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '고객사',		    name: 'CLIENT',          	   filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '수출단가',		name: 'OUT_PRICE',             filter:{type:'text'},          	sortable:true,            align:'center', formatter :function(v) {
		      return Number(v.value).toFixed(4);
        }},
        /* {header: '상해단가',		name: 'SH_PRICE',             filter:{type:'text'},          	sortable:true,            align:'center'        }, */
        {header: '비고',       		name: 'BIGO',           	   filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '생성일자',        name: 'CREATE_DATE',           filter:{type:'text'},            sortable:true,            align:'center'        },
        {header: '생성자',          name: 'CREATE_USER',           filter:{type:'text'},            sortable:true,            align:'center'        },
        {header: '수정일자',        name: 'UPDATE_DATE',           filter:{type:'text'},            sortable:true,            align:'center'        },
        {header: '수정자',          name: 'UPDATE_USER',           filter:{type:'text'},            sortable:true,            align:'center'        }
    ],
    columnOptions: {
    	resizable: true
    }
});

var gridEdit = new tui.Grid({
    el: document.getElementById('prdtInfoGridEdit'),
    data: [],
    rowHeaders: ['checkbox', 'rowNum'],//'checkbox', 'rowNum'
    header:{
    	height: 40
    },
    columns: [
		{header: '종류',         	name: 'KIND',          		   filter:{type:'text'},         	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: '품명',     		name: 'PROD_NM',          	   filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: '상세품명',       	name: 'PROD_DTL_NM',           filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: '품호',		    name: 'PROD_ID',          	   filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: '고객사',       	name: 'CLIENT',                filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: '수출단가',       	name: 'OUT_PRICE',             filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text', validation:{dataType:'number'}, formatter :function(v) {
		      return Number(v.value).toFixed(4);
	    }},
		/* {header: '상해단가',       	name: 'SH_PRICE',              filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text', validation:{dataType:'number'}}, */
		{header: '비고',       		name: 'BIGO',           	   filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: '생성일자',        name: 'CREATE_DATE',           filter:{type:'text'},            sortable:true,            align:'center'        },
		{header: '생성자',          name: 'CREATE_USER',           filter:{type:'text'},            sortable:true,            align:'center'        },
		{header: '수정일자',        name: 'UPDATE_DATE',           filter:{type:'text'},            sortable:true,            align:'center'        },
		{header: '수정자',          name: 'UPDATE_USER',           filter:{type:'text'},            sortable:true,            align:'center'        }
    ],
    columnOptions: {
    	resizable: true
    }
    
});

var dataSet;
var prdtInfo = {
	init:function(){
		console.log("[DEBUG] 콤보박스 초기화(세팅)");
		//this.comboList();
	},
	comboList:function(){
		var params = {};
		$.ajax({
		    url : "/set/prdtInfo/comboList",
		    method :"POST",
		    data:params
		}).success(function(result) {
			dataSet = result;
			gridView.resetData(result);
			prdtInfo.view();
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    });
	},
	search:function(){
		//var params = {'PROD_ID':'PROD_01'};
		var params = {};
		$.ajax({
		    url : "/set/prdtInfo/list",
		    method :"POST",
		    data:params
		}).success(function(result) {
			dataSet = result;
			gridView.resetData(result);
			prdtInfo.view();
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    })/* .error(function(ev){
	    	alert('오류 : ' + ev);
	    }) */;
	},
	view:function(){
		$('#prdtInfoGridEdit').hide();
		$('#prdtInfoGridView').show();
		$('#editBtn').show();
		$('#saveBtn').hide();
		$('#delBtn').hide();
		$('#addBtn').hide();
		$('#viewBtn').hide();
	},
	edit:function(){
		$('#prdtInfoGridView').hide();
		$('#prdtInfoGridEdit').show();
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
	        return v['PROD_ID'] != null && v['PROD_ID'] != '';
	    });
		
		let chkLen = saveData.createdRows.length + saveData.updatedRows.length + saveData.deletedRows.length;
		
		if(chkLen > 0){
			$.ajax({
			    url : "/set/prdtInfo/save",
			    contentType : "application/json",
			    method :"POST",
			    data:JSON.stringify(saveData)
			}).success(function(result) {
				alert(" ㅇ 추가 : " + result["insert"] + "건\n" + " ㅇ 수정 : " + result["update"] + "건\n" + " ㅇ 삭제 : " + result["delete"] + "건");
				prdtInfo.search();
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
	
	$('#searchBtn').click(prdtInfo.search);
	$('#viewBtn').click(prdtInfo.view);
	$('#editBtn').click(prdtInfo.edit);
	$('#saveBtn').click(prdtInfo.save);
	$('#addBtn').click(prdtInfo.add);
	$('#delBtn').click(prdtInfo.del);
	
	dateUtil.init();
	prdtInfo.init();
	prdtInfo.search();
	
});
</script>

