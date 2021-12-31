package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;

import com.hanManager.domain.Codes;


public interface CommonCodeMapper {

	List<Codes> selectCodeList(HashMap<String, Object> map);

}