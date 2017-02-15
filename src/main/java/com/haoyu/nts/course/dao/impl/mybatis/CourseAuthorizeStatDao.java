package com.haoyu.nts.course.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.course.dao.ICourseAuthorizeStatDao;
import com.haoyu.nts.course.entity.CourseAuthorizeStat;
import com.haoyu.sip.core.jdbc.MybatisDao;
@Repository
public class CourseAuthorizeStatDao extends MybatisDao implements ICourseAuthorizeStatDao{

	@Override
	public List<CourseAuthorizeStat> list(Map<String, Object> parameter, PageBounds pageBounds) {
		return super.selectList("select", parameter, pageBounds);
	}

}
