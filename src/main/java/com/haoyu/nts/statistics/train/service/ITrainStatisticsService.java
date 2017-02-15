package com.haoyu.nts.statistics.train.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.statistics.train.entity.TrainResultStatistics;
import com.haoyu.nts.statistics.train.entity.TrainStatistics;

public interface ITrainStatisticsService {

	List<TrainStatistics> list(Map<String, Object> param, PageBounds pageBounds);

	List<TrainResultStatistics> listRegister(Map<String, Object> param, PageBounds pageBounds);

}
