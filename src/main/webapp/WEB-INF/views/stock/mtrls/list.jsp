<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="row-fluid">
    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">원부자재 재고</div>
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
									<!-- <td width='70px'>구분</td>
									<td>
										<select id="PRODUCT_GUBUN" name="PRODUCT_GUBUN" class="" title="구분" style="margin-bottom:0px;">
											<option value="">구분</option>
										</select>
									</td> -->
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
						<!-- <div style="float:left;">	
							<table>
								<tr>
									<td width='70px'>입고일자</td>
									<td>
										<input class="date" name="dateStart" id="dateStart" type="text" style="margin-bottom:0px;">
										~
										<input class="date" name="dateEnd" id="dateEnd" type="text" style="margin-bottom:0px;">
									</td>
								</tr>
							</table>
						</div> -->	
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
			<div id="mtrlsStockGridView" ></div>
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

var productGubunList = [{value:'', text:'-선택-'}];
var kindList = [{value:'', text:'-선택-'}];
var prodIdRowList = [{value:'', text:'-선택-'}];

var gridView = new tui.Grid({
    el: document.getElementById('mtrlsStockGridView'),
    data: [],
    rowHeaders: ['rowNum'],//'checkbox', 'rowNum'
    header:{
    	height: 40
    },
    bodyHeight: 500,
    columns: [
		/* {header: '입고일자',    name: 'INOUT_DATE',      filter:{type:'text'},          sortable:true,            align:'center'},
		{header: '구분',     	name: 'PRODUCT_GUBUN_NM', filter:{type:'text'},         sortable:true,            align:'center'}, */
		{header: '종류',     	name: 'KIND_NM',   	  filter:{type:'text'},         	sortable:true,            align:'center'},
		{header: '품명',       	name: 'PROD_NM',      filter:{type:'text'},         	sortable:true,            align:'center'},
		{header: '상세품명',    name: 'PROD_DTL_NM',  filter:{type:'text'},         	sortable:true,            align:'center', width:150},
		{header: '품호',       	name: 'PROD_ID',      filter:{type:'text'},         	sortable:true,            align:'center'},
		{header: '제품수량',    name: 'WEIGHT_TOT',    filter:{type:'text'},         	sortable:true,            align:'center', formatter :function(v) {
		      return Number(v.value).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }}/* ,
		{header: '박스수량',  	name: 'BOX_COUNT',filter:{type:'text'},         	sortable:true,            align:'center', formatter :function(v) {
		      return Number(v.value).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }},
		{header: '단가',       	name: 'PRICE',        filter:{type:'text'},         	sortable:true,            align:'center', formatter :function(v) {
		      return Number(v.value).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }},
		{header: '총액',       	name: 'TOT_PRICE',    filter:{type:'text'},         	sortable:true,            align:'center', formatter :function(v) {
		      return Number(v.value).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    }} */
    ],
    columnOptions: {
    	resizable: true
    },
    summary: {
        height: 10,
        position: 'bottom', // or 'top'
        columnContent: {
        	WEIGHT_TOT: {
        		template: function(valueMap) {
        			return valueMap.sum.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                }
            }/* ,
            BOX_COUNT: {
            	template: function(valueMap) {
            		return valueMap.sum.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            	}
            },
            PRICE: {
        		template: function(valueMap) {
        			return valueMap.sum.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                }
            },
            TOT_PRICE: {
            	template: function(valueMap) {
            		return valueMap.sum.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            	}
            } */
       }
    }
});

var dataSet;
var comboSet;

var mtrlsStock = {
	init:function(){
		//this.productGubunSets();
		this.kindSets();
		searchCombo.getProdIdRowList();
	},
	/* productGubunSets:function(){
		var params = {"code_group":"product_gubun"};
		$.ajax({
		    url : "/stock/mtrls/productGubunSets",
		    method :"POST",
		    data:params
		}).success(function(result) {
			$.each(result["PRODUCT_GUBUN"], function(i, item){
				$('#PRODUCT_GUBUN').append($('<option/>').val(item.CODE).text(item.NAME));
				productGubunList.push({value:item.CODE, text:item.NAME});
			});
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    });
	}, */
	kindSets:function(){
		var params = {"code_group":"product_kind"};
		$.ajax({
		    url : "/stock/mtrls/kindSets",
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
	search:function(){
		var params = {
			//'PRODUCT_GUBUN':$('#PRODUCT_GUBUN option:selected').val(),
			'KIND':$('#KIND option:selected').val(),
			'PROD_NM':$('#PROD_NM option:selected').val(),
			'PROD_DTL_NM':$('#PROD_DTL_NM option:selected').val(),
			'PROD_ID':$('#PROD_ID').val()
			//'dateStart':$('#dateStart').val(),
			//'dateEnd':$('#dateEnd').val()
		};
		$.ajax({
		    url : "/stock/mtrls/list",
		    method :"POST",
		    data:params
		}).success(function(result) {
			dataSet = result;
			gridView.resetData(result);
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    });
	}
}

var searchCombo = {
	getProdNm:function(e){
		var params = {"kind":$(this).val()};
		$.ajax({
		    url : "/stock/mtrls/prodNmList",
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
		    url : "/stock/mtrls/prodDtlNmList",
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
		var kind = $('#KIND').val();
		var prodNm = $('#PROD_NM').val();
		var prodDtlNm = $(this).val();
		var params = {};
		
		if(kind == null || prodNm == null || prodDtlNm == null || kind == '' || prodNm == '' || prodDtlNm == ''){
			return;
		}else{
			params = {"kind":kind, "prodNm":prodNm, "prodDtlNm":prodDtlNm};
			$.ajax({
			    url : "/stock/mtrls/prodIdList",
			    method :"POST",
			    data:params
			}).success(function(result) {
				$('#PROD_ID').val('');
				$.each(result["PROD_ID"], function(i, item){
					$('#PROD_ID').val(item.CODE);
				});
				
			}).fail(function(ev) {
		    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
		    	$('#PROD_ID').text('');
		    });
		}
	},
	getProdIdRowList:function(){
		$.ajax({
		    url : "/stock/mtrls/getProdIdRowList",
		    method :"POST",
		    data:{}
		}).success(function(result) {
			prodIdRowList = result["PROD_ID_LIST"];
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    });
	}
}

$(function(){
	// 그리드 제어용
	$('#searchBtn').click(mtrlsStock.search);
	
	// 조회 콤보박스 제어용(품명, 상세품명 선택을 통해 품호를 구하기만 있음)
	$('#KIND').change(searchCombo.getProdNm);
	$('#PROD_NM').change(searchCombo.getProdDtlNm);
	$('#PROD_DTL_NM').change(searchCombo.getProdId);
	
	dateUtil.init();
	mtrlsStock.init();
	mtrlsStock.search();
	
});
</script>

