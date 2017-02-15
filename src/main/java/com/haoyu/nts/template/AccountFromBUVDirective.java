package com.haoyu.nts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.nts.account.service.IAccountBizService;
import com.haoyu.nts.utils.PageSplitUtils;
import com.haoyu.sip.core.utils.PropertiesLoader;
import com.haoyu.sip.user.entity.Account;
import com.haoyu.sip.user.entity.Department;
import com.haoyu.sip.user.service.IAccountService;
import com.haoyu.sip.user.service.IDepartmentService;
import com.haoyu.sip.utils.Collections3;

import freemarker.core.Environment;
import freemarker.ext.beans.BeanModel;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
@Component
public class AccountFromBUVDirective implements TemplateDirectiveModel {
	@Resource
	private IAccountService tsAccountService;
	@Resource
	private IDepartmentService departmentService;
	@Resource
	private PropertiesLoader propertiesLoader;
	@Resource
	private IAccountBizService accountBizService;
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body)
			throws TemplateException, IOException {
		Map<String, Object> param = Maps.newHashMap();
		List<Account> accounts = Lists.newArrayList();
		List<Department> departments = Lists.newArrayList();
		PageBounds pageBounds = PageSplitUtils.getPageBounds(params, env);
		if (params.containsKey("account") && params.get("account") != null) {
			BeanModel beanModel = (BeanModel) params.get("account");
			if (beanModel != null) {
				Account account = (Account) beanModel.getWrappedObject();
				if(propertiesLoader.getBoolean("base.data.is.manage")){
					accounts = tsAccountService.list(account, pageBounds);
				}else{
					accounts = accountBizService.getAccountsByUser(accountToMap(account), pageBounds);
				}
				env.setVariable("accounts", new DefaultObjectWrapper().wrap(accounts));
			}
		}
		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList) accounts;
			env.setVariable("paginator", new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}
		body.render(env.getOut());
	}
	
	private Map<String,Object> accountToMap(Account account){
		Map<String,Object> param = Maps.newHashMap();
		if( account.getUser() != null &&  account.getUser().getRealName() != null && account.getUser().getDepartment() != null && account.getUser().getDepartment().getDeptName() != null ){
			param.put("realName", account.getUser().getRealName());
			param.put("deptName",account.getUser().getDepartment().getDeptName());
		}
		if(account!=null &&StringUtils.isNotEmpty(account.getRoleCode())){
			param.put("roleCode", account.getRoleCode());
		}
		if(account != null && StringUtils.isNotEmpty(account.getUserName())){
			param.put("userName", account.getUserName());
		}
		if(Collections3.isNotEmpty(account.getRoles()) && account.getRoles().get(0) != null && account.getRoles().get(0).getId() != ""){
			param.put("roleId",account.getRoles().get(0).getId());
		}
		return param;
	}
}
