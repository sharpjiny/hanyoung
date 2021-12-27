package com.bogoManager.service;

import java.util.HashMap;

import com.bogoManager.domain.PackingVaccum;
import com.bogoManager.model.PackingVaccumModel;

public interface PackingVaccumService {
	public Integer insert(PackingVaccumModel ejectionModel) throws Exception;

	public Integer update(PackingVaccumModel ejectionModel) throws Exception;

	public Integer confirm(PackingVaccum ejection) throws Exception;

	public Integer delete(HashMap<String, Object> ejection) throws Exception;
}
