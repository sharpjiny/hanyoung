package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;

import com.hanManager.domain.PackingVaccum;
import com.hanManager.domain.PackingVaccumProduce;


public interface PackingVaccumMapper {

	Integer selectPackingVaccumPagingCount(HashMap<String, Object> paramMap);

	List<HashMap<String, Object>> selectPackingVaccumList(HashMap<String, Object> paramMap);

	List<HashMap<String, Object>> selectPackingVaccumPagingList(HashMap<String, Object> paramMap);

	PackingVaccum selectPackingVaccum(PackingVaccum PackingVaccum);

	List<PackingVaccumProduce> selectPackingVaccumProduce(PackingVaccum PackingVaccum);

	int insertPackingVaccum(PackingVaccum PackingVaccum);
	int insertPackingVaccumProduce(PackingVaccumProduce PackingVaccumProduce);

	int updatePackingVaccum(PackingVaccum PackingVaccum);
	int updatePackingVaccumProduce(PackingVaccumProduce PackingVaccumProduce);

	int confirmPackingVaccum(PackingVaccum PackingVaccum);

	int deletePackingVaccum(HashMap<String, Object> paramMap);
	int deletePackingVaccumProduce(HashMap<String, Object> paramMap);

	Integer useVaccum(Integer eId);

	List<HashMap<String, Object>> selectRawStocks(HashMap<String, Object> paramMap);

}
