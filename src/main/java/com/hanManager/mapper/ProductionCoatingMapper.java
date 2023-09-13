package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;


public interface ProductionCoatingMapper {
	HashMap<String, Object> getPrice(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> getCoatingDtlList(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtCoatingDtlNm(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtCoatingNm(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtCoatingId(HashMap<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectPrdtCoatingList(HashMap<String, Object> params) throws Exception;
	public void insertPrdtStatusCoating(HashMap<String, Object> params) throws Exception;
	public void updatePrdtStatusCoating(HashMap<String, Object> params) throws Exception;
	public void deletePrdtStatusCoating(HashMap<String, Object> params) throws Exception;
	
	public void insertToMtrlsInOut(HashMap<String, Object> params) throws Exception; //입출고 생산출고로~~
	
	public void insertPrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
	public void updatePrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
	public void deletePrdtMtrlsUsage(HashMap<String, Object> params) throws Exception;
	
}
