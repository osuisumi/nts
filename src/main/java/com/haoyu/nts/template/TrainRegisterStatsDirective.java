package com.haoyu.nts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.haoyu.nts.train.entity.TrainRegisterStat;
import com.haoyu.nts.train.service.ITrainRegisterStatService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class TrainRegisterStatsDirective extends AbstractTemplateDirectiveModel {
	@Resource
	private ITrainRegisterStatService trainRegisterStatService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> parameter = getSelectParam(params);
		PageBounds pageBounds = getPageBounds(params);

		List<TrainRegisterStat> trainRegisterStats = trainRegisterStatService.list(parameter, pageBounds);
		if(CollectionUtils.isNotEmpty(trainRegisterStats)){
			env.setVariable("trainRegisterStats", new DefaultObjectWrapper().wrap(trainRegisterStats));

			if (pageBounds != null && pageBounds.isContainsTotalCount()) {
				PageList pageList = (PageList) trainRegisterStats;
				env.setVariable("paginator", new DefaultObjectWrapper().wrap(pageList.getPaginator()));
			}
		}
		body.render(env.getOut());

	}

}
