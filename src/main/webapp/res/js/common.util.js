
//html to xml
jQuery.fn.validation = function() {
	var $this = null;
	var msg, thisValue = "";
	var ret = true;
	this.find(":input:not(.skip):not(:radio):not(:hidden):not(:file):not(:button)").each(function(){
		$this = $(this);
		msg = $this.attr("title");
		thisValue = $.trim($this.val());
		if(!thisValue){
			var type="입력";
			if($this.attr("type")!='text'){
				type="선택";
			}
			msg += "을(를) "+type+"하세요.";
			ret = false;
			return false;
		}else if(thisValue.length > $this.attr("maxlength")){
			msg += "의 문자 길이는 최대 "+$this.attr("maxlength")+" 까지 허용합니다.";
			ret = false;
			return false;
		}

		if ($this.attr('validate') === 'number' && !isNumeric(thisValue,4)) {
			ret = false;
			msg = '숫자만 입력해주세요.';
			return false;
		}
	});
	if(!ret){
		alert(msg);
		$this.focus();
	}
	$this.val(thisValue);
	return ret;
};

function isNumeric(num, opt){
  // 좌우 trim(공백제거)을 해준다.
  num = String(num).replace(/^\s+|\s+$/g, "");

  if(typeof opt == "undefined" || opt == "1"){
    // 모든 10진수 (부호 선택, 자릿수구분기호 선택, 소수점 선택)
    var regex = /^[+\-]?(([1-9][0-9]{0,2}(,[0-9]{3})*)|[0-9]+){1}(\.[0-9]+)?$/g;
  }else if(opt == "2"){
    // 부호 미사용, 자릿수구분기호 선택, 소수점 선택
    var regex = /^(([1-9][0-9]{0,2}(,[0-9]{3})*)|[0-9]+){1}(\.[0-9]+)?$/g;
  }else if(opt == "3"){
    // 부호 미사용, 자릿수구분기호 미사용, 소수점 선택
    var regex = /^[0-9]+(\.[0-9]+)?$/g;
  }else if(opt == "4"){
	    // 부호 선택, 자릿수구분기호 미사용, 소수점 선택
	    var regex = /^[+\-]?[0-9]+(\.[0-9]+)?$/g;
  }else{
    // only 숫자만(부호 미사용, 자릿수구분기호 미사용, 소수점 미사용)
    var regex = /^[0-9]$/g;
  }

  if( regex.test(num) ){
    num = num.replace(/,/g, "");
    return isNaN(num) ? false : true;
  }else{ return false;  }
}

var paging = {
	moveEvent : false,
	init : function() {
		$("#searchForm")
			.find("[name=pageNum]").val(1).end()
			.submit();
		return false;
	},
	submit : function() {
		if (!paging.moveEvent) {
			$("#searchForm").find("[name=pageNum]").val(1);
		}
		return true;
	},
	moveLink : function(){
		paging.moveEvent = true;
		var flag = $(this).attr("flag");
		if (!flag){
			var pageNum = $(this).attr("pageNum");
			if (!pageNum) pageNum = 1;
				$("#searchForm")
				.find("[name=pageNum]").val(pageNum).end()
				.submit();
		}else{
			var pageNum = $(this).attr("pageNum"+flag);
			if (!pageNum) pageNum = 1;
				$("#searchForm")
				.find("[name=pageNum"+flag+"]").val(pageNum).end()
				.submit();
		}
		
		return false;
	},

	orderByLink : function(){
		paging.moveEvent = true;
		$("#searchForm").submit();
		return false;
	},

	excel : function(link) {
		if(!link) link="excel";
		if($("#searchForm").length > 0 ){
			paging.moveEvent = true;
			$("#searchForm")
				.attr("action", link)
				.submit();
			$("#searchForm").attr("action", "");
			return false;
		}
		location.href = link;
	}
};

var dateUtil={
	init : function(){
		$("input.date").datepicker({
            calendarWeeks: false,
            todayHighlight: true,
            autoclose: true,
            format: "yyyy-mm-dd",
            language: "ko"
        });
	},

	initMonth : function(){
		$("input.month").datepicker({
	        calendarWeeks: false,
	        todayHighlight: true,
	        autoclose: true,
	        format: "yyyy-mm",
	        viewMode: "months",
	        minViewMode: "months",
	        language: "ko"
	    });
	}
}

function app_handle_listing_horisontal_scroll(listing_obj)
{
  //get table object
  table_obj = $('.table',listing_obj);

  //get count fixed collumns params
  count_fixed_collumns = table_obj.attr('data-count-fixed-columns')

  if(count_fixed_collumns>0)
  {
    //get wrapper object
    wrapper_obj = $('.table-scrollable',listing_obj);

    wrapper_left_margin = 0;

    table_collumns_width = new Array();
    table_collumns_margin = new Array();

    //calculate wrapper margin and fixed column width
    $('th',table_obj).each(function(index){
       if(index<count_fixed_collumns)
       {
         wrapper_left_margin += $(this).outerWidth();
         table_collumns_width[index] = $(this).outerWidth();
       }
    })

    //calcualte margin for each column
    $.each( table_collumns_width, function( key, value ) {
      if(key==0)
      {
        table_collumns_margin[key] = wrapper_left_margin;
      }
      else
      {
        next_margin = 0;
        $.each( table_collumns_width, function( key_next, value_next ) {
          if(key_next<key)
          {
            next_margin += value_next;
          }
        });

        table_collumns_margin[key] = wrapper_left_margin-next_margin;
      }
    });

    //set wrapper margin
    if(wrapper_left_margin>0)
    {
      wrapper_obj.css('cssText','margin-left:'+wrapper_left_margin+'px !important; width: auto')
    }

    //set position for fixed columns
    $('tr',table_obj).each(function(){

      //get current row height
      current_row_height = $(this).outerHeight();

      $('th,td',$(this)).each(function(index){

         //set row height for all cells
         $(this).css('height',current_row_height)

         //set position
         if(index<count_fixed_collumns)
         {
           $(this).css('position','absolute')
                  .css('margin-left','-'+table_collumns_margin[index]+'px')
                  .css('width',table_collumns_width[index]-17)

           $(this).addClass('table-fixed-cell')
         }
      })
    })
  }
}