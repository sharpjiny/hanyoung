package com.hanManager.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanManager.mapper.MtrlsStockMapper;

@Service
public class MtrlsStockServiceImpl implements MtrlsStockService {
	@Autowired MtrlsStockMapper mtrlsStockMapper;
	@Override
	public List<HashMap<String, Object>> selectMtrlsStockList(HashMap<String, Object> params) throws Exception {
		
		return mtrlsStockMapper.selectMtrlsStockList(params);
	}
}
