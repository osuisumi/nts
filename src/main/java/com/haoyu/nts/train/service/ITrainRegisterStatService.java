package com.haoyu.nts.train.service;

import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.nts.train.entity.TrainRegisterStat;

public interface ITrainRegisterStatService {

	List<TrainRegisterStat> list(Map<String, Object> parameter, PageBounds pageBounds);
	
	TrainRegisterStat get(String trainRegisterId,String trainId);
	
	void export(Map<String,Object> parameter,PageBounds pageBounds,OutputStream outputStream);
	
	List<String> getTrainResult(String trainId,String userId);

}
