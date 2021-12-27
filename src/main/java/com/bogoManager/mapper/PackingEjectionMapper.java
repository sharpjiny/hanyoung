package com.bogoManager.mapper;

import java.util.HashMap;
import java.util.List;

import com.bogoManager.domain.PackingEjection;
import com.bogoManager.domain.PackingEjectionProduce;


public interface PackingEjectionMapper {

	Integer selectPackingEjectionPagingCount(HashMap<String, Object> paramMap);

	List<HashMap<String, Object>> selectPackingEjectionList(HashMap<String, Object> paramMap);

	List<HashMap<String, Object>> selectPackingEjectionPagingList(HashMap<String, Object> paramMap);

	PackingEjection selectPackingEjection(PackingEjection PackingEjection);

	List<PackingEjectionProduce> selectPackingEjectionProduce(PackingEjection PackingEjection);

	int insertPackingEjection(PackingEjection PackingEjection);
	int insertPackingEjectionProduce(PackingEjectionProduce PackingEjectionProduce);

	int updatePackingEjection(PackingEjection PackingEjection);
	int updatePackingEjectionProduce(PackingEjectionProduce PackingEjectionProduce);

	int confirmPackingEjection(PackingEjection PackingEjection);

	int deletePackingEjection(HashMap<String, Object> paramMap);
	int deletePackingEjectionProduce(HashMap<String, Object> paramMap);

	Integer useEjection(Integer eId);

	List<HashMap<String, Object>> selectRawStocks(HashMap<String, Object> paramMap);

}
