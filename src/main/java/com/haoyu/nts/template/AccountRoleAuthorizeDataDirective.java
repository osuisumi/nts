package com.haoyu.nts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.google.common.collect.Maps;
import com.haoyu.sip.auth.entity.AuthRole;
import com.haoyu.sip.auth.service.IAuthRoleService;
import com.haoyu.sip.user.entity.Account;
import com.haoyu.sip.user.service.IAccountService;

import freemarker.core.Environment;
import freemarker.ext.beans.BeanModel;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

public class AccountRoleAuthorizeDataDirective implements TemplateDirectiveModel {
	
	@Resource
	private IAccountService accountService;
	
	@Resource
	private IAuthRoleService authRoleService;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body)
			throws TemplateException, IOException {
		Map<String, Object> param = Maps.newHashMap();
		if (params.containsKey("account") && params.get("account") != null) {
			BeanModel beanModel = (BeanModel) params.get("account");
			if (beanModel != null) {
				Account account = (Account) beanModel.getWrappedObject();
				account = accountService.findAccountById(account.getId());
				env.setVariable("account", new DefaultObjectWrapper().wrap(account));
			}
		}
		List<AuthRole> roles = authRoleService.list(null, null);
		env.setVariable("roles", new DefaultObjectWrapper().wrap(roles));
		body.render(env.getOut());
	}
}
