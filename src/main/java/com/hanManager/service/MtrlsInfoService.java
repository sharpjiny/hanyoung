package com.hanManager.service;

import java.util.HashMap;
import java.util.List;

import com.hanManager.domain.PackingEjection;
import com.hanManager.model.PackingEjectionModel;

public interface MtrlsInfoService {
	public List<HashMap<String, Object>> selectMtrlsInfoList(HashMap<String, Object> params) throws Exception;
	public HashMap<String, Object> mtrlsInfoSave(HashMap<String, Object> params) throws Exception;
	public Integer insert(HashMap<String, Object> params) throws Exception;
	public Integer update(HashMap<String, Object> params) throws Exception;
	public Integer delete(HashMap<String, Object> params) throws Exception;
}
