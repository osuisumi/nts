package com.haoyu.nts.account.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.account.dao.IAccountBizDao;
import com.haoyu.sip.core.jdbc.MybatisDao;
import com.haoyu.sip.user.entity.Account;

@Repository
public class AccountBizDao extends MybatisDao implements IAccountBizDao{

	@Override
	public List<Account> findAccountsFromBaseUserView(Map<String, Object> parameter, PageBounds pageBounds) {
		return super.selectList("selectFromBaseUserView", parameter, pageBounds);
	}

	@Override
	public List<Account> findAccountsByParameter(Map<String, Object> parameter, PageBounds pageBounds) {
		return super.selectList("select", parameter, pageBounds);
	}

	@Override
	public Map<String, Account> selectMap(Map<String, Object> parameter) {
		return super.selectMap("select", parameter,"user.id");
	}

}
