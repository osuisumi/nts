package com.haoyu.nts.auth.service;

import java.util.List;

import com.haoyu.sip.auth.entity.AuthRole;
import com.haoyu.sip.core.service.Response;

public interface IAuthRoleBizService {
	
	Response deleteUserRole(List<String> roleIds,List<String> userIds,String relationId);

}
