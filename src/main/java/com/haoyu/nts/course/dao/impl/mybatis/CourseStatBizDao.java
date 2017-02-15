package com.haoyu.nts.course.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.haoyu.nts.course.dao.ICourseStatBizDao;
import com.haoyu.nts.course.entity.CourseStatExtend;
import com.haoyu.sip.core.jdbc.MybatisDao;

@Repository
public class CourseStatBizDao extends MybatisDao implements ICourseStatBizDao{

	@Override
	public List<CourseStatExtend> schoolCourseStat(Map<String, Object> parameter, PageBounds pageBounds) {
		//临时删除统计
		//return super.selectList("school", parameter, pageBounds);
		return Lists.newArrayList();
	}

	@Override
	public List<CourseStatExtend> areaCourseStat(Map<String, Object> parameter, PageBounds pageBounds) {
		//临时删除统计
//		return super.selectList("area", parameter, pageBounds);
		return Lists.newArrayList();
	}

}
