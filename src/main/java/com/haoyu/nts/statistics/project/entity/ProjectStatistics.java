package com.haoyu.nts.statistics.project.entity;

import com.haoyu.sip.core.entity.TimePeriod;
import com.haoyu.tip.project.entity.Project;

public class ProjectStatistics extends Project{

	private static final long serialVersionUID = -2757240127892855856L;
	
	//培训总数
	private int trainNum;
	
	//报名总人数
	private int registerHeadcount;
	
	//合格总人数
	private int passHeadcount;
	
	//合格率
	private double passPercent;
	
	//参与单位数
	private int participateDepartmentNum;
	
	//参训人数
	private int participateHeadcount;
	
	//参训率
	private double participatePercent;
	
	//项目执行时间
	private TimePeriod timePeriod;
	
	//省
	private String province;
	
	//市
	private String city;
	
	//区县
	private String counties;
	
	private String provinceRegionsCode;
	
	private String cityRegionsCode;
	
	private String countiesRegionsCode;
		
	public int getTrainNum() {
		return trainNum;
	}

	public void setTrainNum(int trainNum) {
		this.trainNum = trainNum;
	}

	public int getPassHeadcount() {
		return passHeadcount;
	}

	public void setPassHeadcount(int passHeadcount) {
		this.passHeadcount = passHeadcount;
	}

	public int getRegisterHeadcount() {
		return registerHeadcount;
	}

	public void setRegisterHeadcount(int registerHeadcount) {
		this.registerHeadcount = registerHeadcount;
	}

	public int getParticipateDepartmentNum() {
		return participateDepartmentNum;
	}

	public void setParticipateDepartmentNum(int participateDepartmentNum) {
		this.participateDepartmentNum = participateDepartmentNum;
	}

	public int getParticipateHeadcount() {
		return participateHeadcount;
	}

	public void setParticipateHeadcount(int participateHeadcount) {
		this.participateHeadcount = participateHeadcount;
	}

	public double getParticipatePercent() {
		return participatePercent;
	}

	public void setParticipatePercent(double participatePercent) {
		this.participatePercent = participatePercent;
	}

	public TimePeriod getTimePeriod() {
		return timePeriod;
	}

	public void setTimePeriod(TimePeriod timePeriod) {
		this.timePeriod = timePeriod;
	}

	public double getPassPercent() {
		return passPercent;
	}

	public void setPassPercent(double passPercent) {
		this.passPercent = passPercent;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getCounties() {
		return counties;
	}

	public void setCounties(String counties) {
		this.counties = counties;
	}

	public String getProvinceRegionsCode() {
		return provinceRegionsCode;
	}

	public void setProvinceRegionsCode(String provinceRegionsCode) {
		this.provinceRegionsCode = provinceRegionsCode;
	}

	public String getCityRegionsCode() {
		return cityRegionsCode;
	}

	public void setCityRegionsCode(String cityRegionsCode) {
		this.cityRegionsCode = cityRegionsCode;
	}

	public String getCountiesRegionsCode() {
		return countiesRegionsCode;
	}

	public void setCountiesRegionsCode(String countiesRegionsCode) {
		this.countiesRegionsCode = countiesRegionsCode;
	}
	
}