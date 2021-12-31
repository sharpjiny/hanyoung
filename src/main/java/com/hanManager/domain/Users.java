package com.hanManager.domain;

import java.util.Date;

import com.hanManager.Constant;

public class Users {
    private String userId ;		// 사용자 Id
    private String userPwd;	// 사용자 패스워드
    private String newUserPwd;	// 사용자 패스워드
    private String userName;	// 사용자 이름
    private String userRole;	// 사용자 권한
    private String userState;	// 사용
    private String userRoleGroup;	// 사용자 권한
    private String userStateGroup;	// 사용
    private Date created;	//등록일
    private Date lastModified;	// 마지막 수정일
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getUserRole() {
		return userRole;
	}
	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserState() {
		return userState;
	}
	public void setUserState(String userState) {
		this.userState = userState;
	}
	public Date getCreated() {
		return created;
	}
	public void setCreated(Date created) {
		this.created = created;
	}
	public Date getLastModified() {
		return lastModified;
	}
	public void setLastModified(Date lastModified) {
		this.lastModified = lastModified;
	}
	public String getNewUserPwd() {
		return newUserPwd;
	}
	public void setNewUserPwd(String newUserPwd) {
		this.newUserPwd = newUserPwd;
	}
	public String getUserRoleGroup() {
		return Constant.USER_ROLE;
	}
	public String getUserStateGroup() {
		return Constant.USER_STATE;
	}


}
