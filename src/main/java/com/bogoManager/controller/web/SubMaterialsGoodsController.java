package com.bogoManager.controller.web;

import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

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
import com.bogoManager.domain.Goods;
import com.bogoManager.domain.LoginUsers;
import com.bogoManager.mapper.CommonCodeMapper;
import com.bogoManager.mapper.GoodsMapper;
import com.bogoManager.mapper.SubMaterialsManagementMapper;
import com.bogoManager.model.GoodsModel;
import com.bogoManager.web.excel.ExcelUtil;
import com.bogoManager.web.util.CommonUtil;

@Controller
@RequestMapping(value={"/subMats/"})
public class SubMaterialsGoodsController extends DefaultController{
	@Autowired GoodsMapper goodsMapper;
	@Autowired SubMaterialsManagementMapper subMaterialsMapper;
	@Autowired CommonCodeMapper codeMapper;
	String TILESForder = "materials/subMaterials";
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
    		model.addAttribute("list", goodsMapper.selectGoodsList(paramMap));
		} else {
			Integer pageDataTotal = goodsMapper.selectGoodsPagingCount(paramMap);
			model.addAttribute("pageDataTotal", pageDataTotal);
	    	if(pageDataTotal!=null && pageDataTotal > 0){
	    		paramMap = CommonUtil.pagingNumCheck(paramMap, pageDataTotal);
	    		model.addAttribute("pagingList", goodsMapper.selectGoodsPagingList(paramMap));
	    	}
		}
		model.addAttribute("pageParam", paramMap);

		// 구분
		paramMap.put("group", Constant.STOCK_GUBUN);
		model.addAttribute("stockGubuns", codeMapper.selectCodeList(paramMap));

		// 사용처
		model.addAttribute("usePlaces", subMaterialsMapper.selectUsePlace());

		// 종류
		model.addAttribute("kinds", subMaterialsMapper.selectKinds());

		// 단위
		model.addAttribute("unit", subMaterialsMapper.selectUnit(new HashMap<String, Object>()));

		// 품명
		model.addAttribute("productNames", subMaterialsMapper.selectProductNames(paramMap));

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

    	model.addAttribute("pagingList", goodsMapper.selectGoodsStatistics(paramMap));
		model.addAttribute("pageParam", paramMap);

		return TILESForder+"/statistics"+Constant.TILES;
	}

	/**
	 * 상세보기
	 * @return
	 * @throws UnknownHostException
	 */
	@RequestMapping(value={"form"}, method=RequestMethod.GET)
	public String form(Model model, @RequestParam(required=false) Integer goodsId, @ModelAttribute("goodsModel") GoodsModel goodsModel, HttpSession session) throws UnknownHostException {

    	HashMap<String, Object> paramMap = new HashMap<String, Object>();
    	Goods goods = new Goods();
    	if (goodsId!=null) {
    		goods.setGoodsId(goodsId);
    		goods = goodsMapper.selectGoods(goods);
        	paramMap.put("goodsId", goodsId);
        	paramMap.put("kind", goods.getKind());
        	paramMap.put("modelCar", goods.getModelCar());
        	paramMap.put("productName", goods.getProductName());
        	paramMap.put("subMatId", goods.getSubMatId());
        }else {
        	goods = new Goods();
        }

    	goodsModel.setGoods(goods);
    	
    	LoginUsers user = (LoginUsers)session.getAttribute("userSession");
    	
        if(CommonUtil.isNotEmpty(goods.getGoodsId()) && ((CommonUtil.isNotEmpty(goods.getSubType()) || "OK".equals(goods.getIsCheck()) && "bogo01".equals(user.getId())))) {
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
    public String formSubmit(@Valid @ModelAttribute("goodsModel") GoodsModel goodsModel
            , BindingResult result
            , Model model
            , Locale locale
            , HttpServletRequest request
            ) throws UnknownHostException {
    	HashMap<String, Object> paramMap = new HashMap<String, Object>();
        Integer goodsId = goodsModel.getGoods().getGoodsId();

        if (result.hasFieldErrors()){
        	if (goodsId!=null) {
        		Goods goods = new Goods();
        		goods.setGoodsId(goodsId);
        		goods = goodsMapper.selectGoods(goods);
            	paramMap.put("id", goodsId);
            	paramMap.put("kind", goods.getKind());
            	paramMap.put("modelCar", goods.getModelCar());
            	paramMap.put("productName", goods.getProductName());
            	paramMap.put("subMatId", goods.getSubMatId());
            }
            model = formItem(model, paramMap);
        	return TILESForder+"/form"+Constant.TILES;
        }
        int retCode = 0;
        if (goodsId!=null) {
        	retCode = goodsMapper.updateGoods(goodsModel.getGoods());
        } else {
        	retCode = goodsMapper.insertGoods(goodsModel.getGoods());
        	goodsId = goodsModel.getGoods().getGoodsId();
        }
        if(retCode>0) {
        	model.addAttribute(Constant.RETUN_URL, "/materials/subMaterials/search");
        	model.addAttribute(Constant.MESSAGE_KEY, Constant.MESSAGE_SAVE);
        	model.addAttribute(Constant.CODE_KEY, Constant.OK);
            return "default";
       }else{
    	   Goods goods = new Goods();
			if (goodsId!=null) {
				goods.setGoodsId(goodsId);
				goods = goodsMapper.selectGoods(goods);
            	paramMap.put("goodsId", goodsId);
            	paramMap.put("kind", goods.getKind());
            	paramMap.put("modelCar", goods.getModelCar());
            	paramMap.put("productName", goods.getProductName());
			}
			goodsModel.setGoods(goods);
			model = formItem(model, paramMap);
			return TILESForder+"/materials/subMaterials/form"+Constant.TILES;
       }
    }

	private Model formItem(Model model, HashMap<String, Object> paramMap){

		paramMap.put("group", Constant.STOCK_GUBUN);
		model.addAttribute("stockGubuns", codeMapper.selectCodeList(paramMap));

		// 종류
		model.addAttribute("kinds", subMaterialsMapper.selectKinds());

		List<HashMap<String, Object>> unit = null;
		List<HashMap<String, Object>> productNames = null;

        if (paramMap.get("goodsId")!=null) {
        	unit = subMaterialsMapper.selectUnit(paramMap);
        	productNames = subMaterialsMapper.selectProductNames(paramMap);
        }

		// 차종
		model.addAttribute("unit", unit);

		// 품명
		model.addAttribute("productNames", productNames);

		return model;
	}

/*	@RequestMapping(value="excel")
	public void excel (Model model, @RequestParam HashMap<String, Object> paramMap, HttpServletResponse response, @RequestParam(required=false) String logMsg) throws UnknownHostException{
		try {
			List<?> list = null;
			if(pagegingCheck(paramMap)) {
				list = goodsMapper.selectGoodsList(paramMap);
			} else {
				Integer pageDataTotal = goodsMapper.selectGoodsPagingCount(paramMap);
		    	if(pageDataTotal!=null && pageDataTotal > 0){
		    		list = goodsMapper.selectGoodsPagingList(paramMap);
		    	}
			}
			ExcelDownloadUtil util = new ExcelDownloadUtil();
			String[] keys = {"rownum", "stock_date", "work_type_name" , "kind", "stock_gubun_name", "client", "model_car", "product_name", "lh_rh", "sub_mat_id", "product_id", "quantity2"};
			String[] headers = {"NO", "日期", "白/夜班" , "种类", "区分", "入库社", "車种", "品名", "L/R", "品號1", "品號2", "入库重量"};
			String sheetName = "입출고현황";
			String fileName = "입출고현황.xlsx";

			util.makeExcel(request, response, list, keys, headers, sheetName, fileName);
		}catch (Exception e) {

		}
	}*/

	/**
	 * 리스트
	 * @return
	 * @throws UnknownHostException
	 */
	/*@RequestMapping(value={"statisticsExcel"})
	public void statisticsExcel(Model model, @RequestParam HashMap<String, Object> paramMap, HttpServletResponse response, @RequestParam(required=false) String logMsg) throws UnknownHostException{
		try {
			List<?> list = goodsMapper.selectGoodsStatistics(paramMap);
			ExcelDownloadUtil util = new ExcelDownloadUtil();
			String[] keys = {"rownum", "kind", "client", "model_car", "product_name", "lh_rh", "sub_mat_id", "product_id", "total_quantity"};
			String[] headers = {"NO", "种类", "入库社", "車种", "品名", "L/R", "品號1", "品號2", "重量"};
			String sheetName = "재고현황";
			String fileName = "재고현황.xlsx";

			util.makeExcel(request, response, list, keys, headers, sheetName, fileName);
		}catch (Exception e) {

		}
	}*/
}
