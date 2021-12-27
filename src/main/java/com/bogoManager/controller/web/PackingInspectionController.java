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
import com.bogoManager.domain.PackingInspection;
import com.bogoManager.domain.PackingInspectionProduce;
import com.bogoManager.mapper.CommonCodeMapper;
import com.bogoManager.mapper.PackingInspectionMapper;
import com.bogoManager.mapper.VehicleManagementMapper;
import com.bogoManager.model.PackingInspectionModel;
import com.bogoManager.service.PackingInspectionService;
import com.bogoManager.web.util.CommonUtil;

@Controller
@RequestMapping(value={"/production/inspection/"})
public class PackingInspectionController extends DefaultController{
	@Autowired PackingInspectionMapper inspectionMapper;
	@Autowired PackingInspectionService inspectionService;
	@Autowired VehicleManagementMapper vehicleMapper;
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
    		model.addAttribute("list", inspectionMapper.selectPackingInspectionList(paramMap));
		} else {
			Integer pageDataTotal = inspectionMapper.selectPackingInspectionPagingCount(paramMap);
			model.addAttribute("pageDataTotal", pageDataTotal);
	    	if(pageDataTotal!=null && pageDataTotal > 0){
	    		paramMap = CommonUtil.pagingNumCheck(paramMap, pageDataTotal);
	    		model.addAttribute("pagingList", inspectionMapper.selectPackingInspectionPagingList(paramMap));
	    	}
		}
		model.addAttribute("pageParam", paramMap);

		// 반
		paramMap.put("group", Constant.JAB_CLASS);
		model.addAttribute("jabClasss", codeMapper.selectCodeList(paramMap));

		// 주/야간
		paramMap.put("group", Constant.WORK_TYPE);
		model.addAttribute("workTypes", codeMapper.selectCodeList(paramMap));

		// 종류
		model.addAttribute("kinds", vehicleMapper.selectKinds());

		// 차종
		model.addAttribute("modelCars", vehicleMapper.selectModelCars(paramMap));

		// 품명
		model.addAttribute("productNames", vehicleMapper.selectProductNames(paramMap));

		// L/R
		model.addAttribute("lhRhs", vehicleMapper.selectlhRhs(paramMap));

		return TILESForder+"/inspection/"+jspName+Constant.TILES;
	}

	private boolean pagegingCheck(HashMap<String, Object> paramMap) {
		String dateStart = (String) paramMap.get("dateStart");
		String dateEnd = (String) paramMap.get("dateEnd");
		String workType = (String) paramMap.get("workType");
		String jabClass = (String) paramMap.get("jabClass");
		String kind = (String) paramMap.get("kind");
		String modelCar = (String) paramMap.get("modelCar");
		String lhRh = (String) paramMap.get("lhRh");
		String productName = (String) paramMap.get("productName");
		if(CommonUtil.isNotEmpty(dateStart) || CommonUtil.isNotEmpty(dateEnd) || CommonUtil.isNotEmpty(jabClass) || CommonUtil.isNotEmpty(workType) || CommonUtil.isNotEmpty(kind)
				|| CommonUtil.isNotEmpty(modelCar) || CommonUtil.isNotEmpty(lhRh) || CommonUtil.isNotEmpty(productName)) {
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
	public String form(Model model, @RequestParam(required=false) Integer eId, @ModelAttribute("inspectionModel") PackingInspectionModel inspectionModel) throws UnknownHostException {

		PackingInspection inspection = new PackingInspection();
		List<PackingInspectionProduce> produces = new ArrayList<PackingInspectionProduce>();

    	if (eId!=null) {
    		PackingInspection vo = new PackingInspection();
    		vo.seteId(eId);
    		inspection = inspectionMapper.selectPackingInspection(vo);
    		produces = inspectionMapper.selectPackingInspectionProduce(vo);
        }

    	inspectionModel.setInspection(inspection);
    	inspectionModel.setProduces(produces);

        if(CommonUtil.isNotEmpty(inspection.geteId()) && "OK".equals(inspection.getIsCheck())) {
    		return TILESForder+"/inspection/view"+Constant.TILES;
        } else {
            model = formItem(model, inspectionModel);
    		return TILESForder+"/inspection/form"+Constant.TILES;
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
    public String formSubmit(@Valid @ModelAttribute("inspectionModel") PackingInspectionModel inspectionModel
            , BindingResult result
            , Model model
            , Locale locale
            , HttpServletRequest request
            ) {
    	HashMap<String, Object> paramMap = new HashMap<String, Object>();
        Integer eId = inspectionModel.getInspection().geteId();

        if (result.hasFieldErrors()){
            model = formItem(model, inspectionModel);
        	return TILESForder+"/inspection/form"+Constant.TILES;
        }
        int retCode = 0;
    	try {
    		if (CommonUtil.isNotEmpty(eId)) {
	        	retCode = inspectionService.update(inspectionModel);
	        } else {
				retCode = inspectionService.insert(inspectionModel);
	        }
        } catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        if(retCode>0) {
        	model.addAttribute(Constant.RETUN_URL, "/production/inspection/search");
        	model.addAttribute(Constant.MESSAGE_KEY, Constant.MESSAGE_SAVE);
        	model.addAttribute(Constant.CODE_KEY, Constant.OK);
            return "default";
       }else{
    	   	PackingInspection inspection = new PackingInspection();
    	   	if (CommonUtil.isNotEmpty(eId)) {
				/*PackingInspection vo = new PackingInspection();
				vo.setId(id);
				inspection = inspectionMapper.selectPackingInspection(vo);
	           	paramMap.put("id", id);
	           	paramMap.put("kind", inspection.getKind());
	           	paramMap.put("modelCar", inspection.getModelCar());
	           	paramMap.put("productName", inspection.getProductName());*/
			}
    	   	inspectionModel.setInspection(inspection);
            model = formItem(model, inspectionModel);
			return TILESForder+"/inspection/form"+Constant.TILES;
      }
    }

	private Model formItem(Model model, PackingInspectionModel inspectionModel){
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		List<PackingInspectionProduce> produces = inspectionModel.getProduces();
		if(produces.size() < 10) {
			for(int i = produces.size(); i<10; i++) {
        		produces.add(new PackingInspectionProduce());
			}
		}
        Integer eId = inspectionModel.getInspection().geteId();
        
        if (CommonUtil.isNotEmpty(eId)) paramMap.put("eId", eId);
		for(int i = 0; i < produces.size(); i++) {
			PackingInspectionProduce produce = produces.get(i);
			if(produce.getKind()!=null && produce.getModelCar()!=null && produce.getProductName()!=null) {
	        	paramMap.put("kind", produce.getKind());
	        	paramMap.put("modelCar", produce.getModelCar());
	        	paramMap.put("productName", produce.getProductName());
			}
			produces.set(i, formSubItem(produce, paramMap, i));
        }
        inspectionModel.setProduces(produces);

    	paramMap = new HashMap<String, Object>();

    	// 주/야간
		paramMap.put("group", Constant.WORK_TYPE);
		model.addAttribute("workTypes", codeMapper.selectCodeList(paramMap));

		// 반
		paramMap.put("group", Constant.JAB_CLASS);
		model.addAttribute("jabClasss", codeMapper.selectCodeList(paramMap));

		return model;
	}
	
	private PackingInspectionProduce formSubItem(PackingInspectionProduce produce, HashMap<String, Object> paramMap, int loop){
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
