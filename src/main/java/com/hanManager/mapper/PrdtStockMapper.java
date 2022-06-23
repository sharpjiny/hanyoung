package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;


public interface PrdtStockMapper {
	List<HashMap<String, Object>> getProdIdRowList(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtProdDtlNm(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtProdNm(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectPrdtProdId(HashMap<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectPrdtStockList(HashMap<String, Object> params) throws Exception;

}
