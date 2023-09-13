package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;


public interface ProductionWeldingMapper {
	HashMap<String, Object> getPrice(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> getWeldingDtlList(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtWeldingDtlNm(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtWeldingNm(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtWeldingId(HashMap<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectPrdtWeldingList(HashMap<String, Object> params) throws Exception;
	public void insertPrdtStatusWelding(HashMap<String, Object> params) throws Exception;
	public void updatePrdtStatusWelding(HashMap<String, Object> params) throws Exception;
	public void deletePrdtStatusWelding(HashMap<String, Object> params) throws Exception;
	
	public void insertToMtrlsInOut(HashMap<String, Object> params) throws Exception; //입출고 생산출고로~~
	
	public void insertPrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
	public void updatePrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
	public void deletePrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
	
}
