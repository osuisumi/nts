package com.haoyu.nts.statistics.train.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.haoyu.nts.statistics.train.dao.ITrainStatisticsDao;
import com.haoyu.nts.statistics.train.entity.TrainResultStatistics;
import com.haoyu.nts.statistics.train.entity.TrainStatistics;
import com.haoyu.nts.statistics.train.service.ITrainStatisticsService;
import com.haoyu.sip.core.utils.PropertiesLoader;

@Service
public class TrainStatisticsServiceImpl implements ITrainStatisticsService {

	@Resource
	private ITrainStatisticsDao trainStatisticsDao;
	
	@Override
	public List<TrainStatistics> list(Map<String, Object> param, PageBounds pageBounds) {
		List<TrainStatistics> trainStatistics = Lists.newArrayList();
		param.put("date_to_long_prefix",PropertiesLoader.get("date_to_long_prefix"));
		param.put("date_to_long_suffix",PropertiesLoader.get("date_to_long_suffix"));
		if (param.containsKey("queryType") && StringUtils.isNotEmpty(param.get("queryType").toString())) {
			if ("areaStat".equals(param.get("queryType").toString())) {
				trainStatistics = trainStatisticsDao.selectArea(param, pageBounds);
			}
			if ("schoolStat".equals(param.get("queryType").toString())) {
				trainStatistics =  trainStatisticsDao.selectSchool(param, pageBounds);
			}
			if ("studentStat".equals(param.get("queryType").toString())) {
				trainStatistics =  trainStatisticsDao.selectStudent(param, pageBounds);
			}
		}else {
			trainStatistics =  trainStatisticsDao.select(param, pageBounds);
		}
		
		return trainStatistics;
	}

	@Override
	public List<TrainResultStatistics> listRegister(Map<String, Object> param, PageBounds pageBounds) {
		return trainStatisticsDao.selectRegister(param, pageBounds);
	}

}
