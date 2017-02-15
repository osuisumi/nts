package com.haoyu.nts.statistics.train.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.haoyu.nts.statistics.train.dao.ITrainStatisticsDao;
import com.haoyu.nts.statistics.train.entity.TrainResultStatistics;
import com.haoyu.nts.statistics.train.entity.TrainStatistics;
import com.haoyu.sip.core.jdbc.MybatisDao;

@Repository
public class TrainStatisticsDao extends MybatisDao implements ITrainStatisticsDao {

	@Override
	public List<TrainStatistics> select(Map<String, Object> param, PageBounds pageBounds) {
		return super.selectList("selectByParameter", param, pageBounds);
	}

	@Override
	public List<TrainResultStatistics> selectRegister(Map<String, Object> param, PageBounds pageBounds) {
//		return super.selectList("selectResultByParameter", param, pageBounds);
		return Lists.newArrayList();
	}

	@Override
	public List<TrainStatistics> selectArea(Map<String, Object> param, PageBounds pageBounds) {
//		return super.selectList("selectAreaByParameter", param, pageBounds);
		return Lists.newArrayList();
	}

	@Override
	public List<TrainStatistics> selectSchool(Map<String, Object> param, PageBounds pageBounds) {
//		return super.selectList("selectSchoolByParameter", param, pageBounds);
		return Lists.newArrayList();
	}

	@Override
	public List<TrainStatistics> selectStudent(Map<String, Object> param, PageBounds pageBounds) {
		return super.selectList("selectStudentByParameter", param, pageBounds);
	}

}
