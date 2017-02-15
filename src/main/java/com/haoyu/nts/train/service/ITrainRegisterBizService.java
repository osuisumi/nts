package com.haoyu.nts.train.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.train.entity.TrainRegisterExtend;
import com.haoyu.sip.core.service.Response;

public interface ITrainRegisterBizService {
	
	public List<TrainRegisterExtend> findTrainRegisterExtend(Map<String,Object> param,PageBounds pageBounds);
	
	public List<TrainRegisterExtend> findTrainRegisterExtend(TrainRegisterExtend trainRegisterExtend,PageBounds pageBounds);
	
	public Response updateTrainRegisters(String trainId,List<String> userIds,String state);
	
	Map<String, Object> importTrainRegister(String url,String trainId);

}
