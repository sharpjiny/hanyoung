<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<style>
.red.tui-grid-cell{
	background-color:#f8e0e0;
}
.blue.tui-grid-cell{
	background-color:#cef6f5;
}
</style>
<script>
var Grid = tui.Grid;
window.onload = function(){
	
    /* $.ajax({
        url : "/preBoard/getPreBoardList",
        method :"GET",
        dataType : "JSON",
        success : function(result){
            grid.resetData(result);
        } 
    }); */
    
   var gridData = [
	  {
	    name: 'Beautiful Lies',
	    artist: 'Birdy',
	    release: '2016.03.26',
	    type: 'Deluxe',
	    genre: '1'
	  },
	  {
	    name: 'X',
	    artist: 'Ed Sheeran',
	    release: '2014.06.24',
	    type: 'Deluxe',
	    genre: '4',
	    _attributes: {
	      disabled: true // A current row is disabled
	    }
	  },
	  {
	    name: 'Moves Like Jagger',
	    release: '2011.08.08',
	    artist: 'Maroon5',
	    type: 'Single',
	    genre: '5',
	    _attributes: {
	      checkDisabled: true // A checkbox is disabled only
	    }
	  },
	  {
	    name: 'A Head Full Of Dreams',
	    artist: 'Coldplay',
	    release: '2015.12.04',
	    type: 'Deluxe',
	    genre: '2',
	    _attributes: {
	      checked: true, // A checkbox is already checked while rendering
	      className: {
	        // Add class name on a row
	        row: ['red']
	      }
	    }
	  },
	  {
	    name: '19',
	    artist: 'Adele',
	    release: '2008.01.27',
	    type: 'EP',
	    genre: [1,2],
	    /* _attributes: {
	      rowSpan: {
	        // Merge rows
	        artist: 3,
	        genre: 2
	      }
	    } */
	  },
	  {
	    name: '21',
	    artist: 'Adele',
	    release: '2011.01.21',
	    type: 'Deluxe',
	    genre: [1,2] // 똑같은 값이 있든, 아예 없든 하면됨.
	  },
	  {
	    name: '25',
	    artist: 'Adele',
	    release: '2015.11.20',
	    type: 'EP',
	    genre: '3',
	    _attributes: {
	      className: {
	        // Add class name on each columns
	        column: {
	          type: ['blue'],
	          genre: ['blue']
	        }
	      }
	    }
	  }
   ];
    
    for(var i=0; i<7;i+=1){
    	gridData[i].c2 = ((i+5)%8)*100+i,
    	gridData[i].c3 = ((i+3)%7)*60
    }
    
    var grid = new tui.Grid({
        el: document.getElementById('grid'),
        data: gridData,
        //scrollX: true,
        //scrollY: true,
        rowHeaders: ['rowNum', 'checkbox'],//'checkbox', 'rowNum'
        /* pageOptions:{
        	perPage:3
        }, */
        header:{
        	height: 160,
        	complexColumns:[
				  {
				    header: 'Basic',
				    name: 'mergeColumn1',
				    childNames: ['name', 'artist']
				  },
				  {
				    header: 'Extra',
				    name: 'mergeColumn2',
				    childNames: ['type', 'release', 'genre']
				  },
				  {
				    header: 'Detail',
				    name: 'mergeColumn3',
				    childNames: ['mergeColumn1', 'mergeColumn2']
				  },
				  {
				    header: 'Count',
				    name: 'mergeColumn4',
				    childNames: ['downloadCount', 'listenCount']
				  },
				  {
				    header: 'Album Info',
				    name: 'mergeColumn5',
				    childNames: ['c2','c3', 'mergeColumn3', 'mergeColumn4']
				  }
        	]
        },
        columns: [
            {
	          header: 'Name',
	          name: 'name',
	          sortable:true
	        },
	        {
	          header: 'Artist',
	          name: 'artist',
	          sortable:true,
	          rowSpan:true
	        },
	        {
	          header: 'Type',
	          name: 'type',
	          /*filter:{tyep:'text', showApplyBtn:true, showClearBtn:true}*/
	          filter:{type:'text'},
	          sortable:true
	        },
	        {
	          header: 'Release',
	          name: 'release'
	        },
	        {
	          header: 'Genre',
	          name: 'genre',
	          rowSpan:true,
	          formatter:'listItemText',
	          editor:{
	        	  type:'checkbox', // checkbox, select
	        	  options:{
	        		  listItems:[
	        		  	{text:'Pop', value:'1'},
	        		  	{text:'Rock', value:'2'},
	        		  	{text:'R&B', value:'3'},
	        		  	{text:'Electronic', value:'4'},
	        		  	{text:'etc', value:'5'}
	        		  ]
	        	  }
	          },
	          copyOptions:{
	        	  useListItemText:true
	          }
	        },
	        {
	          header: 'Score',
	          name: 'c2',
	          className:'clickable',
	          editor:'text'
	        },
	        {
	          header: 'Item Count',
	          name: 'c3',
	          className:'clickable',
	          editor:'text'
	        }
        ],
        //draggable:true,
        columnOptions:{
        	frozenCount:0,
        	frozenBorderWidth:2,
        	minWidth:300
        },
        summary: {
            height: 30,
            position: 'bottom', // or 'top'
            columnContent: {
              c2: {
                template: function(valueMap) {
                  return 'MAX: ' + valueMap.max + '<br>MIN: ' + valueMap.min;
                }
              },
              c3: {
                template: function(valueMap) {
                  return 'TOTAL: '+valueMap.sum + '<br>AVG: ' + valueMap.avg.toFixed(2);
                }
              }
            }
          }
      });
    
    grid.on('check', function(ev){
    	console.log("check!", ev);	
    });
    
    grid.on('uncheck', function(ev){
    	console.log("uncheck!", ev);	
    });	
    
    grid.on('focusChange', function(ev){
    	console.log("change focused cell!", ev);	
    });	
    
    grid.on('beforeChange', function(ev){
    	console.log("before change!", ev);	
    });	
    
    grid.on('afterChange', function(ev){
    	console.log("after change!", ev);	
    });	
    
    /* grid.on('scrollEnd', function(ev){
    	grid.appendRows(createRows());	
    }); */
    
    var appendBtn = document.getElementById('appendBtn');
    var prependBtn = document.getElementById('prependBtn');
    
    var appendedData = {
    	name:'Music',
    	artist:'Lee',
    	type: 'Deluxe',
    	release:'2019.09.09',
    	genre:'Pop',
    	c2:100,
    	c3:200
    };
    
    appendBtn.addEventListener('click', function(){
    	grid.appendRow(appendedData);
    });
    prependBtn.addEventListener('click', function(){
    	grid.prependRow(appendedData);
    });
    
    Grid.applyTheme('striped', /* {
    	grid:{
    		border: '#aaa',
    		text: '#333'
    	},
    	cell:{
    		disabled:{
    			text:'#999'
    		}
    	}
    } */);
};
</script>  

<div class="row-fluid">
    <!-- block -->
    <div class="block">
        <div class="navbar navbar-inner block-header">
            <div class="muted pull-left">grid test page</div>
        </div>
        <!-- <div class="block-content collapse in"> -->
            <!-- <div class="span12"> -->
            	<div class="alert alert-block">
            		<div id='grid'></div>
            	</div>
            	<div class="btn-wrapper">
            		<button id="appendBtn">appendBtn</button>
            		<button id="prependBtn">prependBtn</button>
            	</div>
            <!-- </div> -->
        <!-- </div> -->
	</div>
    <!-- /block -->
</div>
      