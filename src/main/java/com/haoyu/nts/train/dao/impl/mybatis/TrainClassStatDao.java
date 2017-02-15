package com.haoyu.nts.train.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.train.dao.ITrainClassStatDao;
import com.haoyu.nts.train.entity.TrainClassStat;
import com.haoyu.sip.core.jdbc.MybatisDao;

@Repository
public class TrainClassStatDao extends MybatisDao implements ITrainClassStatDao{

	@Override
	public List<TrainClassStat> findTrainClassStat(Map<String, Object> parameter,PageBounds pageBounds) {
		return super.selectList("select", parameter, pageBounds);
	}
	

}
