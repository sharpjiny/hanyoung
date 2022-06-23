package com.hanManager.service;

import java.util.HashMap;
import java.util.List;

public interface MtrlsStockService {
	public List<HashMap<String, Object>> selectMtrlsStockList(HashMap<String, Object> params) throws Exception;
}
