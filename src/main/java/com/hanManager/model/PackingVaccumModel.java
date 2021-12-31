package com.hanManager.model;

import java.util.List;

import javax.validation.Valid;

import com.hanManager.domain.PackingVaccum;
import com.hanManager.domain.PackingVaccumProduce;

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
