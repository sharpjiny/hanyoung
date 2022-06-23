package com.hanManager.mapper;

import java.util.HashMap;

import com.hanManager.domain.Users;


public interface UsersMapper {

	Users selectUser(Users users);
	void updateUserPW(Users users);
}
