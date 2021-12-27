<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="dialog-userEditForm" title="관리자 계정" class="popup">
	<form action="" class="textL" id="editForm">
		<fieldset>
			<label for="for_user_role">권한</label>
			<select name="userRole" id="for_user_role" title="권한" class="ui-widget-content ui-corner-all">
				<c:forEach items="${roleList}" var="item">
					<option value="${item.code}">${item.name}</option>
				</c:forEach>
			</select>
		</fieldset>
		<fieldset>
			<label for="for_user_name">이름</label>
			<input type="text" name="userName" id="for_user_name" title="이름" dataType="CHAR" maxlength="100" class="ui-widget-content ui-corner-all" />
		</fieldset>
		<fieldset>
			<label for="for_user_id">아이디</label>
			<input type="text" name="userId" id="for_user_id" title="아이디" dataType="CHAR" maxlength="50" class="ui-widget-content ui-corner-all" />
		</fieldset>
		<fieldset>
			<label for="for_user_pwd">비밀번호</label>
			<input type="password" name="userPwd" id="for_user_pwd" title="비밀번호" dataType="CHAR" maxlength="20" class="skipData ui-widget-content ui-corner-all" />
		</fieldset>
		<fieldset>
			<label for="for_user_pwdCopy" class="nowPwd">비밀번호 확인</label>
			<input type="password" name="userPwdCopy" id="for_user_pwdCopy" title="비밀번호 확인" dataType="CHAR" maxlength="20" class="nowPwd skipData ui-widget-content ui-corner-all" />
		</fieldset>
		<fieldset>
			<label for="for_new_user_pwd" class="newPwd">변경비밀번호</label>
			<input type="password" name="newUserPwd" id="for_new_user_pwd" title="비밀번호" dataType="CHAR" maxlength="20" class="newPwd skipData ui-widget-content ui-corner-all" />
		</fieldset>
		<fieldset>
			<label for="for_new_user_pwdCopy" class="newPwd">비밀번호 확인</label>
			<input type="password" name="newUserPwdCopy" id="for_new_user_pwdCopy" title="비밀번호 확인" dataType="CHAR" maxlength="20" class="newPwd skipData ui-widget-content ui-corner-all" />
		</fieldset>
		<fieldset>
			<label for="for_user_state" class="user_state">상태</label>
			<select name="userState" id="for_user_state" title="상태" class="user_state ui-widget-content ui-corner-all">
				<c:forEach items="${stateList}" var="item">
					<option value="${item.code}">${item.name}</option>
				</c:forEach>
			</select>
		</fieldset>
	</form>
</div>