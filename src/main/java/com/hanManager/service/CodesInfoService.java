package com.hanManager.service;

import java.util.HashMap;
import java.util.List;

public interface CodesInfoService {
	public List<HashMap<String, Object>> selectCodesInfoList(HashMap<String, Object> params) throws Exception;
	public HashMap<String, Object> codesInfoSave(HashMap<String, Object> params) throws Exception;
	public Integer insert(HashMap<String, Object> params) throws Exception;
	public Integer update(HashMap<String, Object> params) throws Exception;
	public Integer delete(HashMap<String, Object> params) throws Exception;
}
