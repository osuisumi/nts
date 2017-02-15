package com.haoyu.nts.workshop.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.workshop.dao.IDepartmentWorkshopStatDao;
import com.haoyu.nts.workshop.service.IDepartmentWorkshopStatService;
import com.haoyu.nts.workshop.stat.DepartmentWorkshopStat;

@Service
public class DepartmentWorkshopStatService implements IDepartmentWorkshopStatService{
	
	@Resource
	private  IDepartmentWorkshopStatDao departmentWorkshopStatDao;

	@Override
	public List<DepartmentWorkshopStat> school(Map<String, Object> parameter, PageBounds pageBounds) {
		return departmentWorkshopStatDao.school(parameter, pageBounds);
	}

	@Override
	public List<DepartmentWorkshopStat> area(Map<String, Object> parameter, PageBounds pageBounds) {
		return departmentWorkshopStatDao.area(parameter, pageBounds);
	}

	

}
