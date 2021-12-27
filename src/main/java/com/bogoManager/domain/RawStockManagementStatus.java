package com.bogoManager.domain;

import java.util.Date;

public class RawStockManagementStatus {
    private Integer idx;	    // 품호 / 모비스 고유번호
    private String kind;	    // 종류
    private String inputdate;	// 입출고 날짜
    private String productName;	// 품명
    private String productId;	// 제품의 고유키값, 보고 시 사용됨
    private String client;	    // 고객사
    private Double price;       // 단가
    private Double realPrice;	// 금액
    private String bigo;	    // 내용
    private String loftNumber;	// 로트번호
    private String rawGubun;	// 구분
    private String rawGubunCd;	// 구분코드
    private Double pWeight;	    // 중량
    private Double pNumber;	    // 중량
    private Double weight;	    // 중량
    private String isCheck;	    // 확인여부
	private String created;     // 날짜
    private Date firstcreated;
    private String firstcreatedStr;
    private Date lastModified;
    private String lastModifiedStr;
    private String settlementMonth;
    
    public String getIsCheck() {
		return isCheck;
	}

	public String getInputdate() {
		return inputdate;
	}

	public void setInputdate(String inputdate) {
		this.inputdate = inputdate;
	}

	public void setIsCheck(String isCheck) {
		this.isCheck = isCheck;
	}
	public Double getWeight() {
		return weight;
	}
	public void setWeight(Double weight) {
		this.weight = weight;
	}

	public String getRawGubun() {
		return rawGubun;
	}

	public void setRawGubun(String rawGubun) {
		this.rawGubun = rawGubun;
	}

	public Double getRealPrice() {
		return realPrice;
	}

	public void setRealPrice(Double realPrice) {
		this.realPrice = realPrice;
	}

	public String getBigo() {
		return bigo;
	}
	public void setBigo(String bigo) {
		this.bigo = bigo;
	}

	public String getLoftNumber() {
		return loftNumber;
	}
	public void setLoftNumber(String loftNumber) {
		this.loftNumber = loftNumber;
	}

	public Integer getIdx() {
		return idx;
	}
	public void setIdx(Integer idx) {
		this.idx = idx;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
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
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public Date getLastModified() {
		return lastModified;
	}
	public void setLastModified(Date lastModified) {
		this.lastModified = lastModified;
	}

	public String getRawGubunCd() {
		return rawGubunCd;
	}

	public void setRawGubunCd(String rawGubunCd) {
		this.rawGubunCd = rawGubunCd;
	}

	public Date getFirstcreated() {
		return firstcreated;
	}

	public void setFirstcreated(Date firstcreated) {
		this.firstcreated = firstcreated;
	}

	public String getFirstcreatedStr() {
		return firstcreatedStr;
	}

	public void setFirstcreatedStr(String firstcreatedStr) {
		this.firstcreatedStr = firstcreatedStr;
	}

	public String getLastModifiedStr() {
		return lastModifiedStr;
	}

	public void setLastModifiedStr(String lastModifiedStr) {
		this.lastModifiedStr = lastModifiedStr;
	}

	public Double getpWeight() {
		return pWeight;
	}

	public void setpWeight(Double pWeight) {
		this.pWeight = pWeight;
	}

	public Double getpNumber() {
		return pNumber;
	}

	public void setpNumber(Double pNumber) {
		this.pNumber = pNumber;
	}

	public String getSettlementMonth() {
		return settlementMonth;
	}
	public void setSettlementMonth(String settlementMonth) {
		this.settlementMonth = settlementMonth;
	}
	
}