package com.haoyu.nts.train.entity;

import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.google.common.collect.Maps;
import com.haoyu.sip.core.entity.User;
import com.haoyu.sip.user.entity.UserInfo;
import com.haoyu.tip.train.entity.TrainRegister;

public class TrainRegisterExtend extends TrainRegister {

	private static final long serialVersionUID = 2007900900705805561L;

	private UserInfo userInfo;

	private User user;

	private Date minCreateTime;

	private Date maxCreateTime;

	private String workshopUserRole;
	
	private String className;

	public UserInfo getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(UserInfo userInfo) {
		this.userInfo = userInfo;
	}

	public Map<String, Object> setParam() {
		Map<String, Object> param = Maps.newHashMap();
		if (this.getTrain() != null && StringUtils.isNotEmpty(this.getTrain().getId())) {
			param.put("trainId", this.getTrain().getId());
		}
		if (this.getUserInfo() != null && StringUtils.isNotEmpty(this.getUserInfo().getRealName())) {
			param.put("realName", this.getUserInfo().getRealName());
		}
		if (this.getUserInfo() != null && this.getUserInfo().getDepartment() != null && StringUtils.isNotEmpty(this.getUserInfo().getDepartment().getDeptName())) {
			param.put("deptName", this.getUserInfo().getDepartment().getDeptName());
		}
		if (StringUtils.isNotEmpty(this.getState())) {
			param.put("state", this.getState());
		}
		if (this.minCreateTime != null) {
			param.put("minCreateTime", setDayBegin(this.minCreateTime).getTime());
		}
		if (this.maxCreateTime != null) {
			param.put("maxCreateTime", setDayEnd(this.maxCreateTime).getTime());
		}
		return param;
	}

	public Date getMinCreateTime() {
		return minCreateTime;
	}

	public void setMinCreateTime(Date minCreateTime) {
		this.minCreateTime = minCreateTime;
	}

	public Date getMaxCreateTime() {
		return maxCreateTime;
	}

	public void setMaxCreateTime(Date maxCreateTime) {
		this.maxCreateTime = maxCreateTime;
	}

	private Date setDayBegin(Date date) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.set(Calendar.HOUR_OF_DAY, 0);
		c.set(Calendar.MINUTE, 0);
		c.set(Calendar.SECOND, 0);
		c.set(Calendar.MILLISECOND, 0);
		return c.getTime();
	}

	private Date setDayEnd(Date date) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.set(Calendar.HOUR_OF_DAY, 23);
		c.set(Calendar.MINUTE, 59);
		c.set(Calendar.SECOND, 59);
		return c.getTime();
	}

	public String getWorkshopUserRole() {
		return workshopUserRole;
	}

	public void setWorkshopUserRole(String workshopUserRole) {
		this.workshopUserRole = workshopUserRole;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}
	
	

}
