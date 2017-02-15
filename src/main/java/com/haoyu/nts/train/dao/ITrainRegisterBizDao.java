package com.haoyu.nts.train.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.train.entity.TrainRegisterExtend;

public interface ITrainRegisterBizDao {
	
	public List<TrainRegisterExtend> selectByParameter(Map<String,Object> param,PageBounds pageBounds);

}
