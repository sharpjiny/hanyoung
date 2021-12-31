package com.hanManager.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.hanManager.domain.PackingEjection;
import com.hanManager.domain.PackingEjectionProduce;
import com.hanManager.domain.PackingInspection;
import com.hanManager.domain.PackingInspectionProduce;
import com.hanManager.mapper.PackingInspectionMapper;
import com.hanManager.mapper.StockMapper;
import com.hanManager.model.PackingEjectionModel;
import com.hanManager.model.PackingInspectionModel;
import com.hanManager.web.util.CommonUtil;

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
