package com.haoyu.nts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.google.common.collect.Lists;
import com.haoyu.nts.utils.PageSplitUtils;
import com.haoyu.sip.auth.entity.AuthPermission;
import com.haoyu.sip.auth.service.IAuthPermissionService;

import freemarker.core.Environment;
import freemarker.ext.beans.BeanModel;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
@Component
public class PermissionsDataDirective implements TemplateDirectiveModel {

	@Resource
	private IAuthPermissionService permissionService;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body)
			throws TemplateException, IOException {
		List<AuthPermission> permissions  = Lists.newArrayList();
		PageBounds pageBounds = PageSplitUtils.getPageBounds(params, env);
		if (params.containsKey("permission") && params.get("permission") != null) {
			BeanModel beanModel = (BeanModel) params.get("permission");
			if (beanModel != null) {
				AuthPermission permission = (AuthPermission) beanModel.getWrappedObject();
				permissions = permissionService.list(permission, pageBounds);
				env.setVariable("permissions", new DefaultObjectWrapper().wrap(permissions));
			}
		}
		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList)permissions;
			env.setVariable("paginator" , new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}
		body.render(env.getOut());
	}
}
