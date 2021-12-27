package com.bogoManager.domain;

import java.io.Serializable;

public class LoginUsers implements Serializable {

    private static final long serialVersionUID = 1L;

    private String id; // 사용자 ID
    private String name; // 사용자명
    private String role; // 권한
    private String state; // 상태

    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}

}
