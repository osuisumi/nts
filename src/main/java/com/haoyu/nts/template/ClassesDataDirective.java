package com.haoyu.nts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.haoyu.ncts.clazz.service.IClassService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.ncts.clazz.entity.Class;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class ClassesDataDirective extends  AbstractTemplateDirectiveModel{
	
	@Resource
	private IClassService classService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		PageBounds pageBounds = getPageBounds(params);
		Map<String, Object> param = getSelectParam(params);
		List<Class> classes = classService.listClass(param, pageBounds);
		env.setVariable("classes", new DefaultObjectWrapper().wrap(classes));
		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList)classes;
			env.setVariable("paginator" , new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}
		body.render(env.getOut());
		
	}

}
