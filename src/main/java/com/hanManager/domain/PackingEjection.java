package com.hanManager.domain;

import java.util.Date;

import com.hanManager.web.util.CommonUtil;

public class PackingEjection {
	private Integer eId; //검사번호
	private Integer rawId; //모비스 고유번호
	private String ejectionDate; //검사일
	private String workType; //주/야간
    private String workTypeName;	// 주/야간
	private String ejection; //사출호기
    private String ejectionName;	// 사출호기
	private String startTime; //
	private String endTime; //
	private String planStartTime; //
	private String planEndTime; //
	private String ejectionGroup; //
    private String ejectionGroupName;	//
	private String isCheck; //확인여부
	private String checkUser; //확인한 사람
	private Date checkDate; //
	private Date created; //
	private Date lastModified; //
	private Integer weight1; //중량 소
	private Integer weight2; //중량 중
	private Integer weight3; //중량 종
	private Integer totalProduction; //총사용량
	private Integer cycleTime; //사이클타임
	private String rawKind; //
	private String rawProductName; //
	private String rawProductId; //
	private Integer ct; //
	private String workMan1;	// 작업자1
	private String workMan2;	// 작업자2
	private Double gateWeight;	// 게이트중량
	public Integer geteId() {
		return eId;
	}
	public void seteId(Integer eId) {
		this.eId = eId;
	}
	public Integer getRawId() {
		return rawId;
	}
	public void setRawId(Integer rawId) {
		this.rawId = rawId;
	}
	public String getEjectionDate() {
		return ejectionDate;
	}
	public void setEjectionDate(String ejectionDate) {
		this.ejectionDate = ejectionDate;
	}
	public String getWorkType() {
		if(CommonUtil.isEmpty(workType)) workType="W";
		return workType;
	}
	public void setWorkType(String workType) {
		this.workType = workType;
	}
	public String getWorkTypeName() {
		return workTypeName;
	}
	public void setWorkTypeName(String workTypeName) {
		this.workTypeName = workTypeName;
	}
	public String getEjection() {
		return ejection;
	}
	public void setEjection(String ejection) {
		this.ejection = ejection;
	}
	public String getEjectionName() {
		return ejectionName;
	}
	public void setEjectionName(String ejectionName) {
		this.ejectionName = ejectionName;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getPlanStartTime() {
		return planStartTime;
	}
	public void setPlanStartTime(String planStartTime) {
		this.planStartTime = planStartTime;
	}
	public String getPlanEndTime() {
		return planEndTime;
	}
	public void setPlanEndTime(String planEndTime) {
		this.planEndTime = planEndTime;
	}
	public String getEjectionGroup() {
		return ejectionGroup;
	}
	public void setEjectionGroup(String ejectionGroup) {
		this.ejectionGroup = ejectionGroup;
	}
	public String getEjectionGroupName() {
		return ejectionGroupName;
	}
	public void setEjectionGroupName(String ejectionGroupName) {
		this.ejectionGroupName = ejectionGroupName;
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
	public Date getCheckDate() {
		return checkDate;
	}
	public void setCheckDate(Date checkDate) {
		this.checkDate = checkDate;
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
	public Integer getWeight1() {
		return weight1;
	}
	public void setWeight1(Integer weight1) {
		this.weight1 = weight1;
	}
	public Integer getWeight2() {
		return weight2;
	}
	public void setWeight2(Integer weight2) {
		this.weight2 = weight2;
	}
	public Integer getWeight3() {
		return weight3;
	}
	public void setWeight3(Integer weight3) {
		this.weight3 = weight3;
	}
	public Integer getTotalProduction() {
		return totalProduction;
	}
	public void setTotalProduction(Integer totalProduction) {
		this.totalProduction = totalProduction;
	}
	public Integer getCycleTime() {
		return cycleTime;
	}
	public void setCycleTime(Integer cycleTime) {
		this.cycleTime = cycleTime;
	}
	public String getRawKind() {
		return rawKind;
	}
	public void setRawKind(String rawKind) {
		this.rawKind = rawKind;
	}
	public String getRawProductName() {
		return rawProductName;
	}
	public void setRawProductName(String rawProductName) {
		this.rawProductName = rawProductName;
	}
	public String getRawProductId() {
		return rawProductId;
	}
	public void setRawProductId(String rawProductId) {
		this.rawProductId = rawProductId;
	}
	public Integer getCt() {
		return ct;
	}
	public void setCt(Integer ct) {
		this.ct = ct;
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
	public Double getGateWeight() {
		return gateWeight;
	}
	public void setGateWeight(Double gateWeight) {
		this.gateWeight = gateWeight;
	}

}
