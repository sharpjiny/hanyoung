package com.bogoManager.service;

import java.util.HashMap;

import com.bogoManager.domain.PackingEjection;
import com.bogoManager.model.PackingEjectionModel;

public interface PackingEjectionService {
	public Integer insert(PackingEjectionModel ejectionModel) throws Exception;

	public Integer update(PackingEjectionModel ejectionModel) throws Exception;

	public Integer confirm(PackingEjection ejection) throws Exception;

	public Integer delete(HashMap<String, Object> ejection) throws Exception;
}
