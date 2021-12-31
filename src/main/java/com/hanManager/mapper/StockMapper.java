package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;

import com.hanManager.domain.PackingInspection;
import com.hanManager.domain.Stock;


public interface StockMapper {

	Integer selectStockPagingCount(HashMap<String, Object> paramMap);

	List<HashMap<String, Object>> selectStockList(HashMap<String, Object> paramMap);

	List<HashMap<String, Object>> selectStockPagingList(HashMap<String, Object> paramMap);

	List<HashMap<String, Object>> selectStockStatistics(HashMap<String, Object> paramMap);
	
	List<HashMap<String, Object>> selectStockkinds(HashMap<String, Object> paramMap);

	Stock selectStock(Stock Stock);

	int insertStock(Stock Stock);

	int updateStock(Stock Stock);
	int updateStockSub(Stock Stock);

	int deleteStock(Stock Stock);
	int deleteStockSub(Stock Stock);
	int deleteStockKey(Stock Stock);

	int confirmStock(Stock Stock);
}
