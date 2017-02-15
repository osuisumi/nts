package com.haoyu.nts.statistics.project.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.statistics.project.entity.ProjectStatistics;
import com.haoyu.nts.statistics.train.entity.TrainStatistics;

public interface IProjectStatisticsDao {

	List<ProjectStatistics> select(Map<String, Object> param,PageBounds pageBounds);

	List<ProjectStatistics> selectArea(Map<String, Object> param,PageBounds pageBounds);
	
}
