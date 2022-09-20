package com.hanManager.service;

import java.util.HashMap;
import java.util.List;

public interface PrdtRepairService {
	public List<HashMap<String, Object>> selectPrdtRepairList(HashMap<String, Object> params) throws Exception;
	public HashMap<String, Object> prdtRepairSave(HashMap<String, Object> params) throws Exception;
	public Integer insert(HashMap<String, Object> params) throws Exception;
	public Integer update(HashMap<String, Object> params) throws Exception;
	public Integer delete(HashMap<String, Object> params) throws Exception;
}
