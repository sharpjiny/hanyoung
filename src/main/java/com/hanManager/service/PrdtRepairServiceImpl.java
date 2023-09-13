package com.hanManager.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.hanManager.mapper.FileUploadMapper;
import com.hanManager.mapper.PrdtRepairMapper;

@Service
public class PrdtRepairServiceImpl implements PrdtRepairService {
	@Autowired PrdtRepairMapper prdtRepairMapper;
	@Autowired FileUploadMapper fileUploadMapper;
	@Override
	public List<HashMap<String, Object>> selectPrdtRepairList(HashMap<String, Object> params) throws Exception {
		
		return prdtRepairMapper.selectPrdtRepairList(params);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Integer prdtRepairSave(HashMap<String, Object> params) throws Exception {
		String type = (String)params.get("EVENT_TYPE");
		int rtn = 0;
		if("C".equals(type)){
			rtn = insert(params);
		}else{
			rtn = update(params);
		}
		
		return rtn;
	}
	
	@Override
	@Transactional(rollbackFor={Exception.class}, propagation = Propagation.REQUIRED)
	public Integer insert(HashMap<String, Object> params) throws Exception {
		try {
	        int retCode = 1;
	        
	        // 파일 뽑고, DB 저장하고
	        int file_seq = fileUploadMapper.getFileSeq();
	        params.put("FILE_SEQ", file_seq);
	        fileUploadMapper.insertFileUpload(params);
	        prdtRepairMapper.insertPrdtRepair(params);
	        
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
			fileUploadMapper.updateFileUpload(params);
	        prdtRepairMapper.updatePrdtRepair(params);
	        
			return retCode;
		}catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
	}

	@Override
	@Transactional(rollbackFor={Exception.class}, propagation = Propagation.REQUIRED)
	public Integer delete(List<Map<String, Object>> params) throws Exception {
		try {
			int retCode = 0;
			for(int  i=0; i<params.size();i++){
				fileUploadMapper.deleteFileUpload((HashMap)params.get(i));
				prdtRepairMapper.deletePrdtRepair((HashMap)params.get(i));
				retCode++;
			}
	        
			return retCode;
		}catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
	}
	
}
