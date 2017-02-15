package com.haoyu.nts.account.listener;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.google.common.collect.Lists;
import com.haoyu.sip.auth.service.IAuthRoleService;
import com.haoyu.sip.user.entity.Account;
import com.haoyu.sip.user.event.CreateAccountEvent;
import com.haoyu.sip.utils.Collections3;

@Component
public class CreateAccountListener implements ApplicationListener<CreateAccountEvent>{

	@Resource
	private IAuthRoleService authRoleService;
	
	@Override
	public void onApplicationEvent(CreateAccountEvent event) {
		Account account = (Account) event.getSource();
		if(Collections3.isNotEmpty(account.getRoles())){
			List<String> userIds = Lists.newArrayList(account.getUser().getId());
			authRoleService.addUsersToRole(account.getRoles().get(0),userIds, "nts");
		}
	}

}
