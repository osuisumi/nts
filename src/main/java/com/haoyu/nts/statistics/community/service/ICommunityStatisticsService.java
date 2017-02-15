package com.haoyu.nts.statistics.community.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.statistics.community.entity.CommunityStatistics;

public interface ICommunityStatisticsService {

	List<CommunityStatistics> list(Map<String, Object> param, PageBounds pageBounds);
}
