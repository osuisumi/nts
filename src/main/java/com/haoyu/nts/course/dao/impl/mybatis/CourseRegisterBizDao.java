package com.haoyu.nts.course.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.course.dao.ICourseRegisterBizDao;
import com.haoyu.nts.course.entity.CourseRegisterExtend;
import com.haoyu.sip.core.jdbc.MybatisDao;

@Repository
public class CourseRegisterBizDao extends MybatisDao implements ICourseRegisterBizDao{

	@Override
	public List<CourseRegisterExtend> selectByParameter(Map<String, Object> param, PageBounds pageBounds) {
		return super.selectList("selectByParameter",param, pageBounds);
	}

	@Override
	public int insertByTrainId(Map<String, Object> param) {
		return insert("insertByTrainId", param);
	}

}
