package com.haoyu.nts.user.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.user.dao.IUserBizDao;
import com.haoyu.nts.user.entity.User;
import com.haoyu.nts.user.service.IUserBizService;
import com.haoyu.sip.core.web.SearchParam;

@Service
public class UserBizServiceImpl implements IUserBizService{
	
	@Resource
	private IUserBizDao userBizDao;

	@Override
	public List<User> listUser(SearchParam searchParam, PageBounds pageBounds) {
		return userBizDao.selectUser(searchParam.getParamMap(),pageBounds);
	}

	@Override
	public int count(SearchParam searchParam) {
		return userBizDao.count(searchParam.getParamMap());
	}

	@Override
	public Map<String, User> userIdKeyMap(Map<String, Object> parameter) {
		return userBizDao.userIdKeyMap(parameter);
	}

	@Override
	public List<User> selectForImport(Map<String, Object> parameter) {
		return userBizDao.selectForImport(parameter);
	}

	@Override
	public List<User> selectForImportByUserName(Map<String, Object> parameter) {
		return userBizDao.selectForImportByUserName(parameter);
	}

}
