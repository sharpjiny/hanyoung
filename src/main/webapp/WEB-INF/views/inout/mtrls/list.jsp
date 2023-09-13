<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="row-fluid">
    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">원부자재 입출고</div>
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
									<td width='70px'>결산월</td>
									<td >
										<select id="STTL_MON" name="STTL_MON" class="" title="결산년월" style="margin-bottom:0px;">
											<option value="">결산월</option>
										</select>
									</td>
									<td width='70px'>구분</td>
									<td>
										<select id="RAW_GUBUN" name="RAW_GUBUN" class="" title="구분" style="margin-bottom:0px;">
											<option value="">구분</option>
										</select>
									</td>
									<td width='70px'>입고사</td>
									<td>
										<select id="RAW_CLIENT" name="RAW_CLIENT" class="" title="입고사" style="margin-bottom:0px;">
											<option value="">입고사</option>
										</select>
									</td>
									<td width='70px'>입고일자</td>
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
									<td width='70px'>종류</td>
									<td>
										<select id="KIND" name="KIND" class="" title="종류" style="margin-bottom:0px;">
											<option value="">종류</option>
										</select>
									</td>
									<td width='70px'>품명</td>
									<td>
										<select id="PROD_NM" name="PROD_NM" class="" title="품명" style="margin-bottom:0px;">
											<option value="">품명</option>
										</select>
									</td>
									<td width='70px'>상세품명</td>
									<td>
										<select id="PROD_DTL_NM" name="PROD_DTL_NM" class="" title="상세품명" style="margin-bottom:0px;">
											<option value="">상세품명</option>
										</select>
									</td>
									<td width='70px'>품호</td>
									<td >
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
            </div>
        </div>
        <div style="height:525px;">
			<div id="mtrlsInOutGridView" ></div>
			<div id="mtrlsInOutGridEdit" style="display:none"></div>
		</div>
    </div>
    <!-- /block -->
</div>

<script>
//var MtrlsInOutGrid = tui.Grid;
tui.Grid.applyTheme('default', {
	  cell: {
	    /* normal: {
	      background: '#014386',
	      border: '#0c4e91',
	      text: '#fff',
	    },
	    head: {
	      background: '#0b3f73',
	      border: '#0b3f73',
	      text: '#208be4',
	    },
	    rowHead: {
	      border: ''
	    },
	    selectedHead: {
	      background: '#0b3f73',
	    }, */
	     evenRow: {
	      background: '#f8f8ff',
	    },
	    oddRow: {
	      background: '#f5fffa'
	    } 
	  }
	});

/* MtrlsInOutGrid.applyTheme('striped', {
   	grid:{
   		border: '#aaa',
   		text: '#333'
   	},
   	cell:{
   		disabled:{
   			text:'#999'
   		}
   	}
}); */
var rawGubunList = [{value:'', text:'-선택-'}];
var kindList = [{value:'', text:'-선택-'}];
var prodDtlList = [{value:'', text:'-선택-'}];
var rawClientList = [{value:'', text:'-선택-'}];

var gridView = new tui.Grid({
    el: document.getElementById('mtrlsInOutGridView'),
    //scrollX: true,
    //scrollY: true,
    data: [],
    rowHeaders: ['rowNum'],//'checkbox', 'rowNum'
    header:{
    	height: 40
    },
    bodyHeight: 500,
    columns: [
		{header: '입고일자',    name: 'IN_DATE',      filter:{type:'text'},         sortable:true,            align:'center'},
        /* {header: '결산년월',    name: 'STTL_MON',     filter:{type:'text'},         sortable:true,            align:'center'}, */
		{header: '구분',     	name: 'RAW_GUBUN_NM', filter:{type:'text'},         sortable:true,            align:'center'},
		{header: '입고사',      name: 'RAW_CLIENT_NM',    filter:{type:'text'},         sortable:true,            align:'center'},
		{header: '종류',     	name: 'KIND_NM',   	  filter:{type:'text'},         sortable:true,            align:'center'},
		{header: '품명',       	name: 'PROD_NM',      filter:{type:'text'},         sortable:true,            align:'center'},
		{header: '상세품명',    name: 'PROD_DTL_NM',  filter:{type:'text'},         sortable:true,            align:'center', width:150},
		{header: '품호',       	name: 'PROD_ID',      filter:{type:'text'},         sortable:true,            align:'center'},
		/* {header: 'LOT',       	name: 'LOT_NUM',      filter:{type:'text'},         sortable:true,            align:'center'}, */
		{header: '중량',       	name: 'WEIGHT',       filter:{type:'text'},         sortable:true,            align:'center', formatter :function(v) {
		      return Number(v.value).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }},
		{header: '단가',       	name: 'PRICE',        filter:{type:'text'},         sortable:true,            align:'center', formatter :function(v) {
		      return Number(v.value).toFixed(4);
	    }},
		{header: '총액',       	name: 'TOT_PRICE',    filter:{type:'text'},         sortable:true,            align:'center', formatter :function(v) {
		      return Number(v.value).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }},
		{header: '담당자',      name: 'MAN',          filter:{type:'text'},         sortable:true,            align:'center'},
		{header: '비고',       	name: 'BIGO',         filter:{type:'text'},         sortable:true,            align:'center'},
		{header: '확인',       	name: 'IS_CHECK',     filter:{type:'text'},         sortable:true,            align:'center'},
		{header: '생성일자',    name: 'CREATE_DATE',  filter:{type:'text'},         sortable:true,            align:'center',		hidden: true},
		{header: '생성자',      name: 'CREATE_USER',  filter:{type:'text'},         sortable:true,            align:'center',		hidden: true},
		{header: '수정일자',    name: 'UPDATE_DATE',  filter:{type:'text'},         sortable:true,            align:'center',		hidden: true},
		{header: '수정자',      name: 'UPDATE_USER',  filter:{type:'text'},         sortable:true,            align:'center',		hidden: true},
		{header: 'IDX',		    name: 'IDX',          filter:{type:'text'},         hidden: true}
    ],
    columnOptions: {
    	resizable: true
    },
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
    }
});

var gridEdit = new tui.Grid({
    el: document.getElementById('mtrlsInOutGridEdit'),
    //scrollY: true,
    data: [],
    rowHeaders: ['checkbox', 'rowNum'],//'checkbox', 'rowNum'
    header:{
    	height: 40
    },
    bodyHeight: 500,
    columns: [
		{header: '입고일자',    name: 'IN_DATE',      filter:{type:'text'},         sortable:true,            align:'center', 		className:'clickable', validation:{required:true},        editor:{type:'datePicker', options:{language: 'ko'}}},
		/* {header: '결산년월', name: 'STTL_MON', filter:{type:'text'}, sortable:true, align:'center', className:'clickable',  
			editor: {
	            type: 'datePicker',
	            options: {
	              format: 'yyyy-MM',
	              language: 'ko',
	              type: 'month'
	            }
        }}, */
		{header: '구분', name: 'RAW_GUBUN', filter:{type:'text'}, sortable:true, align:'center', className:'clickable', validation:{required:true}, formatter:'listItemText',
	        editor:{
	        	type:'select', // checkbox, select
	        	options:{
	        		listItems:rawGubunList
	       		}
        }},
        {header: '입고사',      name: 'RAW_CLIENT',       filter:{type:'text'},         sortable:true,            align:'center', 		className:'clickable', validation:{required:true},        editor:'text', formatter:'listItemText',
			editor:{
	        	type:'select', // checkbox, select
	        	options:{
	        		listItems:rawClientList
	       		}
        }},
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
		/* {header: 'LOT',       	name: 'LOT_NUM',      filter:{type:'text'},         sortable:true,            align:'center', 		className:'clickable',        editor:'text'}, */
		{header: '중량',       	name: 'WEIGHT',       filter:{type:'text'},         sortable:true,            align:'center', 		className:'clickable', validation:{required:true},        editor:'text', validation:{dataType:'number'}, formatter :function(v) {
		      return Number(v.value).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }},
		{header: '단가',       	name: 'PRICE',        filter:{type:'text'},         sortable:true,            align:'center', 		className:'clickable', validation:{required:true},        editor:'text', validation:{dataType:'number'}, formatter :function(v) {
		      return Number(v.value).toFixed(4);
	    }},
		{header: '총액',       	name: 'TOT_PRICE',    filter:{type:'text'},         sortable:true,            align:'center', 		className:'clickable', disabled:true,        editor:'text', formatter :function(v) {
		      return Number(v.value).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }},
		{header: '담당자',      name: 'MAN',          filter:{type:'text'},         sortable:true,            align:'center', 		className:'clickable', validation:{required:true},        editor:'text'},
		{header: '비고',       	name: 'BIGO',         filter:{type:'text'},         sortable:true,            align:'center', 		className:'clickable',        editor:'text'},
		{header: '확인',       	name: 'IS_CHECK',     filter:{type:'text'},         sortable:true,            align:'center', 		className:'clickable', formatter:'listItemText',        
			editor:{type:'select',
			options:{
        		listItems:[{text:'NO', value:'NO'}, {text:'OK', value:'OK'}]
       		}}},
		{header: '생성일자',    name: 'CREATE_DATE',  filter:{type:'text'},         sortable:true,            align:'center',		hidden: true        },
		{header: '생성자',      name: 'CREATE_USER',  filter:{type:'text'},         sortable:true,            align:'center',		hidden: true        },
		{header: '수정일자',    name: 'UPDATE_DATE',  filter:{type:'text'},         sortable:true,            align:'center',		hidden: true        },
		{header: '수정자',      name: 'UPDATE_USER',  filter:{type:'text'},         sortable:true,            align:'center',		hidden: true        },
		{header: 'IDX',		    name: 'IDX',          filter:{type:'text'},         hidden: true}
    ],
    columnOptions: {
    	resizable: true
    },
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
    }
});

/* gridEdit.on('afterChange', function(ev){
	gridEdit.setValue(0, 'PROD_NM', [{text:'test', value:'test'}]);
	gridEdit.setColumns([
     	{header: '상세품명',    name: 'PROD_DTL_NM',  filter:{type:'text'},         sortable:true,            align:'center', 		className:'clickable', validation:{required:true},        editor:'text'}
     ]);
}); */


var dataSet;
var comboSet;

var mtrlsInOut = {
	init:function(){
		this.rawGubunSets();
		this.monthsSets();
		this.kindSets();
		this.rawClientSets();
		searchCombo.getProdDtlList();
	},
	rawGubunSets:function(){
		var params = {"code_group":"raw_gubun"};
		$.ajax({
		    url : "/inout/mtrls/rawGubunSets",
		    method :"POST",
		    data:params
		}).success(function(result) {
			$.each(result["RAW_GUBUN"], function(i, item){
				$('#RAW_GUBUN').append($('<option/>').val(item.CODE).text(item.NAME));
				rawGubunList.push({value:item.CODE, text:item.NAME});
			});
			
			/* dataSet = result;
			gridView.resetData(result);
			mtrlsInOut.view(); */
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    });
	},
	monthsSets:function(){
		var params = {"code_group":"months"};
		$.ajax({
		    url : "/inout/mtrls/monthsSets",
		    method :"POST",
		    data:params
		}).success(function(result) {
			$.each(result["MONTHS"], function(i, item){
				$('#STTL_MON').append($('<option/>').val(item.CODE).text(item.NAME));
			});
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    });
	},
	kindSets:function(){
		var params = {"code_group":"kind"};
		$.ajax({
		    url : "/inout/mtrls/kindSets",
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
	rawClientSets:function(){
		var params = {"code_group":"raw_client"};
		$.ajax({
		    url : "/inout/mtrls/rawClientSets",
		    method :"POST",
		    data:params
		}).success(function(result) {
			$.each(result["RAW_CLIENT"], function(i, item){
				$('#RAW_CLIENT').append($('<option/>').val(item.CODE).text(item.NAME));
				rawClientList.push({value:item.CODE, text:item.NAME});
			});
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    });
	},
	search:function(){
		var params = {
			'STTL_MON':$('#STTL_MON option:selected').val(),
			'RAW_GUBUN':$('#RAW_GUBUN option:selected').val(),
			'RAW_CLIENT':$('#RAW_CLIENT option:selected').val(),
			'KIND':$('#KIND option:selected').val(),
			'PROD_NM':$('#PROD_NM option:selected').val(),
			'PROD_DTL_NM':$('#PROD_DTL_NM option:selected').val(),
			'PROD_ID':$('#PROD_ID').val(),
			'dateStart':$('#dateStart').val(),
			'dateEnd':$('#dateEnd').val()
		};
		$.ajax({
		    url : "/inout/mtrls/list",
		    method :"POST",
		    data:params
		}).success(function(result) {
			dataSet = result;
			gridView.resetData(result);
			mtrlsInOut.view();
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    })/* .error(function(ev){
	    	alert('오류 : ' + ev);
	    }) */;
	},
	view:function(){
		$('#mtrlsInOutGridEdit').hide();
		$('#mtrlsInOutGridView').show();
		$('#editBtn').show();
		$('#saveBtn').hide();
		$('#delBtn').hide();
		$('#addBtn').hide();
		$('#viewBtn').hide();
	},
	edit:function(){
		$('#mtrlsInOutGridView').hide();
		$('#mtrlsInOutGridEdit').show();
		$('#viewBtn').show();
		$('#editBtn').hide();
		$('#saveBtn').show();
		$('#addBtn').show();
		$('#delBtn').show();
		
		gridEdit.resetData(dataSet);
		gridEdit.refreshLayout();
		
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
		
		// 빈값 제거..
		/* saveData.createdRows = saveData.createdRows.filter(function(v){
	        return v['PROD_ID'] != null && v['PROD_ID'] != '';
	    }); */
		
		let chkLen = saveData.createdRows.length + saveData.updatedRows.length + saveData.deletedRows.length;
	    
		if(chkLen > 0){
			$.ajax({
			    url : "/inout/mtrls/save",
			    contentType : "application/json",
			    method :"POST",
			    data:JSON.stringify(saveData)
			}).success(function(result) {
				alert(" ㅇ 추가 : " + result["insert"] + "건\n" + " ㅇ 수정 : " + result["update"] + "건\n" + " ㅇ 삭제 : " + result["delete"] + "건");
				mtrlsInOut.search();
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
		gridEdit.prependRow({RAW_GUBUN:'', KIND:'', RAW_CLIENT:'', IS_CHECK:'NO'});
	}
}

var searchCombo = {
	getProdNm:function(e){
		var params = {"kind":$(this).val()};
		$.ajax({
		    url : "/inout/mtrls/prodNmList",
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
		    url : "/inout/mtrls/prodDtlNmList",
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
			    url : "/inout/mtrls/prodIdList",
			    method :"POST",
			    data:params
			}).success(function(result) {
				if(o.rowKey != null && result["PROD_ID"].length > 0){
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
	getProdDtlList:function(){
		$.ajax({
		    url : "/inout/mtrls/prodDtlList",
		    method :"POST",
		    data:{}
		}).success(function(result) {
			prodDtlList = result["PROD_DTL_LIST"];
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    });
	},
	getMatched:function(o, p){
		let ret = [{value:'', text:'-선택-'}];
		let temp = prodDtlList.filter(function(item){
			if(p == 'prodNm'){
				return item.KIND ==  o.row.KIND && item.PROD_NM == o.row.PROD_NM;
			}else if(p == 'kind'){
				return item.KIND ==  o.row.KIND;
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
			}
			$.each(items, function(i, v){
				ret.push({text:v, value:v});
			});
		}
		
		return	ret;
	}
}

$(function(){
	// 그리드 제어용
	$('#searchBtn').click(mtrlsInOut.search);
	$('#viewBtn').click(mtrlsInOut.view);
	$('#editBtn').click(mtrlsInOut.edit);
	$('#saveBtn').click(mtrlsInOut.save);
	$('#addBtn').click(mtrlsInOut.add);
	$('#delBtn').click(mtrlsInOut.del);
	
	// 조회 콤보박스 제어용(품명, 상세품명 선택을 통해 품호를 구하기만 있음)
	$('#KIND').change(searchCombo.getProdNm);
	$('#PROD_NM').change(searchCombo.getProdDtlNm);
	$('#PROD_DTL_NM').change(searchCombo.getProdId);
	
	dateUtil.init();
	mtrlsInOut.init();
	mtrlsInOut.search();
	
});
</script>

