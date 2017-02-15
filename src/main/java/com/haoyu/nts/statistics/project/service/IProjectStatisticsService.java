package com.haoyu.nts.statistics.project.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.statistics.project.entity.ProjectStatistics;

public interface IProjectStatisticsService {

	List<ProjectStatistics> list(Map<String, Object> param, PageBounds pageBounds);

	ProjectStatistics getProjectStatistics(String projectId);

}
