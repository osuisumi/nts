package com.haoyu.nts.statistics.project.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.nts.statistics.project.dao.IProjectStatisticsDao;
import com.haoyu.nts.statistics.project.entity.ProjectStatistics;
import com.haoyu.nts.statistics.project.service.IProjectStatisticsService;
import com.haoyu.nts.statistics.train.service.ITrainStatisticsService;
import com.haoyu.sip.utils.Collections3;

@Service
public class ProjectStatisticsServiceImpl implements IProjectStatisticsService {

	@Resource
	private IProjectStatisticsDao projectStatisticsDao;
	@Resource
	private ITrainStatisticsService trainStatisticsService;
	
	@Override
	public List<ProjectStatistics> list(Map<String, Object> param, PageBounds pageBounds) {
		List<ProjectStatistics> projectStatistics = Lists.newArrayList();
		if (param.containsKey("queryType") && StringUtils.isNotEmpty(param.get("queryType").toString())) {
			if ("areaStat".equals(param.get("queryType").toString())) {
				projectStatistics = projectStatisticsDao.selectArea(param, pageBounds);
			}
		}else {
			projectStatistics =  projectStatisticsDao.select(param, pageBounds);
		}
		return projectStatistics;
	}

	@Override
	public ProjectStatistics getProjectStatistics(String projectId) {
		Map<String, Object> param = Maps.newHashMap();
		param.put("projectId", projectId);
		List<ProjectStatistics> projectStatistics = this.list(param, null);
		if (Collections3.isNotEmpty(projectStatistics)) {
			return projectStatistics.get(0);
		}
		return null;
	}

}
