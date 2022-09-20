package com.hanManager.service;

import java.util.HashMap;
import java.util.List;

public interface ProductionProdService {
	public List<HashMap<String, Object>> selectPrdtProdList(HashMap<String, Object> params) throws Exception;
	public HashMap<String, Object> prdtProdSave(HashMap<String, Object> params) throws Exception;
	public Integer insertPrdtStatusProd(HashMap<String, Object> params) throws Exception;
	public Integer updatePrdtStatusProd(HashMap<String, Object> params) throws Exception;
	public Integer deletePrdtStatusProd(HashMap<String, Object> params) throws Exception;
	
	public Integer insertToMtrlsInOut(HashMap<String, Object> params) throws Exception; // 생산출고로~~~
	
	public Integer insertPrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
	public Integer updatePrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
	public Integer deletePrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
}
