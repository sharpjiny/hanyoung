package com.bogoManager.service;

import java.util.HashMap;

import com.bogoManager.domain.PackingInspection;
import com.bogoManager.model.PackingInspectionModel;

public interface PackingInspectionService {
	public Integer insert(PackingInspectionModel inspectionModel) throws Exception;

	public Integer update(PackingInspectionModel inspectionModel) throws Exception;

	public Integer confirm(PackingInspection inspection) throws Exception;

	public Integer delete(HashMap<String, Object> inspection) throws Exception;
}
