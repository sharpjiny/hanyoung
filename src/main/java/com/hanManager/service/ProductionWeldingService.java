package com.hanManager.service;

import java.util.HashMap;
import java.util.List;

public interface ProductionWeldingService {
	public List<HashMap<String, Object>> selectPrdtWeldingList(HashMap<String, Object> params) throws Exception;
	public HashMap<String, Object> prdtWeldingSave(HashMap<String, Object> params) throws Exception;
	public Integer insertPrdtStatusWelding(HashMap<String, Object> params) throws Exception;
	public Integer updatePrdtStatusWelding(HashMap<String, Object> params) throws Exception;
	public Integer deletePrdtStatusWelding(HashMap<String, Object> params) throws Exception;
	
	public Integer insertToMtrlsInOut(HashMap<String, Object> params) throws Exception; // 생산출고로~~~
	
	public Integer insertPrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
	public Integer updatePrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
	public Integer deletePrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
}
