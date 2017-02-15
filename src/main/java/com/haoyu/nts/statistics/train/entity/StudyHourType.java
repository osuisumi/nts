package com.haoyu.nts.statistics.train.entity;

import java.io.Serializable;
import java.math.BigDecimal;

import com.haoyu.sip.core.mapper.JsonMapper;

public class StudyHourType implements Serializable{

	private static final long serialVersionUID = -7919464692130843475L;

	private BigDecimal course = new BigDecimal(0);
	
	private BigDecimal workshop = new BigDecimal(0);
	
	private BigDecimal community = new BigDecimal(0);

	public BigDecimal getCourse() {
		return course;
	}

	public void setCourse(BigDecimal course) {
		this.course = course;
	}

	public BigDecimal getWorkshop() {
		return workshop;
	}

	public void setWorkshop(BigDecimal workshop) {
		this.workshop = workshop;
	}

	public BigDecimal getCommunity() {
		return community;
	}

	public void setCommunity(BigDecimal community) {
		this.community = community;
	}
	
	public static StudyHourType getStudyHourType(String json){
		JsonMapper jsonMapper = new JsonMapper();
		return jsonMapper.fromJson(json, StudyHourType.class);
	}
}
