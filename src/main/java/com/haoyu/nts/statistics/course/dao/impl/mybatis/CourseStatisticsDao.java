package com.haoyu.nts.statistics.course.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.haoyu.nts.statistics.course.dao.ICourseStatisticsDao;
import com.haoyu.nts.statistics.course.entity.CourseStatistics;
import com.haoyu.sip.core.jdbc.MybatisDao;

@Repository
public class CourseStatisticsDao extends MybatisDao implements ICourseStatisticsDao{

	@Override
	public List<CourseStatistics> select(Map<String, Object> param, PageBounds pageBounds) {
		//return super.selectList("selectByParameter", param, pageBounds);
		return Lists.newArrayList();
	}

}
