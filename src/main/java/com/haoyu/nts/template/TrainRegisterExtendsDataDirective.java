package com.haoyu.nts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.haoyu.nts.train.entity.TrainRegisterExtend;
import com.haoyu.nts.train.service.ITrainRegisterBizService;
import com.haoyu.nts.utils.PageSplitUtils;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;

import freemarker.core.Environment;
import freemarker.ext.beans.BeanModel;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
@Component
public class TrainRegisterExtendsDataDirective extends AbstractTemplateDirectiveModel{
	
	@Resource
	private ITrainRegisterBizService trainregisterBizService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String,Object> parameter = getSelectParam(params);
		PageBounds pageBounds = getPageBounds(params);
		if (params.containsKey("trainRegisterExtend")) {
			BeanModel beanModel = (BeanModel) params.get("trainRegisterExtend");
			if(beanModel!=null){
				TrainRegisterExtend trainRegisterExtend = (TrainRegisterExtend) beanModel.getWrappedObject();
				parameter.putAll( trainRegisterExtend.setParam());
			}
		}
		List<TrainRegisterExtend> trainRegisterExtends = trainregisterBizService.findTrainRegisterExtend(parameter, pageBounds);
		if(pageBounds!=null && pageBounds.isContainsTotalCount()){
			PageList pageList = (PageList)trainRegisterExtends;
			env.setVariable("paginator" , new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}
		env.setVariable("trainRegisterExtends", new DefaultObjectWrapper().wrap(trainRegisterExtends));
	
		body.render(env.getOut());
	}

}
