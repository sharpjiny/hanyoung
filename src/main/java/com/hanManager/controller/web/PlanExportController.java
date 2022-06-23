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
import com.hanManager.mapper.PlanExportMapper;
import com.hanManager.service.PlanExportService;
import com.hanManager.web.util.LoginManager;

@Controller
@RequestMapping(value={"/plan/export/"})
public class PlanExportController extends DefaultController{
	@Autowired CommonCodeMapper codeMapper;
	@Autowired PlanExportService planExportService;
	@Autowired PlanExportMapper planExportMapper;
	String TILESForder = "plan";
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

		return TILESForder+"/export/list"+Constant.TILES;
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
	@RequestMapping(value={"monthSets"})
	public @ResponseBody Map<String, Object> monthSets(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("MONTHS", codeMapper.selectCodeList(params));
		
		return result;
	}
	
	@SuppressWarnings("null")
	@RequestMapping(value={"startCitySets"})
	public @ResponseBody Map<String, Object> startCitySets(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("START_CITY", codeMapper.selectCodeList(params));
		
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
		result.put("PROD_NM", planExportMapper.selectPrdtProdNm(params));
		
		return result;
	}
	
	@SuppressWarnings("null")
	@RequestMapping(value={"prodDtlNmList"})
	public @ResponseBody Map<String, Object> prodDtlNmList(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("PROD_DTL_NM", planExportMapper.selectPrdtProdDtlNm(params));
		
		return result;
	}
	
	@SuppressWarnings("null")
	@RequestMapping(value={"prodIdList"})
	public @ResponseBody Map<String, Object> prodIdList(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("PROD_ID", planExportMapper.selectPrdtProdId(params));
		
		return result;
	}
	
	@SuppressWarnings("null")
	@RequestMapping(value={"getProdIdRowList"})
	public @ResponseBody Map<String, Object> getProdIdRowList(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("PROD_ID_LIST", planExportMapper.getProdIdRowList(params));
		
		return result;
	}
	
	@SuppressWarnings("null")
	@RequestMapping(value={"getPrice"})
	public @ResponseBody Map<String, Object> getPrice(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("PRICE", planExportMapper.getPrice(params));
		return result;
	}
	
	
	/**
	 * 리스트
	 * @return 
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"listV"})
	public @ResponseBody List<HashMap<String, Object>> listV(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		List<HashMap<String, Object>> result = null;
		
		result = planExportMapper.selectPlanExportListV(params);
		
		return result;
	}
	
	/**
	 * 리스트
	 * @return 
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"listE"})
	public @ResponseBody List<HashMap<String, Object>> listE(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		List<HashMap<String, Object>> result = null;
		
		result = planExportMapper.selectPlanExportListE(params);
		
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
		
	    result = planExportService.planExportSave(params);

		return result;
	}
}
