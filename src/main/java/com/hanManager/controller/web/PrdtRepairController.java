package com.hanManager.controller.web;

import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.hanManager.Constant;
import com.hanManager.controller.DefaultAjaxController;
import com.hanManager.controller.DefaultController;
import com.hanManager.domain.LoginUsers;
import com.hanManager.domain.SubMaterialsManagement;
import com.hanManager.mapper.CommonCodeMapper;
import com.hanManager.mapper.PrdtRepairMapper;
import java.io.FileOutputStream;
import com.hanManager.service.PrdtRepairService;
import com.hanManager.web.util.LoginManager;

@Controller
@RequestMapping(value={"/production/repair/"})
public class PrdtRepairController extends DefaultAjaxController{
	@Autowired CommonCodeMapper codeMapper;
	@Autowired PrdtRepairService prdtRepairService;
	@Autowired PrdtRepairMapper prdtRepairMapper;
	String TILESForder = "production";
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

		return TILESForder+"/repair/list"+Constant.TILES;
	}
	
	/**
	 * 조회 항목
	 * @return 
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("null")
	@RequestMapping(value={"workTypeSets"})
	public @ResponseBody Map<String, Object> workTypeSets(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("WORK_TYPE", codeMapper.selectCodeList(params));
		
		return result;
	}
	
	@SuppressWarnings("null")
	@RequestMapping(value={"eqpIdSets"})
	public @ResponseBody Map<String, Object> eqpIdSets(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("EQP_ID", codeMapper.selectCodeList(params));
		
		return result;
	}
	
	@SuppressWarnings("null")
	@RequestMapping(value={"brokenParts"})
	public @ResponseBody Map<String, Object> brokenParts(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("BROKEN_PARTS", codeMapper.selectCodeList(params));
		
		return result;
	}
	
	@SuppressWarnings("null")
	@RequestMapping(value={"monthsSets"})
	public @ResponseBody Map<String, Object> monthsSets(Model model, @RequestParam HashMap<String, Object> params) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("MONTHS", codeMapper.selectCodeList(params));
		
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
		
		result = prdtRepairMapper.selectPrdtRepairList(params);
		
		return result;
	}
	
	/**
	 * 저장(추가, 수정, 삭제)
	 * @return 
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"save"})
	public @ResponseBody Map<String, Object> save(@RequestPart(value = "file") MultipartFile file, @RequestPart(value = "params") HashMap<String, Object> params) throws Exception{
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		HashMap<String, Object> rtn = new HashMap<String, Object>();
		
		LoginUsers loginUser = LoginManager.getInstance().getSession(request);
		params.put("CREATE_USER", loginUser.getId());
		
		uploadFile(file, params);
		
	    rtn.put("rtn", prdtRepairService.prdtRepairSave(params));

		return rtn;
	}
	
	@RequestMapping(value={"del"})
	public @ResponseBody Map<String, Object> del(Model model, @RequestBody List<Map<String, Object>> params) throws Exception{
		HashMap<String, Object> rtn = new HashMap<String, Object>();
		int cnt = prdtRepairService.delete(params);
		rtn.put("rtn", cnt);
		
		return rtn;
	}
	
}
