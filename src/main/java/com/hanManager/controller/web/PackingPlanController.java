package com.hanManager.controller.web;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hanManager.Constant;
import com.hanManager.controller.DefaultController;
import com.hanManager.mapper.CommonCodeMapper;
import com.hanManager.mapper.PackingPlanMapper;
import com.hanManager.mapper.VehicleManagementMapper;
import com.hanManager.service.ExcelServiceImpl;
import com.hanManager.web.util.CommonUtil;

@Controller
@RequestMapping(value={"/production/plan/"})
public class PackingPlanController extends DefaultController{
	@Autowired PackingPlanMapper packingPlan;
	@Autowired ExcelServiceImpl excelService;
	@Autowired CommonCodeMapper codeMapper;
	@Autowired VehicleManagementMapper vehicleMapper;
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
		
		
		model.addAttribute("pageParam", paramMap);
		model.addAttribute("pagingList", packingPlan.selectPackingPlanList(paramMap));
		
		// 주/야간
		paramMap.put("group", Constant.WORK_TYPE);
		model.addAttribute("workTypes", codeMapper.selectCodeList(paramMap));

		// 종류
		model.addAttribute("kinds", vehicleMapper.selectKinds());
		
		// 차종
		model.addAttribute("modelCars", vehicleMapper.selectModelCars(paramMap));
				
		// 품명
		model.addAttribute("productNames", vehicleMapper.selectProductNames(paramMap));
		
		// LH, RH
		paramMap.put("group", Constant.GUBUN_LHRH);
		model.addAttribute("lhRhs", codeMapper.selectCodeList(paramMap));
		
		// 고객사
		model.addAttribute("clients", vehicleMapper.selectClients());
		
		return TILESForder+"/plan/list"+Constant.TILES;
	}
	
	@RequestMapping(value = "/excelUp.do", method = RequestMethod.POST)
    public void ExcelUp(HttpServletRequest req, HttpServletResponse rep){
		
        try { // MultipartHttpServletRequest 생성 
            MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) req; 
            Iterator<String> iter = mhsr.getFileNames(); 
            MultipartFile mfile = null; 
            
            // 값이 나올때까지
            while (iter.hasNext()) { 
                mfile = mhsr.getFile(iter.next()); 
            }
            
            excelService.getExcelUpload(mfile);
            
        } catch (UnsupportedEncodingException e) { // TODO Auto-generated catch block 
            e.printStackTrace(); 
        }catch (IllegalStateException e) { // TODO Auto-generated catch block 
            e.printStackTrace(); 
        } catch (IOException e) { // TODO Auto-generated catch block 
            e.printStackTrace(); 
        } catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
	
	@RequestMapping(value={"deleteAll"})
    public @ResponseBody Map<String, Object> deleteAll(){
		Map<String, Object> map = new HashMap<String, Object>();
        try {
        	packingPlan.deleteAll();
        	map.put("success", "OK");
        }catch (IllegalStateException e) { // TODO Auto-generated catch block 
        	map.put("success", "NO");
            e.printStackTrace(); 
        } catch (Exception e) {
			// TODO Auto-generated catch block
        	map.put("success", "NO");
			e.printStackTrace();
		}
        
        return map;
    }
	
	
}
