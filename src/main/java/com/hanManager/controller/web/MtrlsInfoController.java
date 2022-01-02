package com.hanManager.controller.web;

import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	 * page 호출
	 * @return
	 * @throws UnknownHostException
	 */
	@RequestMapping(value={"page"})
	public String page(Model model, @RequestParam HashMap<String, Object> param) throws UnknownHostException{

		return TILESForder+"/mtrlsInfo/list"+Constant.TILES;
	}
	
	/**
	 * 리스트
	 * @return 
	 * @return
	 * @throws UnknownHostException
	 */
	@RequestMapping(value={"list"})
	public @ResponseBody List<HashMap<String, Object>> list(Model model, @RequestParam HashMap<String, Object> param) throws UnknownHostException{
		
		List<HashMap<String, Object>> result = null;

		result = mtrlsInfoMapper.selectMtrlsInfoList(param);

		return result;
	}
	
	/**
	 * 리스트
	 * @return 
	 * @return
	 * @throws UnknownHostException
	 */
	@RequestMapping(value={"save"})
	public @ResponseBody HashMap<String, Object> save(Model model, @RequestParam HashMap<String, Object> param) throws UnknownHostException{
		
		HashMap<String, Object> result = null;

		result = mtrlsInfoMapper.selectMtrlsInfoSave(param);

		return result;
	}
}
