package com.hanManager.controller.web;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hanManager.Constant;
import com.hanManager.controller.DefaultAjaxController;
import com.hanManager.domain.LoginUsers;
import com.hanManager.domain.PackingEjection;
import com.hanManager.domain.PackingInspection;
import com.hanManager.domain.PackingVaccum;
import com.hanManager.domain.RawStockManagement;
import com.hanManager.domain.RawStockManagementStatus;
import com.hanManager.domain.Stock;
import com.hanManager.domain.SubMaterialsManagement;
import com.hanManager.domain.VehicleManagement;
import com.hanManager.mapper.PackingEjectionMapper;
import com.hanManager.mapper.PackingInspectionMapper;
import com.hanManager.mapper.PackingVaccumMapper;
import com.hanManager.mapper.RawStockManagementMapper;
import com.hanManager.mapper.RawStockManagementMapperStatus;
import com.hanManager.mapper.StockMapper;
import com.hanManager.mapper.SubMaterialsManagementMapper;
import com.hanManager.mapper.VehicleManagementMapper;
import com.hanManager.service.PackingEjectionService;
import com.hanManager.service.PackingInspectionService;
import com.hanManager.service.PackingVaccumService;
import com.hanManager.service.RawStockManagementStatusService;
import com.hanManager.web.util.LoginManager;

@Controller
@RequestMapping(value={"/"})
public class AJaxController extends DefaultAjaxController {

	@Autowired VehicleManagementMapper vehicleMapper;
	@Autowired SubMaterialsManagementMapper subMaterialsMapper;

	@Autowired PackingInspectionMapper inspectionMapper;
	@Autowired PackingInspectionService inspectionService;

	@Autowired StockMapper stockMapper;

	@Autowired RawStockManagementMapper rawStockMapper;
	@Autowired RawStockManagementMapperStatus rawStockMapperStatus;
	@Autowired PackingEjectionMapper ejectionMapper;
	@Autowired PackingEjectionService ejectionService;
	@Autowired PackingVaccumMapper vaccumMapper;
	@Autowired PackingVaccumService vaccumService;
	@Autowired RawStockManagementStatusService rawStockManagementStatusService;
	/**
	 * ????????????????????? ????????????
	 * @return ??????????????????  ??????
	 */
    @RequestMapping(value="set/vehicleSaveAjax")
	public @ResponseBody Map<String, Object> vehicleSaveAjax(@Valid VehicleManagement vehicle, @RequestParam String eventType, BindingResult result, Locale locale) {

    	Map<String, Object> map = new HashMap<String, Object>();
        if (validtion(map, result, locale) == false) {
            return map;
        }
		try {
			VehicleManagement VehicleVo = new VehicleManagement();
    		VehicleVo.setVehicleId(vehicle.getVehicleId());
    		if(vehicleMapper.selectVehicle(VehicleVo)!=null){
    			if("U".equals(eventType)) {
            		map = doResult(map, vehicleMapper.updateVehicle(vehicle), locale);
    			} else {
        	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
                    map.put(Constant.MESSAGE_KEY, msg.getMessage("exsist.id", null, locale));
    			}
    		}else {
    			if("C".equals(eventType)) {
    				map = doResult(map, vehicleMapper.insertVehicle(vehicle), locale);
    			}else {
        	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
                    map.put(Constant.MESSAGE_KEY, msg.getMessage("notexsist.id", null, locale));
    			}
    		}

    	} catch (Exception e) {
	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
            map.put(Constant.MESSAGE_KEY, msg.getMessage("error.db", null, locale));
			log.error("Exception : ", e);
		}
    	return map;
	}

	/**
	 * ????????????????????? ????????????
	 * @return ?????????????????? ??????
	 */
    @RequestMapping(value="set/vehicleDelAjax")
	public @ResponseBody Map<String, Object> vehicleDelAjax(@Valid VehicleManagement vehicle, BindingResult result, Locale locale) {

    	Map<String, Object> map = new HashMap<String, Object>();
        if (validtion(map, result, locale) == false) {
            return map;
        }
		try {
			VehicleManagement VehicleVo = new VehicleManagement();
    		VehicleVo.setVehicleId(vehicle.getVehicleId());
    		VehicleVo = vehicleMapper.selectVehicle(VehicleVo);
    		if(VehicleVo==null){
    	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
                map.put(Constant.MESSAGE_KEY, msg.getMessage("notexsist.id", null, locale));
    		} else {
    			// ????????? ??????
    			Integer useCnt = inspectionMapper.useVehicle(VehicleVo.getVehicleId());
    			if(useCnt!=null && useCnt > 0){
        	    	map.put(Constant.CODE_KEY, Constant.USE_DATA);
                    map.put(Constant.MESSAGE_KEY, "???????????? ?????????????????? ?????????.");
        		}else {
            		map = doResult(map, vehicleMapper.deleteVehicle(vehicle), locale);
        		}
    		}

    	} catch (Exception e) {
	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
            map.put(Constant.MESSAGE_KEY, msg.getMessage("error.db", null, locale));
			log.error("Exception : ", e);
		}
    	return map;
	}

	/**
	 * ????????????????????? ????????????
	 * @return ?????????????????? ??????
	 */
    @RequestMapping(value="set/getVehicleAjax")
	public @ResponseBody Map<String, Object> getVehicleAjax(@Valid VehicleManagement vehicle, BindingResult result, Locale locale) {
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	try{
	    	map.put("vehicle", vehicleMapper.selectVehicle(vehicle));
		}catch (Exception e) {
			log.error("Exception : ", e);
		}
    	return map;
	}

	/**
	 * ????????????????????? ????????????
	 * @return ?????????????????? ??????
	 */
    @RequestMapping(value="set/getVehicleListAjax")
	public @ResponseBody Map<String, Object> getVehicleListAjax(@RequestParam HashMap<String, Object> paramMap) {
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	try{
    		map.put("list", vehicleMapper.selectVehicleList(paramMap));
		}catch (Exception e) {
			log.error("Exception : ", e);
		}
    	return map;
	}

	/**
	 * ??????????????? ????????????
	 * @return ???????????? ??????
	 */
    @RequestMapping(value="inspection/inspectionDelAjax")
	public @ResponseBody Map<String, Object> inspectionDelAjax(@RequestParam HashMap<String, Object> paramMap, Locale locale) {
    	Map<String, Object> map = new HashMap<String, Object>();
		try {
			PackingInspection inspectionVO = new PackingInspection();
			Integer eId = Integer.parseInt((String) paramMap.get("eId"));
			inspectionVO.seteId(eId);
    		if(inspectionMapper.selectPackingInspection(inspectionVO)==null){
    	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
                map.put(Constant.MESSAGE_KEY, msg.getMessage("notexsist.id", null, locale));
    		}else {
        		map = doResult(map, inspectionService.delete(paramMap), locale);
    		}

    	} catch (Exception e) {
	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
            map.put(Constant.MESSAGE_KEY, msg.getMessage("error.db", null, locale));
			log.error("Exception : ", e);
		}
    	return map;
	}

	/**
	 * ??????????????? ????????????
	 * @return ???????????? ??????
	 */
    @RequestMapping(value="inspection/inspectionCheckAjax")
	public @ResponseBody Map<String, Object> inspectionCheckAjax(@Valid PackingInspection packingInspection, BindingResult result, Locale locale) {
    	Map<String, Object> map = new HashMap<String, Object>();
        if (validtion(map, result, locale) == false) {
            return map;
        }
		try {
			PackingInspection inspectionVO = new PackingInspection();
			inspectionVO.seteId(packingInspection.geteId());
    		if(inspectionMapper.selectPackingInspection(inspectionVO)==null){
    	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
                map.put(Constant.MESSAGE_KEY, "???????????? ?????? ????????? ?????????.");
    		}else {
    			// ????????? ?????? ??????
    			LoginUsers loginUser = LoginManager.getInstance().getSession(request);
    			packingInspection.setCheckUser(loginUser.getId());
    			packingInspection.setIsCheck(Constant.MESSAGE_OK);
        		map = doResult(map, inspectionService.confirm(packingInspection), locale);
    		}

    	} catch (Exception e) {
	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
            map.put(Constant.MESSAGE_KEY, msg.getMessage("error.db", null, locale));
			log.error("Exception : ", e);
		}
    	return map;
	}

	/**
	 * ?????? ????????? ????????????
	 * @return ?????? ?????????
	 */
    @RequestMapping(value="vehicle/selectModelCarsAjax")
	public @ResponseBody Map<String, Object> selectModelCarsAjax(@RequestParam HashMap<String, Object> paramMap) {
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	try{
    		map.put("list", vehicleMapper.selectModelCars(paramMap));
		}catch (Exception e) {
			log.error("Exception : ", e);
		}
    	return map;
	}

	/**
	 * ?????? ????????? ????????????
	 * @return ?????? ?????????
	 */
    @RequestMapping(value="vehicle/selectProductNamesAjax")
	public @ResponseBody Map<String, Object> selectProductNamesAjax(@RequestParam HashMap<String, Object> paramMap) {
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	try{
    		map.put("list", vehicleMapper.selectProductNames(paramMap));
		}catch (Exception e) {
			log.error("Exception : ", e);
		}
    	return map;
	}

	/**
	 * L/R ????????? ????????????
	 * @return L/R ?????????
	 */
    @RequestMapping(value="vehicle/selectlhRhsAjax")
	public @ResponseBody Map<String, Object> selectlhRhsAjax(@RequestParam HashMap<String, Object> paramMap) {
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	try{
    		map.put("list", vehicleMapper.selectlhRhs(paramMap));
		}catch (Exception e) {
			log.error("Exception : ", e);
		}
    	return map;
	}

	/**
	 * ??????????????? ????????????
	 * @return ???????????? ??????
	 */
    @RequestMapping(value="stock/stockCheckAjax")
	public @ResponseBody Map<String, Object> stockCheckAjax(@Valid Stock stock, BindingResult result, Locale locale) {
    	Map<String, Object> map = new HashMap<String, Object>();
        if (validtion(map, result, locale) == false) {
            return map;
        }
		try {
			Stock stockVO = new Stock();
			stockVO.setStockId(stock.getStockId());
    		if(stockMapper.selectStock(stockVO)==null){
    	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
                map.put(Constant.MESSAGE_KEY, "???????????? ?????? ????????? ?????????.");
    		}else {
    			// ????????? ?????? ??????
    			LoginUsers loginUser = LoginManager.getInstance().getSession(request);
    			stock.setCheckUser(loginUser.getId());
    			stock.setIsCheck(Constant.MESSAGE_OK);
        		map = doResult(map, stockMapper.confirmStock(stock), locale);
    		}

    	} catch (Exception e) {
	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
            map.put(Constant.MESSAGE_KEY, msg.getMessage("error.db", null, locale));
			log.error("Exception : ", e);
		}
    	return map;
	}

	/**
	 * ??????????????? ????????????
	 * @return ???????????? ??????
	 */
    @RequestMapping(value="stock/stockDelAjax")
	public @ResponseBody Map<String, Object> stockDelAjax(@Valid Stock stock, BindingResult result, Locale locale) {
    	Map<String, Object> map = new HashMap<String, Object>();
        if (validtion(map, result, locale) == false) {
            return map;
        }
		try {
			Stock stockVO = new Stock();
			stockVO.setStockId(stock.getStockId());
    		if(stockMapper.selectStock(stockVO)==null){
    	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
                map.put(Constant.MESSAGE_KEY, msg.getMessage("notexsist.id", null, locale));
    		}else {
        		map = doResult(map, stockMapper.deleteStock(stock), locale);
    		}

    	} catch (Exception e) {
	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
            map.put(Constant.MESSAGE_KEY, msg.getMessage("error.db", null, locale));
			log.error("Exception : ", e);
		}
    	return map;
	}

	/**
	 * ????????????????????? ????????????
	 * @return ?????????????????? ??????
	 */
    @RequestMapping(value="set/getRawStockAjax")
	public @ResponseBody Map<String, Object> getRawStockAjax(@Valid RawStockManagement rawStock, BindingResult result, Locale locale) {
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	try{
	    	map.put("rawStock", rawStockMapper.selectRawStock(rawStock));
		}catch (Exception e) {
			log.error("Exception : ", e);
		}
    	return map;
	}

	/**
	 * ???????????? ????????????
	 * @return ?????????  ??????
	 */
    @RequestMapping(value="set/rawStockSaveAjax")
	public @ResponseBody Map<String, Object> rawStockSaveAjax(@Valid RawStockManagement rawStock, @RequestParam String eventType, BindingResult result, Locale locale) {

    	Map<String, Object> map = new HashMap<String, Object>();
        if (validtion(map, result, locale) == false) {
            return map;
        }
		try {
			RawStockManagement rawStockVO = new RawStockManagement();
    		rawStockVO.setRawId(rawStock.getRawId());
    		RawStockManagement asis = rawStockMapper.selectRawStock(rawStockVO);
    		if(asis!=null){
    			if("U".equals(eventType)) {
    				int ret = rawStockManagementStatusService.update(asis, rawStock);
    				if(ret >= 0 ) {
    					map.put(Constant.CODE_KEY, Constant.OK);
        				map.put(Constant.MESSAGE_KEY, Constant.MESSAGE_OK);
    				} else {
    					map.put(Constant.CODE_KEY, Constant.ERROR_DB);
    					map.put(Constant.MESSAGE_KEY, msg.getMessage("error.db", null, locale));
    				}
    				
    			} else {
        	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
                    map.put(Constant.MESSAGE_KEY, msg.getMessage("exsist.id", null, locale));
    			}
    		}else {
    			if("C".equals(eventType)) {
    				map = doResult(map, rawStockMapper.insertRawStock(rawStock), locale);
    			}else {
        	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
                    map.put(Constant.MESSAGE_KEY, msg.getMessage("notexsist.id", null, locale));
    			}
    		}

    	} catch (Exception e) {
	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
            map.put(Constant.MESSAGE_KEY, msg.getMessage("error.db", null, locale));
			log.error("Exception : ", e);
		}
    	return map;
	}
	/**
	 * ???????????? ????????????
	 * @return ????????? ??????
	 */
    @RequestMapping(value="set/rawStockDelAjax")
	public @ResponseBody Map<String, Object> rawStockDelAjax(@Valid RawStockManagement rawStock, BindingResult result, Locale locale) {

    	Map<String, Object> map = new HashMap<String, Object>();
        if (validtion(map, result, locale) == false) {
            return map;
        }
		try {
			RawStockManagement rawStockVO = new RawStockManagement();
    		rawStockVO.setRawId(rawStock.getRawId());
    		rawStockVO = rawStockMapper.selectRawStock(rawStockVO);
    		if(rawStockVO==null){
    	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
                map.put(Constant.MESSAGE_KEY, msg.getMessage("notexsist.id", null, locale));
    		} else {
    			// ????????? ??????
    			Integer useCnt = ejectionMapper.useEjection(rawStock.getRawId());
    			if(useCnt!=null && useCnt > 0){
        	    	map.put(Constant.CODE_KEY, Constant.USE_DATA);
                    map.put(Constant.MESSAGE_KEY, "???????????? ????????? ?????????.");
        		}else {
            		map = doResult(map, rawStockMapper.deleteRawStock(rawStock), locale);
        		}
    		}

    	} catch (Exception e) {
	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
            map.put(Constant.MESSAGE_KEY, msg.getMessage("error.db", null, locale));
			log.error("Exception : ", e);
		}
    	return map;
	}

	/**
	 * ???????????? ?????????
	 * @return ????????? ?????????
	 */
    @RequestMapping(value="production/ejection/selectRawStocksAjax")
	public @ResponseBody Map<String, Object> selectRawStocksAjax(@RequestParam HashMap<String, Object> paramMap, Locale locale) {
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	try{
	    	map.put("list", ejectionMapper.selectRawStocks(paramMap));
		}catch (Exception e) {
			log.error("Exception : ", e);
		}
    	return map;
	}

	/**
	 * ???????????? ?????????
	 * @return ???????????? ?????????
	 */
    @RequestMapping(value="set/rawStock/getComboRawStocksAjax")
	public @ResponseBody Map<String, Object> getComboRawStocksAjax(@RequestParam HashMap<String, Object> paramMap, Locale locale) {
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	try{
    		map.put("list", rawStockMapper.selectRawProductsRawId(paramMap));
		}catch (Exception e) {
			log.error("Exception : ", e);
		}
    	return map;
	}

	/**
	 * ??????????????? ????????????
	 * @return ???????????? ??????
	 */
    @RequestMapping(value="ejection/ejectionDelAjax")
	public @ResponseBody Map<String, Object> ejectionDelAjax(@RequestParam HashMap<String, Object> paramMap, Locale locale) {
    	Map<String, Object> map = new HashMap<String, Object>();
		try {
			PackingEjection ejectionVO = new PackingEjection();
			Integer eId = Integer.parseInt((String) paramMap.get("eId"));
			ejectionVO.seteId(eId);
    		if(ejectionMapper.selectPackingEjection(ejectionVO)==null){
    	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
                map.put(Constant.MESSAGE_KEY, msg.getMessage("notexsist.id", null, locale));
    		}else {
        		map = doResult(map, ejectionService.delete(paramMap), locale);
    		}

    	} catch (Exception e) {
	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
            map.put(Constant.MESSAGE_KEY, msg.getMessage("error.db", null, locale));
			log.error("Exception : ", e);
		}
    	return map;
	}
    
    /**
	 * ??????????????? ????????????
	 * @return ???????????? ??????
	 */
    @RequestMapping(value="vaccum/vaccumDelAjax")
	public @ResponseBody Map<String, Object> vaccumDelAjax(@RequestParam HashMap<String, Object> paramMap, Locale locale) {
    	Map<String, Object> map = new HashMap<String, Object>();
		try {
			PackingVaccum vaccumVO = new PackingVaccum();
			Integer eId = Integer.parseInt((String) paramMap.get("eId"));
			vaccumVO.seteId(eId);
    		if(vaccumMapper.selectPackingVaccum(vaccumVO)==null){
    	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
                map.put(Constant.MESSAGE_KEY, msg.getMessage("notexsist.id", null, locale));
    		}else {
        		map = doResult(map, vaccumService.delete(paramMap), locale);
    		}

    	} catch (Exception e) {
	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
            map.put(Constant.MESSAGE_KEY, msg.getMessage("error.db", null, locale));
			log.error("Exception : ", e);
		}
    	return map;
	}

	/**
	 * ??????????????? ????????????
	 * @return ???????????? ??????
	 */
    @RequestMapping(value="ejection/ejectionCheckAjax")
	public @ResponseBody Map<String, Object> ejectionCheckAjax(@Valid PackingEjection packingEjection, BindingResult result, Locale locale) {
    	Map<String, Object> map = new HashMap<String, Object>();
        if (validtion(map, result, locale) == false) {
            return map;
        }
		try {
			PackingEjection ejectionVO = new PackingEjection();
			ejectionVO.seteId(packingEjection.geteId());
    		if(ejectionMapper.selectPackingEjection(ejectionVO)==null){
    	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
                map.put(Constant.MESSAGE_KEY, "???????????? ?????? ????????? ?????????.");
    		}else {
    			// ????????? ?????? ??????
    			LoginUsers loginUser = LoginManager.getInstance().getSession(request);
    			packingEjection.setCheckUser(loginUser.getId());
    			packingEjection.setIsCheck(Constant.MESSAGE_OK);
        		map = doResult(map, ejectionService.confirm(packingEjection), locale);
    		}

    	} catch (Exception e) {
	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
            map.put(Constant.MESSAGE_KEY, msg.getMessage("error.db", null, locale));
			log.error("Exception : ", e);
		}
    	return map;
	}
    
    /**
	 * ??????????????? ????????????
	 * @return ???????????? ??????
	 */
    @RequestMapping(value="vaccum/vaccumCheckAjax")
	public @ResponseBody Map<String, Object> vaccumCheckAjax(@Valid PackingVaccum packingVaccum, BindingResult result, Locale locale) {
    	Map<String, Object> map = new HashMap<String, Object>();
        if (validtion(map, result, locale) == false) {
            return map;
        }
		try {
			PackingVaccum vaccumVO = new PackingVaccum();
			vaccumVO.seteId(packingVaccum.geteId());
    		if(vaccumMapper.selectPackingVaccum(vaccumVO)==null){
    	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
                map.put(Constant.MESSAGE_KEY, "???????????? ?????? ????????? ?????????.");
    		}else {
    			// ????????? ?????? ??????
    			LoginUsers loginUser = LoginManager.getInstance().getSession(request);
    			packingVaccum.setCheckUser(loginUser.getId());
    			packingVaccum.setIsCheck(Constant.MESSAGE_OK);
        		map = doResult(map, vaccumService.confirm(packingVaccum), locale);
    		}

    	} catch (Exception e) {
	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
            map.put(Constant.MESSAGE_KEY, msg.getMessage("error.db", null, locale));
			log.error("Exception : ", e);
		}
    	return map;
	}


	/**
	 * ?????? ????????? ????????????
	 * @return ?????? ?????????
	 */
    @RequestMapping(value="rawProductName/selectRawProducts")
	public @ResponseBody Map<String, Object> selectRawProductNameAjax(@RequestParam HashMap<String, Object> paramMap) {
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	try{
    		map.put("list", rawStockMapper.selectRawProducts(paramMap));
		}catch (Exception e) {
			log.error("Exception : ", e);
		}
    	return map;
	}

	/**
	 * ?????? ????????? ????????????
	 * @return ?????? ?????????
	 */
    @RequestMapping(value="rawProductName/selectRawClient")
	public @ResponseBody Map<String, Object> selectRawClientAjax(@RequestParam HashMap<String, Object> paramMap) {
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	try{
    		map.put("list", rawStockMapper.selectRawClient(paramMap));
		}catch (Exception e) {
			log.error("Exception : ", e);
		}
    	return map;
	}

	/**
	 * ?????? ????????? ????????????
	 * @return ?????? ?????????
	 */
    @RequestMapping(value="rawProductName/selectPrice")
	public @ResponseBody Map<String, Object> selectPriceAjax(@RequestParam HashMap<String, Object> paramMap) {
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	try{
    		map.put("obj", rawStockMapper.selectRawPrice(paramMap));
		}catch (Exception e) {
			log.error("Exception : ", e);
		}
    	return map;
	}

    /**
	 * ????????? ????????? ?????? ??????
	 * @return ????????? ?????????
	 */
    @RequestMapping(value="stock/rowstock/getRawStockAjax")
    public @ResponseBody Map<String, Object> stockRawStockAjax(@Valid RawStockManagementStatus rawStock, BindingResult result, Locale locale) {
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	try{
    		RawStockManagementStatus status =rawStockMapperStatus.selectRawStock(rawStock);
	    	map.put("rawStock", status);
		}catch (Exception e) {
			log.error("Exception : ", e);
		}
    	return map;
    }

    /**
	 * ????????? ????????? ?????? ??????
	 * @return ????????? ????????? ???????????? ??????
	 */
    @RequestMapping(value="stock/rowstock/rawStockIsCheckOkAjax")
	public @ResponseBody Map<String, Object> stockRawStockIsCheckOkAjax(@Valid RawStockManagementStatus rawStock, @RequestParam String eventType, BindingResult result, Locale locale) {

    	Map<String, Object> map = new HashMap<String, Object>();
		try {
			map = doResult(map, rawStockMapperStatus.updateRawStockIsCheckOk(rawStock), locale);

    	} catch (Exception e) {
	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
            map.put(Constant.MESSAGE_KEY, msg.getMessage("error.db", null, locale));
			log.error("Exception : ", e);
		}
    	return map;
	}

    /**
     * ????????? ????????? ????????? ?????? ??? ??????
     * @return ????????? ????????? ?????????
     */
    @RequestMapping(value="stock/rowstock/rawStockSaveAjax")
    public @ResponseBody Map<String, Object> stockRawStockSaveAjax(@Valid RawStockManagementStatus rawStock, @RequestParam String eventType, BindingResult result, Locale locale) {

    	Map<String, Object> map = new HashMap<String, Object>();
    	if (validtion(map, result, locale) == false) {
    		return map;
    	}
    	try {
    		RawStockManagementStatus rawStockVO = new RawStockManagementStatus();
    		rawStockVO.setIdx(rawStock.getIdx());

			Double realPrice  = rawStock.getPrice()*rawStock.getWeight();
			rawStock.setRealPrice(realPrice);

    		if(rawStockMapperStatus.selectRawStock(rawStockVO)!=null){
    			if("U".equals(eventType)) {
    				map = doResult(map, rawStockMapperStatus.updateRawStock(rawStock), locale);
    			} else {
    				map.put(Constant.CODE_KEY, Constant.ERROR_DB);
    				map.put(Constant.MESSAGE_KEY, msg.getMessage("exsist.id", null, locale));
    			}
    		}else {
    			if("C".equals(eventType)) {
    				map = doResult(map, rawStockMapperStatus.insertRawStock(rawStock), locale);
    			}else {
    				map.put(Constant.CODE_KEY, Constant.ERROR_DB);
    				map.put(Constant.MESSAGE_KEY, msg.getMessage("notexsist.id", null, locale));
    			}
    		}

    	} catch (Exception e) {
    		map.put(Constant.CODE_KEY, Constant.ERROR_DB);
    		map.put(Constant.MESSAGE_KEY, msg.getMessage("error.db", null, locale));
    		log.error("Exception : ", e);
    	}
    	return map;
    }

    /**
     * ????????? ????????? ????????? ??????
     * @return ????????? ????????? ?????????
     */
    @RequestMapping(value="stock/rowstock/rawStockDeleteAjax")
    public @ResponseBody Map<String, Object> stockRawStockDeleteAjax(@Valid RawStockManagementStatus rawStock, Locale locale) {

    	Map<String, Object> map = new HashMap<String, Object>();

    	try {
    		map = doResult(map, rawStockMapperStatus.deleteRawStock(rawStock), locale);
    	} catch (Exception e) {
    		map.put(Constant.CODE_KEY, Constant.ERROR_DB);
    		map.put(Constant.MESSAGE_KEY, msg.getMessage("error.db", null, locale));
    		log.error("Exception : ", e);
    	}
    	return map;
    }
    
    /**
	 * ???????????? ????????????
	 * @return ?????????  ??????
	 */
    @RequestMapping(value="set/subMatSaveAjax")
	public @ResponseBody Map<String, Object> subMatSaveAjax(@Valid SubMaterialsManagement subMat, @RequestParam String eventType, BindingResult result, Locale locale) {

    	Map<String, Object> map = new HashMap<String, Object>();
        if (validtion(map, result, locale) == false) {
            return map;
        }
		try {
			SubMaterialsManagement SubMatVo = new SubMaterialsManagement();
			SubMatVo.setSubMatId(subMat.getSubMatId());
    		if(subMaterialsMapper.selectSubMat(SubMatVo)!=null){
    			if("U".equals(eventType)) {
            		map = doResult(map, subMaterialsMapper.updateSubMat(subMat), locale);
    			} else {
        	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
                    map.put(Constant.MESSAGE_KEY, msg.getMessage("exsist.id", null, locale));
    			}
    		}else {
    			if("C".equals(eventType)) {
    				map = doResult(map, subMaterialsMapper.insertSubMat(subMat), locale);
    			}else {
        	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
                    map.put(Constant.MESSAGE_KEY, msg.getMessage("notexsist.id", null, locale));
    			}
    		}

    	} catch (Exception e) {
	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
            map.put(Constant.MESSAGE_KEY, msg.getMessage("error.db", null, locale));
			log.error("Exception : ", e);
		}
    	return map;
	}

	/**
	 * ???????????? ????????????
	 * @return ????????? ??????
	 */
    @RequestMapping(value="set/subMatDelAjax")
	public @ResponseBody Map<String, Object> subMatDelAjax(@Valid SubMaterialsManagement subMat, BindingResult result, Locale locale) {

    	Map<String, Object> map = new HashMap<String, Object>();
        if (validtion(map, result, locale) == false) {
            return map;
        }
		try {
			SubMaterialsManagement SubMatVo = new SubMaterialsManagement();
			SubMatVo.setSubMatId(subMat.getSubMatId());
			SubMatVo = subMaterialsMapper.selectSubMat(SubMatVo);
    		if(SubMatVo==null){
    	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
                map.put(Constant.MESSAGE_KEY, msg.getMessage("notexsist.id", null, locale));
    		} else {
    			// ????????? ??????(????????? ????????? ????????? ????????? ??????)
    			/*Integer useCnt = inspectionMapper.useVehicle(SubMatVo.getSubMatId());
    			if(useCnt!=null && useCnt > 0){
        	    	map.put(Constant.CODE_KEY, Constant.USE_DATA);
                    map.put(Constant.MESSAGE_KEY, "???????????? ?????????????????? ?????????.");
        		}else {
            		map = doResult(map, subMaterialsMapper.deleteSubMat(subMat), locale);
        		}*/
    			map = doResult(map, subMaterialsMapper.deleteSubMat(subMat), locale);
    		}

    	} catch (Exception e) {
	    	map.put(Constant.CODE_KEY, Constant.ERROR_DB);
            map.put(Constant.MESSAGE_KEY, msg.getMessage("error.db", null, locale));
			log.error("Exception : ", e);
		}
    	return map;
	}

	/**
	 * ???????????? ????????????
	 * @return ????????? ??????
	 */
    @RequestMapping(value="set/getSubMatAjax")
	public @ResponseBody Map<String, Object> getSubMatAjax(@Valid SubMaterialsManagement subMat, BindingResult result, Locale locale) {
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	try{
	    	map.put("subMat", subMaterialsMapper.selectSubMat(subMat));
		}catch (Exception e) {
			log.error("Exception : ", e);
		}
    	return map;
	}

	/**
	 * ???????????? ????????????
	 * @return ????????? ??????
	 */
    @RequestMapping(value="set/getSubMatListAjax")
	public @ResponseBody Map<String, Object> getSubMatListAjax(@RequestParam HashMap<String, Object> paramMap) {
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	try{
    		map.put("list", subMaterialsMapper.selectSubMatList(paramMap));
		}catch (Exception e) {
			log.error("Exception : ", e);
		}
    	return map;
	}
    
	/**
	 * ????????? ?????? ????????? ????????????
	 * @return ?????? ?????????
	 */
    @RequestMapping(value="subMat/selectUnitAjax")
	public @ResponseBody Map<String, Object> selectUnitAjax(@RequestParam HashMap<String, Object> paramMap) {
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	try{
    		map.put("list", subMaterialsMapper.selectUnit(paramMap));
		}catch (Exception e) {
			log.error("Exception : ", e);
		}
    	return map;
	}
    
    /**
	 * ??????????????? ????????? ????????????
	 * @return ?????? ?????????
	 */
    @RequestMapping(value="subMat/selectMatProductNamesAjax")
	public @ResponseBody Map<String, Object> selectMatProductNamesAjax(@RequestParam HashMap<String, Object> paramMap) {
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	try{
    		map.put("list", subMaterialsMapper.selectProductNames(paramMap));
		}catch (Exception e) {
			log.error("Exception : ", e);
		}
    	return map;
	}
    
}
