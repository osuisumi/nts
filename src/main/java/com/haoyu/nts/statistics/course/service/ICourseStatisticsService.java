package com.haoyu.nts.statistics.course.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.statistics.course.entity.CourseStatistics;

public interface ICourseStatisticsService {
	
	List<CourseStatistics> list(Map<String, Object> param, PageBounds pageBounds);

}
