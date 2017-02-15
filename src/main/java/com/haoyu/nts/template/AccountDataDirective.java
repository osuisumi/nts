package com.haoyu.nts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.nts.utils.PageSplitUtils;
import com.haoyu.sip.user.entity.Account;
import com.haoyu.sip.user.entity.Department;
import com.haoyu.sip.user.service.IAccountService;
import com.haoyu.sip.user.service.IDepartmentService;

import freemarker.core.Environment;
import freemarker.ext.beans.BeanModel;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
@Component
public class AccountDataDirective implements TemplateDirectiveModel {
	@Resource
	private IAccountService tsAccountService;
	@Resource
	private IDepartmentService departmentService;
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body)
			throws TemplateException, IOException {
		Map<String, Object> param = Maps.newHashMap();
		List<Account> accounts  = Lists.newArrayList();
		List<Department> departments = Lists.newArrayList();
		PageBounds pageBounds = PageSplitUtils.getPageBounds(params, env);
		if (params.containsKey("account") && params.get("account") != null) {
			BeanModel beanModel = (BeanModel) params.get("account");
			if (beanModel != null) {
				Account account = (Account) beanModel.getWrappedObject();
				accounts = tsAccountService.list(account, pageBounds);
				env.setVariable("accounts", new DefaultObjectWrapper().wrap(accounts));
			}
		}
		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList)accounts;
			env.setVariable("paginator" , new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}
		body.render(env.getOut());
	}
}
