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
import com.hanManager.mapper.ProductionProdMapper;
import com.hanManager.service.ProductionProdService;
import com.hanManager.web.util.LoginManager;

@Controller
@RequestMapping(value={"/production/prod/"})
public class ProdcutProdController extends DefaultController{
	@Autowired CommonCodeMapper codeMapper;
	@Autowired ProductionProdService productionProdService;
	@Autowired ProductionProdMapper productionProdMapper;
	String TILESForder = "production";
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

		return TILESForder+"/prod/list"+Constant.TILES;
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
	@RequestMapping(value={"eqpIdSets"})
	public @ResponseBody Map<String, Object> eqpIdSets(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("EQP_ID", codeMapper.selectCodeList(params));
		
		return result;
	}
	
	@SuppressWarnings("null")
	@RequestMapping(value={"areaTypeSets"})
	public @ResponseBody Map<String, Object> areaTypeSets(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("AREA_TYPE", codeMapper.selectCodeList(params));
		
		return result;
	}
	
	@SuppressWarnings("null")
	@RequestMapping(value={"workTypeSets"})
	public @ResponseBody Map<String, Object> workTypeSets(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("WORK_TYPE", codeMapper.selectCodeList(params));
		
		return result;
	}
	
	@SuppressWarnings("null")
	@RequestMapping(value={"prodNmList"})
	public @ResponseBody Map<String, Object> prodNmList(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("PROD_NM", productionProdMapper.selectPrdtProdNm(params));
		
		return result;
	}
	
	@SuppressWarnings("null")
	@RequestMapping(value={"prodDtlNmList"})
	public @ResponseBody Map<String, Object> prodDtlNmList(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("PROD_DTL_NM", productionProdMapper.selectPrdtProdDtlNm(params));
		
		return result;
	}
	
	@SuppressWarnings("null")
	@RequestMapping(value={"prodIdList"})
	public @ResponseBody Map<String, Object> prodIdList(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("PROD_ID", productionProdMapper.selectPrdtProdId(params));
		
		return result;
	}
	
	@SuppressWarnings("null")
	@RequestMapping(value={"getProdDtlList"})
	public @ResponseBody Map<String, Object> getProdDtlList(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("PROD_DTL_LIST", productionProdMapper.getProdDtlList(params));
		
		return result;
	}
	
	@SuppressWarnings("null")
	@RequestMapping(value={"getPrice"})
	public @ResponseBody Map<String, Object> getPrice(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("PRICE", productionProdMapper.getPrice(params));
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
		
		result = productionProdMapper.selectPrdtProdList(params);
		
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
		
	    result = productionProdService.prdtProdSave(params);

		return result;
	}
}
