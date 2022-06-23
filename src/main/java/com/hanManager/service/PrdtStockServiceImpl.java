package com.hanManager.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanManager.mapper.PrdtStockMapper;

@Service
public class PrdtStockServiceImpl implements PrdtStockService {
	@Autowired PrdtStockMapper prdtStockMapper;
	@Override
	public List<HashMap<String, Object>> selectPrdtStockList(HashMap<String, Object> params) throws Exception {
		
		return prdtStockMapper.selectPrdtStockList(params);
	}
}
