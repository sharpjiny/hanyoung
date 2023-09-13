package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;


public interface ProductionPackingMapper {
	HashMap<String, Object> getPrice(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> getPackingDtlList(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtPackingDtlNm(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtPackingNm(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtPackingId(HashMap<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectPrdtPackingList(HashMap<String, Object> params) throws Exception;
	public void insertPrdtStatusPacking(HashMap<String, Object> params) throws Exception;
	public void updatePrdtStatusPacking(HashMap<String, Object> params) throws Exception;
	public void deletePrdtStatusPacking(HashMap<String, Object> params) throws Exception;
	
	public void insertToMtrlsInOut(HashMap<String, Object> params) throws Exception; //입출고 생산출고로~~
	
	public void insertPrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
	public void updatePrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
	public void deletePrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
	
}
