package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;


public interface ProductionPrdtRepairMapper {
	HashMap<String, Object> getPrice(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> getPrdtRepairDtlList(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtPrdtRepairDtlNm(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtPrdtRepairNm(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtPrdtRepairId(HashMap<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectPrdtPrdtRepairList(HashMap<String, Object> params) throws Exception;
	public void insertPrdtStatusPrdtRepair(HashMap<String, Object> params) throws Exception;
	public void updatePrdtStatusPrdtRepair(HashMap<String, Object> params) throws Exception;
	public void deletePrdtStatusPrdtRepair(HashMap<String, Object> params) throws Exception;
	
	public void insertToMtrlsInOut(HashMap<String, Object> params) throws Exception; //입출고 생산출고로~~
	
	public void insertPrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
	public void updatePrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
	public void deletePrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
	
}
