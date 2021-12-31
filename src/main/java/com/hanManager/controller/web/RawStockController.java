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
import com.hanManager.mapper.RawStockManagementMapperStatus;
import com.hanManager.mapper.VehicleManagementMapper;
import com.hanManager.web.util.CommonUtil;

@Controller
@RequestMapping(value={"/stock/rawstock/"})
public class RawStockController extends DefaultController{
	@Autowired RawStockManagementMapperStatus rawStockMapperStatus;
	@Autowired RawStockManagementMapper rawStockMapper;
	@Autowired VehicleManagementMapper vehicleMapper;
	@Autowired CommonCodeMapper codeMapper;
	String TILESForder = "stock/rawstock";
	@ModelAttribute("menuType")
	public String type(){
		return TILESForder;
	}

	/**
	 * 원재료 입출고 리스트 조회
	 * @return
	 * @throws UnknownHostException
	 */
	@RequestMapping(value={"search"})
	public String list(Model model, @RequestParam HashMap<String, Object> paramMap, @RequestParam(required=false) String logMsg) throws UnknownHostException{
		String jspName = "list";
		if(pagegingCheck(paramMap)) {
			jspName = "search";
    		model.addAttribute("list", rawStockMapperStatus.selectRawStockPagingList(paramMap));
		} else {
			Integer pageDataTotal = rawStockMapperStatus.selectRawStockPagingCount(paramMap);
			model.addAttribute("pageDataTotal", pageDataTotal);
	    	if(pageDataTotal!=null && pageDataTotal > 0){
	    		paramMap = CommonUtil.pagingNumCheck(paramMap, pageDataTotal);
	    		model.addAttribute("pagingList", rawStockMapperStatus.selectRawStockPagingList(paramMap));
	    	}
		}

		model.addAttribute("pageParam", paramMap);

		// 구분
		paramMap.put("group", Constant.RAW_GUBUN);
		model.addAttribute("stockGubuns", codeMapper.selectCodeList(paramMap));
		
		// 결산월
		paramMap.put("group", Constant.MONTHS);
		model.addAttribute("settlementMonth", codeMapper.selectCodeList(paramMap));

		// 종류
		model.addAttribute("kinds", rawStockMapper.selectRawKinds());
		// 종류
		model.addAttribute("productNames", rawStockMapper.selectRawProducts(paramMap));

		HashMap<String, Object> clientsMap = new HashMap<String, Object>();
		model.addAttribute("clients", rawStockMapper.selectRawClient(clientsMap));

		return TILESForder+"/"+jspName+Constant.TILES;
	}

	/**
	 * 원재료 입출고 리스트 조회조건 유무 체크
	 * @return
	 * @throws UnknownHostException
	 */
	private boolean pagegingCheck(HashMap<String, Object> paramMap) {
		String dateStart = (String) paramMap.get("dateStart");
		String dateEnd = (String) paramMap.get("dateEnd");
		String stockGubun = (String) paramMap.get("stockGubun");
		String kind = (String) paramMap.get("kind");
		String productName = (String) paramMap.get("productName");
		String client = (String) paramMap.get("client");
		String loftNumber = (String) paramMap.get("loftNumber");

		if(CommonUtil.isNotEmpty(dateStart) || CommonUtil.isNotEmpty(dateEnd) || CommonUtil.isNotEmpty(stockGubun) || CommonUtil.isNotEmpty(kind)
				|| CommonUtil.isNotEmpty(productName) || CommonUtil.isNotEmpty(client) || CommonUtil.isNotEmpty(loftNumber) )
		{
			return true;
		}
		return false;
	}

	/**
	 * 원재료재고현황 조회
	 * @return
	 * @throws UnknownHostException
	 */
	@RequestMapping(value={"statistics"})
	public String statistics(Model model, @RequestParam HashMap<String, Object> paramMap, @RequestParam(required=false) String logMsg) throws UnknownHostException{

		model.addAttribute("list", rawStockMapperStatus.selectRawStockStatisticsList(paramMap));
		model.addAttribute("pageParam", paramMap);

		return TILESForder+"/statistics"+Constant.TILES;
	}
}
