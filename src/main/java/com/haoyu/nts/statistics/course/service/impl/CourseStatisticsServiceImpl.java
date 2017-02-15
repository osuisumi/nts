package com.haoyu.nts.statistics.course.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.statistics.course.dao.ICourseStatisticsDao;
import com.haoyu.nts.statistics.course.entity.CourseStatistics;
import com.haoyu.nts.statistics.course.service.ICourseStatisticsService;

@Service
public class CourseStatisticsServiceImpl implements ICourseStatisticsService {

	@Resource
	private ICourseStatisticsDao courseStatisticsDao;
	
	@Override
	public List<CourseStatistics> list(Map<String, Object> param, PageBounds pageBounds) {
		return courseStatisticsDao.select(param, pageBounds);
	}

}
