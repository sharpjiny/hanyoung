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
            <div class="muted pull-left">생산관리 > 생산</div>
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
									<td width='70px'>작업공인</td>
									<td>
										<input name="PRODUCT_MAN" id="PRODUCT_MAN" type="text" style="margin-bottom:0px;">
										<!-- <select id="PRODUCT_GUBUN" name="PRODUCT_GUBUN" class="" title="작업공인" style="margin-bottom:0px;">
											<option value="">작업공인</option>
										</select> -->
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
                   </div>
                </div>
            </div>
        </div>
        <div style="height:525px;">
			<div id="prdtProdGridView" ></div>
			<div id="prdtProdGridEdit" style="display:none"></div>
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
    el: document.getElementById('prdtProdGridView'),
    data: [],
    rowHeaders: ['rowNum'],//'checkbox', 'rowNum'
    header:{
    	height: 40
    },
    bodyHeight: 500,
    columns: [
		{header: '日期',      name: 'PRDT_DATE',      filter:{type:'text'},          sortable:true,            align:'center', width:100},
		{header: '白班/夜班',    	  name: 'WORK_TYPE',      filter:{type:'text'},          sortable:true,            align:'center', width:100},
		{header: '设备',    	  name: 'EQP_ID',      	  filter:{type:'text'},          sortable:true,            align:'center', width:120},
		{header: '工程',    	  name: 'AREA',           filter:{type:'text'},          sortable:true,            align:'center', width:120},
		{header: '种类',     	  name: 'KIND_NM',   	  filter:{type:'text'},          sortable:true,            align:'center', width:120},
		{header: '产品',       	  name: 'PROD_NM',        filter:{type:'text'},          sortable:true,            align:'center', width:120},
		{header: '品名',      name: 'PROD_DTL_NM',    filter:{type:'text'},          sortable:true,            align:'center', width:120},
		{header: '品号 ',    	  name: 'PROD_ID',        filter:{type:'text'},          sortable:true,            align:'center', width:100},
		{header: 'UPH',    	      name: 'UPH',      	  filter:{type:'text'},          sortable:true,            align:'center'},
		{header: '开始时间',      name: 'ST_TIME',        filter:{type:'text'},          sortable:true,            align:'center', width:110},
		{header: '结束时间',      name: 'ED_TIME',        filter:{type:'text'},          sortable:true,            align:'center', width:110},
		{header: '工作时间',  	  name: 'WORK_TIME',  	  filter:{type:'text'},          sortable:true,            align:'center', width:100},
		{header: '休息时间',  	  name: 'REST_TIME',  	  filter:{type:'text'},          sortable:true,            align:'center', width:100},
		{header: '流失时间',  	  name: 'STOPPING_TIME',  filter:{type:'text'},          sortable:true,            align:'center', width:100, formatter:function(v) {
			return v.value != null && v.value != '' ? "<div onclick=searchCombo.popup("+v.rowKey+")>"+v.value+"</div>" : null;
		}},
		{header: '生产数量' ,      name: 'PRDT_CNT',       filter:{type:'text'},          sortable:true,            align:'center', width:100, formatter:function(v) { // 추가
			return v.value != null && v.value != '' ? v.value.toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ",") : null;
	    }},
		{header: '不良数量',      name: 'FAULTY_CNT',     filter:{type:'text'},          sortable:true,            align:'center', width:100, formatter:function(v) { // 추가
			return v.value != null && v.value != '' ? v.value.toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ",") : null;
	    }},
		{header: '良品数量',      name: 'FINISHED_CNT',   filter:{type:'text'},          sortable:true,            align:'center', width:100, formatter:function(v) { // 추가
			return v.value != null && v.value != '' ? v.value.toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ",") : null;
	    }},
		{header: '达成率',    	  name: 'CMPLT_PER',      filter:{type:'text'},          sortable:true,            align:'center', width:100, formatter:function(v) { // 추가
		      return v.value+'%';
	    }},
	    {header: '工人达成率',    	  name: 'MAN_CMPLT_PER',      filter:{type:'text'},          sortable:true,            align:'center', width:100, formatter:function(v) { // 추가
		      return v.value+'%';
	    }},
		{header: '工人1',    	  name: 'MAN1',      filter:{type:'text'},          sortable:true,            align:'center', width:80},
		{header: '工人2',    	  name: 'MAN2',      filter:{type:'text'},          sortable:true,            align:'center', width:80},
		{header: '工人3',    	  name: 'MAN3',      filter:{type:'text'},          sortable:true,            align:'center', width:80},
		{header: '工人4',    	  name: 'MAN4',      filter:{type:'text'},          sortable:true,            align:'center', width:80},
		{header: '1.45',    	  name: 'THICKNESS_1',    filter:{type:'text'},          sortable:true,            align:'center', width:80},
		{header: '2.0',    		  name: 'THICKNESS_2',    filter:{type:'text'},          sortable:true,            align:'center', width:80},
		{header: '2.5',    		  name: 'THICKNESS_3',    filter:{type:'text'},          sortable:true,            align:'center', width:80},
		{header: '2.9',    		  name: 'THICKNESS_4',    filter:{type:'text'},          sortable:true,            align:'center', width:80},
		{header: '3.8',    		  name: 'THICKNESS_5',    filter:{type:'text'},          sortable:true,            align:'center', width:80},
		{header: '추가두께',   	  name: 'THICKNESS_6',    filter:{type:'text'},          sortable:true,            align:'center', hidden:true},
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
        	STOPPING_TIME: {
        		template: function(valueMap) {
        			return valueMap.sum;
             	}
    		},
        	PRDT_CNT: {
             template: function(valueMap) {
               return valueMap.sum.toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
             }
           },
           FAULTY_CNT: {
             template: function(valueMap) {
               return valueMap.sum.toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
             }
           },
           FINISHED_CNT: {
             template: function(valueMap) {
               return valueMap.sum.toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
             }
           },
           CMPLT_PER: {
               template: function(valueMap) {
                 return valueMap.avg.toFixed(2) +'%';
               }
           },
           MAN_CMPLT_PER: {
               template: function(valueMap) {
                 return valueMap.avg.toFixed(2) +'%';
               }
           },
           THICKNESS_1: {
           	template: function(valueMap) {
           		return valueMap.sum;
           	}
           },
           THICKNESS_2: {
           	template: function(valueMap) {
           		return valueMap.sum;
           	}
           },
           THICKNESS_3: {
           	template: function(valueMap) {
           		return valueMap.sum;
           	}
           },
           THICKNESS_4: {
           	template: function(valueMap) {
           		return valueMap.sum;
           	}
           },
           THICKNESS_5: {
           	template: function(valueMap) {
           		return valueMap.sum;
           	}
           }
       }
    }
});

var gridEdit = new tui.Grid({
    el: document.getElementById('prdtProdGridEdit'),
    //scrollY: true,
    data: [],
    rowHeaders: ['checkbox', 'rowNum'],//'checkbox', 'rowNum'
    header:{
    	height: 40
    },
    bodyHeight: 500,
    columns: [
		{header: '日期',      name: 'PRDT_DATE',      filter:{type:'text'},          sortable:true,            align:'center', width:100, className:'clickable', validation:{required:true}, editor:{type:'datePicker', options:{language: 'ko', format: 'yy-MM-dd'}}},
		{header: '白班/夜班',    	  name: 'WORK_TYPE',      filter:{type:'text'},          sortable:true,            align:'center', width:100, className:'clickable', validation:{required:true}, formatter:'listItemText',
	        editor:{
	        	type:'select', // checkbox, select
	        	options:{
	        		listItems:workTypeList
	       		}
        }},
		{header: '设备',    	  name: 'EQP_ID',      	  filter:{type:'text'},          sortable:true,            align:'center', width:120, className:'clickable', validation:{required:true}, formatter:'listItemText',
	        editor:{
	        	type:'select', // checkbox, select
	        	options:{
	        		listItems:eqpIdList
	       		}
        }},
		{header: '工程',    	  name: 'AREA',           filter:{type:'text'},          sortable:true,            align:'center', width:120, className:'clickable', validation:{required:true}, formatter:'listItemText',
	        editor:{
	        	type:'select', // checkbox, select
	        	options:{
	        		listItems:areaTypeList
	       		}
        }},
		{header: '种类', 		  name: 'KIND', 		  filter:{type:'text'}, 		 sortable:true,            align:'center', width:120, className:'clickable', validation:{required:true}, formatter:'listItemText',
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
		{header: '产品',		 name: 'PROD_NM', 		  filter:{type:'text'}, 		sortable:true, 			  align:'center', width:120, className:'clickable', validation:{required:true}, formatter:'listItemText',
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
		{header: '品名', name: 'PROD_DTL_NM', filter:{type:'text'}, sortable:true, align:'center', className:'clickable', width:120, validation:{required:true}, formatter:'listItemText',
   	    	onAfterChange:function(o){
	   	    	searchCombo.getProdId(o);
	   	    },
   	    	editor:{type:'select', // checkbox, select
        	options:{
        		listItems:[{value:'', text:'-선택-'}]
       		}}},
		{header: '品号 ',    	  name: 'PROD_ID',        filter:{type:'text'},          sortable:true,            align:'center', width:100, className:'clickable',        editor:'text', disabled:true},
		{header: 'UPH',    	      name: 'UPH',      	  filter:{type:'text'},          sortable:true,            align:'center', className:'clickable', validation:{required:true}, editor:'text'},
		{header: '开始时间',      name: 'ST_TIME',        filter:{type:'text'},          sortable:true,            align:'center', width:110, className:'clickable', validation:{required:true}, editor:{
            type: 'datePicker',
            options: {
            	language: 'ko',
            	format: 'yy-MM-dd HH:mm',
            	timepicker: {
            		//layoutType: 'tab',
            		showMeridiem:false,
            		inputType: 'selectbox'
                }
            }
          }},
		{header: '结束时间',      name: 'ED_TIME',        filter:{type:'text'},          sortable:true,            align:'center', width:110, className:'clickable', validation:{required:true}, editor:{
            type: 'datePicker',
            options: {
            	language: 'ko',
            	format: 'yy-MM-dd HH:mm',
            	timepicker: {
            		//layoutType: 'tab',
            		//inputType: 'spinbox'
            		showMeridiem:false,
            		inputType: 'selectbox'
                }
            }
          }},
		{header: '工作时间',  	  name: 'WORK_TIME',      filter:{type:'text'},          sortable:true,            align:'center', width:100, disabled:true},
		{header: '休息时间',  	  name: 'REST_TIME',  	  filter:{type:'text'},          sortable:true,            align:'center', width:100, editor:'text'},
		{header: '流失时间',  	  name: 'STOPPING_TIME',  filter:{type:'text'},          sortable:true,            align:'center', width:100, editor:'text'},
		{header: '生产数量',      name: 'PRDT_CNT',       filter:{type:'text'},          sortable:true,            align:'center', width:100, validation:{required:true}, editor:'text', formatter:function(v) { // 추가
		      return v.value != null && v.value != '' ? Number(v.value).toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ",") : null;
	    }},
		{header: '不良数量',      name: 'FAULTY_CNT',     filter:{type:'text'},          sortable:true,            align:'center', width:100, editor:'text', formatter:function(v) { // 추가
		      return v.value != null && v.value != '' ? Number(v.value).toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ",") : null;
	    }},
		{header: '良品数量',      name: 'FINISHED_CNT',   filter:{type:'text'},          sortable:true,            align:'center', width:100, editor:'text', disabled:true, formatter:function(v) { // 추가
		      return v.value != null && v.value != '' ? Number(v.value).toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ",") : null;
	    }},
		{header: '达成率',    	  name: 'CMPLT_PER',      filter:{type:'text'},          sortable:true,            align:'center', width:100, disabled:true, formatter:function(v) { // 추가
		      return v.value != null && v.value != '' ? v.value+'%' : null;
	    }},
	    {header: '工人达成率',    	  name: 'MAN_CMPLT_PER',      filter:{type:'text'},          sortable:true,            align:'center', width:100, disabled:true, formatter:function(v) { // 추가
		      return v.value != null && v.value != '' ? v.value+'%' : null;
	    }},
		{header: '工人1',    	  name: 'MAN1',      filter:{type:'text'},          sortable:true,            align:'center', editor:'text', width:80},
		{header: '工人2',    	  name: 'MAN2',      filter:{type:'text'},          sortable:true,            align:'center', editor:'text', width:80},
		{header: '工人3',    	  name: 'MAN3',      filter:{type:'text'},          sortable:true,            align:'center', editor:'text', width:80},
		{header: '工人4',    	  name: 'MAN4',      filter:{type:'text'},          sortable:true,            align:'center', editor:'text', width:80},
		{header: '1.45',    	  name: 'THICKNESS_1',    filter:{type:'text'},          sortable:true,            align:'center', editor:'text', width:80, disabled:true},
		{header: '2.0',    		  name: 'THICKNESS_2',    filter:{type:'text'},          sortable:true,            align:'center', editor:'text', width:80, disabled:true},
		{header: '2.5',    		  name: 'THICKNESS_3',    filter:{type:'text'},          sortable:true,            align:'center', editor:'text', width:80, disabled:true},
		{header: '2.9',    		  name: 'THICKNESS_4',    filter:{type:'text'},          sortable:true,            align:'center', editor:'text', width:80, disabled:true},
		{header: '3.8',    		  name: 'THICKNESS_5',    filter:{type:'text'},          sortable:true,            align:'center', editor:'text', width:80, disabled:true},
		{header: '추가두께',      name: 'THICKNESS_6',    filter:{type:'text'},          sortable:true,            align:'center', editor:'text', disabled:true, hidden:true},
		{header: '备注',    	  name: 'BIGO',      	  filter:{type:'text'},          sortable:true,            align:'center', width:250, editor:'text'},
		/* {header: '完了',    name: 'IS_CHECK',	filter:{type:'text'},		sortable:true,		align:'center',		className:'clickable', 	width:100, formatter:'listItemText',        
			editor:{type:'select',
			options:{
        		listItems:[{text:'NO', value:'NO'}, {text:'OK', value:'OK'}]
       		}}}, */
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
        	STOPPING_TIME: {
        		template: function(valueMap) {
        			return valueMap.sum;
             	}
    		},
        	PRDT_CNT: {
        		template: function(valueMap) {
        			return valueMap.sum.toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
             	}
    		},
    		FAULTY_CNT: {
                template: function(valueMap) {
                	return valueMap.sum.toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                }
            },
            FINISHED_CNT: {
            	template: function(valueMap) {
            		return valueMap.sum.toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            	}
            },
            CMPLT_PER: {
                template: function(valueMap) {
                  return valueMap.avg.toFixed(2) + '%';
                }
            },
            MAN_CMPLT_PER: {
                template: function(valueMap) {
                  return valueMap.avg.toFixed(2) +'%';
                }
            },
            THICKNESS_1: {
            	template: function(valueMap) {
            		return valueMap.sum;
            	}
            },
            THICKNESS_2: {
            	template: function(valueMap) {
            		return valueMap.sum;
            	}
            },
            THICKNESS_3: {
            	template: function(valueMap) {
            		return valueMap.sum;
            	}
            },
            THICKNESS_4: {
            	template: function(valueMap) {
            		return valueMap.sum;
            	}
            },
            THICKNESS_5: {
            	template: function(valueMap) {
            		return valueMap.sum;
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

var prdtProd = {
	init:function(){
		//this.productGubunSets();
		this.kindSets();
		this.eqpIdSets();
		this.areaTypeSets();
		this.workTypeSets();
		searchCombo.getProdDtlList();
	},
	/* productGubunSets:function(){
		var params = {"code_group":"product_gubun"};
		$.ajax({
		    url : "/production/prod/productGubunSets",
		    method :"POST",
		    data:params
		}).success(function(result) {
			$.each(result["PRODUCT_GUBUN"], function(i, item){
				$('#PRODUCT_GUBUN').append($('<option/>').val(item.CODE).text(item.NAME));
				productGubunList.push({value:item.CODE, text:item.NAME});
			});
			
			//dataSet = result;
			//gridView.resetData(result);
			//prdtProd.view();
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    });
	}, */
	kindSets:function(){
		var params = {"code_group":"product_kind"};
		$.ajax({
		    url : "/production/prod/kindSets",
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
	eqpIdSets:function(){
		var params = {"code_group":"eqp_id"};
		$.ajax({
		    url : "/production/prod/eqpIdSets",
		    method :"POST",
		    data:params
		}).success(function(result) {
			$.each(result["EQP_ID"], function(i, item){
				$('#EQP_ID').append($('<option/>').val(item.CODE).text(item.NAME));
				eqpIdList.push({value:item.CODE, text:item.NAME});
			});
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    });
	},
	areaTypeSets:function(){
		var params = {"code_group":"area_type"};
		$.ajax({
		    url : "/production/prod/areaTypeSets",
		    method :"POST",
		    data:params
		}).success(function(result) {
			$.each(result["AREA_TYPE"], function(i, item){
				$('#AREA_TYPE').append($('<option/>').val(item.CODE).text(item.NAME));
				areaTypeList.push({value:item.CODE, text:item.NAME});
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
			'PRODUCT_MAN':$('#PRODUCT_MAN').val(),
			'EQP_ID':$('#EQP_ID option:selected').val(),
			'KIND':$('#KIND option:selected').val(),
			'PROD_NM':$('#PROD_NM option:selected').val(),
			'PROD_DTL_NM':$('#PROD_DTL_NM option:selected').val(),
			'PROD_ID':$('#PROD_ID').val(),
			'dateStart':$('#dateStart').val(),
			'dateEnd':$('#dateEnd').val()
		};
		$.ajax({
		    url : "/production/prod/list",
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
			prdtProd.view();
		}).fail(function(ev) {
	    	alert('조회를 실패했습니다.(오류 : ' + ev + ' )');
	    })/* .error(function(ev){
	    	alert('오류 : ' + ev);
	    }) */;
	},
	view:function(){
		$('#prdtProdGridEdit').hide();
		$('#prdtProdGridView').show();
		$('#editBtn').show();
		$('#saveBtn').hide();
		$('#delBtn').hide();
		$('#addBtn').hide();
		$('#viewBtn').hide();
	},
	edit:function(){
		$('#prdtProdGridView').hide();
		$('#prdtProdGridEdit').show();
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
		
	    /*
	    var stopFlag = false;
	    
		if(saveData.updatedRows.length > 0){
			$.each(saveData.updatedRows, function(i, v){
				var orgRowKey = saveData.updatedRows[i]["rowKey"];
				var orgIsChk = gridEdit.dataManager.getOriginData()[orgRowKey]["IS_CHECK"];
				if(orgIsChk == "OK"){
					alert("[No."+(orgRowKey+1)+"]" + " 完了(OK) 인 경우, 수정할 수 없습니다. \n관리자에게 요청해 주세요.");
					stopFlag = true;
					return false;
				}
			});
		}
		
		if(stopFlag){
			return;
		} */
		
		/* 
		var resultArr = [];
		var flag = false;
		for(var i = 0; i < gridEdit.getData().length; i++){
	        if(i=0) resultArr.push(gridEdit.getData()[i]);
			for(value in resultArr){
				if(resultArr[value].PRDT_DATE === gridEdit.getData()[i].PRDT_DATE
					&& resultArr[value].WORK_TYPE === gridEdit.getData()[i].WORK_TYPE
					&& resultArr[value].EQP_ID === gridEdit.getData()[i].EQP_ID
					&& resultArr[value].AREA === gridEdit.getData()[i].AREA
					&& resultArr[value].PROD_ID === gridEdit.getData()[i].PROD_ID){
					flag = true;
					alert("No." + (gridEdit.getData()[i]["rowKey"]) + " 이미 등록된 데이터입니다.");
					break;
				}
			}
			
			if(flag){
				//alert("No." + (gridEdit.getData()[i]["rowKey"]) + " 이미 등록된 데이터입니다.");
				break;
			}
			
		}
		
		return; */
		
		let chkLen = saveData.createdRows.length + saveData.updatedRows.length + saveData.deletedRows.length;
		
		if(chkLen > 0){
			$.ajax({
			    url : "/production/prod/save", 
			    contentType : "application/json",
			    method :"POST",
			    data:JSON.stringify(saveData)
			}).success(function(result) {
				alert(" ㅇ 추가 : " + result["insert"] + "건\n" + " ㅇ 수정 : " + result["update"] + "건\n" + " ㅇ 삭제 : " + result["delete"] + "건");
				prdtProd.search();
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
		gridEdit.prependRow();
		//gridEdit.prependRow({IS_CHECK:'NO'});
		//gridEdit.prependRow({FAULTY_CNT:0});
	}
}

var searchCombo = {
	getProdNm:function(e){
		var params = {"kind":$(this).val()};
		$.ajax({
		    url : "/production/prod/prodNmList",
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
		    url : "/production/prod/prodDtlNmList",
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
			    url : "/production/prod/prodIdList",
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
		    url : "/production/prod/getProdDtlList",
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
		    url : "/production/prod/getPrice",
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
	$('#searchBtn').click(prdtProd.search);
	$('#viewBtn').click(prdtProd.view);
	$('#editBtn').click(prdtProd.edit);
	$('#saveBtn').click(prdtProd.save);
	$('#addBtn').click(prdtProd.add);
	$('#delBtn').click(prdtProd.del);
	
	// 조회 콤보박스 제어용(품명, 상세품명 선택을 통해 품호를 구하기만 있음)
	$('#KIND').change(searchCombo.getProdNm);
	$('#PROD_NM').change(searchCombo.getProdDtlNm);
	$('#PROD_DTL_NM').change(searchCombo.getProdId);
	
	dateUtil.init();
	prdtProd.init();
	prdtProd.search('init');
	
});
</script>

