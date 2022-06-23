package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;


public interface MtrlsStockMapper {
	List<HashMap<String, Object>> getProdIdRowList(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectMtrlsProdDtlNm(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectMtrlsProdNm(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectMtrlsProdId(HashMap<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectMtrlsStockList(HashMap<String, Object> params) throws Exception;

}
