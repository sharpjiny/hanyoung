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
		<script src="https://uicdn.toast.com/tui.pagination/v3.4.0/tui-pagination.js"></script>
		<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
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
    </body>
</html>