package com.hanManager.service;

import java.util.HashMap;
import java.util.List;

public interface ProductionQualityService {
	public List<HashMap<String, Object>> selectPrdtQualityList(HashMap<String, Object> params) throws Exception;
	public HashMap<String, Object> prdtQualitySave(HashMap<String, Object> params) throws Exception;
	public Integer insertPrdtStatusQuality(HashMap<String, Object> params) throws Exception;
	public Integer updatePrdtStatusQuality(HashMap<String, Object> params) throws Exception;
	public Integer deletePrdtStatusQuality(HashMap<String, Object> params) throws Exception;
	
}
