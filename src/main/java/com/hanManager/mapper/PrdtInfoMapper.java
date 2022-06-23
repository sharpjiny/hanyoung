package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;


public interface PrdtInfoMapper {

	public List<HashMap<String, Object>> selectPrdtInfoList(HashMap<String, Object> params) throws Exception;
	public void insertPrdtInfo(HashMap<String, Object> params) throws Exception;
	public void updatePrdtInfo(HashMap<String, Object> params) throws Exception;
	public void deletePrdtInfo(HashMap<String, Object> params) throws Exception;

}
