<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="no-js">
    <head>
        <title><tiles:getAsString name="title" /></title>
        <!-- Bootstrap -->
		<link rel="stylesheet" type="text/css" href="<c:url value='/res/css/bootstrap.min.css'/>" media="screen"/>
		<link rel="stylesheet" type="text/css" href="<c:url value='/res/css/bootstrap-responsive.min.css'/>" media="screen"/>
		<link rel="stylesheet" type="text/css" href="<c:url value='/res/css/styles.css'/>" media="screen"/>
        <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
            <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
		<script src="<c:url value='/res/js/plugin/modernizr-2.6.2-respond-1.1.0.min.js'/>"></script>
		<script src="<c:url value='/res/js/plugin/jquery-1.9.1.min.js'/>"></script>
		<script src="<c:url value='/res/js/plugin/bootstrap.min.js'/>"></script>
		<script src="<c:url value='/res/js/common.util.js'/>"></script>
		<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
		<link rel="stylesheet" href="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.css" />
		<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
		<link rel="stylesheet" type="text/css" href="<c:url value='/res/css/datepicker.css'/>" media="screen"/>
		<link rel="stylesheet" type="text/css" href="<c:url value='/res/css/jquery.datetimepicker.css'/>" media="screen"/>
		<script src="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.js"></script>
		<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
		<script src="https://uicdn.toast.com/tui.pagination/v3.4.0/tui-pagination.js"></script>
		<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
		<link rel="stylesheet" type="text/css" href="<c:url value='/res/css/datepicker.css'/>" media="screen" />
		<script src="<c:url value='/res/js/plugin/bootstrap-datepicker.js'/>"></script>
		<script src="<c:url value='/res/js/plugin/bootstrap-datepicker.kr.js'/>"></script>
		<script src="<c:url value='/res/js/plugin/jquery.datetimepicker.full.min.js'/>"></script>
		<script type="text/javascript">
			var userForm ={
				pop : function(){
					$('#changePwModal').modal('show');
				},
				save : function(){
					// 유효성 체크
					if(!$("#submitPwForm").validation()){
						return false;
					}
	
					$.ajax({
						url: '/userEditSave',
						type: 'POST',
						data: $("#submitPwForm").serialize()
					}).success(function( data ) {
						if(data.success == "OK"){
							alert("비밀번호 변경을 완료하였습니다.");
							location.href = "/logout";
						}
					}).fail(function() {
				    	alert( '등록을 실패했습니다' );
				    });
				}}
			$(function(){
				$('#userFormSave').click(userForm.save);
			});
		</script>
    </head>
    <body>
        <div class="navbar navbar-fixed-top">
            <tiles:insertAttribute name="header" />
        </div>
        <div class="container-fluid">
            <div class="row-fluid">
                <!--/span-->
                <div class="" id="content">
                    <tiles:insertAttribute name="content" />
                </div>
            </div>
            <hr>
            <footer>
                <p>&copy; HAN YOUNG 2022</p>
            </footer>
        </div>
        <!--/.fluid-container-->
        
        <!-- 공통 팝업(비밀번호변경) -->
        <div class="modal fade modal-min hide" id="changePwModal" tabindex="-1" role="dialog" aria-labelledby="changePwModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">비밀번호 변경</h4>
		      </div>
		      <div class="modal-body">
			      <form id="submitPwForm" class="form-horizontal" onsubmit="return false;">
			       <fieldset>
			         <div class="control-group">
			           <label class="col-sm-3 control-label" for="userPwd">아이디</label>
			           <div class="controls">
			             <input class="input-xlarge focused" id="userId" name="userId" type="text" title="아이디" placeholder="아이디" value='${userSession.id}'>
			           </div>
			         </div>
			         <div class="control-group">
			           <label class="col-sm-3 control-label" for="userPwd">변경 비밀번호</label>
			           <div class="controls">
			             <input class="input-xlarge focused" id="userPwd" name="userPwd" type="text" title="변경 비밀번호" placeholder="변경 비밀번호">
			           </div>
			         </div>
			       </fieldset>
					<input type="hidden" name="eventType" value=""/>
			     </form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		        <button type="button" class="btn btn-primary" id="userFormSave" >Save changes</button>
		      </div>
		    </div>
		  </div>
		</div>
    </body>
</html>