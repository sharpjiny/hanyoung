<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
.multi-line-css {
  white-space: pre;
  background: #ff8b00;
}
</style>
<div class="row-fluid">
    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">수출계획표</div>
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
									<td width='70px'>出發地</td>
									<td>
										<select id="START_CITY" name="START_CITY" class="" title="出發地" style="margin-bottom:0px;">
											<option value="">出發地</option>
										</select>
									</td>
									<td width='70px'>目的地</td>
									<td>
										<select id="GOAL_CITY" name="GOAL_CITY" class="" title="目的地" style="margin-bottom:0px;">
											<option value="">目的地</option>
										</select>
									</td>
									<td width='70px'>订货日期</td>
									<td>
										<select id="MONTHS" name="MONTHS" class="" title="订货日期" style="margin-bottom:0px;">
											<option value="">订货日期</option>
										</select>
									</td>
									<td width='70px'>出库日期</td>
									<td>
										<input class="date" name="dateStart" id="dateStart" type="text" style="margin-bottom:0px;">
										~
										<input class="date" name="dateEnd" id="dateEnd" type="text" style="margin-bottom:0px;">
									</td>
								</tr>
							</table>
						</div>
						<div style="float:left;">	
							<table>
								<tr>
									<td width='70px'>种类</td>
									<td>
										<select id="KIND" name="KIND" class="" title="种类" style="margin-bottom:0px;">
											<option value="">种类</option>
										</select>
									</td>
									<td width='70px'>品名</td>
									<td>
										<select id="PROD_NM" name="PROD_NM" class="" title="品名" style="margin-bottom:0px;">
											<option value="">品名</option>
										</select>
									</td>
									<td width='70px'>详细品名</td>
									<td>
										<select id="PROD_DTL_NM" name="PROD_DTL_NM" class="" title="详细品名" style="margin-bottom:0px;">
											<option value="">详细品名</option>
										</select>
									</td>
									<td width='70px'>韩荣订日期</td>
									<td>
										<input class="date" name="hyDateStart" id="hyDateStart" type="text" style="margin-bottom:0px;">
										~
										<input class="date" name="hyDateEnd" id="hyDateEnd" type="text" style="margin-bottom:0px;">
									</td>
									<td style="visibility:hidden;position:absolute;">品号</td>
									<td style="visibility:hidden;position:absolute;">
										<input readonly name="PROD_ID" id="PROD_ID" type="text" style="margin-bottom:0px;">
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
                      <button type="button" class="btn btn-success" id="saveBtn" style="display:none">Save <i class="icon-plus icon-white"></i></button>
                      <button type="button" class="btn btn-success" id="addBtn" style="display:none">New Add <i class="icon-plus icon-white"></i></button>
                      <button type="button" class="btn btn-success" id="delBtn" style="display:none">Delete <i class="icon-plus icon-white"></i></button>
                      <button type="button" class="btn btn-success" id="editBtn">Edit <i class="icon-plus icon-white"></i></button>
                      <button type="button" class="btn btn-success" id="viewBtn" style="display:none">View <i class="icon-plus icon-white"></i></button>
                      <span style="margin-left:20px;">
                      <button type="button" class="btn btn-primary" id="searchBtn" >Search </button>
                      </span>
                      <!-- <div style="text-align:right;">
							<button type="button" class="btn btn-primary" id="searchBtn">Search</button>
						</div> -->
                      <!-- <button type="button" class="btn btn-success" id="searchBtn">Search <i class="icon-plus icon-white"></i></button> -->
                      <!-- btn-inverse, btn-info -->
                   </div>
                </div>
                <!-- <span style="margin-left:20px;">요일별 스케쥴 : 월요일 > 오사카, 화요일 > 런던, 수요일 > 뉴욕....</span> -->
            </div>
        </div>
        <div style="height:525px;">
			<div id="planExportGridView" ></div>
			<div id="planExportGridEdit" style="display:none"></div>
		</div>
    </div>
    <!-- /block -->
</div>

<script>
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

var startCityList = [{value:'', text:'-선택-'}];
var goalCityList = [{value:'', text:'-선택-'}];
var kindList = [{value:'', text:'-선택-'}];
//var monthList = [{value:'', text:'-선택-'}];
var prodIdRowList = [{value:'', text:'-선택-'}];

var gridView = new tui.Grid({
    el: document.getElementById('planExportGridView'),
    data: [],
    rowHeaders: ['rowNum'],//'checkbox', 'rowNum'
    header:{
    	height: 40
    },
    bodyHeight: 500,
    columns: [
		{header: '订货日期',    	  name: 'ORDER_DATE',   filter:{type:'text'},         sortable:true,            align:'center', width:120},
		{header: '番号',    		  name: 'ORDER_NO',     filter:{type:'text'},         sortable:true,            align:'center', width:160},
		{header: '韩荣订日期',   	  name: 'HY_DATE',      filter:{type:'text'},         sortable:true,            align:'center', width:120},
		{header: '出库日期',     	  name: 'OUT_DATE', 	filter:{type:'text'},         sortable:true,            align:'center', width:120},
		{header: '船期',    	  name: 'SH_DATE',      filter:{type:'text'},         sortable:true,            align:'center', width:120},
		{header: '船名航次',      name: 'SHIP_NM',   	filter:{type:'text'},         sortable:true,            align:'center', width:230},
		{header: '提单号',         name: 'EXPORT_NO',    filter:{type:'text'},         sortable:true,            align:'center', width:180},
		{header: '出發地',        name: 'FROM_PLACE_NM',filter:{type:'text'},         sortable:true,            align:'center', width:230},
		{header: '目的地',        name: 'TO_PLACE_NM',  filter:{type:'text'},         sortable:true,            align:'center', width:230},
		{header: '顾客公司',    	  name: 'CLIENT_NM',    filter:{type:'text'},         sortable:true,            align:'center', width:120},
		{header: '发货数量',     	  name: 'COUNT',    	filter:{type:'text'},         sortable:true,            align:'center', width:80, formatter :function(v) {
		      return Number(v.value).toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }},
		{header: '发货箱子',     	  name: 'BOX_COUNT',    filter:{type:'text'},         sortable:true,            align:'center', width:80, formatter :function(v) {
		      return Number(v.value).toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }},
		{header: '合计金额(USD)',	  name: 'DAL_PRICE',    filter:{type:'text'},         sortable:true,            align:'center', width:120, formatter :function(v) {
		      return Number(v.value).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }},
	    {header: '合计金额(RMB)',  name: 'RMB_PRICE',    filter:{type:'text'},         sortable:true,            align:'center', width:120, formatter :function(v) {
		      return Number(v.value).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }},
		{header: '出口完了',      name: 'IS_CHECK',     filter:{type:'text'},         sortable:true,            align:'center', width:80},
		{header: '생성일자',      name: 'CREATE_DATE',  filter:{type:'text'},         sortable:true,            align:'center',		hidden: true},
		{header: '생성자',        name: 'CREATE_USER',  filter:{type:'text'},         sortable:true,            align:'center',		hidden: true},
		{header: '수정일자',      name: 'UPDATE_DATE',  filter:{type:'text'},         sortable:true,            align:'center',		hidden: true},
		{header: '수정자',        name: 'UPDATE_USER',  filter:{type:'text'},         sortable:true,            align:'center',		hidden: true},
		{header: 'IDX',		      name: 'IDX',          filter:{type:'text'},         hidden: true}
    ],
    columnOptions: {
    	resizable: true,
    	frozenCount: 4
    },
    summary: {
        height: 10,
        position: 'bottom', // or 'top'
        columnContent: {
        	COUNT: {
             template: function(valueMap) {
               return valueMap.sum.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
             }
           },
           BOX_COUNT: {
             template: function(valueMap) {
               return valueMap.sum.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
             }
           },
           DAL_PRICE: {
              template: function(valueMap) {
                return valueMap.sum.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
              }
            },
           RMB_PRICE: {
              template: function(valueMap) {
                return valueMap.sum.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
              }
           }
       }
    }
});

var gridEdit = new tui.Grid({
    el: document.getElementById('planExportGridEdit'),
    //scrollY: true,
    data: [],
    rowHeaders: ['checkbox', 'rowNum'],//'checkbox', 'rowNum'
    header:{
    	height: 40
    },
    bodyHeight: 500,
    columns: [
		{header: '订货日期',    	name: 'ORDER_DATE',   filter:{type:'text'},		sortable:true,     align:'center', 		className:'clickable', 		width:100, validation:{required:true},        editor:{type:'datePicker', options:{format: 'yyyy-MM', language: 'ko', type: 'month'}}},
		{header: '番号',    		name: 'ORDER_NO',     filter:{type:'text'},     sortable:true,		align:'center', 	className:'clickable',      width:100, editor:'text', validation:{required:true}},
		{header: '韩荣订日期',   	name: 'HY_DATE',      filter:{type:'text'},     sortable:true,		align:'center', 	className:'clickable', 		width:100, editor:{type:'datePicker', options:{language: 'ko'}}},
		{header: '出库日期',     	name: 'OUT_DATE', 	  filter:{type:'text'},     sortable:true,		align:'center', 	className:'clickable',      width:100, editor:{type:'datePicker', options:{language: 'ko'}}},
		{header: '船期',    	name: 'SH_DATE',      filter:{type:'text'},     sortable:true,		align:'center', 	className:'clickable',      width:100, editor:{type:'datePicker', options:{language: 'ko'}}},
		{header: '船名航次',    name: 'SHIP_NM',   	  filter:{type:'text'},     sortable:true,		align:'center', 	className:'clickable',      width:150, editor:'text'},
		{header: '提单号',       name: 'EXPORT_NO',    filter:{type:'text'},     sortable:true,		align:'center', 	className:'clickable',      width:120, editor:'text'},
		{header: '出發地', 		name: 'FROM_PLACE',	  filter:{type:'text'},		sortable:true,		align:'center',		className:'clickable', 		width:150, formatter:'listItemText',
	        editor:{
	        	type:'select', // checkbox, select
	        	options:{
	        		listItems:startCityList
	       		}
        }},
		{header: '目的地', 		name: 'TO_PLACE',	  filter:{type:'text'},		sortable:true,		align:'center',		className:'clickable', 		width:150, formatter:'listItemText',
	        editor:{
	        	type:'select', // checkbox, select
	        	options:{
	        		listItems:goalCityList
	       		}
        }},
		{header: '种类', 		name: 'KIND',		  filter:{type:'text'},	 	sortable:true, 		align:'center',		className:'clickable', 		width:100, validation:{required:true}, formatter:'listItemText',
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
		{header: '品名', 		name: 'PROD_NM',	filter:{type:'text'},		sortable:true,		align:'center',		className:'clickable',		width:100, validation:{required:true}, formatter:'listItemText',
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
		{header: '详细品名', 		name: 'PROD_DTL_NM', filter:{type:'text'}, 		sortable:true, 		align:'center', 	className:'clickable', width:150, validation:{required:true}, formatter:'listItemText',
	   	    onAfterChange:function(o){
	   	    	searchCombo.getProdId(o);
	   	    	searchCombo.getPrice(o.rowKey);
	   	    },
   	    	editor:{type:'select', // checkbox, select
        	options:{
        		listItems:[]
       		}},
	   	 	relations:[
	   	    	{
	   	    		targetNames: ['CLIENT'],
	   	    		listItems: function(o) {
	   	              return searchCombo.getMatched(o, 'prodDtlNm');
	   	            }
	   	    	}
		   	]},
	   	{header: '顾客公司', 		name: 'CLIENT', 	  filter:{type:'text'}, 	sortable:true, 		align:'center', 	className:'clickable', 		width:100, validation:{required:true}, formatter:'listItemText',
       	    editor:{type:'select', // checkbox, select
            options:{
            	listItems:[{value:'', text:'-선택-'}]
           	}}},
		{header: '品号',       	name: 'PROD_ID',    filter:{type:'text'},		sortable:true,		align:'center',		className:'clickable',      editor:'text', disabled:true},
		{header: '发货数量',    	name: 'COUNT',    	filter:{type:'text'},       sortable:true,		align:'center',		className:'clickable', 		width:80, validation:{required:true},        editor:'text', validation:{dataType:'number'}, formatter :function(v) {
		      return Number(v.value).toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }},
		{header: '发货箱子',  	name: 'BOX_COUNT',	filter:{type:'text'},       sortable:true,		align:'center',		className:'clickable', 		width:80, validation:{required:true},        editor:'text', validation:{dataType:'number'}, formatter :function(v) {
		      return Number(v.value).toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }},
		{header: '金额(USD)',    name: 'PRICE',		filter:{type:'text'},		sortable:true,		align:'center',		className:'clickable',		width:100, editor:'text', validation:{dataType:'number'}, formatter :function(v) {
		      return Number(v.value).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }},   	
		{header: '汇率',       	name: 'EXCHANGE',	filter:{type:'text'},       sortable:true,		align:'center',		className:'clickable',      editor:'text', formatter :function(v) {
		      return Number(v.value).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }},
		{header: '备注',       	name: 'BIGO',		filter:{type:'text'},		sortable:true,		align:'center',		className:'clickable',       width:200, editor:'text'},
		{header: '出口完了',    name: 'IS_CHECK',	filter:{type:'text'},		sortable:true,		align:'center',		className:'clickable', 	width:100, formatter:'listItemText',        
			editor:{type:'select',
			options:{
        		listItems:[{text:'NO', value:'NO'}, {text:'OK', value:'OK'}]
       		}}},
		{header: '생성일자',    name: 'CREATE_DATE',  filter:{type:'text'},		sortable:true,		align:'center',		hidden: true        },
		{header: '생성자',      name: 'CREATE_USER',  filter:{type:'text'},		sortable:true,		align:'center',		hidden: true        },
		{header: '수정일자',    name: 'UPDATE_DATE',  filter:{type:'text'},		sortable:true,		align:'center',		hidden: true        },
		{header: '수정자',      name: 'UPDATE_USER',  filter:{type:'text'},		sortable:true,		align:'center',		hidden: true        },
		{header: 'IDX',		    name: 'IDX',          filter:{type:'text'},         hidden: true}
    ],
    columnOptions: {
    	resizable: true,
        frozenCount: 4, // 3개의 컬럼을 고정하고
        //frozenBorderWidth:2  // 고정 컬럼의 경계선 너비를 2px로 한다.
    }/* ,
    summary: {
        height: 10,
        position: 'bottom', // or 'top'
        columnContent: {
        	WEIGHT: {
             template: function(valueMap) {
               return valueMap.sum.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
             }
           },
           TOT_PRICE: {
             template: function(valueMap) {
               return valueMap.sum.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
             }
           }
       }
    } */
});

var dataSet;
var comboSet;

var planExport = {
	init:function(){
		this.kindSets();
		this.monthSets();
		this.startCitySets();
		this.goalCitySets();
		searchCombo.getProdIdRowList();
	},
	kindSets:function(){
		var params = {"code_group":"product_kind"};
		$.ajax({
		    url : "/plan/export/kindSets",
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
	monthSets:function(){
		var params = {"code_group":"months"};
		$.ajax({
		    url : "/plan/export/monthSets",
		    method :"POST",
		    data:params
		}).success(function(result) {
			$.each(result["MONTHS"], function(i, item){
				$('#MONTHS').append($('<option/>').val(item.CODE).text(item.NAME));
				//monthList.push({value:item.CODE, text:item.NAME});
			});
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    });
	},
	startCitySets:function(){
		var params = {"code_group":"start_city"};
		$.ajax({
		    url : "/plan/export/startCitySets",
		    method :"POST",
		    data:params
		}).success(function(result) {
			$.each(result["START_CITY"], function(i, item){
				$('#START_CITY').append($('<option/>').val(item.CODE).text(item.NAME));
				startCityList.push({value:item.CODE, text:item.NAME});
			});
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    });
	},
	goalCitySets:function(){
		var params = {"code_group":"goal_city"};
		$.ajax({
		    url : "/plan/export/goalCitySets",
		    method :"POST",
		    data:params
		}).success(function(result) {
			$.each(result["GOAL_CITY"], function(i, item){
				$('#GOAL_CITY').append($('<option/>').val(item.CODE).text(item.NAME));
				goalCityList.push({value:item.CODE, text:item.NAME});
			});
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    });
	},
	search:function(p){
		var params = {
			'GOAL_CITY':$('#GOAL_CITY option:selected').val(),
			'MONTHS':$('#MONTHS option:selected').val(),
			'KIND':$('#KIND option:selected').val(),
			'PROD_NM':$('#PROD_NM option:selected').val(),
			'PROD_DTL_NM':$('#PROD_DTL_NM option:selected').val(),
			'PROD_ID':$('#PROD_ID').val(),
			'hyDateStart':$('#hyDateStart').val(),
			'hyDateEnd':$('#hyDateEnd').val(),
			'dateStart':$('#dateStart').val(),
			'dateEnd':$('#dateEnd').val()
		};
		$.ajax({
		    url : "/plan/export/listV",
		    method :"POST",
		    data:params
		}).success(function(result) {
			// summary : 최초 숨기고 있음.
			if(p == "init"){
				$(".tui-grid-summary-area").hide();
			}else{
				$(".tui-grid-summary-area").show();
			}
		
			gridView.resetData(result);
			planExport.view();
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    })/* .error(function(ev){
	    	alert('오류 : ' + ev);
	    }) */;
	},
	view:function(){
		$('#planExportGridEdit').hide();
		$('#planExportGridView').show();
		$('#editBtn').show();
		$('#saveBtn').hide();
		$('#delBtn').hide();
		$('#addBtn').hide();
		$('#viewBtn').hide();
	},
	edit:function(){
		$('#planExportGridView').hide();
		$('#planExportGridEdit').show();
		$('#viewBtn').show();
		$('#editBtn').hide();
		$('#saveBtn').show();
		$('#addBtn').show();
		$('#delBtn').show();
		
		var params = {
				'GOAL_CITY':$('#GOAL_CITY option:selected').val(),
				'MONTHS':$('#MONTHS option:selected').val(),
				'KIND':$('#KIND option:selected').val(),
				'PROD_NM':$('#PROD_NM option:selected').val(),
				'PROD_DTL_NM':$('#PROD_DTL_NM option:selected').val(),
				'PROD_ID':$('#PROD_ID').val(),
				'dateStart':$('#dateStart').val(),
				'dateEnd':$('#dateEnd').val()
			};
		
		$.ajax({
		    url : "/plan/export/listE",
		    method :"POST",
		    data:params
		}).success(function(result) {
			gridEdit.resetData(result);
			gridEdit.refreshLayout();
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    });
	},
	save:function(){
		// 유효성 체크
		let errList = gridEdit.validate();
		if(errList.length > 0){
			let sets = errList.map(function(item){
				return gridEdit.getRow(item['rowKey']).sortKey+1;
			});
			
			alert("ERROR : No." + JSON.stringify(sets) + " 에 해당하는 열의 필수값을 입력해야 합니다.");
			return;
		}
		
		let saveData = gridEdit.getModifiedRows();
		
		if(saveData.updatedRows.length > 0){
			var stopFlag = false;
			$.each(saveData.updatedRows, function(i, v){
				var orgRowKey = saveData.updatedRows[i]["rowKey"];
				var orgIsChk = gridEdit.dataManager.getOriginData()[orgRowKey]["IS_CHECK"];
				if(orgIsChk == "OK"){
					alert("[No."+(orgRowKey+1)+"]" + " 出口完了(OK) 인 경우, 수정할 수 없습니다. \n관리자에게 요청해 주세요.");
					stopFlag = true;
					return false;
				}
				
				if(saveData.updatedRows[i]["IS_CHECK"] == "OK" && saveData.updatedRows[i]["OUT_DATE"] == null){
					alert("出库日期 선택해 주세요.");
					stopFlag = true;
					return false;
				}
			});
		}
		
		if(stopFlag){
			return;
		}
		
		let chkLen = saveData.createdRows.length + saveData.updatedRows.length + saveData.deletedRows.length;
	    
		if(chkLen > 0){
			$.ajax({
			    url : "/plan/export/save",
			    contentType : "application/json",
			    method :"POST",
			    data:JSON.stringify(saveData)
			}).success(function(result) {
				alert(" ㅇ 추가 : " + result["insert"] + "건\n" + " ㅇ 수정 : " + result["update"] + "건\n" + " ㅇ 삭제 : " + result["delete"] + "건");
				planExport.search();
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
		gridEdit.prependRow({PRODUCT_GUBUN:'', KIND:'', CLIENT:'', IS_CHECK:'NO'});
	}
}

var searchCombo = {
	getProdNm:function(e){
		var params = {"kind":$(this).val()};
		$.ajax({
		    url : "/plan/export/prodNmList",
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
		    url : "/plan/export/prodDtlNmList",
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
			    url : "/plan/export/prodIdList",
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
		    url : "/plan/export/getProdIdRowList",
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
				//items = [temp[0].CLIENT];
				items = temp[0].CLIENT.split(',');
			}
			/* var uniqueArr = items.filter(function(e, i){
				return items.indexOf(e) === i;
			}); */
			$.each(items, function(i, v){
				ret.push({text:v, value:v});
			});
		}
		
		return	ret;
	},
	getPrice:function(rowKey){
		var kind = gridEdit.getValue(rowKey, "KIND");
		var prodNm = gridEdit.getValue(rowKey, "PROD_NM");
		var prodDtlNm = gridEdit.getValue(rowKey, "PROD_DTL_NM");
		params = {"kind":kind, "prodNm":prodNm, "prodDtlNm":prodDtlNm};

		$.ajax({
		    url : "/plan/export/getPrice",
		    method :"POST",
		    async: false,
		    data:params
		}).success(function(result) {
			if(result["PRICE"]){
				gridEdit.setValue(rowKey, "PRICE", result["PRICE"]["CODE"]);
			}
			
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    });
	}
}

$(function(){
	// 그리드 제어용
	$('#searchBtn').click(planExport.search);
	$('#viewBtn').click(planExport.view);
	$('#editBtn').click(planExport.edit);
	$('#saveBtn').click(planExport.save);
	$('#addBtn').click(planExport.add);
	$('#delBtn').click(planExport.del);
	
	// 조회 콤보박스 제어용(品名, 详细品名 선택을 통해 품호를 구하기만 있음)
	$('#KIND').change(searchCombo.getProdNm);
	$('#PROD_NM').change(searchCombo.getProdDtlNm);
	$('#PROD_DTL_NM').change(searchCombo.getProdId);
	
	dateUtil.init();
	planExport.init();
	planExport.search('init');
	
});
</script>

