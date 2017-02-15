package com.haoyu.nts.statistics.community.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.statistics.community.dao.ICommunityStatisticsDao;
import com.haoyu.nts.statistics.community.entity.CommunityStatistics;
import com.haoyu.nts.statistics.community.service.ICommunityStatisticsService;
import com.haoyu.sip.core.utils.PropertiesLoader;

@Service
public class CommunityStatisticsService implements ICommunityStatisticsService{

	@Resource
	private ICommunityStatisticsDao communityStatisticsDao;
	@Override
	public List<CommunityStatistics> list(Map<String, Object> param, PageBounds pageBounds) {
		param.put("date_to_long_prefix",PropertiesLoader.get("date_to_long_prefix"));
		param.put("date_to_long_suffix",PropertiesLoader.get("date_to_long_suffix"));
		if (param.containsKey("queryType") && StringUtils.isNotEmpty(param.get("queryType").toString())) {
			if ("studentStat".equals(param.get("queryType").toString())) {
				return communityStatisticsDao.selectStudent(param, pageBounds);
			}
		}else {
			return communityStatisticsDao.select(param, pageBounds);
		}
		return null;
	}

}
