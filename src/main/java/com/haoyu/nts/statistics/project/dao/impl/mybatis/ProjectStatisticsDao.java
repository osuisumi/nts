package com.haoyu.nts.statistics.project.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.statistics.project.dao.IProjectStatisticsDao;
import com.haoyu.nts.statistics.project.entity.ProjectStatistics;
import com.haoyu.sip.core.jdbc.MybatisDao;

@Repository
public class ProjectStatisticsDao extends MybatisDao implements IProjectStatisticsDao {

	@Override
	public List<ProjectStatistics> select(Map<String, Object> param, PageBounds pageBounds) {
		return super.selectList("selectByParameter", param, pageBounds);
	}

	@Override
	public List<ProjectStatistics> selectArea(Map<String, Object> param, PageBounds pageBounds) {
		return super.selectList("selectAreaByParameter", param, pageBounds);
	}

}