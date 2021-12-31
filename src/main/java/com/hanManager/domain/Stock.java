package com.hanManager.domain;

import java.util.Date;

import com.hanManager.web.util.CommonUtil;

public class Stock {
    private Integer stockId;	// 재고번호
    private String subType;	// 타입
    private Integer subId;	// 번호
    private Integer subKey;	// 번호
    private String vehicleId;
    private String stockDate;	// 재고일
    private String stockGubun;	// 구분
    private String stockGubunName;	// 구분명
    private String workType;	// 주/야간
    private String workTypeName;	// 주/야간명
    private Integer quantity;	// 수량
    private Date created;
    private Date lastModified;
    private String kind;	// 종류
    private String modelCar;	// 차종
    private String productName;	// 품명
    private String lhRh;	// LH / RH / NA
    private String productId;	// 제품의 고유키값, 보고 시 사용됨
    private String client;	// 고객사
    private String isCheck;	// 확인여부
    private String checkUser;	// 확인한 사람
    private Date checkDate; // 확인일
    private String carNum;
    private String form;
    private Integer perBoxNum;
    private Integer boxNum;
    private String inOutMan;
    private String stockTime;
    private String settlementMonth;
    private Integer stockCnt;
	public Integer getStockId() {
		return stockId;
	}
	public void setStockId(Integer stockId) {
		this.stockId = stockId;
	}
	public Integer getSubKey() {
		return subKey;
	}
	public void setSubKey(Integer subKey) {
		this.subKey = subKey;
	}
	public String getSubType() {
		return subType;
	}
	public void setSubType(String subType) {
		this.subType = subType;
	}
	public Integer getSubId() {
		return subId;
	}
	public void setSubId(Integer subId) {
		this.subId = subId;
	}
	public String getVehicleId() {
		return vehicleId;
	}
	public void setVehicleId(String vehicleId) {
		this.vehicleId = vehicleId;
	}
	public String getStockDate() {
		return stockDate;
	}
	public void setStockDate(String stockDate) {
		this.stockDate = stockDate;
	}
	public String getStockGubun() {
		return stockGubun;
	}
	public void setStockGubun(String stockGubun) {
		this.stockGubun = stockGubun;
	}
	public String getStockGubunName() {
		return stockGubunName;
	}
	public void setStockGubunName(String stockGubunName) {
		this.stockGubunName = stockGubunName;
	}
	public Integer getQuantity() {
		return quantity;
	}
	public Integer getQuantity2() {
		if("s005".equals(this.stockGubun) ||"s004".equals(this.stockGubun) || "s007".equals(this.stockGubun) || "s010".equals(this.stockGubun) || "s011".equals(this.stockGubun) ) quantity*=-1;
		return quantity;
	}
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
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
		if(CommonUtil.isEmpty(kind)) kind = "完成品";
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
	public String getCarNum() {
		return carNum;
	}
	public void setCarNum(String carNum) {
		this.carNum = carNum;
	}
	public String getForm() {
		return form;
	}
	public void setForm(String form) {
		this.form = form;
	}
	public Integer getPerBoxNum() {
		return perBoxNum;
	}
	public void setPerBoxNum(Integer perBoxNum) {
		this.perBoxNum = perBoxNum;
	}
	public Integer getBoxNum() {
		return boxNum;
	}
	public void setBoxNum(Integer boxNum) {
		this.boxNum = boxNum;
	}
	public String getInOutMan() {
		return inOutMan;
	}
	public void setInOutMan(String inOutMan) {
		this.inOutMan = inOutMan;
	}
	public String getStockTime() {
		return stockTime;
	}
	public void setStockTime(String stockTime) {
		this.stockTime = stockTime;
	}
	public String getSettlementMonth() {
		return settlementMonth;
	}
	public void setSettlementMonth(String settlementMonth) {
		this.settlementMonth = settlementMonth;
	}
	public Integer getStockCnt() {
		return stockCnt;
	}
	public void setStockCnt(Integer stockCnt) {
		this.stockCnt = stockCnt;
	}

}
