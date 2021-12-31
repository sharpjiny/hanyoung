package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;

import com.hanManager.domain.SubMaterialsManagement;
import com.hanManager.domain.VehicleManagement;


public interface SubMaterialsManagementMapper {

	Integer selectSubMatPagingCount(HashMap<String, Object> paramMap);

	List<SubMaterialsManagement> selectSubMatPagingList(HashMap<String, Object> paramMap);

	List<SubMaterialsManagement> selectSubMatList(HashMap<String, Object> paramMap);

	SubMaterialsManagement selectSubMat(SubMaterialsManagement subMatManagement);

	int insertSubMat(SubMaterialsManagement subMatManagement);

	int updateSubMat(SubMaterialsManagement subMatManagement);

	int deleteSubMat(SubMaterialsManagement subMatManagement);

	List<HashMap<String, Object>> selectKinds();

	List<HashMap<String, Object>> selectUsePlace();

	List<HashMap<String, Object>> selectUnit(HashMap<String, Object> paramMap);

	List<HashMap<String, Object>> selectProductNames(HashMap<String, Object> paramMap);

}
