package com.haoyu.nts.course.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.course.dao.ICourseStatBizDao;
import com.haoyu.nts.course.entity.CourseStatExtend;
import com.haoyu.nts.course.service.ICourseStatBizService;

@Service
public class CourseStatBizService implements ICourseStatBizService{
	@Resource
	private ICourseStatBizDao courseStatBizDao;

	@Override
	public List<CourseStatExtend> listSchool(Map<String, Object> parameter, PageBounds pageBounds) {
		return courseStatBizDao.schoolCourseStat(parameter, pageBounds);
	}

	@Override
	public List<CourseStatExtend> listArea(Map<String, Object> parameter, PageBounds pageBounds) {
		return courseStatBizDao.areaCourseStat(parameter, pageBounds);
	}

}
