package com.bogoManager.mapper;

import java.util.HashMap;
import java.util.List;

import com.bogoManager.domain.VehicleManagement;


public interface VehicleManagementMapper {

	Integer selectVehiclePagingCount(HashMap<String, Object> paramMap);

	List<VehicleManagement> selectVehiclePagingList(HashMap<String, Object> paramMap);

	List<VehicleManagement> selectVehicleList(HashMap<String, Object> paramMap);

	VehicleManagement selectVehicle(VehicleManagement VehicleManagement);

	int insertVehicle(VehicleManagement VehicleManagement);

	int updateVehicle(VehicleManagement VehicleManagement);

	int deleteVehicle(VehicleManagement VehicleManagement);

	List<HashMap<String, Object>> selectKinds();

	List<HashMap<String, Object>> selectClients();

	List<HashMap<String, Object>> selectModelCars(HashMap<String, Object> paramMap);

	List<HashMap<String, Object>> selectProductNames(HashMap<String, Object> paramMap);

	List<HashMap<String, Object>> selectlhRhs(HashMap<String, Object> paramMap);
	
}
