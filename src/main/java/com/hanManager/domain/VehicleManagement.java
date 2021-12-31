package com.hanManager.domain;

import java.util.Date;

public class VehicleManagement {
    private String vehicleId;	// 품호 / 모비스 고유번호
    private String kind;	// 종류
    private String modelCar;	// 차종
    private String productName;	// 품명
    private String productNo;
    private String lhRh;	// LH / RH / NA,
    private String productId;	// 제품의 고유키값, 보고 시 사용됨
    private String client;	// 고객사
    private Double price;	// 단가,
    private Date created;
    private Date lastModified;
    private Integer weight; // 중량
    private Integer gateWeight; // 게이트중량
    private Integer rawId; // 원재료 키값
    private String bom; // 게이트중량
    private String rawKind;	// 원재료종류
    private String rawProductName;	// 원재료품명
    private String status;	// 상태값

	public String getVehicleId() {
		return vehicleId;
	}
	public void setVehicleId(String vehicleId) {
		this.vehicleId = vehicleId;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public String getModelCar() {
		return modelCar;
	}
	public void setModelCar(String modelCar) {
		this.modelCar = modelCar;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getProductNo() {
		return productNo;
	}
	public void setProductNo(String productNo) {
		this.productNo = productNo;
	}
	public String getLhRh() {
		return lhRh;
	}
	public void setLhRh(String lhRh) {
		this.lhRh = lhRh;
	}
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
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
	public Integer getWeight() {
		return weight;
	}
	public void setWeight(Integer weight) {
		this.weight = weight;
	}
	public Integer getGateWeight() {
		return gateWeight;
	}
	public void setGateWeight(Integer gateWeight) {
		this.gateWeight = gateWeight;
	}
	public String getBom() {
		return bom;
	}
	public void setBom(String bom) {
		this.bom = bom;
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
	public Integer getRawId() {
		return rawId;
	}
	public void setRawId(Integer rawId) {
		this.rawId = rawId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
}