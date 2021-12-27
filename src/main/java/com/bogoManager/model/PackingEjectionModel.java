package com.bogoManager.model;

import java.util.List;

import javax.validation.Valid;

import com.bogoManager.domain.PackingEjection;
import com.bogoManager.domain.PackingEjectionProduce;

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
