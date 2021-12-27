package com.bogoManager.controller.web;

import java.net.UnknownHostException;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bogoManager.Constant;
import com.bogoManager.controller.DefaultController;
import com.bogoManager.mapper.CommonCodeMapper;
import com.bogoManager.mapper.PackingEjectionRawMapper;
import com.bogoManager.mapper.RawStockManagementMapper;
import com.bogoManager.mapper.VehicleManagementMapper;
import com.bogoManager.web.util.CommonUtil;

@Controller
@RequestMapping(value={"/production/ejectionRaw/"})
public class PackingEjectionRawController extends DefaultController{
	@Autowired PackingEjectionRawMapper ejectionRawMapper;
	@Autowired VehicleManagementMapper vehicleMapper;
	@Autowired RawStockManagementMapper rawStockMapper;

	@Autowired CommonCodeMapper codeMapper;
	String TILESForder = "production";
	@ModelAttribute("menuType")
	public String type(){
		return TILESForder;
	}
	/**
	 * 리스트
	 * @return
	 * @throws UnknownHostException
	 */
	@RequestMapping(value={"search"})
	public String list(Model model, @RequestParam HashMap<String, Object> paramMap, @RequestParam(required=false) String logMsg) throws UnknownHostException{
		String jspName = "list";
		if(pagegingCheck(paramMap)) {
			jspName = "search";
    		model.addAttribute("list", ejectionRawMapper.selectPackingEjectionRawList(paramMap));
		} else {
			Integer pageDataTotal = ejectionRawMapper.selectPackingEjectionRawPagingCount(paramMap);
			model.addAttribute("pageDataTotal", pageDataTotal);
	    	if(pageDataTotal!=null && pageDataTotal > 0){
	    		paramMap = CommonUtil.pagingNumCheck(paramMap, pageDataTotal);
	    		model.addAttribute("pagingList", ejectionRawMapper.selectPackingEjectionRawPagingList(paramMap));
	    	}
		}
		model.addAttribute("pageParam", paramMap);

		// 주/야간
		paramMap.put("group", Constant.WORK_TYPE);
		model.addAttribute("workTypes", codeMapper.selectCodeList(paramMap));

		// 반
		paramMap.put("group", Constant.JAB_CLASS);
		model.addAttribute("ejectionGroups", codeMapper.selectCodeList(paramMap));

		// 사출호기
		paramMap.put("group", Constant.EJECTION);
		model.addAttribute("ejections", codeMapper.selectCodeList(paramMap));

		// 종류
		model.addAttribute("kinds", vehicleMapper.selectKinds());

		// 차종
		model.addAttribute("modelCars", vehicleMapper.selectModelCars(paramMap));

		// 품명
		model.addAttribute("productNames", vehicleMapper.selectProductNames(paramMap));

		// L/R
		model.addAttribute("lhRhs", vehicleMapper.selectlhRhs(paramMap));

		// 원재료
		//model.addAttribute("rawStocks", ejectionRawMapper.selectRawStocks(paramMap));
		
		// 원재료종류
		model.addAttribute("rawKinds", rawStockMapper.selectRawKinds());
		// 원재료품명
		model.addAttribute("rawProductNames", rawStockMapper.selectRawProducts(paramMap));

		return TILESForder+"/ejectionRaw/"+jspName+Constant.TILES;
	}

	private boolean pagegingCheck(HashMap<String, Object> paramMap) {
		String dateStart = (String) paramMap.get("dateStart");
		String dateEnd = (String) paramMap.get("dateEnd");
		String workType = (String) paramMap.get("workType");
		String kind = (String) paramMap.get("kind");
		String modelCar = (String) paramMap.get("modelCar");
		String lhRh = (String) paramMap.get("lhRh");
		String productName = (String) paramMap.get("productName");
		String ejectionGroup = (String) paramMap.get("ejectionGroup");
		String ejection = (String) paramMap.get("ejection");
		String rawId = (String) paramMap.get("rawId");
		if(CommonUtil.isNotEmpty(dateStart) || CommonUtil.isNotEmpty(dateEnd) || CommonUtil.isNotEmpty(workType) || CommonUtil.isNotEmpty(kind)
				|| CommonUtil.isNotEmpty(modelCar) || CommonUtil.isNotEmpty(lhRh) || CommonUtil.isNotEmpty(productName) || CommonUtil.isNotEmpty(ejectionGroup) || CommonUtil.isNotEmpty(ejection) || CommonUtil.isNotEmpty(rawId)) {
			return true;
		}
		return false;
	}
}
