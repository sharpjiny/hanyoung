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

import com.hanManager.Constant;
import com.hanManager.controller.DefaultController;
import com.hanManager.mapper.CommonCodeMapper;
import com.hanManager.mapper.SalesMapper;
import com.hanManager.mapper.VehicleManagementMapper;
import com.hanManager.web.util.CommonUtil;

@Controller
@RequestMapping(value={"/sales/"})
public class SalesController extends DefaultController{
	@Autowired SalesMapper salesMapper;
	@Autowired VehicleManagementMapper vehicleMapper;
	@Autowired CommonCodeMapper codeMapper;
	String TILESForder = "sales";
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

		// 고객사
		model.addAttribute("clients", vehicleMapper.selectClients());
		String yearMonth = (String) paramMap.get("yearMonth");
		if(CommonUtil.isEmpty(yearMonth)) {
			yearMonth = CommonUtil.getYearMonth();
		}
		String lastDay = CommonUtil.getLastDay(yearMonth);

		paramMap.put("yearMonth", yearMonth);
		paramMap.put("sDate", yearMonth+"-01");
		paramMap.put("eDate", yearMonth+"-"+lastDay);

		String vehicleId = (String) paramMap.get("vehicleId");
		List<HashMap<String, Object>> list = null;
		if(CommonUtil.isNotEmpty(vehicleId)) {
			list = salesMapper.selectClientMonthList(paramMap);
		}else {
			list = salesMapper.selectMonthList(paramMap);
		}

		model.addAttribute("list", temp(lastDay, list));
		model.addAttribute("lastDay", lastDay);
		return TILESForder+"/list"+Constant.TILES;
	}
	private List<HashMap<String, Object>> temp(String lastDay, List<HashMap<String, Object>> list) {
		if(CommonUtil.isEmpty(list)) return list;
		String itemId = null;
		int itemKey = 0;
		int itemCnt = 1;
		for(int i=0; i < list.size(); i++){
			HashMap<String, Object> itemMap = list.get(i);
			Integer lastDayInt = Integer.valueOf(lastDay);
			int total = 0;
    		String stockGubun = (String) itemMap.get("stock_gubun");
    		int changeVal = 1;
    		if("s004".equals(stockGubun) || "s008".equals(stockGubun)) changeVal = -1;
			for(int day=1; day<=lastDayInt; day++) {
				String strKey = Integer.toString(day);
	    		if(day < 10) strKey = "0"+strKey;
	    		String quantity = String.valueOf(itemMap.get(strKey));
	    		Integer dayQuantity = Integer.valueOf(quantity);
	    		total += dayQuantity;
    			itemMap.put(strKey, dayQuantity);
    			itemMap.put(strKey+"2", dayQuantity*changeVal);
			}
    		itemMap.put("total", total*changeVal);
    		String vehicle_id = (String) itemMap.get("vehicle_id");
    		if(CommonUtil.isEmpty(itemId)) {
    			itemId = vehicle_id;
    			list.get(itemKey).put("itemCnt", 1);
    		}else if(!vehicle_id.equals(itemId)) {
    			list.get(itemKey).put("itemCnt", itemCnt);
    			itemCnt = 1;
    			itemKey = i;
    			itemId = vehicle_id;
    		} else {
        		itemCnt++;
    		}
		}
		if(itemCnt > 1) {
			list.get(itemKey).put("itemCnt", itemCnt);
		}
		return list;

	}
}
