package com.haoyu.nts.course.service.impl;

import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.course.dao.ICourseAuthorizeStatDao;
import com.haoyu.nts.course.entity.CourseAuthorizeStat;
import com.haoyu.nts.course.service.ICourseAuthorizeStatService;
import com.haoyu.sip.excel.ExcelExport;

@Service
public class CourseAuthorizeStatService implements ICourseAuthorizeStatService{
	@Resource
	private ICourseAuthorizeStatDao courseAuthorizeStatDao;

	@Override
	public List<CourseAuthorizeStat> list(Map<String, Object> parameter, PageBounds pageBounds) {
		return courseAuthorizeStatDao.list(parameter, pageBounds);
	}

	@Override
	public void export(Map<String, Object> parameter, PageBounds pageBounds, OutputStream outputStream) {
		List<CourseAuthorizeStat> courseAuthorizeStats = this.list(parameter, pageBounds);
		if(CollectionUtils.isNotEmpty(courseAuthorizeStats)){
			for(CourseAuthorizeStat ca:courseAuthorizeStats){
				ca.setExpertField();
			}
		}
		ExcelExport<CourseAuthorizeStat> ee = new ExcelExport<CourseAuthorizeStat>(CourseAuthorizeStat.class);
		ee.exportExcel(courseAuthorizeStats, outputStream);
	}

}
