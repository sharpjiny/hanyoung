package com.hanManager.service;

import java.util.HashMap;

import com.hanManager.domain.PackingEjection;
import com.hanManager.model.PackingEjectionModel;

public interface PackingEjectionService {
	public Integer insert(PackingEjectionModel ejectionModel) throws Exception;

	public Integer update(PackingEjectionModel ejectionModel) throws Exception;

	public Integer confirm(PackingEjection ejection) throws Exception;

	public Integer delete(HashMap<String, Object> ejection) throws Exception;
}
