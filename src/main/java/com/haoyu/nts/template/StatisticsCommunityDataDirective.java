package com.haoyu.nts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.haoyu.nts.statistics.community.entity.CommunityStatistics;
import com.haoyu.nts.statistics.community.service.ICommunityStatisticsService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.utils.Collections3;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class StatisticsCommunityDataDirective extends AbstractTemplateDirectiveModel{

	@Resource
	private ICommunityStatisticsService communityStatisticsService;
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body)
			throws TemplateException, IOException {
		PageBounds pageBounds = getPageBounds(params);
		Map<String,Object> paramerts = getSelectParam(params);
		
		List<CommunityStatistics> communityStatisticsList = communityStatisticsService.list(paramerts, pageBounds);
		env.setVariable("communityStatisticsList", new DefaultObjectWrapper().wrap(communityStatisticsList));
		
		if (Collections3.isNotEmpty(communityStatisticsList) && pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList)communityStatisticsList;
			env.setVariable("paginator" , new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}
		body.render(env.getOut());
	}

}
