package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;

import com.hanManager.domain.Codes;


public interface CommonCodeMapper {

	List<HashMap<String, Object>> selectCodeList(HashMap<String, Object> map);

}