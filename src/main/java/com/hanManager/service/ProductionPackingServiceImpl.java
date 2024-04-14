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
				/*int cnt = productionPackingMapper.selectPrdtNmCnt(params);//대중소 세트 만들어 놓을려다가 필요없어짐.
				for(){
					
				}*/
				ipCnt += insertPrdtStatusPacking(ilist.get(i));
				//iuCnt += insertPrdtMtrlsUsage(ilist.get(i));
			}
		}
		
		
		if(ulist.size() > 0){
			for(int i=0; i<ulist.size();i++){
				ulist.get(i).put("CREATE_USER", params.get("loginUser"));
				ulist.get(i).put("UPDATE_USER", params.get("loginUser"));
				
				if("NO".equals(ulist.get(i).get("IS_CHECK"))){
					// NO 인 경우만 수정이 가능.
					upCnt += updatePrdtStatusPacking(ulist.get(i));
				}else{
					// 1. 입출고 추가, 2. 원부자재 차감, 3. OK 로 수정 
					insertToMtrlsInOut(ulist.get(i));
					insertToPrdtInOut(ulist.get(i));
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
	        
	        if(!"".equals(insertMap.get("POP_NM")) && insertMap.get("POP_NM") != null){
	        	insertMap.put("PROD_NM", "POP");
	        	insertMap.put("PROD_DTL_NM", insertMap.get("POP_NM"));
	        	insertMap.put("CNT", insertMap.get("POP_CNT"));
	        	productionPackingMapper.insertToMtrlsInOut(insertMap);
	        }
	        
	        if(!insertMap.get("POP_NM").toString().contains("小") && !insertMap.get("POP_NM").toString().contains("中")){
	        	if(!"".equals(insertMap.get("BOX_NM")) && insertMap.get("BOX_NM") != null){
		        	insertMap.put("PROD_NM", "纸箱");
		        	insertMap.put("PROD_DTL_NM", insertMap.get("BOX_NM"));
		        	insertMap.put("CNT", insertMap.get("BOX_CNT"));
		        	productionPackingMapper.insertToMtrlsInOut(insertMap);
		        }
	        }
	        
	        //productionPackingMapper.updatePrdtStatusPacking(params);
	        
			return retCode;
		}catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
	}
	
	@Override
	@Transactional(rollbackFor={Exception.class}, propagation = Propagation.REQUIRED)
	public Integer insertToPrdtInOut(HashMap<String, Object> params) throws Exception {
		try {
	        int retCode = 1;
	        
	        productionPackingMapper.insertToPrdtInOut(params);
	        
	        //productionPackingMapper.updatePrdtStatusPacking(params);
	        
			return retCode;
		}catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
	}
}
