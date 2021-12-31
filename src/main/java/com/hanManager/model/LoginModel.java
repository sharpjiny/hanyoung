package com.hanManager.model;

import org.hibernate.validator.constraints.NotEmpty;

public class LoginModel {

    @NotEmpty(message="{field.required.id}")
    private String id;

    @NotEmpty(message="{field.required.pwd}")
    private String pwd;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
}
