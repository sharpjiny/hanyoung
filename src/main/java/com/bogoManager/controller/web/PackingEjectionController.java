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
import com.bogoManager.mapper.RawStockManagementMapper;
import com.bogoManager.mapper.VehicleManagementMapper;
import com.bogoManager.model.PackingEjectionModel;
import com.bogoManager.service.PackingEjectionService;
import com.bogoManager.web.util.CommonUtil;

@Controller
@RequestMapping(value={"/production/ejection/"})
public class PackingEjectionController extends DefaultController{
	@Autowired PackingEjectionMapper ejectionMapper;
	@Autowired PackingEjectionService ejectionService;
	@Autowired VehicleManagementMapper vehicleMapper;
	@Autowired RawStockManagementMapper rawStockMapper;

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
	public String list(Model model, @RequestParam HashMap<String, Object> paramMap, @RequestParam(required=false) String logMsg) throws UnknownHostException{
		String jspName = "list";
		if(pagegingCheck(paramMap)) {
			jspName = "search";
    		model.addAttribute("list", ejectionMapper.selectPackingEjectionList(paramMap));
		} else {
			Integer pageDataTotal = ejectionMapper.selectPackingEjectionPagingCount(paramMap);
			model.addAttribute("pageDataTotal", pageDataTotal);
	    	if(pageDataTotal!=null && pageDataTotal > 0){
	    		paramMap = CommonUtil.pagingNumCheck(paramMap, pageDataTotal);
	    		model.addAttribute("pagingList", ejectionMapper.selectPackingEjectionPagingList(paramMap));
	    	}
		}
		model.addAttribute("pageParam", paramMap);

		// 주/야간
		paramMap.put("group", Constant.WORK_TYPE);
		model.addAttribute("workTypes", codeMapper.selectCodeList(paramMap));

		// 반
		paramMap.put("group", Constant.JAB_CLASS);
		model.addAttribute("ejectionGroups", codeMapper.selectCodeList(paramMap));

		// 사출호기
		paramMap.put("group", Constant.EJECTION);
		model.addAttribute("ejections", codeMapper.selectCodeList(paramMap));

		// 종류
		model.addAttribute("kinds", vehicleMapper.selectKinds());

		// 차종
		model.addAttribute("modelCars", vehicleMapper.selectModelCars(paramMap));

		// 품명
		model.addAttribute("productNames", vehicleMapper.selectProductNames(paramMap));

		// L/R
		model.addAttribute("lhRhs", vehicleMapper.selectlhRhs(paramMap));

		// 원재료
		model.addAttribute("rawStocks", ejectionMapper.selectRawStocks(paramMap));

		return TILESForder+"/ejection/"+jspName+Constant.TILES;
	}

	private boolean pagegingCheck(HashMap<String, Object> paramMap) {
		String dateStart = (String) paramMap.get("dateStart");
		String dateEnd = (String) paramMap.get("dateEnd");
		String workType = (String) paramMap.get("workType");
		String kind = (String) paramMap.get("kind");
		String modelCar = (String) paramMap.get("modelCar");
		String lhRh = (String) paramMap.get("lhRh");
		String productName = (String) paramMap.get("productName");
		String ejectionGroup = (String) paramMap.get("ejectionGroup");
		String ejection = (String) paramMap.get("ejection");
		String rawId = (String) paramMap.get("rawId");
		if(CommonUtil.isNotEmpty(dateStart) || CommonUtil.isNotEmpty(dateEnd) || CommonUtil.isNotEmpty(workType) || CommonUtil.isNotEmpty(kind)
				|| CommonUtil.isNotEmpty(modelCar) || CommonUtil.isNotEmpty(lhRh) || CommonUtil.isNotEmpty(productName) || CommonUtil.isNotEmpty(ejectionGroup) || CommonUtil.isNotEmpty(ejection) || CommonUtil.isNotEmpty(rawId)) {
			return true;
		}
		return false;
	}

	/**
	 * 상세보기
	 * @return
	 * @throws UnknownHostException
	 */
	@RequestMapping(value={"form"}, method=RequestMethod.GET)
	public String form(Model model, @RequestParam(required=false) Integer eId, @ModelAttribute("ejectionModel") PackingEjectionModel ejectionModel) throws UnknownHostException {

		PackingEjection ejection = new PackingEjection();
		List<PackingEjectionProduce> produces = new ArrayList<PackingEjectionProduce>();

    	if (eId!=null) {
    		PackingEjection vo = new PackingEjection();
    		vo.seteId(eId);
    		ejection = ejectionMapper.selectPackingEjection(vo);
    		produces = ejectionMapper.selectPackingEjectionProduce(vo);
        }

        ejectionModel.setEjection(ejection);
        ejectionModel.setProduces(produces);

        if(CommonUtil.isNotEmpty(ejection.geteId()) && "OK".equals(ejection.getIsCheck())) {
    		return TILESForder+"/ejection/view"+Constant.TILES;
        } else {
            model = formItem(model, ejectionModel);
    		return TILESForder+"/ejection/form"+Constant.TILES;
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
     * @throws Exception
     */
    @RequestMapping(value="form", method=RequestMethod.POST)
    public String formSubmit(@Valid @ModelAttribute("ejectionModel") PackingEjectionModel ejectionModel
            , BindingResult result
            , Model model
            , Locale locale
            , HttpServletRequest request
            ) {
    	HashMap<String, Object> paramMap = new HashMap<String, Object>();
        Integer eId = ejectionModel.getEjection().geteId();

        if (result.hasFieldErrors()){
            model = formItem(model, ejectionModel);
        	return TILESForder+"/ejection/form"+Constant.TILES;
        }
        int retCode = 0;
    	try {
    		if (CommonUtil.isNotEmpty(eId)) {
	        	retCode = ejectionService.update(ejectionModel);
	        } else {
				retCode = ejectionService.insert(ejectionModel);
	        }
        } catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        if(retCode>0) {
        	model.addAttribute(Constant.RETUN_URL, "/production/ejection/search");
        	model.addAttribute(Constant.MESSAGE_KEY, Constant.MESSAGE_SAVE);
        	model.addAttribute(Constant.CODE_KEY, Constant.OK);
            return "default";
       }else{
    	   	PackingEjection ejection = new PackingEjection();
    	   	if (CommonUtil.isNotEmpty(eId)) {
				/*PackingInspection vo = new PackingInspection();
				vo.setId(id);
				inspection = inspectionMapper.selectPackingInspection(vo);
	           	paramMap.put("id", id);
	           	paramMap.put("kind", inspection.getKind());
	           	paramMap.put("modelCar", inspection.getModelCar());
	           	paramMap.put("productName", inspection.getProductName());*/
			}
			ejectionModel.setEjection(ejection);
            model = formItem(model, ejectionModel);
			return TILESForder+"/ejection/form"+Constant.TILES;
      }
    }

	private Model formItem(Model model, PackingEjectionModel ejectionModel){
    	HashMap<String, Object> paramMap = new HashMap<String, Object>();
		List<PackingEjectionProduce> produces = ejectionModel.getProduces();
		if(produces.size() < 2) {
			for(int i = produces.size(); i<2; i++) {
        		produces.add(new PackingEjectionProduce());
			}
		}
        Integer eId = ejectionModel.getEjection().geteId();
        
        if (CommonUtil.isNotEmpty(eId)) paramMap.put("eId", eId);
		for(int i = 0; i < produces.size(); i++) {
			PackingEjectionProduce produce = produces.get(i);
			if(produce.getKind()!=null && produce.getModelCar()!=null && produce.getProductName()!=null) {
	        	paramMap.put("kind", produce.getKind());
	        	paramMap.put("modelCar", produce.getModelCar());
	        	paramMap.put("productName", produce.getProductName());
			}
			produces.set(i, formSubItem(produce, paramMap, i));
        }
        ejectionModel.setProduces(produces);

    	paramMap = new HashMap<String, Object>();

    	// 주/야간
		paramMap.put("group", Constant.WORK_TYPE);
		model.addAttribute("workTypes", codeMapper.selectCodeList(paramMap));

		// 반
		paramMap.put("group", Constant.JAB_CLASS);
		model.addAttribute("ejectionGroups", codeMapper.selectCodeList(paramMap));

		// 사출호기
		paramMap.put("group", Constant.EJECTION);
		model.addAttribute("ejections", codeMapper.selectCodeList(paramMap));

		// 원재료종류
		model.addAttribute("rawKinds", rawStockMapper.selectRawKinds());
		// 원재료명
		if (CommonUtil.isNotEmpty(eId)) {
			paramMap.put("kind", ejectionModel.getEjection().getRawKind());
			model.addAttribute("rawProducts", rawStockMapper.selectRawProductsRawId(paramMap));
		}
		return model;
	}

	private PackingEjectionProduce formSubItem(PackingEjectionProduce produce, HashMap<String, Object> paramMap, int loop){
		// 종류
		produce.setKinds(vehicleMapper.selectKinds());

		List<HashMap<String, Object>> modelCars = null;
		List<HashMap<String, Object>> productNames = null;
		List<HashMap<String, Object>> lhRhs = null;

		if (CommonUtil.isNotEmpty(paramMap.get("eId"))){
        	modelCars = vehicleMapper.selectModelCars(paramMap);
        	productNames = vehicleMapper.selectProductNames(paramMap);
        	lhRhs = vehicleMapper.selectlhRhs(paramMap);
        }

		// 차종
        produce.setModelCars(modelCars);

		// 품명
        produce.setProductNames(productNames);

		// L/R
        produce.setLhRhs(lhRhs);
		return produce;
	}
}
