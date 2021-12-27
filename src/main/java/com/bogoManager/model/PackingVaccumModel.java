package com.bogoManager.model;

import java.util.List;

import javax.validation.Valid;

import com.bogoManager.domain.PackingVaccum;
import com.bogoManager.domain.PackingVaccumProduce;

public class PackingVaccumModel {

    @Valid
    private PackingVaccum vaccum;
    private List<PackingVaccumProduce> produces;

	public PackingVaccum getVaccum() {
		return vaccum;
	}
	public void setVaccum(PackingVaccum vaccum) {
		this.vaccum = vaccum;
	}
	public List<PackingVaccumProduce> getProduces() {
		return produces;
	}
	public void setProduces(List<PackingVaccumProduce> produces) {
		this.produces = produces;
	}
}
