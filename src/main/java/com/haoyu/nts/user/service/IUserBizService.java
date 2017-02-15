package com.haoyu.nts.user.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.user.entity.User;
import com.haoyu.sip.core.web.SearchParam;

public interface IUserBizService {

	List<User> listUser(SearchParam searchParam, PageBounds pageBounds);
	
	List<User> selectForImport(Map<String,Object> parameter);//根据relaname和paperworkno匹配
	
	List<User> selectForImportByUserName(Map<String,Object> parameter);
	
	Map<String,User> userIdKeyMap(Map<String,Object> parameter);
	
	int count(SearchParam searchParam);

}
