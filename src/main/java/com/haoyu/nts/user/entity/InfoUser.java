package com.haoyu.nts.user.entity;

import com.haoyu.sip.core.entity.BaseEntity;

public class InfoUser extends BaseEntity{
	
	private static final long serialVersionUID = 4855930044438745070L;

	private String id;
	
	private String userName;
	
	private String password;
	
	private String realName;
	
	private String deptName;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

}
