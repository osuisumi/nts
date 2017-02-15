package com.haoyu.nts.course.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.course.entity.CourseRegisterExtend;

public interface ICourseRegisterBizDao {
	
	public List<CourseRegisterExtend> selectByParameter(Map<String, Object> param, PageBounds pageBounds);

	public int insertByTrainId(Map<String, Object> param);

}
