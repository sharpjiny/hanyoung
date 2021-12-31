/**
 *  Base64인코딩/디코딩 방식을 이용한 데이터를 암호화/복호화하는 Business Interface class
 */
package com.hanManager.domain;


public class Codes {
    private String code;
    private String name;
    private String sort;
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
}