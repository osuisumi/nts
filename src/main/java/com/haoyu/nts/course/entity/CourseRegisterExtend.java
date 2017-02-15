package com.haoyu.nts.course.entity;

import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.google.common.collect.Maps;
import com.haoyu.ncts.course.entity.CourseRegister;
import com.haoyu.sip.user.entity.UserInfo;

public class CourseRegisterExtend extends CourseRegister {
	private static final long serialVersionUID = 3713842012966502496L;

	private UserInfo userInfo;

	private Date minCreateTime;

	private Date maxCreateTime;

	public UserInfo getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(UserInfo userInfo) {
		this.userInfo = userInfo;
	}

	public Map<String, Object> setParam() {
		Map<String, Object> param = Maps.newHashMap();
		if (this.getCourse() != null && StringUtils.isNotEmpty(this.getCourse().getId())) {
			param.put("courseId", this.getCourse().getId());
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

}
