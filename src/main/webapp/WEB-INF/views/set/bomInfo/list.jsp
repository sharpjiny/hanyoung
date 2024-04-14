<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="row-fluid">
    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">BOM 기준정보 리스트</div>
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
                <h4>Production</h4>
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
				<div id="bomInfoGridView"></div>
				<div id="bomInfoGridEdit" style="display:none"></div>
				<p></p>
				
				<div class="table-toolbar" style="margin: 0px 5px 3px 0px; padding: 0px 30px 12px 0px; text-align:right">
				<h4>Coating</h4>
                   <div class="btn-group">
                      <button type="button" class="btn btn-success" id="saveCoatingBtn" style="display:none">Save <i class="icon-plus icon-white"></i></button>
                      <button type="button" class="btn btn-success" id="addCoatingBtn" style="display:none">New Add <i class="icon-plus icon-white"></i></button>
                      <button type="button" class="btn btn-success" id="delCoatingBtn" style="display:none">Delete <i class="icon-plus icon-white"></i></button>
                      <button type="button" class="btn btn-success" id="editCoatingBtn">Edit <i class="icon-plus icon-white"></i></button>
                      <button type="button" class="btn btn-success" id="viewCoatingBtn" style="display:none">View <i class="icon-plus icon-white"></i></button>
                   </div>
                </div>
				<div id="bomInfoCoatingGridView"></div>
				<div id="bomInfoCoatingGridEdit" style="display:none"></div>
				<p></p>
				
				<div class="table-toolbar" style="margin: 0px 5px 3px 0px; padding: 0px 30px 12px 0px; text-align:right">
				<h4>Packing</h4>
                   <div class="btn-group">
                      <button type="button" class="btn btn-success" id="savePackingBtn" style="display:none">Save <i class="icon-plus icon-white"></i></button>
                      <button type="button" class="btn btn-success" id="addPackingBtn" style="display:none">New Add <i class="icon-plus icon-white"></i></button>
                      <button type="button" class="btn btn-success" id="delPackingBtn" style="display:none">Delete <i class="icon-plus icon-white"></i></button>
                      <button type="button" class="btn btn-success" id="editPackingBtn">Edit <i class="icon-plus icon-white"></i></button>
                      <button type="button" class="btn btn-success" id="viewPackingBtn" style="display:none">View <i class="icon-plus icon-white"></i></button>
                   </div>
                </div>
				<div id="bomInfoPackingGridView"></div>
				<div id="bomInfoPackingGridEdit" style="display:none"></div>
            </div>
        </div>
    </div>
    <!-- /block -->
</div>


<script>
var BomInfoGrid = tui.Grid;
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

var kindList = [{value:'', text:'-선택-'}];
var prodDtlList = [{value:'', text:'-선택-'}];
var gridView = new tui.Grid({
    el: document.getElementById('bomInfoGridView'),
    //scrollX: true,
    //scrollY: true,
    data: [],
    rowHeaders: ['rowNum'],//'checkbox', 'rowNum'
    header:{
    	height: 40
    },
    bodyHeight: 350,
    columns: [
        {header: '종류',         	name: 'KIND',          		   filter:{type:'text'},         	sortable:true,            align:'center'        },
        {header: '품명',     		name: 'PROD_NM',          	   filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '상세품명',       	name: 'PROD_DTL_NM',           filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '품호',		    name: 'PROD_ID',          	   filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '1.45',		name: 'THICKNESS_1',           filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '2.0',		    name: 'THICKNESS_2',           filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '2.5',		    name: 'THICKNESS_3',           filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '2.9',		    name: 'THICKNESS_4',           filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '3.8',		    name: 'THICKNESS_5',           filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '侧面筛网',		name: 'MESH',           		filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '底面筛网',		name: 'MESH_OUT',           	filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '추가두께',		name: 'THICKNESS_6',           filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '비고',       	name: 'BIGO',           	   filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '생성일자',        name: 'CREATE_DATE',           filter:{type:'text'},            sortable:true,            align:'center',       hidden: true        },
        {header: '생성자',         name: 'CREATE_USER',           filter:{type:'text'},            sortable:true,            align:'center',       hidden: true        },
        {header: '수정일자',        name: 'UPDATE_DATE',           filter:{type:'text'},            sortable:true,            align:'center',       hidden: true       },
        {header: '수정자',         name: 'UPDATE_USER',           filter:{type:'text'},            sortable:true,            align:'center',       hidden: true        }
    ]
});


var kindCoatingList = [{value:'', text:'-선택-'}];
var prodDtlCoatingList = [{value:'', text:'-선택-'}];
var gridViewCoating = new tui.Grid({
    el: document.getElementById('bomInfoCoatingGridView'),
    //scrollX: true,
    //scrollY: true,
    data: [],
    rowHeaders: ['rowNum'],//'checkbox', 'rowNum'
    header:{
    	height: 40
    },
    bodyHeight: 350,
    columns: [
        {header: '종류',         	name: 'KIND',          		   filter:{type:'text'},         	sortable:true,            align:'center'        },
        {header: '품명',     		name: 'PROD_NM',          	   filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '상세품명',       	name: 'PROD_DTL_NM',           filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '품호',		    name: 'PROD_ID',          	   filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '합계중량',		name: 'SUM_WEIGHT',           filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '파우더중량',		name: 'PWD_WEIGHT',           filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '비고',       	name: 'BIGO',           	   filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '생성일자',        name: 'CREATE_DATE',           filter:{type:'text'},            sortable:true,            align:'center',       hidden: true        },
        {header: '생성자',          name: 'CREATE_USER',           filter:{type:'text'},            sortable:true,            align:'center',       hidden: true        },
        {header: '수정일자',        name: 'UPDATE_DATE',           filter:{type:'text'},            sortable:true,            align:'center',       hidden: true       },
        {header: '수정자',          name: 'UPDATE_USER',           filter:{type:'text'},            sortable:true,            align:'center',       hidden: true        }
    ]
});

var kindPackingList = [{value:'', text:'-선택-'}];
var prodDtlPackingList = [{value:'', text:'-선택-'}];
var gridViewPacking = new tui.Grid({
    el: document.getElementById('bomInfoPackingGridView'),
    //scrollX: true,
    //scrollY: true,
    data: [],
    rowHeaders: ['rowNum'],//'checkbox', 'rowNum'
    header:{
    	height: 40
    },
    bodyHeight: 350,
    columns: [
        {header: '종류',         	name: 'KIND',          		   filter:{type:'text'},         	sortable:true,            align:'center'        },
        {header: '품명',     		name: 'PROD_NM',          	   filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '상세품명',       	name: 'PROD_DTL_NM',           filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '품호',		    name: 'PROD_ID',          	   filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: 'POP',		    name: 'POP_NM',           filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: 'POP품호',		name: 'POP_ID',           filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: 'POP사용량',		name: 'POP_CNT',           filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '상자',		    name: 'BOX_NM',           filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '상자품호',		name: 'BOX_ID',           filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '상자사용량',		name: 'BOX_CNT',           filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '비고',       	name: 'BIGO',           	   filter:{type:'text'},          	sortable:true,            align:'center'        },
        {header: '생성일자',        name: 'CREATE_DATE',           filter:{type:'text'},            sortable:true,            align:'center',       hidden: true        },
        {header: '생성자',         name: 'CREATE_USER',           filter:{type:'text'},            sortable:true,            align:'center',       hidden: true        },
        {header: '수정일자',        name: 'UPDATE_DATE',           filter:{type:'text'},            sortable:true,            align:'center',       hidden: true       },
        {header: '수정자',         name: 'UPDATE_USER',           filter:{type:'text'},            sortable:true,            align:'center',       hidden: true        }
    ]
});

var gridEdit = new tui.Grid({
    el: document.getElementById('bomInfoGridEdit'),
    data: [],
    rowHeaders: ['checkbox', 'rowNum'],//'checkbox', 'rowNum'
    header:{
    	height: 40
    },
    bodyHeight: 350,
    columns: [
		{header: '종류', name: 'KIND', filter:{type:'text'}, sortable:true, align:'center', className:'clickable', validation:{required:true}, formatter:'listItemText',
        	onAfterChange:function(o){
	   	    	searchCombo.getProdId(o);
	   	    },
        	editor:{
	        	type:'select', // checkbox, select
	        	options:{
	        		listItems:kindList
	       		}
	    	},
	    	relations:[
	    		{
	    			targetNames: ['PROD_NM'],
	    			listItems: function(o){
	    				return searchCombo.getMatched(o, 'kind');
	    			}
	    		}
	    	]
		},
		{header: '품명', name: 'PROD_NM', filter:{type:'text'}, sortable:true, align:'center', className:'clickable', validation:{required:true}, formatter:'listItemText',
			onAfterChange:function(o){
	   	    	searchCombo.getProdId(o);
	   	    },
			editor:{type:'select', // checkbox, select
        	options:{
        		listItems:[]
       		}},
	    	relations:[
   	    		{
   	    			targetNames: ['PROD_DTL_NM'],
   	    			listItems: function(o) {
   	    	          return searchCombo.getMatched(o, 'prodNm');
   	    	        }
   	    		}
	   	    ]},
		{header: '상세품명', name: 'PROD_DTL_NM', filter:{type:'text'}, sortable:true, align:'center', className:'clickable', width:150, validation:{required:true}, formatter:'listItemText',
	   	    onAfterChange:function(o){
	   	    	searchCombo.getProdId(o);
	   	    },
   	    	editor:{type:'select', // checkbox, select
        	options:{
        		listItems:[{value:'', text:'-선택-'}]
       		}}},
		{header: '품호',       	name: 'PROD_ID',      filter:{type:'text'},         sortable:true,            align:'center', 		className:'clickable',        editor:'text', disabled:true},
		{header: '1.45',		    name: 'THICKNESS_1',           filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: '2.0',		    name: 'THICKNESS_2',           filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: '2.5',		    name: 'THICKNESS_3',           filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: '2.9',		    name: 'THICKNESS_4',           filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: '3.8',		    name: 'THICKNESS_5',           filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: '侧面筛网',		    name: 'MESH',           filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: '底面筛网',		    name: 'MESH_OUT',           filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: '추가두께',		    name: 'THICKNESS_6',           filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: '비고',       		name: 'BIGO',           	   filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: '생성일자',        name: 'CREATE_DATE',           filter:{type:'text'},            sortable:true,            align:'center',       hidden: true },
		{header: '생성자',          name: 'CREATE_USER',           filter:{type:'text'},            sortable:true,            align:'center',       hidden: true        },
		{header: '수정일자',        name: 'UPDATE_DATE',           filter:{type:'text'},            sortable:true,            align:'center',       hidden: true        },
		{header: '수정자',          name: 'UPDATE_USER',           filter:{type:'text'},            sortable:true,            align:'center',       hidden: true        }
    ]
});

var gridEditCoating = new tui.Grid({
    el: document.getElementById('bomInfoCoatingGridEdit'),
    data: [],
    rowHeaders: ['checkbox', 'rowNum'],//'checkbox', 'rowNum'
    header:{
    	height: 40
    },
    bodyHeight: 350,
    columns: [
		{header: '종류', name: 'KIND', filter:{type:'text'}, sortable:true, align:'center', className:'clickable', validation:{required:true}, formatter:'listItemText',
        	onAfterChange:function(o){
        		searchComboCoating.getProdId(o);
	   	    },
        	editor:{
	        	type:'select', // checkbox, select
	        	options:{
	        		listItems:kindList
	       		}
	    	},
	    	relations:[
	    		{
	    			targetNames: ['PROD_NM'],
	    			listItems: function(o){
	    				return searchComboCoating.getMatched(o, 'kind');
	    			}
	    		}
	    	]
		},
		{header: '품명', name: 'PROD_NM', filter:{type:'text'}, sortable:true, align:'center', className:'clickable', validation:{required:true}, formatter:'listItemText',
			onAfterChange:function(o){
				searchComboCoating.getProdId(o);
	   	    },
			editor:{type:'select', // checkbox, select
        	options:{
        		listItems:[]
       		}},
	    	relations:[
   	    		{
   	    			targetNames: ['PROD_DTL_NM'],
   	    			listItems: function(o) {
   	    	          return searchComboCoating.getMatched(o, 'prodNm');
   	    	        }
   	    		}
	   	    ]},
		{header: '상세품명', name: 'PROD_DTL_NM', filter:{type:'text'}, sortable:true, align:'center', className:'clickable', width:150, validation:{required:true}, formatter:'listItemText',
	   	    onAfterChange:function(o){
	   	    	searchComboCoating.getProdId(o);
	   	    },
   	    	editor:{type:'select', // checkbox, select
        	options:{
        		listItems:[{value:'', text:'-선택-'}]
       		}}},
		{header: '품호',       	name: 'PROD_ID',      filter:{type:'text'},         sortable:true,            align:'center', 		className:'clickable',        editor:'text', disabled:true},
		{header: '합계중량',		    name: 'SUM_WEIGHT',           filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: '파우더중량',		    name: 'PWD_WEIGHT',           filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: '비고',       		name: 'BIGO',           	   filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: '생성일자',        name: 'CREATE_DATE',           filter:{type:'text'},            sortable:true,            align:'center',       hidden: true },
		{header: '생성자',          name: 'CREATE_USER',           filter:{type:'text'},            sortable:true,            align:'center',       hidden: true        },
		{header: '수정일자',        name: 'UPDATE_DATE',           filter:{type:'text'},            sortable:true,            align:'center',       hidden: true        },
		{header: '수정자',          name: 'UPDATE_USER',           filter:{type:'text'},            sortable:true,            align:'center',       hidden: true        }
    ]
});

var gridEditPacking = new tui.Grid({
    el: document.getElementById('bomInfoPackingGridEdit'),
    data: [],
    rowHeaders: ['checkbox', 'rowNum'],//'checkbox', 'rowNum'
    header:{
    	height: 40
    },
    bodyHeight: 350,
    columns: [
		{header: '종류', name: 'KIND', filter:{type:'text'}, sortable:true, align:'center', className:'clickable', validation:{required:true}, formatter:'listItemText',
        	onAfterChange:function(o){
	   	    	searchComboPacking.getProdId(o);
	   	    },
        	editor:{
	        	type:'select', // checkbox, select
	        	options:{
	        		listItems:kindPackingList
	       		}
	    	},
	    	relations:[
	    		{
	    			targetNames: ['PROD_NM'],
	    			listItems: function(o){
	    				return searchComboPacking.getMatched(o, 'kind');
	    			}
	    		}
	    	]
		},
		{header: '품명', name: 'PROD_NM', filter:{type:'text'}, sortable:true, align:'center', className:'clickable', validation:{required:true}, formatter:'listItemText',
			onAfterChange:function(o){
				searchComboPacking.getProdId(o);
	   	    },
			editor:{type:'select', // checkbox, select
        	options:{
        		listItems:[]
       		}},
	    	relations:[
   	    		{
   	    			targetNames: ['PROD_DTL_NM'],
   	    			listItems: function(o) {
   	    	          return searchComboPacking.getMatched(o, 'prodNm');
   	    	        }
   	    		}
	   	    ]},
		{header: '상세품명', name: 'PROD_DTL_NM', filter:{type:'text'}, sortable:true, align:'center', className:'clickable', width:150, validation:{required:true}, formatter:'listItemText',
	   	    onAfterChange:function(o){
	   	    	searchComboPacking.getProdId(o);
	   	    },
   	    	editor:{type:'select', // checkbox, select
        	options:{
        		listItems:[{value:'', text:'-선택-'}]
       		}}},
		{header: '품호',       	name: 'PROD_ID',      filter:{type:'text'},         sortable:true,            align:'center', 		className:'clickable',        editor:'text', disabled:true},
		{header: 'POP',		    name: 'POP_NM',           filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: 'POP품호',		    name: 'POP_ID',           filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: 'POP사용량',		    name: 'POP_CNT',           filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: '상자',		    name: 'BOX_NM',           filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: '상자품호',		    name: 'BOX_ID',           filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: '상자사용량',		    name: 'BOX_CNT',           filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: '비고',       		name: 'BIGO',           	   filter:{type:'text'},          	sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: '생성일자',        name: 'CREATE_DATE',           filter:{type:'text'},            sortable:true,            align:'center',       hidden: true },
		{header: '생성자',          name: 'CREATE_USER',           filter:{type:'text'},            sortable:true,            align:'center',       hidden: true        },
		{header: '수정일자',        name: 'UPDATE_DATE',           filter:{type:'text'},            sortable:true,            align:'center',       hidden: true        },
		{header: '수정자',          name: 'UPDATE_USER',           filter:{type:'text'},            sortable:true,            align:'center',       hidden: true        }
    ]
});

var dataSet;
var dataSetCoating;
var dataSetPacking;

var bomInfo = {
	init:function(){
		this.kindSets();
		searchCombo.getProdIdRowList();
	},
	kindSets:function(){
		var params = {"code_group":"product_kind"};
		$.ajax({
		    url : "/inout/prdt/kindSets",
		    method :"POST",
		    data:params
		}).success(function(result) {
			$.each(result["KIND"], function(i, item){
				$('#KIND').append($('<option/>').val(item.CODE).text(item.NAME));
				kindList.push({value:item.CODE, text:item.NAME});
			});
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    });
	},
	comboList:function(){
		var params = {};
		$.ajax({
		    url : "/set/bomInfo/comboList",
		    method :"POST",
		    data:params
		}).success(function(result) {
			dataSet = result;
			gridView.resetData(result);
			bomInfo.view();
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    });
	},
	search:function(){
		//var params = {'PROD_ID':'PROD_01'};
		var params = {};
		$.ajax({
		    url : "/set/bomInfo/list",
		    method :"POST",
		    data:params
		}).success(function(result) {
			dataSet = result;
			gridView.resetData(result);
			bomInfo.view();
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    })/* .error(function(ev){
	    	alert('오류 : ' + ev);
	    }) */;
	},
	view:function(){
		$('#bomInfoGridEdit').hide();
		$('#bomInfoGridView').show();
		$('#editBtn').show();
		$('#saveBtn').hide();
		$('#delBtn').hide();
		$('#addBtn').hide();
		$('#viewBtn').hide();
	},
	edit:function(){
		$('#bomInfoGridView').hide();
		$('#bomInfoGridEdit').show();
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
			    url : "/set/bomInfo/save",
			    contentType : "application/json",
			    method :"POST",
			    data:JSON.stringify(saveData)
			}).success(function(result) {
				alert(" ㅇ 추가 : " + result["insert"] + "건\n" + " ㅇ 수정 : " + result["update"] + "건\n" + " ㅇ 삭제 : " + result["delete"] + "건");
				bomInfo.search();
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
		gridEdit.appendRow([]);
	}
}

var bomInfoCoating = {
		init:function(){
			this.kindSets();
			searchComboCoating.getProdIdRowList();
		},
		kindSets:function(){
			var params = {"code_group":"product_kind"};
			$.ajax({
			    url : "/inout/prdt/kindSets",
			    method :"POST",
			    data:params
			}).success(function(result) {
				$.each(result["KIND"], function(i, item){
					$('#KIND').append($('<option/>').val(item.CODE).text(item.NAME));
					kindCoatingList.push({value:item.CODE, text:item.NAME});
				});
			}).fail(function(ev) {
		    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
		    });
		},
		comboList:function(){
			var params = {};
			$.ajax({
			    url : "/set/bomInfo/comboList",
			    method :"POST",
			    data:params
			}).success(function(result) {
				dataSetCoating = result;
				gridViewCoating.resetData(result);
				bomInfoCoating.view();
			}).fail(function(ev) {
		    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
		    });
		},
		search:function(){
			//var params = {'PROD_ID':'PROD_01'};
			var params = {};
			$.ajax({
			    url : "/set/bomInfo/listCoating",
			    method :"POST",
			    data:params
			}).success(function(result) {
				dataSetCoating = result;
				gridViewCoating.resetData(result);
				bomInfoCoating.view();
			}).fail(function(ev) {
		    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
		    });
		},
		view:function(){
			$('#bomInfoCoatingGridEdit').hide();
			$('#bomInfoCoatingGridView').show();
			$('#editCoatingBtn').show();
			$('#saveCoatingBtn').hide();
			$('#delCoatingBtn').hide();
			$('#addCoatingBtn').hide();
			$('#viewCoatingBtn').hide();
		},
		edit:function(){
			$('#bomInfoCoatingGridView').hide();
			$('#bomInfoCoatingGridEdit').show();
			$('#viewCoatingBtn').show();
			$('#editCoatingBtn').hide();
			$('#saveCoatingBtn').show();
			$('#addCoatingBtn').show();
			$('#delCoatingBtn').show();
			
			gridEditCoating.resetData(dataSetCoating);
			gridEditCoating.refreshLayout();
			
		},
		save:function(){
			let saveData = gridEditCoating.getModifiedRows();
			
			// 빈값 제거..
			saveData.createdRows = saveData.createdRows.filter(function(v){
		        return v['PROD_ID'] != null && v['PROD_ID'] != '';
		    });
			
			let chkLen = saveData.createdRows.length + saveData.updatedRows.length + saveData.deletedRows.length;
			
			if(chkLen > 0){
				$.ajax({
				    url : "/set/bomInfo/saveCoating",
				    contentType : "application/json",
				    method :"POST",
				    data:JSON.stringify(saveData)
				}).success(function(result) {
					alert(" ㅇ 추가 : " + result["insert"] + "건\n" + " ㅇ 수정 : " + result["update"] + "건\n" + " ㅇ 삭제 : " + result["delete"] + "건");
					bomInfo.search();
				}).fail(function(ev) {
			    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
			    });
			}else{
				alert("수정할 데이터가 없습니다.");
			}
		},
		del:function(){
			let chkLen = gridEditCoating.getCheckedRows().length;
			if(chkLen > 0){
				gridEditCoating.getCheckedRows().forEach(function(v, i){
					gridEditCoating.removeRow(v.rowKey);
				});
			}else{
				alert("선택된 row가 없습니다.");
			}
		},
		add:function(){
			gridEditCoating.appendRow([]);
		}
	}


var bomInfoPacking = {
		init:function(){
			this.kindSets();
			searchComboPacking.getProdIdRowList();
		},
		kindSets:function(){
			var params = {"code_group":"product_kind"};
			$.ajax({
			    url : "/inout/prdt/kindSets",
			    method :"POST",
			    data:params
			}).success(function(result) {
				$.each(result["KIND"], function(i, item){
					$('#KIND').append($('<option/>').val(item.CODE).text(item.NAME));
					kindPackingList.push({value:item.CODE, text:item.NAME});
				});
			}).fail(function(ev) {
		    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
		    });
		},
		comboList:function(){
			var params = {};
			$.ajax({
			    url : "/set/bomInfo/comboList",
			    method :"POST",
			    data:params
			}).success(function(result) {
				dataSetPacking = result;
				gridViewPacking.resetData(result);
				bomInfoPacking.view();
			}).fail(function(ev) {
		    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
		    });
		},
		search:function(){
			//var params = {'PROD_ID':'PROD_01'};
			var params = {};
			$.ajax({
			    url : "/set/bomInfo/listPacking",
			    method :"POST",
			    data:params
			}).success(function(result) {
				dataSetPacking = result;
				gridViewPacking.resetData(result);
				bomInfoPacking.view();
			}).fail(function(ev) {
		    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
		    });
		},
		view:function(){
			$('#bomInfoPackingGridEdit').hide();
			$('#bomInfoPackingGridView').show();
			$('#editPackingBtn').show();
			$('#savePackingBtn').hide();
			$('#delPackingBtn').hide();
			$('#addPackingBtn').hide();
			$('#viewPackingBtn').hide();
		},
		edit:function(){
			$('#bomInfoPackingGridView').hide();
			$('#bomInfoPackingGridEdit').show();
			$('#viewPackingBtn').show();
			$('#editPackingBtn').hide();
			$('#savePackingBtn').show();
			$('#addPackingBtn').show();
			$('#delPackingBtn').show();
			
			gridEditPacking.resetData(dataSetPacking);
			gridEditPacking.refreshLayout();
			
		},
		save:function(){
			let saveData = gridEditPacking.getModifiedRows();
			
			// 빈값 제거..
			saveData.createdRows = saveData.createdRows.filter(function(v){
		        return v['PROD_ID'] != null && v['PROD_ID'] != '';
		    });
			
			let chkLen = saveData.createdRows.length + saveData.updatedRows.length + saveData.deletedRows.length;
			
			if(chkLen > 0){
				$.ajax({
				    url : "/set/bomInfo/savePacking",
				    contentType : "application/json",
				    method :"POST",
				    data:JSON.stringify(saveData)
				}).success(function(result) {
					alert(" ㅇ 추가 : " + result["insert"] + "건\n" + " ㅇ 수정 : " + result["update"] + "건\n" + " ㅇ 삭제 : " + result["delete"] + "건");
					bomInfo.search();
				}).fail(function(ev) {
			    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
			    });
			}else{
				alert("수정할 데이터가 없습니다.");
			}
		},
		del:function(){
			let chkLen = gridEditPacking.getCheckedRows().length;
			if(chkLen > 0){
				gridEditPacking.getCheckedRows().forEach(function(v, i){
					gridEditPacking.removeRow(v.rowKey);
				});
			}else{
				alert("선택된 row가 없습니다.");
			}
		},
		add:function(){
			gridEditPacking.appendRow([]);
		}
	}

var searchCombo = {
	getProdNm:function(e){
		var params = {"kind":$(this).val()};
		$.ajax({
		    url : "/inout/prdt/prodNmList",
		    method :"POST",
		    data:params
		}).success(function(result) {
			$('#PROD_NM').find('option:not(:eq(0))').remove();
			$('#PROD_DTL_NM').find('option:not(:eq(0))').remove();
			$('#PROD_ID').val('');
			$.each(result["PROD_NM"], function(i, item){
				$('#PROD_NM').append($('<option/>').val(item.CODE).text(item.NAME));
			});
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    });
	},
	getProdDtlNm:function(){
		var params = {"kind":$('#KIND').val(), "prodNm":$(this).val()};
		$.ajax({
		    url : "/inout/prdt/prodDtlNmList",
		    method :"POST",
		    data:params
		}).success(function(result) {
			$('#PROD_DTL_NM').find('option:not(:eq(0))').remove();
			$('#PROD_ID').val('');
			$.each(result["PROD_DTL_NM"], function(i, item){
				$('#PROD_DTL_NM').append($('<option/>').val(item.CODE).text(item.NAME));
			});
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    });
	},
	getProdId:function(o){
		var stop = true;
		var kind = '';
		var prodNm = '';
		var prodDtlNm = '';
		var params = {};
		
		if(o.rowKey != null){
			gridEdit.setValue(o.rowKey, "PROD_ID", '');
			kind = gridEdit.getValue(o.rowKey, "KIND");
			prodNm = gridEdit.getValue(o.rowKey, "PROD_NM");
			prodDtlNm = gridEdit.getValue(o.rowKey, "PROD_DTL_NM");
		}else{
			kind = $('#KIND').val();
			prodNm = $('#PROD_NM').val();
			prodDtlNm = $(this).val();
		}
		
		if(kind == null || prodNm == null || prodDtlNm == null || kind == '' || prodNm == '' || prodDtlNm == ''){
			return;
		}else{
			params = {"kind":kind, "prodNm":prodNm, "prodDtlNm":prodDtlNm};
			$.ajax({
			    url : "/inout/prdt/prodIdList",
			    method :"POST",
			    data:params
			}).success(function(result) {
				if(o.rowKey != null){
					gridEdit.setValue(o.rowKey, "PROD_ID", result["PROD_ID"][0]["CODE"]);
				}else{
					$('#PROD_ID').val('');
					$.each(result["PROD_ID"], function(i, item){
						$('#PROD_ID').val(item.CODE);
					});
				}
				
			}).fail(function(ev) {
		    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
		    	$('#PROD_ID').text('');
		    });
		}
	},
	getProdIdRowList:function(){
		$.ajax({
		    url : "/inout/prdt/getProdIdRowList",
		    method :"POST",
		    data:{}
		}).success(function(result) {
			prodIdRowList = result["PROD_ID_LIST"];
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    });
	},
	getMatched:function(o, p){
		let ret = [{value:'', text:'-선택-'}];
		let temp = prodIdRowList.filter(function(item){
			if(p == 'prodNm'){
				return item.KIND ==  o.row.KIND && item.PROD_NM == o.row.PROD_NM;
			}else if(p == 'kind'){
				return item.KIND ==  o.row.KIND;
			}else {
				return item.KIND ==  o.row.KIND && item.PROD_NM == o.row.PROD_NM && item.PROD_DTL_NM.indexOf(o.row.PROD_DTL_NM) >= 0;
			}
			return false;
		});
		
		if(temp != null && temp.length > 0 ){
			let items = [];
			if(p == 'prodNm'){
				items = temp[0].PROD_DTL_NM.split(',');
			}else if(p == 'kind'){
				$.each(temp, function(i, v){
					items.push(temp[i]["PROD_NM"]);
				});
			}else {
				items = temp[0].CLIENT.split(',');
			}
			$.each(items, function(i, v){
				ret.push({text:v, value:v});
			});
		}
		
		return	ret;
	}
}

var searchComboCoating = {
		getProdNm:function(e){
			var params = {"kind":$(this).val()};
			$.ajax({
			    url : "/inout/prdt/prodNmList",
			    method :"POST",
			    data:params
			}).success(function(result) {
				$('#PROD_NM').find('option:not(:eq(0))').remove();
				$('#PROD_DTL_NM').find('option:not(:eq(0))').remove();
				$('#PROD_ID').val('');
				$.each(result["PROD_NM"], function(i, item){
					$('#PROD_NM').append($('<option/>').val(item.CODE).text(item.NAME));
				});
			}).fail(function(ev) {
		    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
		    });
		},
		getProdDtlNm:function(){
			var params = {"kind":$('#KIND').val(), "prodNm":$(this).val()};
			$.ajax({
			    url : "/inout/prdt/prodDtlNmList",
			    method :"POST",
			    data:params
			}).success(function(result) {
				$('#PROD_DTL_NM').find('option:not(:eq(0))').remove();
				$('#PROD_ID').val('');
				$.each(result["PROD_DTL_NM"], function(i, item){
					$('#PROD_DTL_NM').append($('<option/>').val(item.CODE).text(item.NAME));
				});
			}).fail(function(ev) {
		    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
		    });
		},
		getProdId:function(o){
			var stop = true;
			var kind = '';
			var prodNm = '';
			var prodDtlNm = '';
			var params = {};
			
			if(o.rowKey != null){
				gridEditCoating.setValue(o.rowKey, "PROD_ID", '');
				kind = gridEditCoating.getValue(o.rowKey, "KIND");
				prodNm = gridEditCoating.getValue(o.rowKey, "PROD_NM");
				prodDtlNm = gridEditCoating.getValue(o.rowKey, "PROD_DTL_NM");
			}else{
				kind = $('#KIND').val();
				prodNm = $('#PROD_NM').val();
				prodDtlNm = $(this).val();
			}
			
			if(kind == null || prodNm == null || prodDtlNm == null || kind == '' || prodNm == '' || prodDtlNm == ''){
				return;
			}else{
				params = {"kind":kind, "prodNm":prodNm, "prodDtlNm":prodDtlNm};
				$.ajax({
				    url : "/inout/prdt/prodIdList",
				    method :"POST",
				    data:params
				}).success(function(result) {
					if(o.rowKey != null){
						gridEditCoating.setValue(o.rowKey, "PROD_ID", result["PROD_ID"][0]["CODE"]);
					}else{
						$('#PROD_ID').val('');
						$.each(result["PROD_ID"], function(i, item){
							$('#PROD_ID').val(item.CODE);
						});
					}
					
				}).fail(function(ev) {
			    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
			    	$('#PROD_ID').text('');
			    });
			}
		},
		getProdIdRowList:function(){
			$.ajax({
			    url : "/inout/prdt/getProdIdRowList",
			    method :"POST",
			    data:{}
			}).success(function(result) {
				prodIdRowList = result["PROD_ID_LIST"];
			}).fail(function(ev) {
		    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
		    });
		},
		getMatched:function(o, p){
			let ret = [{value:'', text:'-선택-'}];
			let temp = prodIdRowList.filter(function(item){
				if(p == 'prodNm'){
					return item.KIND ==  o.row.KIND && item.PROD_NM == o.row.PROD_NM;
				}else if(p == 'kind'){
					return item.KIND ==  o.row.KIND;
				}else {
					return item.KIND ==  o.row.KIND && item.PROD_NM == o.row.PROD_NM && item.PROD_DTL_NM.indexOf(o.row.PROD_DTL_NM) >= 0;
				}
				return false;
			});
			
			if(temp != null && temp.length > 0 ){
				let items = [];
				if(p == 'prodNm'){
					items = temp[0].PROD_DTL_NM.split(',');
				}else if(p == 'kind'){
					$.each(temp, function(i, v){
						items.push(temp[i]["PROD_NM"]);
					});
				}else {
					items = temp[0].CLIENT.split(',');
				}
				$.each(items, function(i, v){
					ret.push({text:v, value:v});
				});
			}
			
			return	ret;
		}
	}


var searchComboPacking = {
		getProdNm:function(e){
			var params = {"kind":$(this).val()};
			$.ajax({
			    url : "/inout/prdt/prodNmList",
			    method :"POST",
			    data:params
			}).success(function(result) {
				$('#PROD_NM').find('option:not(:eq(0))').remove();
				$('#PROD_DTL_NM').find('option:not(:eq(0))').remove();
				$('#PROD_ID').val('');
				$.each(result["PROD_NM"], function(i, item){
					$('#PROD_NM').append($('<option/>').val(item.CODE).text(item.NAME));
				});
			}).fail(function(ev) {
		    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
		    });
		},
		getProdDtlNm:function(){
			var params = {"kind":$('#KIND').val(), "prodNm":$(this).val()};
			$.ajax({
			    url : "/inout/prdt/prodDtlNmList",
			    method :"POST",
			    data:params
			}).success(function(result) {
				$('#PROD_DTL_NM').find('option:not(:eq(0))').remove();
				$('#PROD_ID').val('');
				$.each(result["PROD_DTL_NM"], function(i, item){
					$('#PROD_DTL_NM').append($('<option/>').val(item.CODE).text(item.NAME));
				});
			}).fail(function(ev) {
		    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
		    });
		},
		getProdId:function(o){
			var stop = true;
			var kind = '';
			var prodNm = '';
			var prodDtlNm = '';
			var params = {};
			
			if(o.rowKey != null){
				gridEditPacking.setValue(o.rowKey, "PROD_ID", '');
				kind = gridEditPacking.getValue(o.rowKey, "KIND");
				prodNm = gridEditPacking.getValue(o.rowKey, "PROD_NM");
				prodDtlNm = gridEditPacking.getValue(o.rowKey, "PROD_DTL_NM");
			}else{
				kind = $('#KIND').val();
				prodNm = $('#PROD_NM').val();
				prodDtlNm = $(this).val();
			}
			
			if(kind == null || prodNm == null || prodDtlNm == null || kind == '' || prodNm == '' || prodDtlNm == ''){
				return;
			}else{
				params = {"kind":kind, "prodNm":prodNm, "prodDtlNm":prodDtlNm};
				$.ajax({
				    url : "/inout/prdt/prodIdList",
				    method :"POST",
				    data:params
				}).success(function(result) {
					if(o.rowKey != null){
						gridEditPacking.setValue(o.rowKey, "PROD_ID", result["PROD_ID"][0]["CODE"]);
					}else{
						$('#PROD_ID').val('');
						$.each(result["PROD_ID"], function(i, item){
							$('#PROD_ID').val(item.CODE);
						});
					}
					
				}).fail(function(ev) {
			    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
			    	$('#PROD_ID').text('');
			    });
			}
		},
		getProdIdRowList:function(){
			$.ajax({
			    url : "/inout/prdt/getProdIdRowList",
			    method :"POST",
			    data:{}
			}).success(function(result) {
				prodIdRowList = result["PROD_ID_LIST"];
			}).fail(function(ev) {
		    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
		    });
		},
		getMatched:function(o, p){
			let ret = [{value:'', text:'-선택-'}];
			let temp = prodIdRowList.filter(function(item){
				if(p == 'prodNm'){
					return item.KIND ==  o.row.KIND && item.PROD_NM == o.row.PROD_NM;
				}else if(p == 'kind'){
					return item.KIND ==  o.row.KIND;
				}else {
					return item.KIND ==  o.row.KIND && item.PROD_NM == o.row.PROD_NM && item.PROD_DTL_NM.indexOf(o.row.PROD_DTL_NM) >= 0;
				}
				return false;
			});
			
			if(temp != null && temp.length > 0 ){
				let items = [];
				if(p == 'prodNm'){
					items = temp[0].PROD_DTL_NM.split(',');
				}else if(p == 'kind'){
					$.each(temp, function(i, v){
						items.push(temp[i]["PROD_NM"]);
					});
				}else {
					items = temp[0].CLIENT.split(',');
				}
				$.each(items, function(i, v){
					ret.push({text:v, value:v});
				});
			}
			
			return	ret;
		}
	}

$(function(){
	
	$('#searchBtn').click(bomInfo.search);
	$('#viewBtn').click(bomInfo.view);
	$('#editBtn').click(bomInfo.edit);
	$('#saveBtn').click(bomInfo.save);
	$('#addBtn').click(bomInfo.add);
	$('#delBtn').click(bomInfo.del);
	
	$('#viewCoatingBtn').click(bomInfoCoating.view);
	$('#editCoatingBtn').click(bomInfoCoating.edit);
	$('#saveCoatingBtn').click(bomInfoCoating.save);
	$('#addCoatingBtn').click(bomInfoCoating.add);
	$('#delCoatingBtn').click(bomInfoCoating.del);
	
	$('#viewPackingBtn').click(bomInfoPacking.view);
	$('#editPackingBtn').click(bomInfoPacking.edit);
	$('#savePackingBtn').click(bomInfoPacking.save);
	$('#addPackingBtn').click(bomInfoPacking.add);
	$('#delPackingBtn').click(bomInfoPacking.del);
	
	$('#KIND').change(searchCombo.getProdNm);
	$('#PROD_NM').change(searchCombo.getProdDtlNm);
	$('#PROD_DTL_NM').change(searchCombo.getProdId);
	
	$('#KIND').change(searchComboCoating.getProdNm);
	$('#PROD_NM').change(searchComboCoating.getProdDtlNm);
	$('#PROD_DTL_NM').change(searchComboCoating.getProdId);
	
	$('#KIND').change(searchComboPacking.getProdNm);
	$('#PROD_NM').change(searchComboPacking.getProdDtlNm);
	$('#PROD_DTL_NM').change(searchComboPacking.getProdId);
	
	dateUtil.init();
	bomInfo.init();
	bomInfo.search();
	
	bomInfoCoating.init();
	bomInfoCoating.search();
	
	bomInfoPacking.init();
	bomInfoPacking.search();
	
});
</script>

