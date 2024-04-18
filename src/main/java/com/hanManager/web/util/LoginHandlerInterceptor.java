package com.hanManager.web.util;

import java.io.PrintWriter;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.hanManager.domain.LoginUsers;

public class LoginHandlerInterceptor implements HandlerInterceptor {
	
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    private AntPathMatcher pathMatcher = new AntPathMatcher();
    private String[] excludeList;
    private String loginPage = "/login";
    private String firstPage;


    @Autowired
    private ApplicationContext applicationContext;

    public String[] getExcludeList() {
        return excludeList;
    }

    public void setExcludeList(String[] excludeList) {
        this.excludeList = excludeList;
    }

    public void setFirstPage(String firstPage) {
        this.firstPage = firstPage;
    }

    public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3) throws Exception {
    }
    
    public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3) throws Exception {
    }

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

    	LoginUsers loginUser = LoginManager.getInstance().getSession(request);
    	List<String> list = new ArrayList<String>();
        list.add("49.69.204.243");
        logger.info("ip ==============> "+request.getRemoteAddr());
        logger.info("loginUser ==============> "+loginUser);
        
        if((loginUser != null && !"hanadmin".equals(loginUser.getId())) && (loginUser != null && !"han00".equals(loginUser.getId()))){
        	boolean flag = true;
        	for(String li : list){
        		if(request.getRemoteAddr().matches(li)){
        			flag = false;
        			break;
        		}
            }
        	
        	if(flag){
        		logger.info("ALERT_ PART");
            	response.setContentType("text/html; charset=UTF-8");
        		PrintWriter out = response.getWriter();
        		out.println("<script>alert('Unauthorized access');</script>");
        		out.flush();
        		return false;
            }
        }
        
        final String requestUri = getRequestUri(request);

        final boolean isLogin = LoginManager.getInstance().isLogin(request);

        //if (StringUtils.equals(request.getServletPath(), "/index.html") && isLogin) {
        if (isWelcommPage(requestUri)) {
            if (isLogin == true) {
                request.getRequestDispatcher(firstPage).forward(request, response);
                return false;
            } else {
                return true;
            }
        } else if (isExclude(requestUri) == false) {

            if (isLogin == false) {
                if (StringUtils.equals("XMLHttpRequest", request.getHeader("X-Requested-With"))) {
                    response.setCharacterEncoding("UTF-8");
                    response.setContentType("application/json; charset=UTF-8");

                    PrintWriter writer = response.getWriter();
                    writer.print("{\"notLogin\": true}");
                    writer.flush();
                } else {
                    String path = null;
                    String queryString = null;

                    if (request.getMethod().equalsIgnoreCase("post")) {
                        String referer = request.getHeader("Referer");

                        if (StringUtils.isNotEmpty(referer)) {
                            URL refererUrl = new URL(referer);

                            path = refererUrl.getPath();
                            queryString = refererUrl.getQuery();
                        }
                    } else {
                        path = request.getRequestURI();
                        queryString = request.getQueryString();
                    }

                    if (path != null) {

                        if (path.startsWith(request.getContextPath())) {
                            path = path.substring(request.getContextPath().length());
                        }

                        StringBuilder returnUrl = new StringBuilder(path);

                        if (StringUtils.isEmpty(request.getQueryString()) == false) {
                            returnUrl.append("?").append(queryString);
                        }

                        request.setAttribute("returnUrl", returnUrl.toString());
                    }

                    request.getRequestDispatcher(loginPage).forward(request, response);
                }

                return false;
            }
        }

        return true;
    }

    private boolean isWelcommPage(String reuqestUri) {
        if (StringUtils.equals(loginPage, reuqestUri)
                || StringUtils.equals(loginPage + "/", reuqestUri)
                || StringUtils.equals(loginPage + ".do", reuqestUri)) {
            return true;
        }

        return false;
    }

    private boolean isExclude(String reuqestUri) {
        boolean ret = false;
        for (String exclude : excludeList) {

            if (pathMatcher.match(exclude, reuqestUri)) {
                ret = true;
            }
        }

        if (logger.isTraceEnabled()) {
            logger.trace("reuqestUri={}, exclude={}", reuqestUri, ret);
        }

        return ret;
    }

    private String getRequestUri(HttpServletRequest request) {
        String uri = StringUtils.removeStart(request.getRequestURI(), request.getContextPath());
        if (StringUtils.equals("/", uri)) {
            uri = request.getServletPath();
        }

        return uri;
    }
    
    
}
