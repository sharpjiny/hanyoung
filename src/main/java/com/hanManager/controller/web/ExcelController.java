package com.hanManager.controller.web;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hanManager.controller.DefaultController;
import com.hanManager.service.ExcelServiceImpl;

@Controller
public class ExcelController extends DefaultController {
	@Autowired ExcelServiceImpl excelService;
	
	/*@RequestMapping(value = "/excelUp.do", method = RequestMethod.POST)
    public void ExcelUp(HttpServletRequest req, HttpServletResponse rep) throws Exception{
		
        Map returnObject = new HashMap(); 
        try { // MultipartHttpServletRequest 생성 
            MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) req; 
            Iterator iter = mhsr.getFileNames(); 
            MultipartFile mfile = null; 
            String fieldName = ""; 
            
            // 값이 나올때까지
            while (iter.hasNext()) { 
                fieldName = iter.next().toString(); // 내용을 가져와서 
                mfile = mhsr.getFile(fieldName); 
                String origName; 
                origName = new String(mfile.getOriginalFilename().getBytes("8859_1"), "UTF-8"); //한글꺠짐 방지 // 파일명이 없다면 
                
                returnObject.put("params", mhsr.getParameterMap()); 
                
                //위치 및 파일
                excelService.getExcelUpload("D:\\"+origName);
            }
            
        } catch (UnsupportedEncodingException e) { // TODO Auto-generated catch block 
            e.printStackTrace(); 
        }catch (IllegalStateException e) { // TODO Auto-generated catch block 
            e.printStackTrace(); 
        } catch (IOException e) { // TODO Auto-generated catch block 
            e.printStackTrace(); 
        }
    }
*/
}
