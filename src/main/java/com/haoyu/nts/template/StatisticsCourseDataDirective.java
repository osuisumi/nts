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
import com.haoyu.nts.statistics.course.entity.CourseStatistics;
import com.haoyu.nts.statistics.course.service.ICourseStatisticsService;
import com.haoyu.nts.utils.PageSplitUtils;
import com.haoyu.sip.utils.Collections3;

import freemarker.core.Environment;
import freemarker.ext.beans.BeanModel;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class StatisticsCourseDataDirective implements TemplateDirectiveModel{
	
	@Resource
	private ICourseStatisticsService courseStatisticsService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body)
			throws TemplateException, IOException {
		List<CourseStatistics> courseStatisticsList = Lists.newArrayList();
		PageBounds pageBounds = PageSplitUtils.getPageBounds(params, env);
		if (params.containsKey("courseStatistics") && params.get("courseStatistics") != null) {
			BeanModel beanModel = (BeanModel) params.get("courseStatistics");
			if (beanModel != null) {
				Map<String, Object> param = Maps.newHashMap();
				CourseStatistics courseStatistics = (CourseStatistics) beanModel.getWrappedObject();
				courseStatistics.setParam(param);
				courseStatisticsList = courseStatisticsService.list(param, pageBounds);
				env.setVariable("courseStatisticsList", new DefaultObjectWrapper().wrap(courseStatisticsList));
			}
		}
		if (Collections3.isNotEmpty(courseStatisticsList) && pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList)courseStatisticsList;
			env.setVariable("paginator" , new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}
		body.render(env.getOut());		
	}
	

}
