/**
 * FileName : LoginManager.java
 * Comment  :
 * @version : 1.0
 * @author  : goindolo
 * @date    : 2009. 4. 22.
 */
package com.bogoManager.web.util;

import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;

/**
 * 로그인 관리 클래스로서 싱글펀 패턴 적용
 */
public class LoginManager {

    /** session key */
    private static final String SESSION_KEY = "userSession";

    private static LoginManager INSTANCE;


    private static Lock lock = new ReentrantLock();

    /**
     * LoginManager instance를 가져온다.
     * @return LoginManager instance
     * @author goindolo
     */
    public static LoginManager getInstance() {
        if(INSTANCE == null) {
            try {
                lock.lock();
                INSTANCE = new LoginManager();
            } finally {
                lock.unlock();
            }
        }

        return INSTANCE;
    }

    /**
     * 사용자 Session을 가져온다.
     * @param request
     * @return 사용자 Session
     * @author goindolo
     */
    @SuppressWarnings("unchecked")
    public static  <T> T getUserSession(HttpServletRequest request) {
        return (T) (getInstance().getSession(request));
    }


    //================== non-static ==============

    /**
     * 생성자
     */
    private LoginManager() {}

    /**
     * 로그인을 한다.
     * @param request
     * @param userSession
     * @author goindolo
     */
    public void login(HttpServletRequest request, Object user) {

        HttpSession session = request.getSession();

        if(session != null && session.isNew() == false) {
            logout(request);
        }

        session = request.getSession(true);

        session.setAttribute(SESSION_KEY, user);
    }

    /**
     * 로그아웃을 한다.
     * @param context
     * @author goindolo
     */
    public void logout(PageContext context) {
        logout((HttpServletRequest) context.getRequest());
    }

    /**
     * 로그아웃을 한다.
     * @param request
     * @author goindolo
     */
    public void logout(HttpServletRequest request) {

        HttpSession session = request.getSession(false);

        if(session != null) {
            if(session.getAttribute(SESSION_KEY) != null) {
                session.removeAttribute(SESSION_KEY);
            }

            session.invalidate();
        }
    }

    /**
     * 사용자 Session을 가져온다.
     * @param request
     * @return 사용자 Session
     * @author goindolo
     */
    @SuppressWarnings("unchecked")
    public <T> T getSession(HttpServletRequest request) {

        HttpSession session = request.getSession(false);

        T userSession =  null;
        if(session == null || session.getAttribute(SESSION_KEY) == null) {
            return null;
        }else{
            userSession = (T) session.getAttribute(SESSION_KEY);
        }

        return userSession;
    }

    public boolean isLogin (HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute(SESSION_KEY) == null) return false;

        return true;
    }
}
