<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="row-fluid">
    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">완제품 입출고</div>
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
									<td width='70px'>구분</td>
									<td>
										<select id="PRODUCT_GUBUN" name="PRODUCT_GUBUN" class="" title="구분" style="margin-bottom:0px;">
											<option value="">구분</option>
										</select>
									</td>
									<td width='70px'>입고사</td>
									<td>
										<select id="CLIENT" name="CLIENT" class="" title="입고사" style="margin-bottom:0px;">
											<option value="">입고사</option>
										</select>
									</td>
									<td width='70px'>목적지</td>
									<td>
										<select id="GOAL_CITY" name="GOAL_CITY" class="" title="목적지" style="margin-bottom:0px;">
											<option value="">목적지</option>
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
			<div id="prdtInOutGridView" ></div>
			<div id="prdtInOutGridEdit" style="display:none"></div>
		</div>
    </div>
    <!-- /block -->
</div>

<script>
//var PrdtInOutGrid = tui.Grid;
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

/* PrdtInOutGrid.applyTheme('striped', {
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
var goalCityList = [{value:'', text:'-선택-'}];
var productGubunList = [{value:'', text:'-선택-'}];
var kindList = [{value:'', text:'-선택-'}];
//var clientList = [{value:'', text:'-선택-'}];
var prodIdRowList = [{value:'', text:'-선택-'}];

var gridView = new tui.Grid({
    el: document.getElementById('prdtInOutGridView'),
    //scrollX: true,
    //scrollY: true,
    data: [],
    rowHeaders: ['rowNum'],//'checkbox', 'rowNum'
    header:{
    	height: 40
    },
    bodyHeight: 500,
    columns: [
		{header: '입고일자',    name: 'INOUT_DATE',      filter:{type:'text'},          sortable:true,            align:'center'},
		/* {header: '목적지',    	name: 'TO_PLACE_NM',      filter:{type:'text'},         sortable:true,            align:'center', width:150}, */
		{header: '구분',     	name: 'PRODUCT_GUBUN_NM', filter:{type:'text'},         sortable:true,            align:'center', width:225},
		{header: '입고사',      name: 'CLIENT',    filter:{type:'text'},         	sortable:true,            align:'center'},
		{header: '종류',     	name: 'KIND_NM',   	  filter:{type:'text'},         	sortable:true,            align:'center'},
		{header: '품명',       	name: 'PROD_NM',      filter:{type:'text'},         	sortable:true,            align:'center'},
		{header: '상세품명',    name: 'PROD_DTL_NM',  filter:{type:'text'},         	sortable:true,            align:'center', width:150},
		{header: '품호',       	name: 'PROD_ID',      filter:{type:'text'},         	sortable:true,            align:'center'},
		/* {header: '수출번호',    name: 'OUT_NUM',      filter:{type:'text'},         	sortable:true,            align:'center'}, */
		{header: '제품수량',  	name: 'BOX_PER_COUNT',filter:{type:'text'},         	sortable:true,            align:'center', formatter :function(v) {
		      return Number(v.value).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }},
		{header: '박스수량',    name: 'BOX_COUNT',    filter:{type:'text'},         	sortable:true,            align:'center', formatter :function(v) {
		      return Number(v.value).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }},
		/* {header: '수출방법',    name: 'OUT_METHOD',   filter:{type:'text'},         	sortable:true,            align:'center'}, */
		/* {header: '단가',       	name: 'PRICE',        filter:{type:'text'},         	sortable:true,            align:'center', formatter :function(v) {
		      return Number(v.value).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }}, */
		/* {header: '총수량',      name: 'TOT_COUNT',    filter:{type:'text'},         	sortable:true,            align:'center', formatter :function(v) {
		      return Number(v.value).toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }}, */
		/* {header: '총액',       	name: 'TOT_PRICE',    filter:{type:'text'},         	sortable:true,            align:'center', formatter :function(v) {
		      return Number(v.value).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }}, */
		{header: '담당자',      name: 'MAN',          filter:{type:'text'},         	sortable:true,            align:'center'},
		{header: '비고',       	name: 'BIGO',         filter:{type:'text'},         	sortable:true,            align:'center'},
		{header: '확인',       	name: 'IS_CHECK',     filter:{type:'text'},         	sortable:true,            align:'center'},
		{header: '생성일자',    name: 'CREATE_DATE',  filter:{type:'text'},         	sortable:true,            align:'center',		hidden: true},
		{header: '생성자',      name: 'CREATE_USER',  filter:{type:'text'},         	sortable:true,            align:'center',		hidden: true},
		{header: '수정일자',    name: 'UPDATE_DATE',  filter:{type:'text'},         	sortable:true,            align:'center',		hidden: true},
		{header: '수정자',      name: 'UPDATE_USER',  filter:{type:'text'},         	sortable:true,            align:'center',		hidden: true},
		{header: 'IDX',		    name: 'IDX',          filter:{type:'text'},         hidden: true}
    ],
    columnOptions: {
    	resizable: true
    },
    summary: {
        height: 10,
        position: 'bottom', // or 'top'
        columnContent: {
        	BOX_PER_COUNT: {
             template: function(valueMap) {
               return valueMap.sum.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
             }
           },
           BOX_COUNT: {
             template: function(valueMap) {
               return valueMap.sum.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
             }
           }
       }
    }
});

var gridEdit = new tui.Grid({
    el: document.getElementById('prdtInOutGridEdit'),
    //scrollY: true,
    data: [],
    rowHeaders: ['checkbox', 'rowNum'],//'checkbox', 'rowNum'
    header:{
    	height: 40
    },
    bodyHeight: 500,
    columns: [
		{header: '입고일자',    name: 'INOUT_DATE',      filter:{type:'text'},         sortable:true,            align:'center', 		className:'clickable', validation:{required:true},        editor:{type:'datePicker', options:{language: 'ko'}}},
		/* {header: '목적지', 		name: 'TO_PLACE', 		 filter:{type:'text'}, sortable:true, align:'center', className:'clickable', validation:{required:true}, width:150, formatter:'listItemText',
	        editor:{
	        	type:'select', // checkbox, select
	        	options:{
	        		listItems:goalCityList
	       		}
        }}, */
		{header: '구분', name: 'PRODUCT_GUBUN', filter:{type:'text'}, sortable:true, align:'center', className:'clickable', validation:{required:true}, formatter:'listItemText',  width:225,
	        editor:{
	        	type:'select', // checkbox, select
	        	options:{
	        		listItems:productGubunList
	       		}
        }},
        {header: '입고사', name: 'CLIENT', filter:{type:'text'}, sortable:true, align:'center', className:'clickable', validation:{required:true},
       	    editor:'text'},
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
	   	    	searchCombo.getPrice(o.rowKey);
	   	    },
   	    	editor:{type:'select', // checkbox, select
        	options:{
        		listItems:[]
       		}},
       		/*relations:[
	   	    	{
	   	    		targetNames: ['CLIENT'],
	   	    		listItems: function(o) {
	   	              return searchCombo.getMatched(o, 'prodDtlNm');
	   	            }
	   	    	}
		   	]*/},
		{header: '품호',       	name: 'PROD_ID',      filter:{type:'text'},         sortable:true,            align:'center', 		className:'clickable',        editor:'text', disabled:true},
		/* {header: '수출번호',    name: 'OUT_NUM',      filter:{type:'text'},         sortable:true,            align:'center', 		className:'clickable',        editor:'text'}, */
		{header: '제품수량',  	name: 'BOX_PER_COUNT',filter:{type:'text'},         sortable:true,            align:'center', 		className:'clickable', validation:{required:true},        editor:'text', validation:{dataType:'number'}, formatter :function(v) {
		      return Number(v.value).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }},
		{header: '박스수량',    name: 'BOX_COUNT',    filter:{type:'text'},         sortable:true,            align:'center', 		className:'clickable', validation:{required:true},        editor:'text', validation:{dataType:'number'}, formatter :function(v) {
		      return Number(v.value).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }},
		/* {header: '수출방법',    name: 'OUT_METHOD',   filter:{type:'text'},         sortable:true,            align:'center', 		className:'clickable', formatter:'listItemText',        
			editor:{type:'select',
			options:{
        		listItems:[{text:'SH', value:'상해'}, {text:'JP', value:'일본'}]
       		}}}, */
		/* {header: '단가',       	name: 'PRICE',        filter:{type:'text'},         sortable:true,            align:'center', 		className:'clickable', validation:{required:true},        editor:'text', validation:{dataType:'number'}, formatter :function(v) {
		      return Number(v.value).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }}, */
		/* {header: '총수량',      name: 'TOT_COUNT',    filter:{type:'text'},         sortable:true,            align:'center', 		className:'clickable', disabled:true,        editor:'text', formatter :function(v) {
		      return Number(v.value).toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }}, */
		/* {header: '총액',       	name: 'TOT_PRICE',    filter:{type:'text'},         sortable:true,            align:'center', 		className:'clickable', disabled:true,        editor:'text', formatter :function(v) {
		      return Number(v.value).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }}, */
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
        	BOX_PER_COUNT: {
             template: function(valueMap) {
               return valueMap.sum.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
             }
           },
           BOX_COUNT: {
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

var prdtInOut = {
	init:function(){
		this.productGubunSets();
		this.kindSets();
		//this.clientSets();
		this.goalCitySets();
		searchCombo.getProdIdRowList();
	},
	productGubunSets:function(){
		var params = {"code_group":"product_gubun"};
		$.ajax({
		    url : "/inout/prdt/productGubunSets",
		    method :"POST",
		    data:params
		}).success(function(result) {
			$.each(result["PRODUCT_GUBUN"], function(i, item){
				$('#PRODUCT_GUBUN').append($('<option/>').val(item.CODE).text(item.NAME));
				productGubunList.push({value:item.CODE, text:item.NAME});
			});
			
			/* dataSet = result;
			gridView.resetData(result);
			prdtInOut.view(); */
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    });
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
	/* clientSets:function(){
		var params = {"code_group":"client"};
		$.ajax({
		    url : "/inout/prdt/clientSets",
		    method :"POST",
		    data:params
		}).success(function(result) {
			$.each(result["CLIENT"], function(i, item){
				$('#CLIENT').append($('<option/>').val(item.CODE).text(item.NAME));
				clientList.push({value:item.CODE, text:item.NAME});
			});
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    });
	}, */
	goalCitySets:function(){
		var params = {"code_group":"goal_city"};
		$.ajax({
		    url : "/inout/prdt/goalCitySets",
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
			'STTL_MON':$('#STTL_MON option:selected').val(),
			'PRODUCT_GUBUN':$('#PRODUCT_GUBUN option:selected').val(),
			'CLIENT':$('#CLIENT option:selected').val(),
			'KIND':$('#KIND option:selected').val(),
			'PROD_NM':$('#PROD_NM option:selected').val(),
			'PROD_DTL_NM':$('#PROD_DTL_NM option:selected').val(),
			'PROD_ID':$('#PROD_ID').val(),
			'dateStart':$('#dateStart').val(),
			'dateEnd':$('#dateEnd').val()
		};
		$.ajax({
		    url : "/inout/prdt/list",
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
			prdtInOut.view();
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    })/* .error(function(ev){
	    	alert('오류 : ' + ev);
	    }) */;
	},
	view:function(){
		$('#prdtInOutGridEdit').hide();
		$('#prdtInOutGridView').show();
		$('#editBtn').show();
		$('#saveBtn').hide();
		$('#delBtn').hide();
		$('#addBtn').hide();
		$('#viewBtn').hide();
	},
	edit:function(){
		$('#prdtInOutGridView').hide();
		$('#prdtInOutGridEdit').show();
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
			    url : "/inout/prdt/save",
			    contentType : "application/json",
			    method :"POST",
			    data:JSON.stringify(saveData)
			}).success(function(result) {
				alert(" ㅇ 추가 : " + result["insert"] + "건\n" + " ㅇ 수정 : " + result["update"] + "건\n" + " ㅇ 삭제 : " + result["delete"] + "건");
				prdtInOut.search();
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
				//items = temp[0].CLIENT.split(',');
			}
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
		    url : "/inout/prdt/getPrice",
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
	$('#searchBtn').click(prdtInOut.search);
	$('#viewBtn').click(prdtInOut.view);
	$('#editBtn').click(prdtInOut.edit);
	$('#saveBtn').click(prdtInOut.save);
	$('#addBtn').click(prdtInOut.add);
	$('#delBtn').click(prdtInOut.del);
	
	// 조회 콤보박스 제어용(품명, 상세품명 선택을 통해 품호를 구하기만 있음)
	$('#KIND').change(searchCombo.getProdNm);
	$('#PROD_NM').change(searchCombo.getProdDtlNm);
	$('#PROD_DTL_NM').change(searchCombo.getProdId);
	
	dateUtil.init();
	prdtInOut.init();
	prdtInOut.search('init');
	
});
</script>

