package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;


public interface BomInfoMapper {

	public List<HashMap<String, Object>> selectBomInfoList(HashMap<String, Object> params) throws Exception;
	public void insertBomInfo(HashMap<String, Object> params) throws Exception;
	public void updateBomInfo(HashMap<String, Object> params) throws Exception;
	public void deleteBomInfo(HashMap<String, Object> params) throws Exception;

}
