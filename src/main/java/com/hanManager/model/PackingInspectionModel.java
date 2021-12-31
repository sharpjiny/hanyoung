package com.hanManager.model;

import java.util.List;

import javax.validation.Valid;

import com.hanManager.domain.PackingInspection;
import com.hanManager.domain.PackingInspectionProduce;
import com.hanManager.domain.PackingVaccumProduce;

public class PackingInspectionModel {

    @Valid
    private PackingInspection inspection;
    private List<PackingInspectionProduce> produces;

	public PackingInspection getInspection() {
		return inspection;
	}

	public void setInspection(PackingInspection inspection) {
		this.inspection = inspection;
	}
	
	public List<PackingInspectionProduce> getProduces() {
		return produces;
	}
	public void setProduces(List<PackingInspectionProduce> produces) {
		this.produces = produces;
	}

}
