package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;


public interface MtrlsInfoMapper {

	public List<HashMap<String, Object>> selectMtrlsInfoList(HashMap<String, Object> params) throws Exception;
	public void insertMtrlsInfo(HashMap<String, Object> params) throws Exception;
	public void updateMtrlsInfo(HashMap<String, Object> params) throws Exception;
	public void deleteMtrlsInfo(HashMap<String, Object> params) throws Exception;

}
