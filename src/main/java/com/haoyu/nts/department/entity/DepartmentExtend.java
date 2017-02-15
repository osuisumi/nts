package com.haoyu.nts.department.entity;

import com.haoyu.common.regions.entity.Regions;
import com.haoyu.sip.user.entity.Department;

public class DepartmentExtend extends Department{

	private static final long serialVersionUID = -3052880550307882475L;

	private Regions province;
	
	private Regions city;
	
	private Regions counties;

	public DepartmentExtend() {
	}

	public Regions getProvince() {
		return province;
	}

	public void setProvince(Regions province) {
		this.province = province;
	}

	public Regions getCity() {
		return city;
	}

	public void setCity(Regions city) {
		this.city = city;
	}

	public Regions getCounties() {
		return counties;
	}

	public void setCounties(Regions counties) {
		this.counties = counties;
	}

}
