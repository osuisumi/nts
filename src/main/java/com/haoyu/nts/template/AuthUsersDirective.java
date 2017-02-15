package com.haoyu.nts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.haoyu.sip.auth.entity.AuthRole;
import com.haoyu.sip.auth.entity.AuthUser;
import com.haoyu.sip.auth.service.IAuthUserService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class AuthUsersDirective extends AbstractTemplateDirectiveModel {

	@Resource
	private IAuthUserService authUserService;

	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> parameter = getSelectParam(params);
		String roleCode = null;
		String relationId = null;
		if (parameter.containsKey("roleCode")) {
			roleCode = (String) parameter.get("roleCode");
		}
		if (parameter.containsKey("relationId")) {
			relationId = (String) parameter.get("relationId");
		}
		AuthRole authRole = new AuthRole();
		authRole.setCode(roleCode);
		List<AuthUser> authUsers = authUserService.findAuthUserByRoleAndRelation(authRole, relationId);
		env.setVariable("authUsers", new DefaultObjectWrapper().wrap(authUsers));
		body.render(env.getOut());
	}
}
