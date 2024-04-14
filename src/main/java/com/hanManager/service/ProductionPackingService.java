package com.hanManager.service;

import java.util.HashMap;
import java.util.List;

public interface ProductionPackingService {
	public List<HashMap<String, Object>> selectPrdtPackingList(HashMap<String, Object> params) throws Exception;
	public HashMap<String, Object> prdtPackingSave(HashMap<String, Object> params) throws Exception;
	public Integer insertPrdtStatusPacking(HashMap<String, Object> params) throws Exception;
	public Integer updatePrdtStatusPacking(HashMap<String, Object> params) throws Exception;
	public Integer deletePrdtStatusPacking(HashMap<String, Object> params) throws Exception;
	
	public Integer insertToMtrlsInOut(HashMap<String, Object> params) throws Exception; // 완제품 입출고로~~~
	public Integer insertToPrdtInOut(HashMap<String, Object> params) throws Exception; // 원부자재로~~~
	
	public Integer insertPrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
	public Integer updatePrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
	public Integer deletePrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
}
