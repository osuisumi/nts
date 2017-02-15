package com.haoyu.nts.course.service;

import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.course.entity.CourseAuthorizeStat;

public interface ICourseAuthorizeStatService {
	
	List<CourseAuthorizeStat> list(Map<String,Object> parameter,PageBounds pageBounds);
	
	void export(Map<String,Object> parameter,PageBounds pageBounds,OutputStream outputStream);

}
