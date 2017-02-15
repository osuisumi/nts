package com.haoyu.nts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.google.common.collect.Lists;
import com.haoyu.nts.workshop.service.IDepartmentWorkshopStatService;
import com.haoyu.nts.workshop.stat.DepartmentWorkshopStat;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class DepartmentWorkshopStatDirective extends AbstractTemplateDirectiveModel{
	@Resource
	private IDepartmentWorkshopStatService departmentWorkshopStatService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String,Object> parameter = getSelectParam(params);
		PageBounds pageBounds =  getPageBounds(params);
		List<DepartmentWorkshopStat> result = Lists.newArrayList();
		if(parameter.get("type").equals("school")){
			result = departmentWorkshopStatService.school(parameter,pageBounds);
		}else if(parameter.get("type").equals("area")){
			result = departmentWorkshopStatService.area(parameter,pageBounds);
		}
		env.setVariable("departmentWorkshopStats", new DefaultObjectWrapper().wrap(result));
		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList) result;
			env.setVariable("paginator", new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}
		body.render(env.getOut());


	}

}
