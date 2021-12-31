package com.hanManager.domain;

import java.util.Date;

public class SubMaterialsManagement {
    private int subMatId;	// 품호 / 모비스 고유번호
    private String kind;	// 종류
    private String productName;	// 품명
    private String unit;	// 단위
    private String usePlace;	// 사용처
    private Double price;	// 단가
    private String photo;	// 사진
    private Date created;
    private Date lastModified;
	public int getSubMatId() {
		return subMatId;
	}
	public void setSubMatId(int subMatId) {
		this.subMatId = subMatId;
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
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getUsePlace() {
		return usePlace;
	}
	public void setUsePlace(String usePlace) {
		this.usePlace = usePlace;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
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