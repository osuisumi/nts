package com.haoyu.nts.workshop.service;

import java.util.List;
import java.util.Map;

import com.haoyu.sip.core.service.Response;

public interface IWorkshopUserBizService {
	
	Response saveWorkshopUsers(String workshopId,List<String> userIds,String role);
	
	Map<String,Object> importTrainWorkshopStudent(String url,String workshopId);
	
}
