package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;


public interface ProductionQualityMapper {
	HashMap<String, Object> getPrice(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> getProdDtlList(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtProdDtlNm(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtProdNm(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtProdId(HashMap<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectPrdtQualityList(HashMap<String, Object> params) throws Exception;
	public void insertPrdtStatusQuality(HashMap<String, Object> params) throws Exception;
	public void updatePrdtStatusQuality(HashMap<String, Object> params) throws Exception;
	public void deletePrdtStatusQuality(HashMap<String, Object> params) throws Exception;
	
}
