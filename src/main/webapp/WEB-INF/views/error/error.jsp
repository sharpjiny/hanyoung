<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
죄송합니다.<br />
잠시 시스템에 오류가 발생하었습니다.<br />
잠시 후 이용하여 주시기 바랍니다.<br />
이전화면으로 이동하시려면 브라우저의 뒤로가기 버튼을 눌려주시기 바랍니다.<br />

<a href="${contextPath}/home">홈으로 이동</a>

<%-- 		<h1><img src="${contextPath}/img/common/adminCi.jpg" alt="해양경찰청 모바일 관리자 CI" /></h1>
		<div id="content">
			<h2><img src="${contextPath}/img/common/error_mark.jpg" alt="에러 마크" /></h2>
			<div id="msg">
				<span class="error" >
					<spring:message code='image.errorBg' /><c:out value="${exception.message}"/>
			 	</span>
			</div>
			<div>
				<a href="${contextPath}/index.do" ><img src="${contextPath}/img/common/bu_accept.jpg" alt="확인 링크이동" /></a>
			</div>
		</div> --%>
