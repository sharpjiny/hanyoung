package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;


public interface PrdtInOutMapper {
	HashMap<String, Object> getPrice(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> getProdIdRowList(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtProdDtlNm(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtProdNm(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtProdId(HashMap<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectPrdtInOutList(HashMap<String, Object> params) throws Exception;
	public void insertPrdtInOut(HashMap<String, Object> params) throws Exception;
	public void updatePrdtInOut(HashMap<String, Object> params) throws Exception;
	public void deletePrdtInOut(HashMap<String, Object> params) throws Exception;
	
	// 재고 연동
	//public void mergePrdtStock(HashMap<String, Object> params) throws Exception;
	//public void deletePrdtStock(HashMap<String, Object> params) throws Exception;

}
