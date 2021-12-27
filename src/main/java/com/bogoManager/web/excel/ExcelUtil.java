package com.bogoManager.web.excel;

import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelUtil {

	public void makeExcel(HttpServletRequest request,
			HttpServletResponse response, List<?> list, String[] keys,
			String[] headers, String sheetName, String fileName) {
		String encodeFileName = null;
		try {
			encodeFileName = new String(fileName.getBytes("euc-kr"),"8859_1");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		XSSFWorkbook workbook = new XSSFWorkbook();

		XSSFSheet sheet = workbook.createSheet();
        workbook.setSheetName(0 , sheetName);

        XSSFRow rowHeader = sheet.createRow(0);
        for(int i = 0 ; i < headers.length ; i++) {
        	XSSFCell cell = rowHeader.createCell((short)i);
        	cell.setCellValue(headers[i]);
        }
        for(int i = 0 ; i < list.size(); i++) {
        	HashMap map = (HashMap) list.get(i);
        	XSSFRow row = sheet.createRow(i + 1);
            for(int j = 0 ; j < keys.length ; j++) {
            	XSSFCell cell = row.createCell((short)j);
            	String value = "";
            	if(keys[j].equals("rownum")) {
            		value = i+1+"";
            	}else if(map.get(keys[j]) != null) {
            		value = map.get(keys[j]).toString();
            	}
            	cell.setCellValue(value);
            }
        }
        for (int i=0;i<headers.length;i++)  {
	        sheet.autoSizeColumn(i);
	        sheet.setColumnWidth(i, (sheet.getColumnWidth(i))+512 );
        }
        response.setHeader("Content-disposition","attachment;filename=" + encodeFileName+";");

        BufferedOutputStream fos = null;
        try {
			fos = new BufferedOutputStream(response.getOutputStream());
			workbook.write(fos);
        } catch (Exception e) {
        } finally {
            if(fos != null) {
				try {
	                if(workbook!=null) workbook.close();
	                if(fos!=null) fos.close();
	            } catch (IOException e) {
					e.printStackTrace();
				}
            }
        }
	}
	
	public static Workbook getWorkbook(String filePath) {
		 
        /*
         * FileInputStream은 파일의 경로에 있는 파일을 읽어서 Byte로 가져온다.
         * 
         * 파일이 존재하지 않는다면은 RuntimeException이 발생된다.
         */
        FileInputStream fis = null;
        try {
            fis = new FileInputStream(filePath);
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e.getMessage(), e);
        }
 
        Workbook wb = null;
 
        /*
         * 파일의 확장자를 체크해서 .XLS 라면 HSSFWorkbook에 .XLSX라면 XSSFWorkbook에 각각 초기화 한다.
         */
        if (filePath.toUpperCase().endsWith(".XLS")) {
            try {
                wb = new HSSFWorkbook(fis);
            } catch (IOException e) {
                throw new RuntimeException(e.getMessage(), e);
            }
        } else if (filePath.toUpperCase().endsWith(".XLSX")) {
            try {
                wb = new XSSFWorkbook(fis);
            } catch (IOException e) {
                throw new RuntimeException(e.getMessage(), e);
            }
        }
 
        return wb;
 
    }
 
    //Excel Upload시에 데이터를 얻어옵니다.
    @SuppressWarnings("deprecation")
    public static String cellValue(Cell cell) {
 
        String value = null;
        if (cell == null)
            value = "";
        else {
            switch (cell.getCellType()) { // cell 타입에 따른 데이타 저장
            case Cell.CELL_TYPE_FORMULA:
                value = cell.getCellFormula();
                break;
            case Cell.CELL_TYPE_NUMERIC:
                if (DateUtil.isCellDateFormatted(cell)) {
                    // you should change this to your application date format
                    SimpleDateFormat objSimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    value = ""+ objSimpleDateFormat.format(cell.getDateCellValue());
                } else {
                    value = ""+ String.format("%.0f", new Double(cell.getNumericCellValue()));
                }
                break;
            case Cell.CELL_TYPE_STRING:
                value = "" + cell.getStringCellValue();
                break;
            case Cell.CELL_TYPE_BLANK:
                // value=""+cell.getBooleanCellValue();
                value = "";
                break;
            case Cell.CELL_TYPE_ERROR:
                value = "" + cell.getErrorCellValue();
                break;
            default:
            }
        }
 
        return value.trim();
    }
}
