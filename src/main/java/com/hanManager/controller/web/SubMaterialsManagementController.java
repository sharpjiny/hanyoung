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
import com.hanManager.mapper.SubMaterialsManagementMapper;
import com.hanManager.mapper.VehicleManagementMapper;
import com.hanManager.web.util.CommonUtil;

@Controller
@RequestMapping(value={"/set/submat/"})
public class SubMaterialsManagementController extends DefaultController{
	@Autowired SubMaterialsManagementMapper subMaterialsMapper;
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

		model.addAttribute("pagingList", subMaterialsMapper.selectSubMatList(paramMap));

		model.addAttribute("pageParam", paramMap);

		paramMap = new HashMap<String, Object>();
		return TILESForder+"/subMaterials/list"+Constant.TILES;
	}
}
