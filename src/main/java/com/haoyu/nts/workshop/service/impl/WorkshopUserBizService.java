package com.haoyu.nts.workshop.service.impl;

import java.io.File;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.nts.account.utils.AccountRoleCode;
import com.haoyu.nts.tempimport.entity.TempImport;
import com.haoyu.nts.tempimport.service.ITempImportService;
import com.haoyu.nts.user.service.IUserBizService;
import com.haoyu.nts.workshop.excel.WorkshopUserExport;
import com.haoyu.nts.workshop.excel.WorkshopUserModel;
import com.haoyu.nts.workshop.service.IWorkshopUserBizService;
import com.haoyu.sip.core.entity.User;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.PropertiesLoader;
import com.haoyu.sip.excel.ExcelImport;
import com.haoyu.sip.excel.utils.StringUtils;
import com.haoyu.sip.user.entity.UserInfo;
import com.haoyu.sip.user.service.IUserInfoService;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.sip.utils.Identities;
import com.haoyu.tip.train.entity.Train;
import com.haoyu.tip.train.entity.TrainRegister;
import com.haoyu.tip.train.utils.TrainRegisterState;
import com.haoyu.wsts.workshop.entity.Workshop;
import com.haoyu.wsts.workshop.entity.WorkshopUser;
import com.haoyu.wsts.workshop.service.IWorkshopService;
import com.haoyu.wsts.workshop.service.IWorkshopUserService;
import com.haoyu.wsts.workshop.utils.WorkshopUserRole;
import com.haoyu.wsts.workshop.utils.WorkshopUserState;

@Service
public class WorkshopUserBizService implements IWorkshopUserBizService{
	
	@Resource
	private PropertiesLoader propertiesLoader;
	@Resource
	private IUserInfoService userInfoService;
	@Resource
	private IWorkshopUserService workshopUserService;
	@Resource
	private ITempImportService tempImportService;
	@Resource
	private IUserBizService userBizService;
	@Resource
	private IWorkshopService workshopService;


	@Override
	public Response saveWorkshopUsers(String workshopId, List<String> userIds, String role) {
		if(CollectionUtils.isEmpty(userIds)){
			return Response.failInstance().responseMsg("userIds is empty");
		}
		Map<String,Object> parameter = Maps.newHashMap();
		parameter.put("workshopId", workshopId);
		parameter.put("role", role);
		List<WorkshopUser> existUsers = workshopUserService.findWorkshopUsers(parameter, null);
		
		List<String> prepareAdd = Lists.newArrayList();
		List<String> prepareRemove = CollectionUtils.isEmpty(existUsers)?Lists.newArrayList():Collections3.extractToList(existUsers,"user.id");
		for(String userId:userIds){
			if(prepareRemove.contains(userId)){
				prepareRemove.remove(userId);
			}else{
				prepareAdd.add(userId);
			}
		}
		
		//执行新增、删除
		if(CollectionUtils.isNotEmpty(prepareRemove)){
			List<String> workshopUserIds = Lists.newArrayList();
			List<String> removeUserIds = Lists.newArrayList();
			for(String userId:prepareRemove){
				workshopUserIds.add(WorkshopUser.getId(workshopId, userId));
				removeUserIds.add(userId);
			}
			workshopUserService.batchDelete(workshopUserIds,removeUserIds);
		}
		
		Workshop preSaveWorkshop = new Workshop();
		preSaveWorkshop.setId(workshopId);
		List<WorkshopUser> workshopUsers = Lists.newArrayList();
		preSaveWorkshop.setWorkshopUsers(workshopUsers);
		
		if(CollectionUtils.isNotEmpty(prepareAdd)){
			for(String userId:prepareAdd){
				if(StringUtils.isNotEmpty(userId)){
					WorkshopUser workshopUser = new WorkshopUser();
					workshopUser.setUser(new User(userId));
					workshopUser.setWorkshopId(workshopId);
					workshopUser.setRole(role);
					workshopUser.setState(WorkshopUserState.PASS);
					preSaveWorkshop.getWorkshopUsers().add(workshopUser);
				}
			}
		}
		
		if(CollectionUtils.isNotEmpty(preSaveWorkshop.getWorkshopUsers())){
			workshopUserService.batchSave(preSaveWorkshop);
		}
		return Response.successInstance();
	}

	@Override
	public Map<String, Object> importTrainWorkshopStudent(String url, String workshopId) {
		String tempFileDir = propertiesLoader.getProperty("file.temp.dir");
		File file = new File(tempFileDir + url);
		Map<String, Object> resultMap = Maps.newHashMap();
		List<WorkshopUserExport> successList = Lists.newArrayList();
		List<String> failList = Lists.newArrayList();
		ExcelImport<WorkshopUserModel> ei = new ExcelImport<WorkshopUserModel>(WorkshopUserModel.class);
		Collection<WorkshopUserModel> list = ei.importExcel(file, 0, 1);
		for (String str : ei.getErrorMsg()) {
			failList.add(str);
		}

		String pid = Identities.uuid2();

		try{
			// 循环插入excel数据到临时表
			createTemp(list, pid);
			
			Workshop workshop = workshopService.findWorkshopById(workshopId);
			String trainId=  workshop.getWorkshopRelation().getRelation().getId();

			List<com.haoyu.nts.user.entity.User> uesrs = Lists.newArrayList();

			// 查询excel中姓名，身份证号匹配的用户并且报名了相关培训
			Map<String, Object> userMapSelect = Maps.newHashMap();
			userMapSelect.put("pid", pid);
			userMapSelect.put("hasRegisterTrain", trainId);
			uesrs = userBizService.selectForImport(userMapSelect);

			List<String> existsUserNames = Collections3.extractToList(uesrs, "realName");
			List<String> existsPaperworkNos = Collections3.extractToList(uesrs, "paperworkNo");
			Map<String, String> paperwork_userId = Collections3.extractToMap(uesrs, "paperworkNo", "id");

			Map<String, Object> trParam = Maps.newHashMap();
			trParam.put("workshopId",workshopId);
			List<WorkshopUser> existWorkshopUser = workshopUserService.findWorkshopUsers(trParam, null);
			List<String> existWorkshopUserIds = Collections3.extractToList(existWorkshopUser, "user.id");

			List<WorkshopUserExport> exportList = Lists.newArrayList();
			for (WorkshopUserModel um : list) {
				WorkshopUserExport workshopUserExport = new WorkshopUserExport();
				int dataRow = um.getLineNumber();
				if (existsPaperworkNos.contains(um.getPaperworkNo().trim().trim()) && existsUserNames.contains(um.getRealName().trim().trim())) {
					if (!existWorkshopUserIds.contains(paperwork_userId.get(um.getPaperworkNo().trim().trim()))) {
						WorkshopUser workshopUser = new WorkshopUser();
						workshopUser.setDefaultValue();
						workshopUser.setState(WorkshopUserState.PASS);
						workshopUser.setRole(WorkshopUserRole.STUDENT);
						workshopUser.setUser(new User(paperwork_userId.get(um.getPaperworkNo().trim().trim())));
						workshopUser.setWorkshopId(workshopId);
						workshopUserService.createWorkshopUser(workshopUser);
						existWorkshopUserIds.add(paperwork_userId.get(um.getPaperworkNo().trim().trim()));
					}
					workshopUserExport.setRealName(um.getRealName().trim());
					workshopUserExport.setPaperworkNo(um.getPaperworkNo().trim());
					workshopUserExport.setMsg("导入成功");
					successList.add(workshopUserExport);
				} else {
					workshopUserExport.setMsg("导入失败,第" + dataRow + "行,不存在该用户或该用户没有报名该培训");
					workshopUserExport.setRealName(um.getRealName().trim());
					workshopUserExport.setPaperworkNo(um.getPaperworkNo().trim());
					failList.add("第" + dataRow + "行,用户:" + um.getRealName().trim() + " 不存在该用户或该用户没有报名该培训");
					exportList.add(workshopUserExport);
				}
			}
			resultMap.put("successList", successList);
			resultMap.put("failList", failList);
			return resultMap;
		}finally{
			tempImportService.deleteByPid(pid);
		}
	}
	
	private void createTemp(Collection<WorkshopUserModel> list, String pid) {
		List<TempImport> tis = Lists.newArrayList();
		for (WorkshopUserModel trm : list) {
			TempImport ti = new TempImport(pid);
			ti.setField1(trm.getRealName().trim());
			ti.setField2(trm.getPaperworkNo().trim());
			tis.add(ti);
		}
		tempImportService.createList(tis);
	}

}
