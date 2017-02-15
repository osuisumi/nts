package com.haoyu.nts.workshop.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.workshop.stat.DepartmentWorkshopStat;

public interface IDepartmentWorkshopStatDao {
	
	List<DepartmentWorkshopStat> school(Map<String,Object> parameter,PageBounds pageBounds);
	
	List<DepartmentWorkshopStat> area(Map<String,Object> parameter,PageBounds pageBounds);
}
