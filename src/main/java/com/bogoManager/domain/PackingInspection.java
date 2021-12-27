package com.bogoManager.domain;

import java.util.Date;

import com.bogoManager.web.util.CommonUtil;

public class PackingInspection {
    private Integer eId;	// 검사번호
    private String inspectionDate;	// 검사일
    private String jabClass;	// 작업반
    private String jabClassName;	// 작업반
    private String workType;	// 주/야간
    private String workTypeName;	// 주/야간
    private String workMan1; //
    private String workMan2; //
    private String workMan3; //
    private String workMan4; //
    private String workMan5; //
    private String isCheck;	// 확인여부
    private String checkUser;	// 확인한 사람
    private Date checkDate; // 확인일
    private Date created;
    private Date lastModified;
    private String productId;	// 제품의 고유키값, 보고 시 사용됨
    private String client;	// 고객사

	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	public Integer geteId() {
		return eId;
	}
	public void seteId(Integer eId) {
		this.eId = eId;
	}
	public String getInspectionDate() {
		return inspectionDate;
	}
	public void setInspectionDate(String inspectionDate) {
		this.inspectionDate = inspectionDate;
	}
	public String getJabClass() {
		if(CommonUtil.isEmpty(jabClass)) jabClass="GA";
		return jabClass;
	}
	public void setJabClass(String jabClass) {
		this.jabClass = jabClass;
	}
	public String getJabClassName() {
		return jabClassName;
	}
	public void setJabClassName(String jabClassName) {
		this.jabClassName = jabClassName;
	}
	public String getWorkType() {
		if(CommonUtil.isEmpty(workType)) workType="W";
		return workType;
	}
	public void setWorkType(String workType) {
		this.workType = workType;
	}
	public String getWorkMan1() {
		return workMan1;
	}
	public void setWorkMan1(String workMan1) {
		this.workMan1 = workMan1;
	}
	public String getWorkMan2() {
		return workMan2;
	}
	public void setWorkMan2(String workMan2) {
		this.workMan2 = workMan2;
	}
	public String getWorkMan3() {
		return workMan3;
	}
	public void setWorkMan3(String workMan3) {
		this.workMan3 = workMan3;
	}
	public String getWorkMan4() {
		return workMan4;
	}
	public void setWorkMan4(String workMan4) {
		this.workMan4 = workMan4;
	}
	public String getWorkMan5() {
		return workMan5;
	}
	public void setWorkMan5(String workMan5) {
		this.workMan5 = workMan5;
	}
	public String getIsCheck() {
		return isCheck;
	}
	public void setIsCheck(String isCheck) {
		this.isCheck = isCheck;
	}
	public String getCheckUser() {
		return checkUser;
	}
	public void setCheckUser(String checkUser) {
		this.checkUser = checkUser;
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
	public String getWorkTypeName() {
		return workTypeName;
	}
	public void setWorkTypeName(String workTypeName) {
		this.workTypeName = workTypeName;
	}
	public Date getCheckDate() {
		return checkDate;
	}
	public void setCheckDate(Date checkDate) {
		this.checkDate = checkDate;
	}
}
