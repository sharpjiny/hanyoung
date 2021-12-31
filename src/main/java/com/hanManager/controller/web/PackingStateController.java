package com.hanManager.controller.web;

import java.net.UnknownHostException;
import java.util.HashMap;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hanManager.Constant;
import com.hanManager.controller.DefaultController;
import com.hanManager.mapper.CommonCodeMapper;
import com.hanManager.mapper.PackingStateMapper;
import com.hanManager.mapper.VehicleManagementMapper;

@Controller
@RequestMapping(value={"/production/state/"})
public class PackingStateController extends DefaultController{
	@Autowired PackingStateMapper packingState;
	@Autowired CommonCodeMapper codeMapper;
	@Autowired VehicleManagementMapper vehicleMapper;
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
		
		model.addAttribute("pageParam", paramMap);
		model.addAttribute("pagingList", packingState.selectPackingStateList(paramMap));
		
		// 차종
		model.addAttribute("modelCars", vehicleMapper.selectModelCars(paramMap));
				
		// 품명
		model.addAttribute("productNames", vehicleMapper.selectProductNames(paramMap));
		
		// 고객사
		model.addAttribute("clients", vehicleMapper.selectClients());
		
		return TILESForder+"/state/list"+Constant.TILES;
	}
	
}
