package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;


public interface PlanExportMapper {
	HashMap<String, Object> getPrice(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> getProdIdRowList(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtProdDtlNm(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtProdNm(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtProdId(HashMap<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectPlanExportListV(HashMap<String, Object> params) throws Exception;
	public List<HashMap<String, Object>> selectPlanExportListE(HashMap<String, Object> params) throws Exception;
	public void insertPlanExport(HashMap<String, Object> params) throws Exception;
	public void updatePlanExport(HashMap<String, Object> params) throws Exception;
	public void deletePlanExport(HashMap<String, Object> params) throws Exception;
	
	// 입출고 추가용
	public String selectOrderNo(String order_no) throws Exception;
	public List<HashMap<String, Object>> selectProdIdList(String order_no) throws Exception;
	public void insertPlanExportToInout(String order_no) throws Exception;
	public void updatePlanExportIsChk(HashMap<String, Object> params) throws Exception;
	
	// 재고
	//public void updateProdStock(HashMap<String, Object> params) throws Exception;
	
	

}
