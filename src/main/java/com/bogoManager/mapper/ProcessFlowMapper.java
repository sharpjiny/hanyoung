package com.bogoManager.mapper;

import java.util.HashMap;
import java.util.List;

public interface ProcessFlowMapper {
	
  List<HashMap<String, Object>> selectProcessFlowList(HashMap<String, Object> paramHashMap);
  
}
