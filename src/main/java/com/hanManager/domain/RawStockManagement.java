package com.hanManager.domain;

import java.util.Date;

public class RawStockManagement {
    private Integer rawId;	// 품호 / 모비스 고유번호
    private String kind;	// 종류
    private String productName;	// 품명
    private String productId;	// 제품의 고유키값, 보고 시 사용됨
    private String client;	// 고객사
    private Double price;	// 단가,
    private Date created;
    private Date lastModified;

	public Integer getRawId() {
		return rawId;
	}
	public void setRawId(Integer rawId) {
		this.rawId = rawId;
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
}