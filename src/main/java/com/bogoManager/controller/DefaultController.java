package com.bogoManager.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.web.bind.ServletRequestDataBinder;

public class DefaultController {
	protected Log log = LogFactory.getLog(getClass());

	@Autowired
	protected HttpServletRequest request;

	protected void initBinder(ServletRequestDataBinder binder) throws Exception {
		// bind empty strings as null
		binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
	}

}
