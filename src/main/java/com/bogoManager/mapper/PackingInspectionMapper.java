package com.bogoManager.mapper;

import java.util.HashMap;
import java.util.List;

import com.bogoManager.domain.PackingInspection;
import com.bogoManager.domain.PackingInspectionProduce;
import com.bogoManager.domain.PackingVaccum;
import com.bogoManager.domain.PackingVaccumProduce;


public interface PackingInspectionMapper {

	Integer selectPackingInspectionPagingCount(HashMap<String, Object> paramMap);

	List<HashMap<String, Object>> selectPackingInspectionList(HashMap<String, Object> paramMap);

	List<HashMap<String, Object>> selectPackingInspectionPagingList(HashMap<String, Object> paramMap);

	PackingInspection selectPackingInspection(PackingInspection PackingInspection);
	
	List<PackingInspectionProduce> selectPackingInspectionProduce(PackingInspection PackingInspection);
	
	int insertPackingInspection(PackingInspection PackingInspection);
	int insertPackingInspectionProduce(PackingInspectionProduce PackingInspectionProduce);

	int updatePackingInspection(PackingInspection PackingInspection);
	int updatePackingInspectionProduce(PackingInspectionProduce PackingInspectionProduce);

	int confirmPackingInspection(PackingInspection PackingInspection);

	int deletePackingInspection(HashMap<String, Object> paramMap);
	int deletePackingInspectionProduce(HashMap<String, Object> paramMap);

	Integer useVehicle(String vehicleId);

}
