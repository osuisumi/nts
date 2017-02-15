package com.haoyu.nts.train.entity;

import com.haoyu.ncts.course.entity.CourseRegister;
import com.haoyu.ncts.course.entity.CourseResult;

public class CourseRegisterExtend extends CourseRegister{
	private static final long serialVersionUID = -3012153137219662997L;
	
	private CourseResult courseResult;

	public CourseResult getCourseResult() {
		return courseResult;
	}

	public void setCourseResult(CourseResult courseResult) {
		this.courseResult = courseResult;
	}

	
	
}
