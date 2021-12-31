package com.hanManager.mapper;

import java.util.List;
import java.util.Map;

public interface PackingStateMapper {
	List<Map<String, Object>> selectPackingStateList(Map<String, Object> paramMap);
}
