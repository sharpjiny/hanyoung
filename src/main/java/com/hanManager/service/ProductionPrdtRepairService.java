package com.hanManager.service;

import java.util.HashMap;
import java.util.List;

public interface ProductionPrdtRepairService {
	public List<HashMap<String, Object>> selectPrdtPrdtRepairList(HashMap<String, Object> params) throws Exception;
	public HashMap<String, Object> prdtPrdtRepairSave(HashMap<String, Object> params) throws Exception;
	public Integer insertPrdtStatusPrdtRepair(HashMap<String, Object> params) throws Exception;
	public Integer updatePrdtStatusPrdtRepair(HashMap<String, Object> params) throws Exception;
	public Integer deletePrdtStatusPrdtRepair(HashMap<String, Object> params) throws Exception;
	
	public Integer insertToMtrlsInOut(HashMap<String, Object> params) throws Exception; // 생산출고로~~~
	
	public Integer insertPrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
	public Integer updatePrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
	public Integer deletePrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
}
