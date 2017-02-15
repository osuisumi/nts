package com.haoyu.nts.account.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.user.entity.Account;

public interface IAccountBizDao {
	
	//从baseuserView获取account
	List<Account> findAccountsFromBaseUserView(Map<String,Object> parameter,PageBounds pageBounds);
	
	//用map从account表查account
	List<Account> findAccountsByParameter(Map<String,Object> parameter,PageBounds pageBounds);
	
	Map<String,Account> selectMap(Map<String,Object> parameter);
	
}
