package com.haoyu.nts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.sip.user.entity.UserInfo;
import com.haoyu.sip.user.service.IUserInfoService;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class UsersDataDirective implements TemplateDirectiveModel {
	@Resource
	private IUserInfoService userInfoService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> param = Maps.newHashMap();
		List<UserInfo> users = userInfoService.listUser(param, null);
		if (users != null) {
			env.setVariable("users", new DefaultObjectWrapper().wrap(users));
		} else {
			env.setVariable("users", new DefaultObjectWrapper().wrap(Lists.newArrayList()));
		}
		body.render(env.getOut());

	}

}
