package com.hanManager.service;

import java.util.HashMap;

import com.hanManager.domain.PackingVaccum;
import com.hanManager.model.PackingVaccumModel;

public interface PackingVaccumService {
	public Integer insert(PackingVaccumModel ejectionModel) throws Exception;

	public Integer update(PackingVaccumModel ejectionModel) throws Exception;

	public Integer confirm(PackingVaccum ejection) throws Exception;

	public Integer delete(HashMap<String, Object> ejection) throws Exception;
}
