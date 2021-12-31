<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<title>Login</title>
<!-- Bootstrap -->
<link rel="stylesheet" type="text/css" href="<c:url value='/res/css/bootstrap.min.css'/>" media="screen"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/res/css/bootstrap-responsive.min.css'/>" media="screen"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/res/css/styles.css'/>" media="screen"/>
<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
<script src="<c:url value='/res/js/modernizr-2.6.2-respond-1.1.0.min.js'/>"></script>
</head>
<body id="login">
	<div class="container">
		<form:form modelAttribute="loginModel" action="login" method="post" onsubmit="return login.formChk(); return false;" class="form-signin">
			<h2 class="form-signin-heading">Please sign in</h2>
			<form:input path="id" title="ID" placeholder="Username" class="input-block-level"/>
			<div class="error"><form:errors path="id" cssClass="errors" class="login username-field" /></div>
			<form:password path="pwd" title="PASSWORD" placeholder="Password" class="input-block-level"/>
			<div class="error"><form:errors path="pwd" cssClass="errors" class="login password-field" /></div>
			<!-- <label
				class="checkbox"> <input type="checkbox" value="remember-me">
				Remember me
			</label> -->
			<button class="btn btn-large btn-primary" type="submit">Sign in</button>
		</form:form>
	</div>
	<!-- /container -->
	<script src="<c:url value='/res/js/plugin/jquery-1.9.1.min.js'/>"></script>
	<script src="<c:url value='/res/js/plugin/bootstrap.min.js'/>"></script>
	<script type="text/javascript">
	var login ={
		formChk : function(){
			var id = $('#id').val();
			var pwd = $('#pwd').val();
			if(!id){
				alert('아이디를 입력하세요.');
				return false;
			}
			if(!pwd){
				alert('비밀번호를 입력하세요.');
				return false;
			}
			return true;
		}
	}
	</script>
</body>
</html>