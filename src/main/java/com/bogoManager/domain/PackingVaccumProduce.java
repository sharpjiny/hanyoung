package com.bogoManager.domain;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.bogoManager.web.util.CommonUtil;

public class PackingVaccumProduce {
    private Integer eId;	// 검사번호
    private Integer epId;	// 검사번호
    private String vehicleId;
    private Integer production;	// 전체생산수량
    private Date created;
    private Date lastModified;
    private String kind;	// 종류
    private String modelCar;	// 차종
    private String productName;	// 품명
    private String lhRh;	// LH / RH / NA
    private String productId;	// 제품의 고유키값, 보고 시 사용됨
    private String client;	// 고객사
    private List<HashMap<String, Object>> kinds;	// 종류
    private List<HashMap<String, Object>> modelCars;	// 차종
    private List<HashMap<String, Object>> productNames;	// 품명
    private List<HashMap<String, Object>> lhRhs;	// LH / RH / NA
	public Integer geteId() {
		return eId;
	}
	public void seteId(Integer eId) {
		this.eId = eId;
	}
	public Integer getEpId() {
		return epId;
	}
	public void setEpId(Integer epId) {
		this.epId = epId;
	}
	public String getVehicleId() {
		return vehicleId;
	}
	public void setVehicleId(String vehicleId) {
		this.vehicleId = vehicleId;
	}
	public Integer getProduction() {
		return production;
	}
	public void setProduction(Integer production) {
		this.production = production;
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
	public List<HashMap<String, Object>> getKinds() {
		return kinds;
	}
	public void setKinds(List<HashMap<String, Object>> kinds) {
		this.kinds = kinds;
	}
	public List<HashMap<String, Object>> getModelCars() {
		return modelCars;
	}
	public void setModelCars(List<HashMap<String, Object>> modelCars) {
		this.modelCars = modelCars;
	}
	public List<HashMap<String, Object>> getProductNames() {
		return productNames;
	}
	public void setProductNames(List<HashMap<String, Object>> productNames) {
		this.productNames = productNames;
	}
	public List<HashMap<String, Object>> getLhRhs() {
		return lhRhs;
	}
	public void setLhRhs(List<HashMap<String, Object>> lhRhs) {
		this.lhRhs = lhRhs;
	}

}
