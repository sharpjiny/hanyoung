package com.bogoManager.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.bogoManager.domain.PackingEjection;
import com.bogoManager.domain.PackingEjectionProduce;
import com.bogoManager.domain.Stock;
import com.bogoManager.mapper.PackingEjectionMapper;
import com.bogoManager.mapper.StockMapper;
import com.bogoManager.model.PackingEjectionModel;
import com.bogoManager.web.util.CommonUtil;

@Service
public class PackingEjectionServiceImpl implements PackingEjectionService {

	@Autowired PackingEjectionMapper ejectionMapper;
	@Autowired StockMapper stockMapper;

	@Transactional(rollbackFor={Exception.class}, propagation = Propagation.REQUIRED)
	public Integer insert(PackingEjectionModel ejectionModel) throws Exception {
		try {
			PackingEjection ejection = ejectionModel.getEjection();
    		Integer eId = ejection.geteId();
	        int retCode = ejectionMapper.insertPackingEjection(ejection);
        	if(retCode > 0) {
        		eId = ejection.geteId();
        		List<PackingEjectionProduce> produces = ejectionModel.getProduces();
        		for(PackingEjectionProduce produce : produces) {
        			if(CommonUtil.isEmpty(produce.getVehicleId()) || CommonUtil.isEmpty(produce.getProduction())) continue;
        			produce.seteId(eId);
        			retCode = ejectionMapper.insertPackingEjectionProduce(produce);
        			/*if(retCode > 0) {
            			if("완제품".equals(produce.getKind()) || "完成品".equals(produce.getKind())){
                	        Integer id = produce.getEpId();
                    		Stock stock = new Stock();
                    		stock.setSubType("EJECTION_PRODUCE");
                    		stock.setSubKey(eId);
                    		stock.setSubId(id);
                    		stock.setWorkType(ejection.getWorkType());
                    		stock.setStockDate(ejection.getEjectionDate());
                    		stock.setQuantity(produce.getProduction() - produce.getFaulty());
                    		stock.setVehicleId(produce.getVehicleId());
                    		stock.setStockGubun("s006");
                    		retCode = stockMapper.insertStock(stock);
            			}
                		if(retCode > 0) retCode = eId;
                		else throw new Exception();
            		}
            		else throw new Exception();
            		*/
        		}
        	}
			return retCode;
		}catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
	}

	@Transactional(rollbackFor={Exception.class}, propagation = Propagation.REQUIRED)
	public Integer update(PackingEjectionModel ejectionModel) throws Exception {
		try {
			PackingEjection ejection = ejectionModel.getEjection();
    		Integer eId = ejection.geteId();
	        int retCode = 0;
	        if (eId!=null) {
	        	retCode = ejectionMapper.updatePackingEjection(ejection);
	        	if(retCode > 0) {
	        		HashMap<String, Object> paramMap = new HashMap<String, Object>();
	        		paramMap.put("eId", eId);
	        		ejectionMapper.deletePackingEjectionProduce(paramMap);
            		//Stock stock = new Stock();
            		//stock.setSubType("EJECTION_PRODUCE");
            		//stock.setSubKey(eId);
            		//retCode = stockMapper.deleteStockKey(stock);
	        		List<PackingEjectionProduce> produces = ejectionModel.getProduces();
	        		for(PackingEjectionProduce produce : produces) {
	        			if(CommonUtil.isEmpty(produce.getVehicleId())) continue;
	        			produce.seteId(eId);
	        			retCode = ejectionMapper.insertPackingEjectionProduce(produce);
	        			/*if(retCode > 0) {
	            			if("완제품".equals(produce.getKind()) || "完成品".equals(produce.getKind())){
	                	        Integer id = produce.getEpId();
	                    		stock = new Stock();
	                    		stock.setSubType("EJECTION_PRODUCE");
	                    		stock.setSubKey(eId);
	                    		stock.setSubId(id);
	                    		stock.setWorkType(ejection.getWorkType());
	                    		stock.setStockDate(ejection.getEjectionDate());
	                    		stock.setQuantity(produce.getProduction() - produce.getFaulty());
	                    		stock.setVehicleId(produce.getVehicleId());
	                    		stock.setStockGubun("s006");
	                    		retCode = stockMapper.insertStock(stock);
	            			}
	                		if(retCode > 0) retCode = eId;
	                		else throw new Exception();
	            		}
	            		else throw new Exception();*/
	        		}
	        	}
	        }
			return retCode;
		}catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
	}

	@Override
	@Transactional(rollbackFor={Exception.class}, propagation = Propagation.REQUIRED)
	public Integer confirm(PackingEjection ejection) throws Exception {
		try {
	        Integer eId = ejection.geteId();
	        int retCode = 0;
	        if (eId!=null) {
	        	retCode = ejectionMapper.confirmPackingEjection(ejection);
	        }
			return retCode;
		}catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
	}

	@Override
	@Transactional(rollbackFor={Exception.class}, propagation = Propagation.REQUIRED)
	public Integer delete(HashMap<String, Object> ejection) throws Exception {
		try {
			Integer eId = Integer.parseInt((String) ejection.get("eId"));
	        int retCode = 0;
	        if (eId!=null) {
	        	retCode = ejectionMapper.deletePackingEjectionProduce(ejection);
	        	if(retCode > 0) {
		        	retCode = ejectionMapper.deletePackingEjection(ejection);
            		//Stock stock = new Stock();
            		//stock.setSubType("EJECTION_PRODUCE");
            		//stock.setSubKey(eId);
            		//retCode = stockMapper.deleteStockKey(stock);
	        	}
	        }
			return retCode;
		}catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
	}
}
