package com.hanManager.service;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.hanManager.mapper.PlanExportMapper;

@Service
public class PlanExportServiceImpl implements PlanExportService {
	@Autowired PlanExportMapper planExportMapper;
	
	@SuppressWarnings("unchecked")
	@Override
	public HashMap<String, Object> planExportSave(HashMap<String, Object> params) throws Exception {
		
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
			String ORDER_NO = "";
			for(int i=0; i<ulist.size();i++){
				ulist.get(i).put("CREATE_USER", params.get("loginUser"));
				ulist.get(i).put("UPDATE_USER", params.get("loginUser"));
				
				if("OK".equals(ulist.get(i).get("IS_CHECK"))){
					planExportMapper.updatePlanExportIsChk(ulist.get(i));
					ORDER_NO = ulist.get(i).get("ORDER_NO").toString();
					String OUT_NUM = planExportMapper.selectOrderNo(ORDER_NO);
					if(OUT_NUM == null || "".equals(OUT_NUM) ){
						// 입출고 insert
						planExportMapper.insertPlanExportToInout(ORDER_NO);
						List<HashMap<String, Object>> result = null;
						result = planExportMapper.selectProdIdList(ORDER_NO);
						ucnt = ((BigDecimal)result.get(0).get("CNT")).intValue(); // insert 건수
						
						// 재고 update(차감)
						/*for(int j=0; j<result.size(); j++){
							planExportMapper.updateProdStock(result.get(i));
						}*/
					}
					break;
				}else{
					ucnt += update(ulist.get(i));
				}
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
	        planExportMapper.insertPlanExport(params);
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
	        planExportMapper.updatePlanExport(params);
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
	        planExportMapper.deletePlanExport(params);
			return retCode;
		}catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
	}
}
