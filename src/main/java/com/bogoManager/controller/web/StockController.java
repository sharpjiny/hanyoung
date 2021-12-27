package com.bogoManager.controller.web;

import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
import com.bogoManager.domain.LoginUsers;
import com.bogoManager.domain.Stock;
import com.bogoManager.mapper.CommonCodeMapper;
import com.bogoManager.mapper.StockMapper;
import com.bogoManager.mapper.VehicleManagementMapper;
import com.bogoManager.model.StockModel;
import com.bogoManager.web.excel.ExcelUtil;
import com.bogoManager.web.util.CommonUtil;
import com.bogoManager.web.util.LoginManager;
import com.bogoManager.domain.Users;

@Controller
@RequestMapping(value={"/stock/"})
public class StockController extends DefaultController{
	@Autowired StockMapper stockMapper;
	@Autowired VehicleManagementMapper vehicleMapper;
	@Autowired CommonCodeMapper codeMapper;
	String TILESForder = "stock";
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
		String jspName = "list";
		if(pagegingCheck(paramMap)) {
			jspName = "search";
			List<HashMap<String, Object>> list = new ArrayList();
    		String concat = "";
    		list = stockMapper.selectStockList(paramMap);
    		Map<String, String> tmpMap = new LinkedHashMap<String, String>();
    		int loopCnt = 1;
    		String stock_date = "";
			String stock_time = "";
			String car_num = "";
			String work_type_name = "";
			String stock_cnt = "";
    		if(list != null && list.size() > 0){
    			for(int i=0; i<list.size(); i++){
    				if(list.get(i).get("stock_date") != null){
    					stock_date = list.get(i).get("stock_date").toString();
    				}else{
    					stock_date = "";
    				}
    				if(list.get(i).get("stock_time") != null){
    					stock_time = list.get(i).get("stock_time").toString();
    				}else{
    					stock_time = "";
    				}
    				if(list.get(i).get("car_num") != null){
            			car_num = list.get(i).get("car_num").toString();
    				}else{
    					car_num = "";
    				}
    				if(list.get(i).get("work_type_name") != null){
    					work_type_name = list.get(i).get("work_type_name").toString();
    				}else{
    					work_type_name = "";
    				}
    				if(list.get(i).get("stock_cnt") != null){
    					stock_cnt = list.get(i).get("stock_cnt").toString();
    				}else{
    					stock_cnt = "";
    				}
    					
        			if(concat.equals(stock_date+stock_time+car_num+work_type_name+stock_cnt)){
        				loopCnt++;
        				tmpMap.put(concat, loopCnt+"");
        				concat = stock_date+stock_time+car_num+work_type_name+stock_cnt;
        			}else{
        				loopCnt = 1;
        				concat = stock_date+stock_time+car_num+work_type_name+stock_cnt;
        				tmpMap.put(concat, loopCnt+"");
        			}
        		}
    			
    			for(int j=0; j<list.size(); j++){
    				if(list.get(j).get("stock_date") != null){
    					stock_date = list.get(j).get("stock_date").toString();
    				}else{
    					stock_date = "";
    				}
    				if(list.get(j).get("stock_time") != null){
    					stock_time = list.get(j).get("stock_time").toString();
    				}else{
    					stock_time = "";
    				}
    				if(list.get(j).get("car_num") != null){
            			car_num = list.get(j).get("car_num").toString();
    				}else{
    					car_num = "";
    				}
    				if(list.get(j).get("work_type_name") != null){
    					work_type_name = list.get(j).get("work_type_name").toString();
    				}else{
    					work_type_name = "";
    				}
    				if(list.get(j).get("stock_cnt") != null){
    					stock_cnt = list.get(j).get("stock_cnt").toString();
    				}else{
    					stock_cnt = "";
    				}
        			
        			for( String key : tmpMap.keySet() ){
        				if(key.equals(stock_date+stock_time+car_num+work_type_name+stock_cnt)){
        					list.get(j).put("loop_cnt", tmpMap.get(key));
    	    			}
        	        }
        		}
    			
    		}
    		//model.addAttribute("list", stockMapper.selectStockList(paramMap));
    		model.addAttribute("list", list);
		} else {
			Integer pageDataTotal = stockMapper.selectStockPagingCount(paramMap);
			model.addAttribute("pageDataTotal", pageDataTotal);
	    	if(pageDataTotal!=null && pageDataTotal > 0){
	    		paramMap = CommonUtil.pagingNumCheck(paramMap, pageDataTotal);
	    		List<HashMap<String, Object>> list = new ArrayList();
	    		String concat = "";
	    		list = stockMapper.selectStockPagingList(paramMap);
	    		Map<String, String> tmpMap = new LinkedHashMap<String, String>();
	    		int loopCnt = 1;
	    		String stock_date = "";
				String stock_time = "";
				String car_num = "";
				String work_type_name = "";
				String stock_cnt = "";
	    		for(int i=0; i<list.size(); i++){
	    			if(list.get(i).get("stock_date") != null){
	    				stock_date = list.get(i).get("stock_date").toString();
	    			}else{
    					stock_date = "";
    				}
	    			if(list.get(i).get("stock_time") != null){
	    				stock_time = list.get(i).get("stock_time").toString();
	    			}else{
	    				stock_time = "";
    				}
	    			if(list.get(i).get("car_num") != null){
	    				car_num = list.get(i).get("car_num").toString();
	    			}else{
	    				car_num = "";
    				}
	    			if(list.get(i).get("work_type_name") != null){
	    				work_type_name = list.get(i).get("work_type_name").toString();
	    			}else{
	    				work_type_name = "";
    				}
	    			if(list.get(i).get("stock_cnt") != null){
	    				stock_cnt = list.get(i).get("stock_cnt").toString();
	    			}else{
	    				stock_cnt = "";
    				}
	    			
	    			if(concat.equals(stock_date+stock_time+car_num+work_type_name+stock_cnt)){
	    				loopCnt++;
	    				tmpMap.put(concat, loopCnt+"");
	    				concat = stock_date+stock_time+car_num+work_type_name+stock_cnt;
	    			}else{
	    				loopCnt = 1;
	    				concat = stock_date+stock_time+car_num+work_type_name+stock_cnt;
	    				tmpMap.put(concat, loopCnt+"");
	    			}
	    		}
	    		
	    		for(int j=0; j<list.size(); j++){
	    			if(list.get(j).get("stock_date") != null){
    					stock_date = list.get(j).get("stock_date").toString();
    				}else{
    					stock_date = "";
    				}
    				if(list.get(j).get("stock_time") != null){
    					stock_time = list.get(j).get("stock_time").toString();
    				}else{
    					stock_time = "";
    				}
    				if(list.get(j).get("car_num") != null){
            			car_num = list.get(j).get("car_num").toString();
    				}else{
    					car_num = "";
    				}
    				if(list.get(j).get("work_type_name") != null){
    					work_type_name = list.get(j).get("work_type_name").toString();
    				}else{
    					work_type_name = "";
    				}
    				if(list.get(j).get("stock_cnt") != null){
    					stock_cnt = list.get(j).get("stock_cnt").toString();
    				}else{
    					stock_cnt = "";
    				}
	    			
	    			for( String key : tmpMap.keySet() ){
	    				if(key.equals(stock_date+stock_time+car_num+work_type_name+stock_cnt)){
	    					list.get(j).put("loop_cnt", tmpMap.get(key));
		    			}
	    	        }
	    		}
	    		//model.addAttribute("pagingList", stockMapper.selectStockPagingList(paramMap));
	    		model.addAttribute("pagingList", list);
	    	}
		}
		model.addAttribute("pageParam", paramMap);

		// 구분
		paramMap.put("group", Constant.STOCK_GUBUN);
		model.addAttribute("stockGubuns", codeMapper.selectCodeList(paramMap));

		// 주/야간
		paramMap.put("group", Constant.WORK_TYPE);
		model.addAttribute("workTypes", codeMapper.selectCodeList(paramMap));
		
		// 결산월
		paramMap.put("group", Constant.MONTHS);
		model.addAttribute("settlementMonth", codeMapper.selectCodeList(paramMap));

		// 고객사
		model.addAttribute("clients", vehicleMapper.selectClients());

		// 종류
		model.addAttribute("kinds", vehicleMapper.selectKinds());

		// 차종
		model.addAttribute("modelCars", vehicleMapper.selectModelCars(new HashMap<String, Object>()));

		// 품명
		model.addAttribute("productNames", vehicleMapper.selectProductNames(paramMap));

		// L/R
		model.addAttribute("lhRhs", vehicleMapper.selectlhRhs(paramMap));
		
		// isCheck
		paramMap.put("group", Constant.IS_CHECK);
		model.addAttribute("isCheck", codeMapper.selectCodeList(paramMap));

		return TILESForder+"/"+jspName+Constant.TILES;
	}

	private boolean pagegingCheck(HashMap<String, Object> paramMap) {
		String dateStart = (String) paramMap.get("dateStart");
		String dateEnd = (String) paramMap.get("dateEnd");
		String workType = (String) paramMap.get("workType");
		String kind = (String) paramMap.get("kind");
		String modelCar = (String) paramMap.get("modelCar");
		String lhRh = (String) paramMap.get("lhRh");
		String productName = (String) paramMap.get("productName");
		String stockGubun = (String) paramMap.get("stockGubun");
		String client = (String) paramMap.get("client");
		if(CommonUtil.isNotEmpty(dateStart) || CommonUtil.isNotEmpty(dateEnd) || CommonUtil.isNotEmpty(workType) || CommonUtil.isNotEmpty(kind)
				|| CommonUtil.isNotEmpty(modelCar) || CommonUtil.isNotEmpty(lhRh) || CommonUtil.isNotEmpty(productName) || CommonUtil.isNotEmpty(stockGubun) || CommonUtil.isNotEmpty(client)) {
			return true;
		}
		return false;
	}

	/**
	 * 리스트
	 * @return
	 * @throws UnknownHostException
	 */
	@RequestMapping(value={"statistics"})
	public String statistics(Model model, @RequestParam HashMap<String, Object> paramMap, @RequestParam(required=false) String logMsg) throws UnknownHostException{
		
		model.addAttribute("kinds", stockMapper.selectStockkinds(paramMap));

    	model.addAttribute("pagingList", stockMapper.selectStockStatistics(paramMap));
		model.addAttribute("pageParam", paramMap);

		return TILESForder+"/statistics"+Constant.TILES;
	}

	/**
	 * 상세보기
	 * @return
	 * @throws UnknownHostException
	 */
	@RequestMapping(value={"form"}, method=RequestMethod.GET)
	public String form(Model model, @RequestParam(required=false) Integer stockId, @ModelAttribute("stockModel") StockModel stockModel, HttpSession session) throws UnknownHostException {

    	HashMap<String, Object> paramMap = new HashMap<String, Object>();
    	Stock stock = new Stock();
    	if (stockId!=null) {
    		stock.setStockId(stockId);
    		stock = stockMapper.selectStock(stock);
        	paramMap.put("stockId", stockId);
        	paramMap.put("settlementMonth", stock.getSettlementMonth());
        	paramMap.put("stockTime", stock.getStockTime());
        	paramMap.put("kind", stock.getKind());
        	paramMap.put("modelCar", stock.getModelCar());
        	paramMap.put("productName", stock.getProductName());
        	paramMap.put("vehicleId", stock.getVehicleId());
        }else {
        	stock = new Stock();
        }

    	stockModel.setStock(stock);
    	
    	LoginUsers user = (LoginUsers)session.getAttribute("userSession");
    	
        if(CommonUtil.isNotEmpty(stock.getStockId()) && ((CommonUtil.isNotEmpty(stock.getSubType()) || "OK".equals(stock.getIsCheck()) && "bogo01".equals(user.getId())))) {
    		return TILESForder+"/view"+Constant.TILES;
        } else {
            model = formItem(model, paramMap);
    		return TILESForder+"/form"+Constant.TILES;
        }
	}

    /**
     * 서비스 관리 - 등록 및 수정 submit
     * @param cmd
     * @param serviceModel
     * @param result
     * @param model
     * @param locale
     * @param request
     * @return
     * @throws UnknownHostException
     */
    @RequestMapping(value="form", method=RequestMethod.POST)
    public String formSubmit(@Valid @ModelAttribute("stockModel") StockModel stockModel
            , BindingResult result
            , Model model
            , Locale locale
            , HttpServletRequest request
            ) throws UnknownHostException {
    	HashMap<String, Object> paramMap = new HashMap<String, Object>();
        Integer stockId = stockModel.getStock().getStockId();

        if (result.hasFieldErrors()){
        	if (stockId!=null) {
            	Stock stock = new Stock();
        		stock.setStockId(stockId);
        		stock = stockMapper.selectStock(stock);
            	paramMap.put("id", stockId);
            	paramMap.put("settlementMonth", stock.getSettlementMonth());
            	paramMap.put("kind", stock.getKind());
            	paramMap.put("modelCar", stock.getModelCar());
            	paramMap.put("productName", stock.getProductName());
            	paramMap.put("vehicleId", stock.getVehicleId());
            }
            model = formItem(model, paramMap);
        	return TILESForder+"/form"+Constant.TILES;
        }
        int retCode = 0;
        if(stockModel.getStock().getStockTime().equals("____-__-__ __:__")){
    		Stock stock = new Stock();
    		stock = stockModel.getStock();
    		stock.setStockTime(null);
    		stockModel.setStock(stock);
    	}
        if (stockId!=null) {
        	retCode = stockMapper.updateStock(stockModel.getStock());
        } else {
        	retCode = stockMapper.insertStock(stockModel.getStock());
    		stockId = stockModel.getStock().getStockId();
        }
        if(retCode>0) {
        	model.addAttribute(Constant.RETUN_URL, "/stock/search");
        	model.addAttribute(Constant.MESSAGE_KEY, Constant.MESSAGE_SAVE);
        	model.addAttribute(Constant.CODE_KEY, Constant.OK);
            return "default";
       }else{
       		Stock stock = new Stock();
			if (stockId!=null) {
        		stock.setStockId(stockId);
        		stock = stockMapper.selectStock(stock);
            	paramMap.put("stockId", stockId);
            	paramMap.put("settlementMonth", stock.getSettlementMonth());
            	paramMap.put("kind", stock.getKind());
            	paramMap.put("modelCar", stock.getModelCar());
            	paramMap.put("productName", stock.getProductName());
			}
	    	stockModel.setStock(stock);
			model = formItem(model, paramMap);
			return TILESForder+"/stock/form"+Constant.TILES;
       }
    }

	private Model formItem(Model model, HashMap<String, Object> paramMap){

		paramMap.put("group", Constant.STOCK_GUBUN);
		model.addAttribute("stockGubuns", codeMapper.selectCodeList(paramMap));

		paramMap.put("group", Constant.WORK_TYPE);
		model.addAttribute("workTypes", codeMapper.selectCodeList(paramMap));
		
		paramMap.put("group", Constant.MONTHS);
		model.addAttribute("settlementMonth", codeMapper.selectCodeList(paramMap));

		// 종류
		model.addAttribute("kinds", vehicleMapper.selectKinds());

		List<HashMap<String, Object>> modelCars = null;
		List<HashMap<String, Object>> productNames = null;
		List<HashMap<String, Object>> lhRhs = null;

        if (paramMap.get("stockId")!=null) {
        	modelCars = vehicleMapper.selectModelCars(paramMap);
        	productNames = vehicleMapper.selectProductNames(paramMap);
        	lhRhs = vehicleMapper.selectlhRhs(paramMap);
        }

		// 차종
		model.addAttribute("modelCars", modelCars);

		// 품명
		model.addAttribute("productNames", productNames);

		// L/R
		model.addAttribute("lhRhs", lhRhs);
		return model;
	}

	@RequestMapping(value="excel")
	public void excel (Model model, @RequestParam HashMap<String, Object> paramMap, HttpServletResponse response, @RequestParam(required=false) String logMsg) throws UnknownHostException{
		try {
			List<?> list = null;
			if(pagegingCheck(paramMap)) {
				list = stockMapper.selectStockList(paramMap);
			} else {
				Integer pageDataTotal = stockMapper.selectStockPagingCount(paramMap);
		    	if(pageDataTotal!=null && pageDataTotal > 0){
		    		list = stockMapper.selectStockPagingList(paramMap);
		    	}
			}
			ExcelUtil util = new ExcelUtil();
			String[] keys = {"rownum", "stock_date", "work_type_name" , "kind", "stock_gubun_name", "client", "model_car", "product_name", "lh_rh", "vehicle_id", "product_id", "quantity2"};
			String[] headers = {"NO", "日期", "白/夜班" , "种类", "区分", "入库社", "車种", "品名", "L/R", "品號1", "品號2", "入库重量"};
			String sheetName = "입출고현황";
			String fileName = "입출고현황.xlsx";

			util.makeExcel(request, response, list, keys, headers, sheetName, fileName);
		}catch (Exception e) {

		}
	}

	/**
	 * 리스트
	 * @return
	 * @throws UnknownHostException
	 */
	@RequestMapping(value={"statisticsExcel"})
	public void statisticsExcel(Model model, @RequestParam HashMap<String, Object> paramMap, HttpServletResponse response, @RequestParam(required=false) String logMsg) throws UnknownHostException{
		try {
			List<?> list = stockMapper.selectStockStatistics(paramMap);
			ExcelUtil util = new ExcelUtil();
			String[] keys = {"rownum", "kind", "client", "model_car", "product_name", "lh_rh", "vehicle_id", "product_id", "total_quantity"};
			String[] headers = {"NO", "种类", "入库社", "車种", "品名", "L/R", "品號1", "品號2", "重量"};
			String sheetName = "재고현황";
			String fileName = "재고현황.xlsx";

			util.makeExcel(request, response, list, keys, headers, sheetName, fileName);
		}catch (Exception e) {

		}
	}
}
