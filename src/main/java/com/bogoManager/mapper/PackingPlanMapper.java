package com.bogoManager.mapper;

import java.util.List;
import java.util.Map;

public interface PackingPlanMapper {
	
	List<Map<String, Object>> selectPackingPlanList(Map<String, Object> paramMap);
	Integer mergeDB(Map<String, Object> map);
	Integer deleteAll();

}