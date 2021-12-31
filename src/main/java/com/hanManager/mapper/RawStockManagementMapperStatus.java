package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;

import com.hanManager.domain.Codes;
import com.hanManager.domain.RawStockManagementStatus;


public interface RawStockManagementMapperStatus {

	Integer selectRawStockPagingCount(HashMap<String, Object> paramMap);

	List<RawStockManagementStatus> selectRawStockPagingList(HashMap<String, Object> paramMap);

	List<RawStockManagementStatus> selectRawStockList(HashMap<String, Object> paramMap);

	List<RawStockManagementStatus> selectRawStockStatisticsList(HashMap<String, Object> paramMap);

	RawStockManagementStatus selectRawStock(RawStockManagementStatus RawStockManagementStatus);

	int insertRawStock(RawStockManagementStatus RawStockManagementStatus);

	int updateRawStock(RawStockManagementStatus RawStockManagementStatus);

	int deleteRawStock(RawStockManagementStatus RawStockManagementStatus);

	int updateRawStockIsCheckOk(RawStockManagementStatus RawStockManagementStatus);

	List<String> selectRawKinds();

	List<Codes> selectRawProducts(HashMap<String, Object> paramMap);
	
	int updateCommonCode(HashMap<String, Object> paramMap);

}
