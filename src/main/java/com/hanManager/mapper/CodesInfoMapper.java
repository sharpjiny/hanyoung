package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;


public interface CodesInfoMapper {

	public List<HashMap<String, Object>> selectCodesInfoList(HashMap<String, Object> params) throws Exception;
	public void insertCodesInfo(HashMap<String, Object> params) throws Exception;
	public void updateCodesInfo(HashMap<String, Object> params) throws Exception;
	public void deleteCodesInfo(HashMap<String, Object> params) throws Exception;

}
