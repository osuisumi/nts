package com.haoyu.nts.auth.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.google.common.collect.Maps;
import com.haoyu.nts.auth.service.IAuthRoleBizService;
import com.haoyu.sip.auth.dao.IAuthUserRoleDao;
import com.haoyu.sip.auth.realm.CacheCleaner;
import com.haoyu.sip.core.service.Response;

@Service
public class AuthRoleBizServiceImpl implements IAuthRoleBizService {

	@Resource
	private IAuthUserRoleDao authUserRoleDao;
	@Resource
	private CacheCleaner authRealm;

	public Response deleteUserRole(List<String> roleIds, List<String> userIds, String relationId) {

		Map<String, Object> param = Maps.newHashMap();
		param.put("userIds", userIds);
		param.put("roleIds", roleIds);
		param.put("relationId", relationId);
		authUserRoleDao.deleteRoleUser(param);
		if (authRealm != null && authRealm.hasCache()) {
			authRealm.clearUserCacheByIds(userIds);
		}
		return Response.successInstance();
	}
	

}
