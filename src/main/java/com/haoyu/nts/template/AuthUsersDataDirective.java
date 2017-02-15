package com.haoyu.nts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.haoyu.sip.auth.entity.AuthUser;
import com.haoyu.sip.auth.service.IAuthUserService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class AuthUsersDataDirective extends AbstractTemplateDirectiveModel {

	@Resource
	private IAuthUserService authUserService;

	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		List<AuthUser> authUsers = authUserService.findAuthUserByParameter(getSelectParam(params));
		env.setVariable("authUsers", new DefaultObjectWrapper().wrap(authUsers));
		body.render(env.getOut());
	}
}
