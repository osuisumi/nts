package com.haoyu.nts.course.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.course.entity.CourseAuthorizeStat;

public interface ICourseAuthorizeStatDao {
	
	List<CourseAuthorizeStat> list(Map<String,Object> parameter,PageBounds pageBounds);

}
