package com.haoyu.nts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.google.common.collect.Lists;
import com.haoyu.nts.utils.PageSplitUtils;
import com.haoyu.sip.auth.entity.AuthRole;
import com.haoyu.sip.auth.service.IAuthRoleService;

import freemarker.core.Environment;
import freemarker.ext.beans.BeanModel;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
@Component
public class RolesDataDirective implements TemplateDirectiveModel {
	
	@Resource
	private IAuthRoleService authRoleService;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body)
			throws TemplateException, IOException {
		List<AuthRole> roles  = Lists.newArrayList();
		AuthRole role = new AuthRole();
		PageBounds pageBounds = PageSplitUtils.getPageBounds(params, env);
		if (params.containsKey("role") && params.get("role") != null) {
			BeanModel beanModel = (BeanModel) params.get("role");
			if (beanModel != null) {
				role = (AuthRole) beanModel.getWrappedObject();
			}
		}
		roles = authRoleService.list(role, pageBounds);
		env.setVariable("roles", new DefaultObjectWrapper().wrap(roles));
		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList)roles;
			env.setVariable("paginator" , new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}
		body.render(env.getOut());
	}
}
