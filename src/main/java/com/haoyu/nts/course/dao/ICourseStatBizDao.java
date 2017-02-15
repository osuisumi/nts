package com.haoyu.nts.course.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.course.entity.CourseStatExtend;

public interface ICourseStatBizDao {
	
	public List<CourseStatExtend> schoolCourseStat(Map<String,Object> parameter,PageBounds pageBounds);
	
	public List<CourseStatExtend> areaCourseStat(Map<String,Object> parameter,PageBounds pageBounds);
	

}
