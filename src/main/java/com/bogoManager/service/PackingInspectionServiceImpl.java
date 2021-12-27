package com.bogoManager.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.bogoManager.domain.PackingEjection;
import com.bogoManager.domain.PackingEjectionProduce;
import com.bogoManager.domain.PackingInspection;
import com.bogoManager.domain.PackingInspectionProduce;
import com.bogoManager.mapper.PackingInspectionMapper;
import com.bogoManager.mapper.StockMapper;
import com.bogoManager.model.PackingEjectionModel;
import com.bogoManager.model.PackingInspectionModel;
import com.bogoManager.web.util.CommonUtil;

@Service
public class PackingInspectionServiceImpl implements PackingInspectionService {

	@Autowired PackingInspectionMapper inspectionMapper;
	@Autowired StockMapper stockMapper;

	@Transactional(rollbackFor={Exception.class}, propagation = Propagation.REQUIRED)
	public Integer insert(PackingInspectionModel inspectionModel) throws Exception {
		try {
			PackingInspection inspection = inspectionModel.getInspection();
    		Integer eId = inspection.geteId();
	        int retCode = inspectionMapper.insertPackingInspection(inspection);
        	if(retCode > 0) {
        		eId = inspection.geteId();
        		List<PackingInspectionProduce> produces = inspectionModel.getProduces();
        		for(PackingInspectionProduce produce : produces) {
        			if(CommonUtil.isEmpty(produce.getVehicleId())) continue;
        			produce.seteId(eId);
        			retCode = inspectionMapper.insertPackingInspectionProduce(produce);
        		}
        	}
			return retCode;
		}catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
	}
	
	@Transactional(rollbackFor={Exception.class}, propagation = Propagation.REQUIRED)
	public Integer update(PackingInspectionModel inspectionModel) throws Exception {
		try {
			PackingInspection inspection = inspectionModel.getInspection();
    		Integer eId = inspection.geteId();
	        int retCode = 0;
	        if (eId!=null) {
	        	retCode = inspectionMapper.updatePackingInspection(inspection);
	        	if(retCode > 0) {
	        		HashMap<String, Object> paramMap = new HashMap<String, Object>();
	        		paramMap.put("eId", eId);
	        		inspectionMapper.deletePackingInspectionProduce(paramMap);
	        		List<PackingInspectionProduce> produces = inspectionModel.getProduces();
	        		for(PackingInspectionProduce produce : produces) {
	        			if(CommonUtil.isEmpty(produce.getVehicleId())) continue;
	        			produce.seteId(eId);
	        			retCode = inspectionMapper.insertPackingInspectionProduce(produce);
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
	public Integer confirm(PackingInspection inspection) throws Exception {
		try {
	        Integer eId = inspection.geteId();
	        int retCode = 0;
	        if (eId!=null) {
	        	retCode = inspectionMapper.confirmPackingInspection(inspection);
	        }
			return retCode;
		}catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
	}
	
	@Override
	@Transactional(rollbackFor={Exception.class}, propagation = Propagation.REQUIRED)
	public Integer delete(HashMap<String, Object> inspection) throws Exception {
		try {
			Integer eId = Integer.parseInt((String) inspection.get("eId"));
	        int retCode = 0;
	        if (eId!=null) {
	        	retCode = inspectionMapper.deletePackingInspectionProduce(inspection);
	        	if(retCode > 0) {
		        	retCode = inspectionMapper.deletePackingInspection(inspection);
	        	}
	        }
			return retCode;
		}catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}
	}
}
