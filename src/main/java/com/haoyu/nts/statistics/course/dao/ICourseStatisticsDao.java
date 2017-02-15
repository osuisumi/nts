package com.haoyu.nts.statistics.course.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.statistics.course.entity.CourseStatistics;

public interface ICourseStatisticsDao {

	public List<CourseStatistics> select(Map<String, Object> param,PageBounds pageBounds);

}
