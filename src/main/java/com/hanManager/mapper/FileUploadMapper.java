package com.hanManager.mapper;

import java.util.HashMap;
import java.util.List;


public interface FileUploadMapper {
	public int getFileSeq() throws Exception;
	public void insertFileUpload(HashMap<String, Object> map) throws Exception;
	public void updateFileUpload(HashMap<String, Object> map) throws Exception;
	public void deleteFileUpload(HashMap<String, Object> map) throws Exception;
	
}
