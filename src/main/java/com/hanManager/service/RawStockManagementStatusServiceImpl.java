package com.hanManager.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.hanManager.domain.RawStockManagement;
import com.hanManager.mapper.RawStockManagementMapper;
import com.hanManager.mapper.RawStockManagementMapperStatus;
@Service
public class RawStockManagementStatusServiceImpl implements RawStockManagementStatusService {
	@Autowired RawStockManagementMapperStatus rawStockManagementMapperStatus;
	@Autowired RawStockManagementMapper rawStockMapper;
	@Transactional(rollbackFor={Exception.class}, propagation = Propagation.REQUIRED)
	public Integer update(RawStockManagement asis, RawStockManagement tobe) throws Exception {		
		rawStockMapper.updateRawStock(tobe);
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("asIsproductName", asis.getProductName());	
		paramMap.put("asIsproductId", asis.getProductId());	
		paramMap.put("asIskind", asis.getKind());	
		paramMap.put("asIsclient", asis.getClient());	
		paramMap.put("productName", tobe.getProductName());	
		paramMap.put("productId", tobe.getProductId());	
		paramMap.put("kind", tobe.getKind());	
		paramMap.put("client", tobe.getClient());	
		int ret = rawStockManagementMapperStatus.updateCommonCode(paramMap);
		
		if(ret < 0) {
			throw new Exception();
		}
		return ret;
	}

}
