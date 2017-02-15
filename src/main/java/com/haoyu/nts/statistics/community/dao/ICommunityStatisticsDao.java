package com.haoyu.nts.statistics.community.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.statistics.community.entity.CommunityStatistics;

public interface ICommunityStatisticsDao {

	List<CommunityStatistics> select(Map<String, Object> param,PageBounds pageBounds);
	
	List<CommunityStatistics> selectStudent(Map<String, Object> param,PageBounds pageBounds);
}
