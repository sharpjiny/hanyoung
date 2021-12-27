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
import com.bogoManager.mapper.RawStockManagementMapper;
import com.bogoManager.mapper.VehicleManagementMapper;
import com.bogoManager.web.util.CommonUtil;

@Controller
@RequestMapping(value={"/set/vehicle/"})
public class VehicleManagementController extends DefaultController{
	@Autowired VehicleManagementMapper vehicleMapper;
	@Autowired RawStockManagementMapper rawStockMapper;
	@Autowired CommonCodeMapper codeMapper;
	String TILESForder = "set";
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

		/*Integer pageDataTotal = vehicleMapper.selectVehiclePagingCount(paramMap);
		model.addAttribute("pageDataTotal", pageDataTotal);
    	if(pageDataTotal!=null && pageDataTotal > 0){
    		paramMap = CommonUtil.pagingNumCheck(paramMap, pageDataTotal);
    		model.addAttribute("pagingList", vehicleMapper.selectVehiclePagingList(paramMap));
    	}*/
		model.addAttribute("pagingList", vehicleMapper.selectVehicleList(paramMap));

		model.addAttribute("pageParam", paramMap);
		
		// 종류
		model.addAttribute("kinds", rawStockMapper.selectRawKinds());
		// 품명
		model.addAttribute("productNames", rawStockMapper.selectRawProductsRawId(paramMap));

		paramMap = new HashMap<String, Object>();
		paramMap.put("group", Constant.GUBUN_LHRH);
		model.addAttribute("gubunLhRh", codeMapper.selectCodeList(paramMap));
		return TILESForder+"/vehicle/list"+Constant.TILES;
	}
}
