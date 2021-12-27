package com.bogoManager.web.util;

import java.util.Arrays;
import java.util.Enumeration;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.text.StrBuilder;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;

public class DefaultExeptionResolver extends SimpleMappingExceptionResolver {

	protected Log logger = LogFactory.getLog(this.getClass());

	@Override

	protected ModelAndView doResolveException(HttpServletRequest request
												, HttpServletResponse response
												, Object handler
												, Exception ex) {

		String queryString  = request.getQueryString();
		StrBuilder msg = new StrBuilder(StringUtils.defaultIfEmpty(ex.getMessage(), ex.getClass().getName()) );
		msg.appendNewLine();
		msg.append("RequestURI = ").append(request.getRequestURI());

		if (StringUtils.isNotEmpty(queryString)) {
			msg.append("?").append(queryString).appendNewLine();
		} else {
			msg.appendNewLine();
		}

		appendHeader(msg, request);
		appendParameters(msg, request);

		HttpSession session = request.getSession();

		if (session != null) {
			appendSession(msg, session);
		}

		logger.error(msg.toString(), ex);

		return super.doResolveException(request, response, handler, ex);
	}

	@SuppressWarnings("unchecked")
	private void appendParameters(StrBuilder msg, HttpServletRequest request) {
		Map<String, String[]> parameterMap = request.getParameterMap();

		if (parameterMap.size() > 0) {
			msg.append("====== Request Paramaters ======").appendNewLine();

			for (Entry<String, String[]> entry : parameterMap.entrySet()) {
				msg.append("    ").append(entry.getKey()).append(" = ").append(Arrays.asList(entry.getValue())).appendNewLine();
			}
			msg.append("================================").appendNewLine();
		}
	}

	@SuppressWarnings("rawtypes")
	private void appendSession (StrBuilder msg, HttpSession session) {
		Enumeration sessionAttributeNames = session.getAttributeNames();

		if (sessionAttributeNames.hasMoreElements()) {
			msg.append("========= Session Info =========").appendNewLine();

			while (sessionAttributeNames.hasMoreElements()) {
				String key = (String) sessionAttributeNames.nextElement();
				Object value = session.getAttribute(key);

				msg.append("    ").append(key).append(" = ").append(value).appendNewLine();
			}

			msg.append("================================").appendNewLine();
		}
	}

	@SuppressWarnings("rawtypes")
	private void appendHeader(StrBuilder msg, HttpServletRequest request) {
		Enumeration headerNames = request.getHeaderNames();

		if (headerNames.hasMoreElements()) {
			msg.append("====== Request Header Info ======").appendNewLine();

			while (headerNames.hasMoreElements()) {
				String key = (String) headerNames.nextElement();
				String value = request.getHeader(key);

				msg.append("    ").append(key).append(" = ").append(value).appendNewLine();
			}

			msg.append("================================").appendNewLine();
		}
	}
}
