package com.haoyu.nts.statistics.community.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.haoyu.nts.statistics.community.dao.ICommunityStatisticsDao;
import com.haoyu.nts.statistics.community.entity.CommunityStatistics;
import com.haoyu.sip.core.jdbc.MybatisDao;

@Repository
public class CommunityStatisticsDao  extends MybatisDao implements ICommunityStatisticsDao{

	@Override
	public List<CommunityStatistics> select(Map<String, Object> param, PageBounds pageBounds) {
		//临时删除统计
//		return super.selectList("selectByParameter", param, pageBounds);
		return Lists.newArrayList();
	}

	@Override
	public List<CommunityStatistics> selectStudent(Map<String, Object> param, PageBounds pageBounds) {
//		return super.selectList("selectStudentByParameter", param, pageBounds);
		return Lists.newArrayList();
	}

}
