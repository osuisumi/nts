package com.haoyu.nts.template;

import java.io.IOException;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.haoyu.nts.user.entity.User;
import com.haoyu.nts.user.service.IUserBizService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class BaseUserViewMapDirective extends AbstractTemplateDirectiveModel {
	@Resource
	private IUserBizService userBizService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> parameter = getSelectParam(params);
		Map<String, User> BUVUserMap = userBizService.userIdKeyMap(parameter);
		env.setVariable("BUVUserMap", new DefaultObjectWrapper().wrap(BUVUserMap));
		body.render(env.getOut());
	}

}
