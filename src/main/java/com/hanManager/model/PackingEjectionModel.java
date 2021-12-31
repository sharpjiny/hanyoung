package com.hanManager.model;

import java.util.List;

import javax.validation.Valid;

import com.hanManager.domain.PackingEjection;
import com.hanManager.domain.PackingEjectionProduce;

public class PackingEjectionModel {

    @Valid
    private PackingEjection ejection;
    private List<PackingEjectionProduce> produces;

	public PackingEjection getEjection() {
		return ejection;
	}
	public void setEjection(PackingEjection ejection) {
		this.ejection = ejection;
	}
	public List<PackingEjectionProduce> getProduces() {
		return produces;
	}
	public void setProduces(List<PackingEjectionProduce> produces) {
		this.produces = produces;
	}
}
