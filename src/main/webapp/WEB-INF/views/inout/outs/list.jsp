<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
.tui-timepicker-select {
	padding: 0px 0 5px 9px;
}
</style>
<div class="row-fluid">
    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">재고관리 > 외주원부자재</div>
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
						<div style="float:left;">	
							<table>
								<tr>
									<td width='70px'>구분</td>
									<td>
										<select id="PRODUCT_GUBUN" name="PRODUCT_GUBUN" class="" title="구분" style="margin-bottom:0px;">
											<option value="">구분</option>
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
                      <span style="margin-left:20px;">
                      <button type="button" class="btn btn-primary" id="searchBtn" >Search </button>
                      </span>
                   </div>
                </div>
            </div>
        </div>
        <div style="height:525px;">
			<div id="outsInOutGridView" ></div>
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

var workTypeList = [{value:'', text:'-선택-'}];
var productGubunList = [{value:'', text:'-선택-'}];
var kindList = [{value:'', text:'-선택-'}];
var eqpIdList = [{value:'', text:'-선택-'}];
var areaTypeList = [{value:'', text:'-선택-'}];
var prodDtlList = [{value:'', text:'-선택-'}];

var gridView = new tui.Grid({
    el: document.getElementById('outsInOutGridView'),
    data: [],
    rowHeaders: ['rowNum'],//'checkbox', 'rowNum'
    header:{
    	height: 40
    },
    bodyHeight: 500,
    columns: [
		{header: '入库日期',      name: 'INOUT_DATE',      filter:{type:'text'},          sortable:true,            align:'center', width:100},
		{header: '设备',    	  name: 'PRODUCT_GUBUN_NM',      	  filter:{type:'text'},          sortable:true,            align:'center', width:200},
		{header: '种类',     	  name: 'KIND_NM',   	  filter:{type:'text'},          sortable:true,            align:'center', width:120},
		{header: '产品',       	  name: 'PROD_NM',        filter:{type:'text'},          sortable:true,            align:'center', width:120},
		{header: '品名',      name: 'PROD_DTL_NM',    filter:{type:'text'},          sortable:true,            align:'center', width:120},
		/* {header: '品号 ',    	  name: 'PROD_ID',        filter:{type:'text'},          sortable:true,            align:'center', width:100}, */
		{header: '数量' ,      name: 'BOX_PER_COUNT',       filter:{type:'text'},          sortable:true,            align:'center', width:100, formatter:function(v) { // 추가
			return v.value != null && v.value != '' ? v.value.toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ",") : null;
	    }},
		{header: '白粉',    	  name: 'POWDER_WHITE_CNT',    filter:{type:'text'},          sortable:true,            align:'center', width:100},
		{header: '黑粉',    	  name: 'POWDER_BLACK_CNT',    filter:{type:'text'},          sortable:true,            align:'center', width:100},
		{header: '白粉数量',    	  name: 'WHITE_USED_CNT',    filter:{type:'text'},          sortable:true,            align:'center', width:120, formatter:function(v) { // 추가
			return v.value != null && v.value != '' ? v.value.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",") : null;
	    }},
		{header: '黑粉数量',    	  name: 'BLACK_USED_CNT',    filter:{type:'text'},          sortable:true,            align:'center', width:120, formatter:function(v) { // 추가
			return v.value != null && v.value != '' ? v.value.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",") : null;
	    }},
		{header: '1.45',    	  name: 'THICKNESS_1',    filter:{type:'text'},          sortable:true,            align:'center', width:80},
		{header: '2.0',    		  name: 'THICKNESS_2',    filter:{type:'text'},          sortable:true,            align:'center', width:80},
		{header: '2.5',    		  name: 'THICKNESS_3',    filter:{type:'text'},          sortable:true,            align:'center', width:80},
		{header: '2.9',    		  name: 'THICKNESS_4',    filter:{type:'text'},          sortable:true,            align:'center', width:80},
		{header: '3.8',    		  name: 'THICKNESS_5',    filter:{type:'text'},          sortable:true,            align:'center', width:80},
		/* {header: '侧面筛网',    		  name: 'MESH',    filter:{type:'text'},          sortable:true,            align:'center', width:80}, */
		{header: '底面筛网',    		  name: 'MESH_OUT',    filter:{type:'text'},          sortable:true,            align:'center', width:80},
		{header: '备注',    	  name: 'BIGO',      	  filter:{type:'text'},          sortable:true,            align:'center', width:250},
		/* {header: '完了',      name: 'IS_CHECK',     filter:{type:'text'},         sortable:true,            align:'center', width:80}, */ 
		{header: '생성일자',      name: 'CREATE_DATE',    filter:{type:'text'},          sortable:true,            align:'center', hidden:true},
		{header: '생성자',    	  name: 'CREATE_USER',    filter:{type:'text'},          sortable:true,            align:'center', hidden:true},
		{header: '수정일자',      name: 'UPDATE_DATE',    filter:{type:'text'},          sortable:true,            align:'center', hidden:true},
		{header: '수정자',    	  name: 'UPDATE_USER',    filter:{type:'text'},          sortable:true,            align:'center', hidden:true}
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
               return valueMap.sum.toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
             }
           },
           POWDER_WHITE_CNT: {
               template: function(valueMap) {
            	   return valueMap.sum.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
               }
           },
           POWDER_BLACK_CNT: {
               template: function(valueMap) {
            	   return valueMap.sum.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
               }
           },
           WHITE_USED_CNT: {
               template: function(valueMap) {
            	   return valueMap.sum.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
               }
           },
           BLACK_USED_CNT: {
               template: function(valueMap) {
            	   return valueMap.sum.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
               }
           },
           THICKNESS_1: {
           	template: function(valueMap) {
           		return valueMap.sum.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
           	}
           },
           THICKNESS_2: {
           	template: function(valueMap) {
           		return valueMap.sum.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
           	}
           },
           THICKNESS_3: {
           	template: function(valueMap) {
           		return valueMap.sum.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
           	}
           },
           THICKNESS_4: {
           	template: function(valueMap) {
           		return valueMap.sum.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
           	}
           },
           THICKNESS_5: {
           	template: function(valueMap) {
           		return valueMap.sum.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
           	}
           }/* ,
           MESH: {
           	template: function(valueMap) {
           		return valueMap.sum.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
           	}
           } */,
           MESH_OUT: {
           	template: function(valueMap) {
           		return valueMap.sum.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
           	}
           }
       }
    }
});


var dataSet;
var comboSet;

var outsInOut = {
	init:function(){
		this.productGubunSets();
		this.kindSets();
		searchCombo.getProdDtlList();
	},
	productGubunSets:function(){
		var params = {"code_group":"product_gubun"};
		$.ajax({
		    url : "/inout/outs/productGubunSets",
		    method :"POST",
		    data:params
		}).success(function(result) {
			$.each(result["PRODUCT_GUBUN"], function(i, item){
				if(item.CODE === 'product08' || item.CODE === 'product10' || item.CODE === 'product11' ){
					$('#PRODUCT_GUBUN').append($('<option/>').val(item.CODE).text(item.NAME));
					productGubunList.push({value:item.CODE, text:item.NAME});
				}
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
		    url : "/inout/outs/kindSets",
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
	search:function(p){
		var params = {
			'PRODUCT_GUBUN':$('#PRODUCT_GUBUN option:selected').val(),	
			'KIND':$('#KIND option:selected').val(),
			'PROD_NM':$('#PROD_NM option:selected').val(),
			'PROD_DTL_NM':$('#PROD_DTL_NM option:selected').val(),
			'PROD_ID':$('#PROD_ID').val(),
			'dateStart':$('#dateStart').val(),
			'dateEnd':$('#dateEnd').val()
		};
		$.ajax({
		    url : "/inout/outs/list",
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
			//outsInOut.view();
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    })/* .error(function(ev){
	    	alert('오류 : ' + ev);
	    }) */;
	}
}

var searchCombo = {
	getProdNm:function(e){
		var params = {"kind":$(this).val()};
		$.ajax({
		    url : "/inout/outs/prodNmList",
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
		    url : "/inout/outs/prodDtlNmList",
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
			    url : "/inout/outs/prodIdList",
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
	getProdDtlList:function(){
		$.ajax({
		    url : "/inout/outs/getProdDtlList",
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
	},
	getPrice:function(rowKey){
		var kind = gridEdit.getValue(rowKey, "KIND");
		var prodNm = gridEdit.getValue(rowKey, "PROD_NM");
		var prodDtlNm = gridEdit.getValue(rowKey, "PROD_DTL_NM");
		params = {"kind":kind, "prodNm":prodNm, "prodDtlNm":prodDtlNm};

		$.ajax({
		    url : "/inout/outs/getPrice",
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
	},
	popup: function(rowKey){
		alert(rowKey);
        var url = "/production/repair/page";
        var name = "popup test";
        var option = "width = 500, height = 500, top = 100, left = 200, location = no"
        window.open(url, name, option);
    }
}

$(function(){
	// 그리드 제어용
	$('#searchBtn').click(outsInOut.search);
	
	// 조회 콤보박스 제어용(품명, 상세품명 선택을 통해 품호를 구하기만 있음)
	$('#KIND').change(searchCombo.getProdNm);
	$('#PROD_NM').change(searchCombo.getProdDtlNm);
	$('#PROD_DTL_NM').change(searchCombo.getProdId);
	
	dateUtil.init();
	outsInOut.init();
	outsInOut.search('init');
	
});
</script>

