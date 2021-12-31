package com.hanManager.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public interface ExcelService {
	public List<?> getExcelUpload(MultipartFile excelFile) throws Exception;
}
