package com.haoyu.nts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.haoyu.nts.train.entity.TrainClassStat;
import com.haoyu.nts.train.service.ITrainClassStatService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class TrainClassStatsDirective extends AbstractTemplateDirectiveModel {
	@Resource
	private ITrainClassStatService trainClassStatService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> selectParameter = getSelectParam(params);
		PageBounds pageBounds = getPageBounds(params);
		List<TrainClassStat> trainClassStats = trainClassStatService.findTrainClassStats(selectParameter, pageBounds);
		env.setVariable("trainClassStats", new DefaultObjectWrapper().wrap(trainClassStats));
		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList) trainClassStats;
			env.setVariable("paginator", new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}

		body.render(env.getOut());

	}

}
