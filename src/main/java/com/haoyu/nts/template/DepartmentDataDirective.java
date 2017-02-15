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
import com.haoyu.sip.user.entity.Department;
import com.haoyu.sip.user.service.IDepartmentService;

import freemarker.core.Environment;
import freemarker.ext.beans.BeanModel;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class DepartmentDataDirective implements TemplateDirectiveModel {
	@Resource
	private IDepartmentService departmentService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body)
			throws TemplateException, IOException {
		Map<String, Object> param = Maps.newHashMap();
		List<Department> departments = Lists.newArrayList();
		Department department = null;
		PageBounds pageBounds = PageSplitUtils.getPageBounds(params, env);
		if (params.containsKey("department") && params.get("department") != null) {
			BeanModel beanModel = (BeanModel) params.get("department");
			if (beanModel != null) {
				department = (Department) beanModel.getWrappedObject();
			}
		}else{
			department = new Department();
			department.setDeptType("1");
		}
		departments = departmentService.list(department, pageBounds);
		env.setVariable("departments", new DefaultObjectWrapper().wrap(departments));
		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList)departments;
			env.setVariable("paginator" , new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}
		body.render(env.getOut());
	}
}
