package com.haoyu.nts.train.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.train.entity.TrainClassStat;
import com.haoyu.sip.core.service.Response;

public interface ITrainClassStatService {
	
	List<TrainClassStat> findTrainClassStats(Map<String,Object> parameter,PageBounds pageBounds);
	
	Response saveClassUser(String userIds,String classId,String trainId);

}
