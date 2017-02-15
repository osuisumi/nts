package com.haoyu.nts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.google.common.collect.Lists;
import com.haoyu.nts.course.entity.CourseStatExtend;
import com.haoyu.nts.course.service.ICourseStatBizService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class CourseStatExtendsDirective extends AbstractTemplateDirectiveModel {
	@Resource
	private ICourseStatBizService courseStatBizService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> parameter = getSelectParam(params);
		PageBounds pageBounds = getPageBounds(params);
		List<CourseStatExtend> courseStatExtends = Lists.newArrayList();

		if (parameter.get("type").equals("area")) {
			courseStatExtends = courseStatBizService.listArea(parameter, pageBounds);
		} else if (parameter.get("type").equals("school")) {
			courseStatExtends = courseStatBizService.listSchool(parameter, pageBounds);
		}

		env.setVariable("courseStatExtends", new DefaultObjectWrapper().wrap(courseStatExtends));

		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList) courseStatExtends;
			env.setVariable("paginator", new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}

		body.render(env.getOut());
	}

}
