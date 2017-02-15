package com.haoyu.nts.train.service.impl;

import java.io.File;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

import com.haoyu.nts.tempimport.entity.TempImport;
import com.haoyu.nts.tempimport.service.ITempImportService;
import com.haoyu.nts.train.excel.TrainAuthorizeExport;
import com.haoyu.nts.train.excel.TrainAuthorizeModel;
import com.haoyu.nts.train.service.ITrainAuthorizeBizService;
import com.haoyu.nts.user.service.IUserBizService;
import com.haoyu.sip.core.entity.User;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.PropertiesLoader;
import com.haoyu.sip.excel.ExcelImport;
import com.haoyu.sip.user.service.IUserInfoService;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.sip.utils.Identities;
import com.haoyu.tip.train.entity.Train;
import com.haoyu.tip.train.entity.TrainAuthorize;
import com.haoyu.tip.train.service.ITrainAuthorizeService;
import com.haoyu.tip.train.utils.TrainAuthorizeRole;
import com.haoyu.tip.train.utils.TrainAuthorizeState;

@Service
public class TrainAuthorizeBizService  implements ITrainAuthorizeBizService{
	@Resource
	private PropertiesLoader propertiesLoader;
	@Resource
	private IUserInfoService userInfoService;
	@Resource
	private ITrainAuthorizeService trainAuthorizeService;
	@Resource
	private ITempImportService tempImportService;
	@Resource
	private IUserBizService userBizService;

	@Override
	public Map<String, Object> importTrainAuthorize(String url,String trainId) {
		String tempFileDir = propertiesLoader.getProperty("file.temp.dir");
		File file = new File(tempFileDir + url);
		Map<String, Object> resultMap = Maps.newHashMap();
		List<TrainAuthorizeExport> successList = Lists.newArrayList();
		List<String> failList = Lists.newArrayList();
		ExcelImport<TrainAuthorizeModel> ei = new ExcelImport<TrainAuthorizeModel>(TrainAuthorizeModel.class);
		Collection<TrainAuthorizeModel> list = ei.importExcel(file, 0, 1);
		for (String str : ei.getErrorMsg()) {
			failList.add(str);
		}
		String pid = Identities.uuid2();
		
		try{
			createTemp(list, pid);
			Map<String, Object> userMapSelect = Maps.newHashMap();
			userMapSelect.put("pid", pid);
			List<com.haoyu.nts.user.entity.User> users = userBizService.selectForImportByUserName(userMapSelect);
			
			Map<String,com.haoyu.nts.user.entity.User> userNameUserMap =Maps.newHashMap();
			if(CollectionUtils.isNotEmpty(users)){
				userNameUserMap = Collections3.extractToMap(users, "userName", null);
			}
			List<TrainAuthorizeExport> exportList = Lists.newArrayList();
			
			Map<String,Object> trParam = Maps.newHashMap();
			trParam.put("trainId", trainId);
			List<TrainAuthorize> existTrainAuthorize = trainAuthorizeService.findTrainAuthorizes(trParam, null);
			List<String> registedUserIds = Collections3.extractToList(existTrainAuthorize, "user.id");
			
			for(TrainAuthorizeModel um:list){
				TrainAuthorizeExport trainAuthorizeExport = new TrainAuthorizeExport();
				int dataRow = um.getLineNumber();
				if(userNameUserMap.containsKey(um.getUserName().trim())){
					com.haoyu.nts.user.entity.User u = userNameUserMap.get(um.getUserName().trim());
					if(!registedUserIds.contains(u.getId())){
						TrainAuthorize trainAuthorize = new TrainAuthorize();
						trainAuthorize.setId(Identities.uuid2());
						trainAuthorize.setDefaultValue();
						trainAuthorize.setTrain(new Train(trainId));
						trainAuthorize.setUser(new User(u.getId()));
						trainAuthorize.setRole(TrainAuthorizeRole.ASSISTANT);
						trainAuthorize.setState(TrainAuthorizeState.PASS);
						Response response = trainAuthorizeService.createTrainAuthorize(trainAuthorize);
						if(response.isSuccess()){
							trainAuthorizeExport.setUserName(um.getUserName());
							trainAuthorizeExport.setMsg("导入成功");
							successList.add(trainAuthorizeExport);
						}else{
							trainAuthorizeExport.setMsg("导入失败,第" + dataRow + "行插入数据库失败");
							exportList.add(trainAuthorizeExport);
						}
					}else{
						trainAuthorizeExport.setUserName(um.getUserName());
						trainAuthorizeExport.setMsg("导入成功");
						successList.add(trainAuthorizeExport);
					}
				}else{
					trainAuthorizeExport.setMsg("导入失败,第" + dataRow + "行,不存在该用户");
					trainAuthorizeExport.setUserName(um.getUserName());
					failList.add("第" + dataRow + "行,用户:" + um.getUserName().trim() + " 不存在");
					exportList.add(trainAuthorizeExport);
				}
			}
			resultMap.put("successList", successList);
			resultMap.put("failList", failList);
			return resultMap;
		}finally{
			tempImportService.deleteByPid(pid);
		}
		
	}
	
	private void createTemp(Collection<TrainAuthorizeModel> list, String pid) {
		List<TempImport> tis = Lists.newArrayList();
		for (TrainAuthorizeModel trm : list) {
			TempImport ti = new TempImport(pid);
			ti.setField1(trm.getUserName().trim());
			tis.add(ti);
		}
		tempImportService.createList(tis);
	}
	
	

}
