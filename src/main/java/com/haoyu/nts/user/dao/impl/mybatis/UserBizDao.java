package com.haoyu.nts.user.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.user.dao.IUserBizDao;
import com.haoyu.nts.user.entity.User;
import com.haoyu.sip.core.jdbc.MybatisDao;

@Repository
public class UserBizDao extends MybatisDao implements IUserBizDao{

	@Override
	public List<User> selectUser(Map<String, Object> param, PageBounds pageBounds) {
		return selectList("select", param, pageBounds);
	}
	
	@Override
	public int count(Map<String,Object> param){
		return selectOne("count", param);
	}

	@Override
	public Map<String, User> userIdKeyMap(Map<String, Object> parameter) {
		return selectMap("select", parameter, "id");
	}

	@Override
	public List<User> selectForImport(Map<String, Object> param) {
		return selectList("selectForImport",param);
	}

	@Override
	public List<User> selectForImportByUserName(Map<String, Object> param) {
		return selectList("selectForImportByUserName",param);
	};

}
