package com.haoyu.nts.course.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.course.entity.CourseRegisterExtend;
import com.haoyu.sip.core.service.Response;

public interface ICourseRegisterBizService {
	
	public List<CourseRegisterExtend> findCourseRegisterExtend(Map<String, Object> param, PageBounds pageBounds);
	
	public List<CourseRegisterExtend> findCourseRegisterExtend(CourseRegisterExtend courseRegisterExtend,PageBounds pageBounds);
	
	Map<String, Object> importCourseRegister(String url,String courseId,String trainId);

	public Response autoImportCourseRegister(String courseId, String trainId, String stage);

}
