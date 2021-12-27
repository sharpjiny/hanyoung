package com.bogoManager.controller.web;

import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bogoManager.Constant;
import com.bogoManager.controller.DefaultController;
import com.bogoManager.domain.Codes;
import com.bogoManager.domain.PackingEjection;
import com.bogoManager.domain.PackingEjectionProduce;
import com.bogoManager.mapper.CommonCodeMapper;
import com.bogoManager.mapper.PackingEjectionMapper;
import com.bogoManager.mapper.PackingInspectionMapper;
import com.bogoManager.mapper.PackingTotalViewMapper;
import com.bogoManager.mapper.PackingVaccumMapper;
import com.bogoManager.mapper.RawStockManagementMapper;
import com.bogoManager.mapper.VehicleManagementMapper;
import com.bogoManager.model.PackingEjectionModel;
import com.bogoManager.service.PackingEjectionService;
import com.bogoManager.web.util.CommonUtil;

@Controller
@RequestMapping(value={"/production/totalView/"})
public class PackingTotalViewController extends DefaultController{
	@Autowired PackingTotalViewMapper totalViewMapper;
	@Autowired PackingEjectionService ejectionService;

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
	public String list(Model model, @RequestParam HashMap<String, Object> pageParamEje, @RequestParam HashMap<String, Object> pageParamVac, @RequestParam HashMap<String, Object> pageParamIns, @RequestParam(required=false) String logMsg) throws UnknownHostException{
		String jspName = "list";
		if(pagegingCheck(pageParamEje)) {
			jspName = "search";
    		model.addAttribute("listEje", totalViewMapper.selectPackingEjectionTotalList(pageParamEje));
		} /*else {
			Integer pageDataEjeTotal = totalViewMapper.selectPackingEjectionTotalPagingCount(pageParamEje);
			model.addAttribute("pageDataEjeTotal", pageDataEjeTotal);
	    	if(pageDataEjeTotal!=null && pageDataEjeTotal > 0){
	    		pageParamEje = CommonUtil.pagingNumTotalCheck(pageParamEje, pageDataEjeTotal, "Eje");
	    		model.addAttribute("pagingListEje", totalViewMapper.selectPackingEjectionTotalPagingList(pageParamEje));
	    		
	    	}
		}*/
		if(pagegingCheck(pageParamVac)) {
			jspName = "search";
    		model.addAttribute("listVac", totalViewMapper.selectPackingVaccumTotalList(pageParamVac));
		}/* else {
			//model.addAttribute("pagingListVac", totalViewMapper.selectPackingVaccumTotalList(pageParamVac));
			Integer pageDataVacTotal = totalViewMapper.selectPackingVaccumTotalPagingCount(pageParamVac);
			model.addAttribute("pageDataVacTotal", pageDataVacTotal);
	    	if(pageDataVacTotal!=null && pageDataVacTotal > 0){
	    		pageParamVac = CommonUtil.pagingNumTotalCheck(pageParamVac, pageDataVacTotal, "Vac");
	    		model.addAttribute("pagingListVac", totalViewMapper.selectPackingVaccumTotalPagingList(pageParamVac));
	    		
	    	}
		}*/
		if(pagegingCheck(pageParamIns)) {
			jspName = "search";
    		model.addAttribute("listIns", totalViewMapper.selectPackingInspectionTotalList(pageParamIns));
		} /*else {
			Integer pageDataInsTotal = totalViewMapper.selectPackingInspectionTotalPagingCount(pageParamIns);
			model.addAttribute("pageDataInsTotal", pageDataInsTotal);
	    	if(pageDataInsTotal!=null && pageDataInsTotal > 0){
	    		pageParamIns = CommonUtil.pagingNumTotalCheck(pageParamIns, pageDataInsTotal, "Ins");
	    		model.addAttribute("pagingListIns", totalViewMapper.selectPackingInspectionTotalPagingList(pageParamIns));
	    		
	    	}
		}*/
		model.addAttribute("pageParamEje", pageParamEje);
		model.addAttribute("pageParamVac", pageParamVac);
		model.addAttribute("pageParamIns", pageParamIns);

		return TILESForder+"/totalView/"+jspName+Constant.TILES;
	}

	private boolean pagegingCheck(HashMap<String, Object> paramMap) {
		String dateStart = (String) paramMap.get("dateStart");
		String dateEnd = (String) paramMap.get("dateEnd");
		if(CommonUtil.isNotEmpty(dateStart) || CommonUtil.isNotEmpty(dateEnd)) {
			return true;
		}
		return false;
	}

}
