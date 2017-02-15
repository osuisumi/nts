package com.haoyu.nts.course.entity;

import com.haoyu.ncts.course.entity.CourseStat;
import com.haoyu.sip.user.entity.Department;

public class CourseStatExtend extends CourseStat {

	private Department department;

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

}
