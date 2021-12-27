package com.bogoManager.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.bogoManager.domain.PackingVaccum;
import com.bogoManager.domain.PackingVaccumProduce;
import com.bogoManager.domain.Stock;
import com.bogoManager.mapper.PackingVaccumMapper;
import com.bogoManager.mapper.StockMapper;
import com.bogoManager.model.PackingVaccumModel;
import com.bogoManager.web.util.CommonUtil;

@Service
public class PackingVaccumServiceImpl implements PackingVaccumService {

	@Autowired PackingVaccumMapper vaccumMapper;
	@Autowired StockMapper stockMapper;

	@Transactional(rollbackFor={Exception.class}, propagation = Propagation.REQUIRED)
	public Integer insert(PackingVaccumModel vaccumModel) throws Exception {
		try {
			PackingVaccum vaccum = vaccumModel.getVaccum();
    		Integer eId = vaccum.geteId();
	        int retCode = vaccumMapper.insertPackingVaccum(vaccum);
        	if(retCode > 0) {
        		eId = vaccum.geteId();
        		List<PackingVaccumProduce> produces = vaccumModel.getProduces();
        		for(PackingVaccumProduce produce : produces) {
        			if(CommonUtil.isEmpty(produce.getVehicleId())) continue;
        			produce.seteId(eId);
        			retCode = vaccumMapper.insertPackingVaccumProduce(produce);
        			/*if(retCode > 0) {
            			if("완제품".equals(produce.getKind()) || "完成品".equals(produce.getKind())){
                	        Integer id = produce.getEpId();
                    		Stock stock = new Stock();
                    		stock.setSubType("EJECTION_PRODUCE");
                    		stock.setSubKey(eId);
                    		stock.setSubId(id);
                    		stock.setWorkType(vaccum.getWorkType());
                    		stock.setStockDate(vaccum.getVaccumDate());
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
	public Integer update(PackingVaccumModel vaccumModel) throws Exception {
		try {
			PackingVaccum vaccum = vaccumModel.getVaccum();
    		Integer eId = vaccum.geteId();
	        int retCode = 0;
	        if (eId!=null) {
	        	retCode = vaccumMapper.updatePackingVaccum(vaccum);
	        	if(retCode > 0) {
	        		HashMap<String, Object> paramMap = new HashMap<String, Object>();
	        		paramMap.put("eId", eId);
	        		vaccumMapper.deletePackingVaccumProduce(paramMap);
            		//Stock stock = new Stock();
            		//stock.setSubType("EJECTION_PRODUCE");
            		//stock.setSubKey(eId);
            		//retCode = stockMapper.deleteStockKey(stock);
	        		List<PackingVaccumProduce> produces = vaccumModel.getProduces();
	        		for(PackingVaccumProduce produce : produces) {
	        			if(CommonUtil.isEmpty(produce.getVehicleId())) continue;
	        			produce.seteId(eId);
	        			retCode = vaccumMapper.insertPackingVaccumProduce(produce);
	        			/*if(retCode > 0) {
	            			if("완제품".equals(produce.getKind()) || "完成品".equals(produce.getKind())){
	                	        Integer id = produce.getEpId();
	                    		stock = new Stock();
	                    		stock.setSubType("EJECTION_PRODUCE");
	                    		stock.setSubKey(eId);
	                    		stock.setSubId(id);
	                    		stock.setWorkType(vaccum.getWorkType());
	                    		stock.setStockDate(vaccum.getVaccumDate());
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
	public Integer confirm(PackingVaccum vaccum) throws Exception {
		try {
	        Integer eId = vaccum.geteId();
	        int retCode = 0;
	        if (eId!=null) {
	        	retCode = vaccumMapper.confirmPackingVaccum(vaccum);
	        }
			return retCode;
		}catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
	}

	@Override
	@Transactional(rollbackFor={Exception.class}, propagation = Propagation.REQUIRED)
	public Integer delete(HashMap<String, Object> vaccum) throws Exception {
		try {
			Integer eId = Integer.parseInt((String) vaccum.get("eId"));
	        int retCode = 0;
	        if (eId!=null) {
	        	retCode = vaccumMapper.deletePackingVaccumProduce(vaccum);
	        	if(retCode > 0) {
		        	retCode = vaccumMapper.deletePackingVaccum(vaccum);
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
