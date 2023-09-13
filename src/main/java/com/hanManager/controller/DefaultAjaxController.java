package com.hanManager.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.multipart.MultipartFile;

import com.hanManager.Constant;

public class DefaultAjaxController extends DefaultController{

    @Autowired
	protected MessageSource msg;

    protected boolean validtion(Map<String, Object> result, BindingResult bind, Locale locale) {
        boolean ret = true;
        if (bind.hasErrors()) {
            List<FieldError> fieldErrors = bind.getFieldErrors();
            List<Map<String, String>> errs = new ArrayList<Map<String, String>>();
            for (FieldError err : fieldErrors) {

                Map<String, String> errMap = new LinkedHashMap<String, String>();
                errMap.put("field", err.getField());
                errMap.put("msg", err.getDefaultMessage());

                errs.add(errMap);
            }

            result.put(Constant.CODE_KEY, Constant.FIELD_ERROR);
            result.put(Constant.MESSAGE_KEY, msg.getMessage("error.field", null, locale));

            result.put("errors", errs);

            ret = false;
        }

        return ret;
    }

	protected Map<String, Object> doResult(Map<String, Object> result, int ret, Locale locale) {

        if (ret > 0 ) {
            result.put(Constant.CODE_KEY, Constant.OK);
            result.put(Constant.MESSAGE_KEY, Constant.MESSAGE_OK);
        } else {
            result.put(Constant.CODE_KEY, Constant.ERROR_DB);
            result.put(Constant.MESSAGE_KEY, msg.getMessage("error.db", null, locale));
        }

        return result;
    }
	
	public HashMap<String, Object> uploadFile(MultipartFile upFile, HashMap<String, Object> params) throws Exception {
		String base_path = (String)params.get("BASE_PATH");
		String originalFilename = upFile.getOriginalFilename();
		long fileSize = upFile.getSize();
		byte [] data = upFile.getBytes();
		String yymmdd = mkDir(base_path);
		
		FileOutputStream fos = new FileOutputStream(base_path + File.separator + yymmdd + File.separator + originalFilename);
		fos.write(upFile.getBytes());
		fos.close();
		
		params.put("FILE_NAME", originalFilename); // 원래 파일이름
		params.put("FILE_PATH" , "/imgUpload/"+yymmdd); // 파일이 저장된 base 주소
		params.put("FILE_SIZE" , Long.toString(fileSize)); // 파일 사이즈
	
		
		return params;
	}
	
	public String mkDir(String base_path) throws IOException { //날짜별로 디렉터리 만드는 소스
		
		Calendar cal = Calendar.getInstance();
		int year = cal.get(cal.YEAR);
		int month = cal.get(cal.MONTH) + 1;
		int date = cal.get(cal.DATE);
		
		String yymmdd = "";
		yymmdd += Integer.toString(year);
		yymmdd += Integer.toString(month);
		yymmdd += Integer.toString(date);
		
		File folder = new File(base_path+yymmdd);
		
		if(!folder.exists()) {
			folder.mkdir();
		}else {
			System.out.println("이미 폴더가 존재합니다");
		}
		
		return yymmdd;
	}
}
