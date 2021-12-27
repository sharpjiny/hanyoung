<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
죄송합니다.<br />
사용이 제한되어 있습니다.<br />
관리자에게 문의 후 사용하세요. <br />
이전화면으로 이동하시려면 브라우저의 뒤로가기 버튼을 눌려주시기 바랍니다.<br />

<a href="${contextPath}/logout">홈으로 이동</a>

