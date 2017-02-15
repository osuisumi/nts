package com.haoyu.nts.workshop.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.workshop.dao.IDepartmentWorkshopStatDao;
import com.haoyu.nts.workshop.stat.DepartmentWorkshopStat;
import com.haoyu.sip.core.jdbc.MybatisDao;

@Repository
public class DepartmentWorkshopStatDao extends MybatisDao implements IDepartmentWorkshopStatDao{

	@Override
	public List<DepartmentWorkshopStat> school(Map<String, Object> parameter, PageBounds pageBounds) {
		return super.selectList("school", parameter, pageBounds);
	}

	@Override
	public List<DepartmentWorkshopStat> area(Map<String, Object> parameter, PageBounds pageBounds) {
		return super.selectList("area", parameter, pageBounds);	
	}


}
