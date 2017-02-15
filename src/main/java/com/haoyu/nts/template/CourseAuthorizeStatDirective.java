package com.haoyu.nts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.haoyu.nts.course.entity.CourseAuthorizeStat;
import com.haoyu.nts.course.service.ICourseAuthorizeStatService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class CourseAuthorizeStatDirective extends AbstractTemplateDirectiveModel {
	@Resource
	private ICourseAuthorizeStatService courseAuthorizeStatService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> parameter = getSelectParam(params);
		PageBounds pageBounds = getPageBounds(params);

		List<CourseAuthorizeStat> courseAuthorizeStats = courseAuthorizeStatService.list(parameter, pageBounds);

		env.setVariable("courseAuthorizeStats", new DefaultObjectWrapper().wrap(courseAuthorizeStats));

		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList) courseAuthorizeStats;
			env.setVariable("paginator", new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}

		body.render(env.getOut());

	}

}
