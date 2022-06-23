package com.hanManager.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.hanManager.mapper.PrdtInfoMapper;

@Service
public class PrdtInfoServiceImpl implements PrdtInfoService {
	@Autowired PrdtInfoMapper prdtInfoMapper;
	@Override
	public List<HashMap<String, Object>> selectPrdtInfoList(HashMap<String, Object> params) throws Exception {
		
		return prdtInfoMapper.selectPrdtInfoList(params);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public HashMap<String, Object> prdtInfoSave(HashMap<String, Object> params) throws Exception {
		
		List<HashMap<String, Object>> ilist = (List<HashMap<String, Object>>) params.get("createdRows");
		List<HashMap<String, Object>> ulist = (List<HashMap<String, Object>>) params.get("updatedRows");
		List<HashMap<String, Object>> dlist = (List<HashMap<String, Object>>) params.get("deletedRows");
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		
		int icnt = 0;
		int ucnt = 0;
		int dcnt = 0;
		
		if(ilist.size() > 0){
			for(int i=0; i<ilist.size();i++){
				ilist.get(i).put("CREATE_USER", params.get("loginUser"));
				ilist.get(i).put("UPDATE_USER", params.get("loginUser"));
				icnt += insert(ilist.get(i));
			}
		}
		
		if(ulist.size() > 0){
			for(int i=0; i<ulist.size();i++){
				ulist.get(i).put("CREATE_USER", params.get("loginUser"));
				ulist.get(i).put("UPDATE_USER", params.get("loginUser"));
				ucnt += update(ulist.get(i));
			}
		}
		
		if(dlist.size() > 0){
			for(int  i=0; i<dlist.size();i++){
				dlist.get(i).put("CREATE_USER", params.get("loginUser"));
				dlist.get(i).put("UPDATE_USER", params.get("loginUser"));
				dcnt += delete(dlist.get(i));
			}
		}
		
		rtnMap.put("insert", icnt);
		rtnMap.put("update", ucnt);
		rtnMap.put("delete", dcnt);
		
		return rtnMap;
	}
	
	@Override
	@Transactional(rollbackFor={Exception.class}, propagation = Propagation.REQUIRED)
	public Integer insert(HashMap<String, Object> params) throws Exception {
		try {
	        int retCode = 1;
	        prdtInfoMapper.insertPrdtInfo(params);
			return retCode;
		}catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
	}
	
	@Override
	@Transactional(rollbackFor={Exception.class}, propagation = Propagation.REQUIRED)
	public Integer update(HashMap<String, Object> params) throws Exception {
		try {
			int retCode = 1;
	        prdtInfoMapper.updatePrdtInfo(params);
			return retCode;
		}catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
	}

	@Override
	@Transactional(rollbackFor={Exception.class}, propagation = Propagation.REQUIRED)
	public Integer delete(HashMap<String, Object> params) throws Exception {
		try {
			int retCode = 1;
	        prdtInfoMapper.deletePrdtInfo(params);
			return retCode;
		}catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
	}
}
