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
import com.haoyu.nts.statistics.train.entity.TrainResultStatistics;
import com.haoyu.nts.statistics.train.service.ITrainStatisticsService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.utils.Collections3;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class StatisticsTrainResultDataDirective extends AbstractTemplateDirectiveModel {

	@Resource
	private ITrainStatisticsService trainStatisticsService;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body)
			throws TemplateException, IOException {
		Map<String,Object> param = getSelectParam(params);
		PageBounds pageBounds =  getPageBounds(params);
		List<TrainResultStatistics> trainResultStatistics = Lists.newArrayList();
		
		if (param.containsKey("trainId") && StringUtils.isNotEmpty(param.get("trainId").toString())) {
			trainResultStatistics = trainStatisticsService.listRegister(param, pageBounds);
			env.setVariable("trainResultStatistics", new DefaultObjectWrapper().wrap(trainResultStatistics));
		}
		if (Collections3.isNotEmpty(trainResultStatistics) && pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList) trainResultStatistics;
			env.setVariable("paginator", new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}
		body.render(env.getOut());
	}

}
