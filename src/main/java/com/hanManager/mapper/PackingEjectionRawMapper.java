package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;

import com.hanManager.domain.PackingEjection;
import com.hanManager.domain.PackingEjectionProduce;


public interface PackingEjectionRawMapper {

	Integer selectPackingEjectionRawPagingCount(HashMap<String, Object> paramMap);

	List<HashMap<String, Object>> selectPackingEjectionRawList(HashMap<String, Object> paramMap);

	List<HashMap<String, Object>> selectPackingEjectionRawPagingList(HashMap<String, Object> paramMap);

	List<HashMap<String, Object>> selectRawStocks(HashMap<String, Object> paramMap);

}
