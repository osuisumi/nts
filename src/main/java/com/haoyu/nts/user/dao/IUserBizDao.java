package com.haoyu.nts.user.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.user.entity.User;

public interface IUserBizDao {

	List<User> selectUser(Map<String, Object> param, PageBounds pageBounds);
	
	List<User> selectForImport(Map<String,Object> param);
	
	List<User> selectForImportByUserName(Map<String,Object> param);
	
	Map<String,User> userIdKeyMap(Map<String,Object> parameter);
	
	public int count(Map<String,Object> param);

}
