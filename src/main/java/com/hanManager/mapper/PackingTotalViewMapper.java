package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;

import com.hanManager.domain.PackingVaccum;
import com.hanManager.domain.PackingVaccumProduce;


public interface PackingTotalViewMapper {
	

	Integer selectPackingEjectionTotalPagingCount(HashMap<String, Object> paramMap);

	List<HashMap<String, Object>> selectPackingEjectionTotalList(HashMap<String, Object> paramMap);

	List<HashMap<String, Object>> selectPackingEjectionTotalPagingList(HashMap<String, Object> paramMap);

	Integer selectPackingVaccumTotalPagingCount(HashMap<String, Object> paramMap);

	List<HashMap<String, Object>> selectPackingVaccumTotalList(HashMap<String, Object> paramMap);

	List<HashMap<String, Object>> selectPackingVaccumTotalPagingList(HashMap<String, Object> paramMap);
	
	Integer selectPackingInspectionTotalPagingCount(HashMap<String, Object> paramMap);

	List<HashMap<String, Object>> selectPackingInspectionTotalList(HashMap<String, Object> paramMap);

	List<HashMap<String, Object>> selectPackingInspectionTotalPagingList(HashMap<String, Object> paramMap);

}
