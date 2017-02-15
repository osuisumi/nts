package com.haoyu.nts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.ncts.course.entity.CourseResult;
import com.haoyu.ncts.course.service.ICourseResultService;
import com.haoyu.nts.course.entity.CourseRegisterExtend;
import com.haoyu.nts.course.service.ICourseRegisterBizService;
import com.haoyu.nts.utils.PageSplitUtils;
import com.haoyu.sip.utils.Collections3;

import freemarker.core.Environment;
import freemarker.ext.beans.BeanModel;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateBooleanModel;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class CourseRegistersDataDirective implements TemplateDirectiveModel{
	
	@Resource
	private ICourseRegisterBizService courseRegisterBizService;
	@Resource
	private ICourseResultService courseResultService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> param = Maps.newHashMap();
		List<CourseRegisterExtend> courseRegisters = Lists.newArrayList();
		PageBounds pageBounds = PageSplitUtils.getPageBounds(params, env);
		if (params.containsKey("courseRegisterExtend") && params.get("courseRegisterExtend") != null) {
			BeanModel beanModel = (BeanModel) params.get("courseRegisterExtend");
			if (beanModel != null) {
				CourseRegisterExtend courseRegisterExtend = (CourseRegisterExtend) beanModel.getWrappedObject();
				courseRegisters = courseRegisterBizService.findCourseRegisterExtend(courseRegisterExtend, pageBounds);
			}
		}
		env.setVariable("courseRegisters", new DefaultObjectWrapper().wrap(courseRegisters));
		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList)courseRegisters;
			env.setVariable("paginator" , new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}
		
		if (Collections3.isNotEmpty(courseRegisters) && params.containsKey("getResult")) {
			TemplateBooleanModel model = (TemplateBooleanModel) params.get("getResult");
			if (model != null) {
				boolean getResult = model.getAsBoolean();
				if (getResult) {
					List<String> ids = Collections3.extractToList(courseRegisters, "id");
					param = Maps.newHashMap();
					param.put("ids", ids);
					Map<String, CourseResult> courseResultMap = courseResultService.mapCourseResult(param);
					env.setVariable("courseResultMap" , new DefaultObjectWrapper().wrap(courseResultMap));
				}
			}
		}
		body.render(env.getOut());
		
	}

}
