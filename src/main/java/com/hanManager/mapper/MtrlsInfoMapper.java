package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;


public interface MtrlsInfoMapper {

	List<HashMap<String, Object>> selectMtrlsInfoList(HashMap<String, Object> paramMap);

}
