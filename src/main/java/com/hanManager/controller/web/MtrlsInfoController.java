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
import com.hanManager.mapper.MtrlsInfoMapper;

@Controller
@RequestMapping(value={"/set/mtrlsInfo/"})
public class MtrlsInfoController extends DefaultController{
	@Autowired MtrlsInfoMapper mtrlsInfoMapper;
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

		model.addAttribute("pagingList", mtrlsInfoMapper.selectMtrlsInfoList(paramMap));

		model.addAttribute("pageParam", paramMap);
		
		paramMap = new HashMap<String, Object>();
		model.addAttribute("gubunLhRh", codeMapper.selectCodeList(paramMap));
		return TILESForder+"/mtrlsInfo/list"+Constant.TILES;
	}
}
