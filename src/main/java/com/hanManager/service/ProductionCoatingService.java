package com.hanManager.service;

import java.util.HashMap;
import java.util.List;

public interface ProductionCoatingService {
	public List<HashMap<String, Object>> selectPrdtCoatingList(HashMap<String, Object> params) throws Exception;
	public HashMap<String, Object> prdtCoatingSave(HashMap<String, Object> params) throws Exception;
	public Integer insertPrdtStatusCoating(HashMap<String, Object> params) throws Exception;
	public Integer updatePrdtStatusCoating(HashMap<String, Object> params) throws Exception;
	public Integer deletePrdtStatusCoating(HashMap<String, Object> params) throws Exception;
	
	public Integer insertToMtrlsInOut(HashMap<String, Object> params) throws Exception; // 생산출고로~~~
	
	public Integer insertPrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
	public Integer updatePrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
	public Integer deletePrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
}
