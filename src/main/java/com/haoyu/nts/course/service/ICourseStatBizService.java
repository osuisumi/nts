
package com.haoyu.nts.course.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.course.entity.CourseStatExtend;

public interface ICourseStatBizService {
	
	List<CourseStatExtend> listSchool(Map<String,Object> parameter,PageBounds pageBounds);
	
	List<CourseStatExtend> listArea(Map<String,Object> parameter,PageBounds pageBounds);

}
