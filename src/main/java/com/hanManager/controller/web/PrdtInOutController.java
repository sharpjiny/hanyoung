package com.hanManager.controller.web;

import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hanManager.Constant;
import com.hanManager.controller.DefaultController;
import com.hanManager.domain.LoginUsers;
import com.hanManager.mapper.CommonCodeMapper;
import com.hanManager.mapper.PrdtInOutMapper;
import com.hanManager.service.PrdtInOutService;
import com.hanManager.web.util.LoginManager;

@Controller
@RequestMapping(value={"/inout/prdt/"})
public class PrdtInOutController extends DefaultController{
	@Autowired CommonCodeMapper codeMapper;
	@Autowired PrdtInOutService prdtInOutService;
	@Autowired PrdtInOutMapper prdtInOutMapper;
	String TILESForder = "inout";
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
	public String page(Model model, @RequestParam HashMap<String, Object> params) throws UnknownHostException{

		return TILESForder+"/prdt/list"+Constant.TILES;
	}
	
	/**
	 * 조회 항목
	 * @return 
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("null")
	@RequestMapping(value={"productGubunSets"})
	public @ResponseBody Map<String, Object> productGubunSets(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("PRODUCT_GUBUN", codeMapper.selectCodeList(params));
		
		return result;
	}
	
	@SuppressWarnings("null")
	@RequestMapping(value={"monthsSets"})
	public @ResponseBody Map<String, Object> monthsSets(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("MONTHS", codeMapper.selectCodeList(params));
		
		return result;
	}
	
	@SuppressWarnings("null")
	@RequestMapping(value={"kindSets"})
	public @ResponseBody Map<String, Object> kindSets(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("KIND", codeMapper.selectCodeList(params));
		
		return result;
	}
	
	@SuppressWarnings("null")
	@RequestMapping(value={"clientSets"})
	public @ResponseBody Map<String, Object> clientSets(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("CLIENT", codeMapper.selectCodeList(params));
		
		return result;
	}
	
	@SuppressWarnings("null")
	@RequestMapping(value={"goalCitySets"})
	public @ResponseBody Map<String, Object> goalCitySets(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("GOAL_CITY", codeMapper.selectCodeList(params));
		
		return result;
	}
	
	@SuppressWarnings("null")
	@RequestMapping(value={"prodNmList"})
	public @ResponseBody Map<String, Object> prodNmList(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("PROD_NM", prdtInOutMapper.selectPrdtProdNm(params));
		
		return result;
	}
	
	@SuppressWarnings("null")
	@RequestMapping(value={"prodDtlNmList"})
	public @ResponseBody Map<String, Object> prodDtlNmList(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("PROD_DTL_NM", prdtInOutMapper.selectPrdtProdDtlNm(params));
		
		return result;
	}
	
	@SuppressWarnings("null")
	@RequestMapping(value={"prodIdList"})
	public @ResponseBody Map<String, Object> prodIdList(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("PROD_ID", prdtInOutMapper.selectPrdtProdId(params));
		
		return result;
	}
	
	@SuppressWarnings("null")
	@RequestMapping(value={"getProdIdRowList"})
	public @ResponseBody Map<String, Object> getProdIdRowList(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("PROD_ID_LIST", prdtInOutMapper.getProdIdRowList(params));
		
		return result;
	}
	
	@SuppressWarnings("null")
	@RequestMapping(value={"getPrice"})
	public @ResponseBody Map<String, Object> getPrice(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("PRICE", prdtInOutMapper.getPrice(params));
		return result;
	}
	
	/**
	 * 리스트
	 * @return 
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"list"})
	public @ResponseBody List<HashMap<String, Object>> list(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		List<HashMap<String, Object>> result = null;
		
		result = prdtInOutMapper.selectPrdtInOutList(params);
		
		return result;
	}
	
	/**
	 * 저장(추가, 수정, 삭제)
	 * @return 
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"save"})
	public @ResponseBody HashMap<String, Object> save(Model model, @RequestBody HashMap<String, Object> params) throws Exception{
		
		HashMap<String, Object> result = null;
		
		LoginUsers loginUser = LoginManager.getInstance().getSession(request);
		params.put("loginUser", loginUser.getId());
		
	    result = prdtInOutService.prdtInOutSave(params);

		return result;
	}
}
