package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;

import com.hanManager.domain.PackingInspection;
import com.hanManager.domain.Stock;


public interface SalesMapper {

	List<HashMap<String, Object>> selectMonthList(HashMap<String, Object> paramMap);

	List<HashMap<String, Object>> selectClientMonthList(HashMap<String, Object> paramMap);
}
