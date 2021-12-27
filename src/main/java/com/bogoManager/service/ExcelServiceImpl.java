package com.bogoManager.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.bogoManager.mapper.ExcelMapper;
import com.bogoManager.mapper.PackingPlanMapper;
import com.bogoManager.web.excel.ExcelUtil;

@Service
public class ExcelServiceImpl implements ExcelService {
	@Autowired PackingPlanMapper ppm;
	public List<?> getExcelUpload(MultipartFile excelFile) throws Exception{
        
        List<?> list = null;
        
        try {
        	//ppm.deleteDB();
        	
        	OPCPackage opcPackage = OPCPackage.open(excelFile.getInputStream());
            XSSFWorkbook workbook = new XSSFWorkbook(opcPackage);
            
            Sheet sheet = (Sheet) workbook.getSheetAt(0);
            
            List productLst = new ArrayList();
            for (int i = sheet.getFirstRowNum()+3; i <= sheet.getLastRowNum(); i++) {
                Row productRow = sheet.getRow(i);
                /*if(!"".equals(ExcelUtil.cellValue(productRow.getCell(3)))){
                	productLst.add(""+ExcelUtil.cellValue(productRow.getCell(3)));
                }*/
                productLst.add(""+ExcelUtil.cellValue(productRow.getCell(3)));
            }
            //Collections.sort(productLst);
            
            List dateLst = new ArrayList();
            Row dateRow = sheet.getRow(1);
            for(int i=0; i<20; i++){
            	dateLst.add(""+ExcelUtil.cellValue(dateRow.getCell(4+i)));
            }
            
            /*dateLst.add(""+ExcelUtil.cellValue(dateRow.getCell(5)));
    		dateLst.add(""+ExcelUtil.cellValue(dateRow.getCell(6)));
    		dateLst.add(""+ExcelUtil.cellValue(dateRow.getCell(7)));
    		dateLst.add(""+ExcelUtil.cellValue(dateRow.getCell(8)));
    		dateLst.add(""+ExcelUtil.cellValue(dateRow.getCell(9)));
    		dateLst.add(""+ExcelUtil.cellValue(dateRow.getCell(10)));
    		dateLst.add(""+ExcelUtil.cellValue(dateRow.getCell(11)));
    		dateLst.add(""+ExcelUtil.cellValue(dateRow.getCell(12)));
    		dateLst.add(""+ExcelUtil.cellValue(dateRow.getCell(13)));
    		dateLst.add(""+ExcelUtil.cellValue(dateRow.getCell(14)));
    		dateLst.add(""+ExcelUtil.cellValue(dateRow.getCell(15)));
    		dateLst.add(""+ExcelUtil.cellValue(dateRow.getCell(16)));
    		dateLst.add(""+ExcelUtil.cellValue(dateRow.getCell(17)));*/
    		
    		List excelUploadList = new ArrayList();
			String beforeProduct = "";
			int idx = 3;
			for(int b=0; b<productLst.size(); b++){
				Row cntRow = sheet.getRow(idx++);
				for(int c=0; c<dateLst.size(); c++){
					Map map = new HashMap();
					map.put("product_id", productLst.get(b));
					map.put("plan_date", dateLst.get(c));
					if(c%2 == 0){
						map.put("work_type", "W");
					}else{
						map.put("work_type", "L");
					}
					map.put("quantity", ExcelUtil.cellValue(cntRow.getCell(c+4)));
					if(!beforeProduct.equals(productLst.get(b)) && !"".equals(ExcelUtil.cellValue(cntRow.getCell(c+4))) && Integer.parseInt(ExcelUtil.cellValue(cntRow.getCell(c+4))) != 0){
						excelUploadList.add(map);
					}
				}
				beforeProduct = productLst.get(b).toString();
			}
			
			Map param = new HashMap();
			param.put("excelUploadList", excelUploadList);
			ppm.mergeDB(param);
            
        }catch(Exception e){
        	e.printStackTrace();
        }
        
        return list;
        
    }
}
