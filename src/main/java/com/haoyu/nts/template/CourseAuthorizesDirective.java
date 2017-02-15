package com.haoyu.nts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.haoyu.ncts.course.entity.CourseAuthorize;
import com.haoyu.ncts.course.service.ICourseAuthorizeService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class CourseAuthorizesDirective extends AbstractTemplateDirectiveModel {

	@Resource
	private ICourseAuthorizeService courseAuthorizeService;

	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> parameter = getSelectParam(params);
		PageBounds pageBounds = getPageBounds(params);
		List<CourseAuthorize> courseAuthorizes = courseAuthorizeService.listCourseAuthorize(parameter, pageBounds);
		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList) courseAuthorizes;
			env.setVariable("paginator", new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}
		env.setVariable("courseAuthorizes", new DefaultObjectWrapper().wrap(courseAuthorizes));
		body.render(env.getOut());
	}
}
