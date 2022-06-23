package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;


public interface MtrlsInOutMapper {
	List<HashMap<String, Object>> selectMtrlsProdDtlList(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectMtrlsProdDtlNm(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectMtrlsProdNm(HashMap<String, Object> map) throws Exception;
	List<HashMap<String, Object>> selectMtrlsProdId(HashMap<String, Object> map) throws Exception;
	public List<HashMap<String, Object>> selectMtrlsInOutList(HashMap<String, Object> params) throws Exception;
	public void insertMtrlsInOut(HashMap<String, Object> params) throws Exception;
	public void updateMtrlsInOut(HashMap<String, Object> params) throws Exception;
	public void deleteMtrlsInOut(HashMap<String, Object> params) throws Exception;

}
