package com.bogoManager.mapper;

import java.util.HashMap;
import java.util.List;

import com.bogoManager.domain.Codes;
import com.bogoManager.domain.RawStockManagement;


public interface RawStockManagementMapper {

	Integer selectRawStockPagingCount(HashMap<String, Object> paramMap);

	List<RawStockManagement> selectRawStockPagingList(HashMap<String, Object> paramMap);

	List<RawStockManagement> selectRawStockList(HashMap<String, Object> paramMap);

	RawStockManagement selectRawStock(RawStockManagement rawStockManagement);

	int insertRawStock(RawStockManagement rawStockManagement);

	int updateRawStock(RawStockManagement rawStockManagement);

	int deleteRawStock(RawStockManagement rawStockManagement);

	List<HashMap<String, Object>> selectRawKinds();

	List<Codes> selectRawProducts(HashMap<String, Object> paramMap);
	
	List<HashMap<String, Object>> selectRawProductsRawId(HashMap<String, Object> paramMap);

	List<Codes> selectRawClient(HashMap<String, Object> paramMap);

	HashMap<String, Object> selectRawPrice(HashMap<String, Object> paramMap);

}
