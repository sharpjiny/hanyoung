package com.hanManager.controller;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;

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
}
