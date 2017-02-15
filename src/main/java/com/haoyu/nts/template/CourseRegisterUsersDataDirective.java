package com.haoyu.nts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.sip.core.entity.User;
import com.haoyu.sip.core.utils.PropertiesLoader;
import com.haoyu.sip.user.entity.UserInfo;
import com.haoyu.sip.user.service.IUserInfoService;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.tip.train.entity.TrainRegister;
import com.haoyu.tip.train.service.ITrainRegisterService;
import com.haoyu.tip.train.utils.TrainRegisterState;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
@Component
public class CourseRegisterUsersDataDirective implements TemplateDirectiveModel {
	@Resource
	private IUserInfoService userInfoService;
	@Resource
	private PropertiesLoader propertiesLoader;
	@Resource
	private ITrainRegisterService trainRegisterService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		String isNeedTrainRegister = propertiesLoader.getProperty("is_need_train_register");
		if ("true".equals(isNeedTrainRegister)) {
			if (params.containsKey("trainId") && StringUtils.isNotEmpty(params.get("trainId").toString())) {
				Map<String, Object> param = Maps.newHashMap();
				param.put("state", TrainRegisterState.PASS);
				String trainId = params.get("trainId").toString();
				param.put("trainId", trainId);
				List<TrainRegister> trainRegister = trainRegisterService.findTrainRegisters(param);
				List<User> users = Collections3.extractToList(trainRegister, "user");
				if (users != null) {
					env.setVariable("users", new DefaultObjectWrapper().wrap(users));
				} else {
					env.setVariable("users", new DefaultObjectWrapper().wrap(Lists.newArrayList()));
				}
			}else{
				env.setVariable("users", new DefaultObjectWrapper().wrap(Lists.newArrayList()));
			}
		} else {
			Map<String, Object> param = Maps.newHashMap();
			List<UserInfo> users = userInfoService.listUser(param, null);
			if (users != null) {
				env.setVariable("users", new DefaultObjectWrapper().wrap(users));
			} else {
				env.setVariable("users", new DefaultObjectWrapper().wrap(Lists.newArrayList()));
			}
		}

		body.render(env.getOut());

	}

}
