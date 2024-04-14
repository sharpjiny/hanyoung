package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;


public interface BomInfoMapper {

	public List<HashMap<String, Object>> selectBomInfoList(HashMap<String, Object> params) throws Exception;
	public void insertBomInfo(HashMap<String, Object> params) throws Exception;
	public void updateBomInfo(HashMap<String, Object> params) throws Exception;
	public void deleteBomInfo(HashMap<String, Object> params) throws Exception;
	
	public List<HashMap<String, Object>> selectBomInfoCoatingList(HashMap<String, Object> params) throws Exception;
	public void insertBomInfoCoating(HashMap<String, Object> params) throws Exception;
	public void updateBomInfoCoating(HashMap<String, Object> params) throws Exception;
	public void deleteBomInfoCoating(HashMap<String, Object> params) throws Exception;
	
	public List<HashMap<String, Object>> selectBomInfoPackingList(HashMap<String, Object> params) throws Exception;
	public void insertBomInfoPacking(HashMap<String, Object> params) throws Exception;
	public void updateBomInfoPacking(HashMap<String, Object> params) throws Exception;
	public void deleteBomInfoPacking(HashMap<String, Object> params) throws Exception;

}
