package com.bogoManager.mapper;

import java.util.HashMap;
import java.util.List;

import com.bogoManager.domain.Codes;


public interface CommonCodeMapper {

	List<Codes> selectCodeList(HashMap<String, Object> map);

}