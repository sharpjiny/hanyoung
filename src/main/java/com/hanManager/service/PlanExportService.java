package com.hanManager.service;

import java.util.HashMap;
import java.util.List;

public interface PlanExportService {
	public HashMap<String, Object> planExportSave(HashMap<String, Object> params) throws Exception;
	public Integer insert(HashMap<String, Object> params) throws Exception;
	public Integer update(HashMap<String, Object> params) throws Exception;
	public Integer delete(HashMap<String, Object> params) throws Exception;
}
