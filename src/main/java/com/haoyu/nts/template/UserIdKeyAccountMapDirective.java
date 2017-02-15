package com.haoyu.nts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.haoyu.nts.account.service.IAccountBizService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.user.entity.Account;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class UserIdKeyAccountMapDirective extends AbstractTemplateDirectiveModel {
	@Resource
	private IAccountBizService accountBizService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> parameter = getSelectParam(params);
		if(parameter.containsKey("userIds")){
			Map<String,Account> result = accountBizService.getMap(parameter);
			env.setVariable("accountMap", new DefaultObjectWrapper().wrap(result));
		}
		body.render(env.getOut());

	}

}
