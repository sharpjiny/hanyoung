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
import com.hanManager.mapper.RawStockManagementMapper;
import com.hanManager.web.util.CommonUtil;

@Controller
@RequestMapping(value={"/set/rawStock/"})
public class RawStockManagementController extends DefaultController{
	@Autowired RawStockManagementMapper RawStockMapper;
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

		/*Integer pageDataTotal = RawStockMapper.selectRawStockPagingCount(paramMap);
		model.addAttribute("pageDataTotal", pageDataTotal);
    	if(pageDataTotal!=null && pageDataTotal > 0){
    		paramMap = CommonUtil.pagingNumCheck(paramMap, pageDataTotal);
    		model.addAttribute("pagingList", RawStockMapper.selectRawStockPagingList(paramMap));
    	}*/
    	
    	model.addAttribute("pagingList", RawStockMapper.selectRawStockPagingList(paramMap));
		model.addAttribute("pageParam", paramMap);
		return TILESForder+"/rawStock/list"+Constant.TILES;
	}
}
