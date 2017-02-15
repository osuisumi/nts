package com.haoyu.nts.statistics.train.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.statistics.train.entity.TrainResultStatistics;
import com.haoyu.nts.statistics.train.entity.TrainStatistics;

public interface ITrainStatisticsDao {
	
	List<TrainStatistics> select(Map<String, Object> param,PageBounds pageBounds);

	List<TrainResultStatistics> selectRegister(Map<String, Object> param, PageBounds pageBounds);

	List<TrainStatistics> selectArea(Map<String, Object> param,PageBounds pageBounds);
	
	List<TrainStatistics> selectSchool(Map<String, Object> param,PageBounds pageBounds);

	List<TrainStatistics> selectStudent(Map<String, Object> param, PageBounds pageBounds);
}
