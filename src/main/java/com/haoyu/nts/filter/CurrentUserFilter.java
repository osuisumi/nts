package com.haoyu.nts.filter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.web.filter.authz.AuthorizationFilter;

import com.haoyu.sip.core.entity.User;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.login.Loginer;

public class CurrentUserFilter extends AuthorizationFilter {

	@Override
	protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {
		Loginer loginer = (Loginer) ((HttpServletRequest)request).getSession().getAttribute("loginer");
		if (loginer != null) {
			User user = new User();
			user.setId(loginer.getId());
			user.setRealName(loginer.getRealName());
			ThreadContext.bind(user);
		}
		return true;
	}

}
