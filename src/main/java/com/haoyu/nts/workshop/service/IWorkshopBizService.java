package com.haoyu.nts.workshop.service;

import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.core.service.Response;
import com.haoyu.wsts.workshop.entity.Workshop;

public interface IWorkshopBizService {
	
	Response createExtendWorkshops(String workshopId,String extendNames,int extendNum,String relationId);
	
	Response audit(String state,String msg,List<Workshop> workshops);
	
	void exportWorkerStat(Map<String,Object> parameter,PageBounds pageBounds,OutputStream outputStream);
	

}
