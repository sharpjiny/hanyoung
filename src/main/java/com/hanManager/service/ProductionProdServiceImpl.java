package com.hanManager.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.hanManager.mapper.ProductionProdMapper;

@Service
public class ProductionProdServiceImpl implements ProductionProdService {
	@Autowired ProductionProdMapper productionProdMapper;
	@Override
	public List<HashMap<String, Object>> selectPrdtInOutList(HashMap<String, Object> params) throws Exception {
		
		return productionProdMapper.selectPrdtInOutList(params);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public HashMap<String, Object> prdtInOutSave(HashMap<String, Object> params) throws Exception {
		
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
	        productionProdMapper.insertPrdtInOut(params);
	        
	        // 재고 테이블 merge
	        /*if("product02".equals(params.get("PRODUCT_GUBUN")) || "product05".equals(params.get("PRODUCT_GUBUN"))){
	        	if(params.get("PROD_ID") == null || "".equals(params.get("PROD_ID"))){
	        		List<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
	        		params.put("kind", params.get("KIND"));
	        		params.put("prodNm", params.get("PROD_NM"));
	        		params.put("prodDtlNm", params.get("PROD_DTL_NM"));
	        		list = prdtInOutMapper.selectPrdtProdId(params);
		        	params.put("PROD_ID", list.get(0).get("CODE"));
	        	}
	        	prdtInOutMapper.mergePrdtStock(params);
	        }*/
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
			productionProdMapper.updatePrdtInOut(params);
	        
	        // 재고 테이블 merge
	        /*if("product02".equals(params.get("PRODUCT_GUBUN")) || "product05".equals(params.get("PRODUCT_GUBUN"))){
	        	params.put("COUNT", params.get("BOX_PER_COUNT"));
	        	params.put("BOX_COUNT", params.get("BOX_COUNT"));
	        	prdtInOutMapper.mergePrdtStock(params);
	        }*/
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
			productionProdMapper.deletePrdtInOut(params);
	        
	        // 재고 테이블 update
	        /*if("product02".equals(params.get("PRODUCT_GUBUN")) || "product05".equals(params.get("PRODUCT_GUBUN"))){
	        	prdtInOutMapper.deletePrdtStock(params);
	        }*/
			return retCode;
		}catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
	}
}
