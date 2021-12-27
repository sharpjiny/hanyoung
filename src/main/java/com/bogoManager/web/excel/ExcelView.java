package com.bogoManager.web.excel;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;

public class ExcelView extends AbstractExcelView {
	@Override
	protected void buildExcelDocument(Map<String, Object> ModelMap,
			HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String excelName = ModelMap.get("target").toString();
		HSSFSheet worksheet = null;
		HSSFRow row = null;
		@SuppressWarnings("unchecked")
		ArrayList<HashMap<String,Object>> excelList = (ArrayList<HashMap<String,Object>>) ModelMap.get("excelList");
		@SuppressWarnings("unchecked")
		List<String> headerList = (List<String>) ModelMap.get("HeaderList");
		worksheet = workbook.createSheet(excelName + " WorkSheet");
		row = worksheet.createRow(0);
		
		for(int i = 0; i < headerList.size(); i++){
			row.createCell(i).setCellValue(headerList.get(i));
		}
		
		if(excelName.equals("로그목록")){
			for(int i = 0; i < excelList.size(); i++){
				row = worksheet.createRow(i+1);
            
		    	row.createCell(i);
				row.createCell(i+1).setCellValue((String) excelList.get(i).get("menu_used_txt"));		
				row.createCell(i+2).setCellValue((String) excelList.get(i).get("logs_type_txt"));		
				row.createCell(i+3).setCellValue((String) excelList.get(i).get("msg"));		
				row.createCell(i+4).setCellValue((String) excelList.get(i).get("created"));		
				row.createCell(i+5).setCellValue((String) excelList.get(i).get("user_id"));		
				row.createCell(i+6).setCellValue((String) excelList.get(i).get("user_name"));		
				row.createCell(i+7).setCellValue((String) excelList.get(i).get("user_ip"));		

			}
		}else{
			for(int i = 0; i < excelList.size(); i++){
				row = worksheet.createRow(i+1);	    
                
		    	row.createCell(i);
				row.createCell(i+1).setCellValue((String) excelList.get(i).get("building_name"));		
				row.createCell(i+2).setCellValue((String) excelList.get(i).get("estimat_date"));		
				row.createCell(i+3).setCellValue((String) excelList.get(i).get("measure_date"));		
				row.createCell(i+3).setCellValue((String) excelList.get(i).get("measure_target_txt"));		
				row.createCell(i+4).setCellValue((String) excelList.get(i).get("company_name"));		
				row.createCell(i+5).setCellValue((String) excelList.get(i).get("building_addr"));		
				row.createCell(i+6).setCellValue((String) excelList.get(i).get("incharge_name"));		
				row.createCell(i+7).setCellValue((String) excelList.get(i).get("incharge_department"));		
				row.createCell(i+8).setCellValue((String) excelList.get(i).get("incharge_rank"));		
				row.createCell(i+9).setCellValue((String) excelList.get(i).get("incharge_tel"));		
				row.createCell(i+10).setCellValue((String) excelList.get(i).get("incharge_phone"));			
				row.createCell(i+11).setCellValue((String) excelList.get(i).get("incharge_fax"));		
				row.createCell(i+12).setCellValue((String) excelList.get(i).get("incharge_email"));		
				
			}
		}

		
		response.setContentType("Application/Msexcel");
		excelName = URLEncoder.encode(excelName, "UTF-8");
		response.setHeader("Content-Disposition", "ATTachment; Filename="+ excelName + "-excel");
	}
}