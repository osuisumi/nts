package com.haoyu.nts.account.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.user.entity.Account;

public interface IAccountBizService {
	
	List<Account> getAccountsByUser(Map<String,Object> parameter,PageBounds pageBounds);
	
	Map<String,Account> getMap(Map<String,Object> parameter);
	
	Account findAccountById(String id);
	
	Map<String, Object> importAccount(String url);
	
	List<Account> getAccountFromAccount(Map<String,Object> parameter,PageBounds pageBounds);
	
	Map<String,Object> importStudent(String url);

}
