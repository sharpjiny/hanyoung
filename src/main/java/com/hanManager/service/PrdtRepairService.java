package com.hanManager.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


public interface PrdtRepairService {
	public List<HashMap<String, Object>> selectPrdtRepairList(HashMap<String, Object> params) throws Exception;
	public Integer prdtRepairSave(HashMap<String, Object> map) throws Exception;
	public Integer insert(HashMap<String, Object> map) throws Exception;
	public Integer update(HashMap<String, Object> map) throws Exception;
	public Integer delete(List<Map<String, Object>> params) throws Exception;
}
