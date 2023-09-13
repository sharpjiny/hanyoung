package com.hanManager.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.hanManager.mapper.ProductionPackingMapper;

@Service
public class ProductionPackingServiceImpl implements ProductionPackingService {
	@Autowired ProductionPackingMapper productionPackingMapper;
	@Override
	public List<HashMap<String, Object>> selectPrdtPackingList(HashMap<String, Object> params) throws Exception {
		
		return productionPackingMapper.selectPrdtPackingList(params);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public HashMap<String, Object> prdtPackingSave(HashMap<String, Object> params) throws Exception {
		
		List<HashMap<String, Object>> ilist = (List<HashMap<String, Object>>) params.get("createdRows");
		List<HashMap<String, Object>> ulist = (List<HashMap<String, Object>>) params.get("updatedRows");
		List<HashMap<String, Object>> dlist = (List<HashMap<String, Object>>) params.get("deletedRows");
		HashMap<String, Object> rtnMap = new HashMap<String, Object>();
		
		int ipCnt = 0;
		int upCnt = 0;
		int dpCnt = 0;
		
		/*int iuCnt = 0;
		int uuCnt = 0;
		int duCnt = 0;*/
		
		if(ilist.size() > 0){
			for(int i=0; i<ilist.size();i++){
				ilist.get(i).put("CREATE_USER", params.get("loginUser"));
				ilist.get(i).put("UPDATE_USER", params.get("loginUser"));
				ipCnt += insertPrdtStatusPacking(ilist.get(i));
				//iuCnt += insertPrdtMtrlsUsage(ilist.get(i));
			}
		}
		
		
		if(ulist.size() > 0){
			for(int i=0; i<ulist.size();i++){
				ulist.get(i).put("CREATE_USER", params.get("loginUser"));
				ulist.get(i).put("UPDATE_USER", params.get("loginUser"));
				
				if("OK".equals(ulist.get(i).get("IS_CHECK"))){
					// 입출고 작업 후 OK 로 업데이트.
					upCnt += insertToMtrlsInOut(ulist.get(i));
				}else{
					upCnt += updatePrdtStatusPacking(ulist.get(i));
				}
			}
			
		}
		
		/*if(ulist.size() > 0){
			for(int i=0; i<ulist.size();i++){
				ulist.get(i).put("CREATE_USER", params.get("loginUser"));
				ulist.get(i).put("UPDATE_USER", params.get("loginUser"));
				upCnt += updatePrdtStatusPacking(ulist.get(i));
				//uuCnt += updatePrdtMtrlsUsage(ulist.get(i));
			}
		}*/
		
		if(dlist.size() > 0){
			for(int  i=0; i<dlist.size();i++){
				dlist.get(i).put("CREATE_USER", params.get("loginUser"));
				dlist.get(i).put("UPDATE_USER", params.get("loginUser"));
				dpCnt += deletePrdtStatusPacking(dlist.get(i));
				//duCnt += deletePrdtMtrlsUsage(dlist.get(i));
			}
		}
		
		rtnMap.put("insert", ipCnt);
		rtnMap.put("update", upCnt);
		rtnMap.put("delete", dpCnt);
		
		/*rtnMap.put("insert", iuCnt);
		rtnMap.put("update", uuCnt);
		rtnMap.put("delete", duCnt);*/
		
		return rtnMap;
	}
	
	@Override
	@Transactional(rollbackFor={Exception.class}, propagation = Propagation.REQUIRED)
	public Integer insertPrdtStatusPacking(HashMap<String, Object> params) throws Exception {
		try {
	        int retCode = 1;
	        productionPackingMapper.insertPrdtStatusPacking(params);
	        
	        // 재고 테이블 merge
	        /*if("product02".equals(params.get("PRODUCT_GUBUN")) || "product05".equals(params.get("PRODUCT_GUBUN"))){
	        	if(params.get("PROD_ID") == null || "".equals(params.get("PROD_ID"))){
	        		List<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
	        		params.put("kind", params.get("KIND"));
	        		params.put("prodNm", params.get("PROD_NM"));
	        		params.put("prodDtlNm", params.get("PROD_DTL_NM"));
	        		list = prdtPackingMapper.selectPrdtPackingId(params);
		        	params.put("PROD_ID", list.get(0).get("CODE"));
	        	}
	        	prdtPackingMapper.mergePrdtStock(params);
	        }*/
			return retCode;
		}catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
	}
	
	@Override
	@Transactional(rollbackFor={Exception.class}, propagation = Propagation.REQUIRED)
	public Integer updatePrdtStatusPacking(HashMap<String, Object> params) throws Exception {
		try {
			int retCode = 1;
			productionPackingMapper.updatePrdtStatusPacking(params);
	        
	        // 재고 테이블 merge
	        /*if("product02".equals(params.get("PRODUCT_GUBUN")) || "product05".equals(params.get("PRODUCT_GUBUN"))){
	        	params.put("COUNT", params.get("BOX_PER_COUNT"));
	        	params.put("BOX_COUNT", params.get("BOX_COUNT"));
	        	prdtPackingMapper.mergePrdtStock(params);
	        }*/
			return retCode;
		}catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
	}

	@Override
	@Transactional(rollbackFor={Exception.class}, propagation = Propagation.REQUIRED)
	public Integer deletePrdtStatusPacking(HashMap<String, Object> params) throws Exception {
		try {
			int retCode = 1;
			productionPackingMapper.deletePrdtStatusPacking(params);
	        
	        // 재고 테이블 update
	        /*if("product02".equals(params.get("PRODUCT_GUBUN")) || "product05".equals(params.get("PRODUCT_GUBUN"))){
	        	prdtPackingMapper.deletePrdtStock(params);
	        }*/
			return retCode;
		}catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
	}
	
	@Override
	@Transactional(rollbackFor={Exception.class}, propagation = Propagation.REQUIRED)
	public Integer insertPrdtMtrlsUsage(HashMap<String, Object> params) throws Exception {
		try {
	        int retCode = 1;
	        productionPackingMapper.insertPrdtMtrlsUsage(params);
	        
	        // 재고 테이블 merge
	        /*if("product02".equals(params.get("PRODUCT_GUBUN")) || "product05".equals(params.get("PRODUCT_GUBUN"))){
	        	if(params.get("PROD_ID") == null || "".equals(params.get("PROD_ID"))){
	        		List<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
	        		params.put("kind", params.get("KIND"));
	        		params.put("prodNm", params.get("PROD_NM"));
	        		params.put("prodDtlNm", params.get("PROD_DTL_NM"));
	        		list = prdtPackingMapper.selectPrdtPackingId(params);
		        	params.put("PROD_ID", list.get(0).get("CODE"));
	        	}
	        	prdtPackingMapper.mergePrdtStock(params);
	        }*/
			return retCode;
		}catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
	}
	
	@Override
	@Transactional(rollbackFor={Exception.class}, propagation = Propagation.REQUIRED)
	public Integer updatePrdtMtrlsUsage(HashMap<String, Object> params) throws Exception {
		try {
			int retCode = 1;
			productionPackingMapper.updatePrdtMtrlsUsage(params);
	        
	        // 재고 테이블 merge
	        /*if("product02".equals(params.get("PRODUCT_GUBUN")) || "product05".equals(params.get("PRODUCT_GUBUN"))){
	        	params.put("COUNT", params.get("BOX_PER_COUNT"));
	        	params.put("BOX_COUNT", params.get("BOX_COUNT"));
	        	prdtPackingMapper.mergePrdtStock(params);
	        }*/
			return retCode;
		}catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
	}

	@Override
	@Transactional(rollbackFor={Exception.class}, propagation = Propagation.REQUIRED)
	public Integer deletePrdtMtrlsUsage(HashMap<String, Object> params) throws Exception {
		try {
			int retCode = 1;
			productionPackingMapper.deletePrdtMtrlsUsage(params);
	        
	        // 재고 테이블 update
	        /*if("product02".equals(params.get("PRODUCT_GUBUN")) || "product05".equals(params.get("PRODUCT_GUBUN"))){
	        	prdtPackingMapper.deletePrdtStock(params);
	        }*/
			return retCode;
		}catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
	}
	
	@Override
	@Transactional(rollbackFor={Exception.class}, propagation = Propagation.REQUIRED)
	public Integer insertToMtrlsInOut(HashMap<String, Object> params) throws Exception {
		try {
	        int retCode = 1;
	        
	        HashMap insertMap = new HashMap();
	        insertMap.putAll(params);
	        
	        if(!"".equals(insertMap.get("THICKNESS_1")) && insertMap.get("THICKNESS_1") != null){
	        	insertMap.put("PROD_ID", "Y101");
	        	insertMap.put("WEIGHT", insertMap.get("THICKNESS_1"));
	        	productionPackingMapper.insertToMtrlsInOut(insertMap);
	        }
	        if(!"".equals(insertMap.get("THICKNESS_2")) && insertMap.get("THICKNESS_2") != null){
	        	insertMap.put("PROD_ID", "Y102");
	        	insertMap.put("WEIGHT", insertMap.get("THICKNESS_2"));
	        	productionPackingMapper.insertToMtrlsInOut(insertMap);
	        }
	        if(!"".equals(insertMap.get("THICKNESS_3")) && insertMap.get("THICKNESS_3") != null){
	        	insertMap.put("PROD_ID", "Y103");
	        	insertMap.put("WEIGHT", params.get("THICKNESS_3"));
	        	productionPackingMapper.insertToMtrlsInOut(insertMap);
	        }
	        if(!"".equals(insertMap.get("THICKNESS_4")) && insertMap.get("THICKNESS_4") != null){
	        	insertMap.put("PROD_ID", "Y104");
	        	insertMap.put("WEIGHT", params.get("THICKNESS_4"));
	        	productionPackingMapper.insertToMtrlsInOut(insertMap);
	        }
	        if(!"".equals(insertMap.get("THICKNESS_5")) && insertMap.get("THICKNESS_5") != null){
	        	insertMap.put("PROD_ID", "Y105");
	        	insertMap.put("WEIGHT", params.get("THICKNESS_5"));
	        	productionPackingMapper.insertToMtrlsInOut(insertMap);
	        }
	        if(!"".equals(insertMap.get("THICKNESS_6")) && insertMap.get("THICKNESS_6") != null){
	        	insertMap.put("PROD_ID", "Y106");
	        	insertMap.put("WEIGHT", params.get("THICKNESS_6"));
	        	productionPackingMapper.insertToMtrlsInOut(insertMap);
	        }
	        
	        productionPackingMapper.updatePrdtStatusPacking(params);
	        
			return retCode;
		}catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
	}
}
