package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;


public interface ProductionProdMapper {
	HashMap<String, Object> getPrice(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> getProdDtlList(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtProdDtlNm(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtProdNm(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtProdId(HashMap<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectPrdtProdList(HashMap<String, Object> params) throws Exception;
	public void insertPrdtStatusProd(HashMap<String, Object> params) throws Exception;
	public void updatePrdtStatusProd(HashMap<String, Object> params) throws Exception;
	public void deletePrdtStatusProd(HashMap<String, Object> params) throws Exception;
	
	public void insertPrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
	public void updatePrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
	public void deletePrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
	
}
