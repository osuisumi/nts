package com.haoyu.nts.template;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.google.common.collect.Lists;
import com.haoyu.nts.statistics.project.entity.ProjectStatistics;
import com.haoyu.nts.statistics.project.service.IProjectStatisticsService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.utils.Collections3;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class StatisticsProjectDataDirective extends AbstractTemplateDirectiveModel {
	
	@Resource
	private IProjectStatisticsService projectStatisticsService;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body)
			throws TemplateException, IOException {
		PageBounds pageBounds = getPageBounds(params);
		Map<String,Object> paramerts = getSelectParam(params);
		List<ProjectStatistics> projectStatisticsList = Lists.newArrayList();
		
		if (paramerts.containsKey("state") && StringUtils.isNotEmpty(paramerts.get("state").toString())) {
			String state = paramerts.get("state").toString();
			if ("ready".equals(state)) {
				paramerts.put("startTimeGreaterThan", new Date());
			}
			if ("in_progress".equals(state)) {
				paramerts.put("startTimeLessThanOrEquals", new Date());
				paramerts.put("endTimeGreaterThanOrEquals", new Date());
			}
			if ("end".equals(state)) {
				paramerts.put("endTimeLessThan", new Date());
			}
		}
		
		projectStatisticsList = projectStatisticsService.list(paramerts, pageBounds);
		env.setVariable("projectStatisticsList", new DefaultObjectWrapper().wrap(projectStatisticsList));
		
		if (Collections3.isNotEmpty(projectStatisticsList) && pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList)projectStatisticsList;
			env.setVariable("paginator" , new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}
		body.render(env.getOut());
	}

}
