package com.haoyu.nts.workshop.web;

import java.util.List;

import com.google.common.collect.Lists;
import com.haoyu.wsts.workshop.entity.Workshop;

public class Workshops {

	private List<Workshop> workshops = Lists.newArrayList();

	public List<Workshop> getWorkshops() {
		return workshops;
	}

	public void setWorkshops(List<Workshop> workshops) {
		this.workshops = workshops;
	}

}
