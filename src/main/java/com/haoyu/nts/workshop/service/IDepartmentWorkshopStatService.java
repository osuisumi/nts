package com.haoyu.nts.workshop.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.workshop.stat.DepartmentWorkshopStat;

public interface IDepartmentWorkshopStatService {
	
	List<DepartmentWorkshopStat> school(Map<String,Object> parameter,PageBounds pageBounds);
	
	List<DepartmentWorkshopStat> area(Map<String,Object> parameter,PageBounds pageBounds);

}
