package com.haoyu.nts.train.service.impl;

import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.ncts.course.service.ICourseRegisterService;
import com.haoyu.ncts.course.service.ICourseResultService;
import com.haoyu.ncts.course.service.ICourseService;
import com.haoyu.nts.train.dao.ITrainRegisterStatDao;
import com.haoyu.nts.train.entity.CourseRegisterExtend;
import com.haoyu.nts.train.entity.TrainRegisterStat;
import com.haoyu.nts.train.service.ITrainRegisterStatService;
import com.haoyu.sip.core.utils.PropertiesLoader;
import com.haoyu.sip.excel.ExcelExport;
import com.haoyu.sip.excel.utils.StringUtils;
import com.haoyu.tip.train.entity.Train;
import com.haoyu.tip.train.service.ITrainRegisterService;
import com.haoyu.tip.train.service.ITrainService;
import com.haoyu.tip.train.utils.TrainRegisterResult;
import com.haoyu.wsts.workshop.entity.WorkshopUser;
import com.haoyu.wsts.workshop.service.IWorkshopService;
import com.haoyu.wsts.workshop.service.IWorkshopUserService;

@Service
public class TrainRegisterStatService implements ITrainRegisterStatService{
	@Resource
	private ITrainRegisterStatDao trainRegisterStatDao; 
	@Resource
	private ICourseService courseService;
	@Resource
	private ICourseResultService courseResultService;
	@Resource
	private ICourseRegisterService courseRegisterService;
	@Resource
	private IWorkshopUserService workshopUserService;
	@Resource
	private IWorkshopService workshopService;
	@Resource
	private ITrainService trainService;
	@Resource
	private ITrainRegisterService trainRegisterService;

	@Override
	public List<TrainRegisterStat> list(Map<String, Object> parameter, PageBounds pageBounds) {
		parameter.put("date_to_long_prefix",PropertiesLoader.get("date_to_long_prefix"));
		parameter.put("date_to_long_suffix",PropertiesLoader.get("date_to_long_suffix"));
		if(parameter.containsKey("trainId")){
			String trainId = String.valueOf(parameter.get("trainId"));
			Train train = trainService.findTrainById(trainId);
			if(train!=null){
				if(StringUtils.isNotEmpty(train.getType())){
					if(train.getType().contains("course")){
						parameter.put("getCourseStat", "Y");
					}
					if(train.getType().contains("workshop")){
						parameter.put("getWorkshopStat", "Y");
					}
					if(train.getType().contains("community")){
						parameter.put("getCommunityStat","Y");
					}
					List<TrainRegisterStat> trainRegisterStats =  trainRegisterStatDao.list(parameter, pageBounds);
					if(CollectionUtils.isNotEmpty(trainRegisterStats)){
						for(TrainRegisterStat ts:trainRegisterStats){
							ts.setTrain(train);
						}
					}
					return trainRegisterStats;
				}
			}
		}
		return null;
		

	}
	
	@Override
	public TrainRegisterStat get(String trainRegisterId,String trainId) {
		if(StringUtils.isNotEmpty(trainId)){
			Train train = trainService.findTrainById(trainId);
			if(train!=null){
				Map<String,Object> parameter = Maps.newHashMap();
				parameter.put("trainRegisterId", trainRegisterId);
				parameter.put("trainId", trainId);
				parameter.put("getDetail", "Y");
				if(train.getType().contains("course")){
					parameter.put("getCourseStat", "Y");
				}
				if(train.getType().contains("workshop")){
					parameter.put("getWorkshopStat", "Y");
				}
				if(train.getType().contains("community")){
					parameter.put("getCommunityStat","Y");
				}
				List<TrainRegisterStat> trainRegisterStats = list(parameter,null);
				if(CollectionUtils.isNotEmpty(trainRegisterStats)){
					TrainRegisterStat ts =  trainRegisterStats.get(0);
					if(ts!=null){
						ts.setTrain(train);
						if(train.getType().contains("course")){
							String userId = ts.getTrainRegister().getUser().getId();
							List<String> userIds = Lists.newArrayList();
							userIds.add(userId);
							Map<String,Object> crParam = Maps.newHashMap();
							crParam.put("userIds", userIds);
							crParam.put("relationId",train.getId());
							List<CourseRegisterExtend> courseRegisters = trainRegisterStatDao.findCourseRegister(crParam);
							if(CollectionUtils.isNotEmpty(courseRegisters)){
								ts.getCourseRegisters().addAll(courseRegisters);
							}
						}
						if(train.getType().contains("workshop")){
							String userId = ts.getTrainRegister().getUser().getId();
							Map<String,Object> wuParam = Maps.newHashMap();
							wuParam.put("userId", userId);
							wuParam.put("relationId",train.getId());
							List<WorkshopUser> workshopUser = workshopUserService.findWorkshopUsers(wuParam, null);
							if(CollectionUtils.isNotEmpty(workshopUser)){
								ts.getWorkshopUsers().addAll(workshopUser);
							}
						}
						return ts;
					}
					return ts;
				}
			}
		}

		return null;
	}
	

	@Override
	public void export(Map<String, Object> parameter,PageBounds pageBounds,OutputStream outputStream) {
		if(pageBounds != null){
			pageBounds.setContainsTotalCount(false);
		}
		List<TrainRegisterStat> trainRegisterStats = this.list(parameter, pageBounds);
		for(TrainRegisterStat ts:trainRegisterStats){
			ts.setExportField();
		}
		ExcelExport<TrainRegisterStat> ee = new ExcelExport<TrainRegisterStat>(TrainRegisterStat.class);
		ee.exportExcel(trainRegisterStats, outputStream);
	}

	@Override
	public List<String> getTrainResult(String trainId, String userId) {
		Map<String,Object> parameter = Maps.newHashMap();
		parameter.put("trainId", trainId);
		if(StringUtils.isNotEmpty(userId)){
			parameter.put("userId", userId);
		}
		parameter.put("resultNeq", TrainRegisterResult.PASSED);
		List<TrainRegisterStat> trainRegisterStats = list(parameter, null);
		
		List<String> trids = Lists.newArrayList();
		if(CollectionUtils.isNotEmpty(trainRegisterStats)){
			for(TrainRegisterStat trs:trainRegisterStats){
				if("合格".equals(trs.getTrainResult())){
					trids.add(trs.getTrainRegister().getId());
				}
			}
		}
		return trids;
	}
	
	

}
