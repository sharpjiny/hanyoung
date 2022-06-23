package com.hanManager.service;

import java.util.HashMap;
import java.util.List;

public interface PrdtStockService {
	public List<HashMap<String, Object>> selectPrdtStockList(HashMap<String, Object> params) throws Exception;
}
