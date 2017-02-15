package com.haoyu.nts.course.controller.param;

import java.io.Serializable;
import java.util.List;

import com.google.common.collect.Lists;
import com.haoyu.ncts.course.entity.CourseAuthorize;

public class CourseAuthorizeParam implements Serializable{
	
	private static final long serialVersionUID = -7717275732213869015L;

	private List<CourseAuthorize> courseAuthorizes = Lists.newArrayList();
	
	private String userId;
	
	private String courseId;
	
	private String role;

	public String getCourseId() {
		return courseId;
	}

	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public List<CourseAuthorize> getCourseAuthorizes() {
		return courseAuthorizes;
	}

	public void setCourseAuthorizes(List<CourseAuthorize> courseAuthorizes) {
		this.courseAuthorizes = courseAuthorizes;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

}
