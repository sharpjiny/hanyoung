package com.bogoManager.mapper;

import java.util.HashMap;
import java.util.List;

import com.bogoManager.domain.PackingInspection;
import com.bogoManager.domain.Stock;


public interface SalesMapper {

	List<HashMap<String, Object>> selectMonthList(HashMap<String, Object> paramMap);

	List<HashMap<String, Object>> selectClientMonthList(HashMap<String, Object> paramMap);
}
