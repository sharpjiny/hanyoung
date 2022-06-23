package com.hanManager.controller.web;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hanManager.Constant;
import com.hanManager.controller.DefaultController;
import com.hanManager.domain.LoginUsers;
import com.hanManager.domain.Users;
import com.hanManager.domain.VehicleManagement;
import com.hanManager.mapper.UsersMapper;
import com.hanManager.model.LoginModel;
import com.hanManager.web.util.CommonUtil;
import com.hanManager.web.util.LoginManager;

@Controller
public class WebLoginController extends DefaultController {
    @Autowired private UsersMapper usersMapper;

	/**
	 * 로그인 페이지
	 *
	 * @param loginModel
	 * @param locale
	 * @return
	 */
	@RequestMapping(value = { "login" }, method = RequestMethod.GET)
	public String login(@ModelAttribute LoginModel loginModel, Locale locale) {

		return "login";

	}

	/**
	 * 로그인 액션
	 * @param session
	 * @param loginModel
	 * @param result
	 * @param locale
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = { "login" }, method = RequestMethod.POST)
	public String loginSubmit(HttpSession session,
			@Valid @ModelAttribute LoginModel loginModel,
			BindingResult result, HttpServletRequest request) throws Exception {
		// 유효성 검사
		if (result.hasFieldErrors()) {
			return "login";
		}
		String inputPwd2 = CommonUtil.encryptPassword(loginModel.getPwd());
		//로그인 DB 확인
		Users user = new Users();
		user.setUserId(loginModel.getId());
		user = usersMapper.selectUser(user);
		if (user == null) {
			result.rejectValue("id", "notexsist");
			return "login";
        }

		if(user.getUserState()==null || !user.getUserState().equals("1")){
			result.rejectValue("id", "notId");
        	return "login";
		}
//		// 패스워드 확인
		String inputPwd = CommonUtil.encryptPassword(loginModel.getPwd());

        if (StringUtils.equals(user.getUserPwd(), inputPwd) == false) {
			result.rejectValue("pwd", "notequal");
        	return "login";
        }

		// 세션담기
		LoginUsers loginUser = new LoginUsers();
		loginUser.setId(user.getUserId());
        loginUser.setName(user.getUserName());
        loginUser.setRole(user.getUserRole());
        loginUser.setState(user.getUserState());
		LoginManager.getInstance().login(request, loginUser);

		return "redirect:/home";
	}

	/**
	 * 로그아웃
	 *
	 * @param request
	 * @return
	 */
	@RequestMapping(value = { "logout" }, method = RequestMethod.GET)
	public String logout(HttpServletRequest request) {
		LoginManager.getInstance().logout(request);
		return "redirect:/";
	}
	
	/**
	 * 사용자 비밀번호 변경
	 *
	 * @param request
	 * @return
	 */
	@RequestMapping(value="userEditSave")
	public @ResponseBody Map<String, Object> userEditSave(@Valid Users users, @RequestParam String eventType, BindingResult result, Locale locale) {

    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("success", "NO");
    	
		try {
			String id = users.getUserId();
			String pw = users.getUserPwd();
			
			if((id != null && !"".equals(id)) && (pw != null && !"".equals(pw))){
				String pwd = CommonUtil.encryptPassword(users.getUserPwd());
				users.setUserPwd(pwd);
				usersMapper.updateUserPW(users);
				map.put("success", "OK");
			}
    	} catch (Exception e) {
			log.error("Exception : ", e);
		}
    	return map;
	}

	/**
	 * 메인 화면
	 */
	@RequestMapping(value = { "home" })
	public String home(HttpServletRequest request) {
//    	// 로그인이 안되 있으면 로그인 화면으로 이동
		if(!LoginManager.getInstance().isLogin(request)){
			return "redirect:/login";
		}

		return Constant.HOME_URL;
	}

	/**
	 * 사용 불가 회원
	 */
	@RequestMapping(value = { "unuse" })
	public String unuse() {

		return "unuse";
	}
}
