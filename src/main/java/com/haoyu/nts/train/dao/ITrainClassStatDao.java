package com.haoyu.nts.train.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.train.entity.TrainClassStat;

public interface ITrainClassStatDao {
	
	public List<TrainClassStat> findTrainClassStat(Map<String,Object> parameter,PageBounds pageBounds);

}
