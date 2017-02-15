package com.haoyu.nts.train.service.impl;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.nts.train.dao.ITrainClassStatDao;
import com.haoyu.nts.train.entity.TrainClassStat;
import com.haoyu.nts.train.service.ITrainClassStatService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.tip.train.entity.TrainRegister;
import com.haoyu.tip.train.service.ITrainRegisterService;

@Service
public class TrainClassStatService implements ITrainClassStatService{
	
	@Resource
	private ITrainClassStatDao trainClassStatDao;
	@Resource
	private ITrainRegisterService trainRegisterService;

	@Override
	public List<TrainClassStat> findTrainClassStats(Map<String, Object> parameter, PageBounds pageBounds) {
		return trainClassStatDao.findTrainClassStat(parameter, pageBounds);
	}

	@Override
	public Response saveClassUser(String trainRegisterIds, String classId, String trainId) {
		if(StringUtils.isEmpty(trainRegisterIds)){
			return Response.failInstance().responseMsg("userIds is empty");
		}
		
		List<String> prepareAdd = Lists.newArrayList();
		prepareAdd.addAll(Arrays.asList(trainRegisterIds.split(",")));
		List<String> prepareRemove = Lists.newArrayList();
		
		Map<String,Object> selectParam = Maps.newHashMap();
		selectParam.put("classId", classId);
		selectParam.put("trainId", trainId);
		selectParam.put("state", "pass");
		//已经在班级内的
		List<TrainRegister> classedTrainRegisters =  trainRegisterService.findTrainRegisters(selectParam);
		
		List<String> existUserIds = CollectionUtils.isEmpty(classedTrainRegisters)?Lists.newArrayList():Collections3.extractToList(classedTrainRegisters, "id");
		
		for(String euid:existUserIds){
			if(prepareAdd.contains(euid)){
				prepareAdd.remove(euid);
			}else{
				prepareRemove.add(euid);
			}
		}
		
		if(!CollectionUtils.isEmpty(prepareAdd)){
			TrainRegister trainRegister = new TrainRegister();
			trainRegister.setClassId(classId);
			trainRegister.setId(getIds(prepareAdd));
			trainRegisterService.updateTrainRegister(trainRegister);
		}
		
		if(!CollectionUtils.isEmpty(prepareRemove)){
			TrainRegister trainRegister = new TrainRegister();
			trainRegister.setClassId("noClass");
			trainRegister.setId(getIds(prepareRemove));
			trainRegisterService.updateTrainRegister(trainRegister);
		}
		return Response.successInstance();
		
	}
	
	private String getIds(List<String> ids){
		String result = "";
		for(String id:ids){
			if(result.equals("")){
				result = id;
			}else{
				result = result + "," + id;
			}
		}
		return result;
	}
	
}
