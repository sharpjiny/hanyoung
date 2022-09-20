package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;


public interface PrdtRepairMapper {
	HashMap<String, Object> getPrice(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> getProdIdRowList(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtProdDtlNm(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtProdNm(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtProdId(HashMap<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectPrdtRepairList(HashMap<String, Object> params) throws Exception;
	public void insertPrdtRepair(HashMap<String, Object> params) throws Exception;
	public void updatePrdtRepair(HashMap<String, Object> params) throws Exception;
	public void deletePrdtRepair(HashMap<String, Object> params) throws Exception;
	
	// 재고 연동
	//public void mergePrdtStock(HashMap<String, Object> params) throws Exception;
	//public void deletePrdtStock(HashMap<String, Object> params) throws Exception;

}
