package com.hanManager.controller.web;

import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.List;

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
import com.hanManager.mapper.BomInfoMapper;
import com.hanManager.service.BomInfoService;
import com.hanManager.web.util.LoginManager;

@Controller
@RequestMapping(value={"/set/bomInfo/"})
public class BomInfoController extends DefaultController{
	@Autowired CommonCodeMapper codeMapper;
	@Autowired BomInfoService bomInfoService;
	@Autowired BomInfoMapper bomInfoMapper;
	String TILESForder = "set";
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

		return TILESForder+"/bomInfo/list"+Constant.TILES;
	}
	
	/**
	 * 조회 항목
	 * @return 
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("null")
	@RequestMapping(value={"comboList"})
	public @ResponseBody HashMap<String, Object> comboList(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		HashMap<String, Object> result = null;
		
		result.put("PROD_ID", codeMapper.selectCodeList(params));
		result.put("KIND", codeMapper.selectCodeList(params));
		result.put("PROD_NM", codeMapper.selectCodeList(params));
		result.put("PROD_DTL_NM", codeMapper.selectCodeList(params));
		
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
		
		result = bomInfoMapper.selectBomInfoList(params);
		
		return result;
	}
	
	/**
	 * 리스트
	 * @return 
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"listCoating"})
	public @ResponseBody List<HashMap<String, Object>> listCoating(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		List<HashMap<String, Object>> result = null;
		
		result = bomInfoMapper.selectBomInfoCoatingList(params);
		
		return result;
	}
	
	/**
	 * 리스트
	 * @return 
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"listPacking"})
	public @ResponseBody List<HashMap<String, Object>> listPacking(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		List<HashMap<String, Object>> result = null;
		
		result = bomInfoMapper.selectBomInfoPackingList(params);
		
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
		
	    result = bomInfoService.bomInfoSave(params);

		return result;
	}
	
	/**
	 * 코팅 저장(추가, 수정, 삭제)
	 * @return 
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"saveCoating"})
	public @ResponseBody HashMap<String, Object> saveCoating(Model model, @RequestBody HashMap<String, Object> params) throws Exception{
		
		HashMap<String, Object> result = null;
		
		LoginUsers loginUser = LoginManager.getInstance().getSession(request);
		params.put("loginUser", loginUser.getId());
		
	    result = bomInfoService.bomInfoCoatingSave(params);

		return result;
	}
	
	/**
	 * 포장 저장(추가, 수정, 삭제)
	 * @return 
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"savePacking"})
	public @ResponseBody HashMap<String, Object> savePacking(Model model, @RequestBody HashMap<String, Object> params) throws Exception{
		
		HashMap<String, Object> result = null;
		
		LoginUsers loginUser = LoginManager.getInstance().getSession(request);
		params.put("loginUser", loginUser.getId());
		
	    result = bomInfoService.bomInfoPackingSave(params);

		return result;
	}
}
