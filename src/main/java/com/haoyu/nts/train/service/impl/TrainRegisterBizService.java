package com.haoyu.nts.train.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.nts.account.utils.AccountRoleCode;
import com.haoyu.nts.tempimport.entity.TempImport;
import com.haoyu.nts.tempimport.service.ITempImportService;
import com.haoyu.nts.train.dao.ITrainRegisterBizDao;
import com.haoyu.nts.train.entity.TrainRegisterExtend;
import com.haoyu.nts.train.excel.TrainRegisterExport;
import com.haoyu.nts.train.excel.TrainRegisterModel;
import com.haoyu.nts.train.service.ITrainRegisterBizService;
import com.haoyu.nts.user.service.IUserBizService;
import com.haoyu.sip.core.entity.User;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.PropertiesLoader;
import com.haoyu.sip.excel.ExcelImport;
import com.haoyu.sip.user.service.IUserInfoService;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.sip.utils.Identities;
import com.haoyu.tip.train.entity.Train;
import com.haoyu.tip.train.entity.TrainRegister;
import com.haoyu.tip.train.service.ITrainRegisterService;
import com.haoyu.tip.train.utils.TrainRegisterState;

@Service
public class TrainRegisterBizService implements ITrainRegisterBizService {
	@Resource
	private ITrainRegisterBizDao trainRegisterBizDao;
	@Resource
	private ITrainRegisterService trainRegisterService;
	@Resource
	private PropertiesLoader propertiesLoader;
	@Resource
	private IUserInfoService userInfoService;
	@Resource
	private ITempImportService tempImportService;
	@Resource
	private IUserBizService userBizService;

	@Override
	public List<TrainRegisterExtend> findTrainRegisterExtend(Map<String, Object> param, PageBounds pageBounds) {
		return trainRegisterBizDao.selectByParameter(param, pageBounds);
	}

	@Override
	public List<TrainRegisterExtend> findTrainRegisterExtend(TrainRegisterExtend trainRegisterExtend,
			PageBounds pageBounds) {
		return this.findTrainRegisterExtend(trainRegisterExtend.setParam(), pageBounds);
	}

	@Override
	public Response updateTrainRegisters(String trainId, List<String> userIds, String state) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("trainId", trainId);
		List<TrainRegister> oldRelations = trainRegisterService.findTrainRegisters(param);
		List<TrainRegister> prepareAdd = generateTrainRegisters(trainId, userIds, state);
		List<TrainRegister> prepareRemove = new ArrayList<TrainRegister>();
		for (TrainRegister tr : oldRelations) {
			if (!userIds.contains(tr.getUser().getId())) {
				prepareRemove.add(tr);
			} else {
				prepareAdd.remove(tr);
			}
		}
		Response response = Response.successInstance();
		if (!CollectionUtils.isEmpty(prepareAdd)) {
			response = trainRegisterService.createTrainRegisters(prepareAdd);
		}
		if (response.isSuccess()) {
			if (!CollectionUtils.isEmpty(prepareRemove)) {
				TrainRegister trainRegister = new TrainRegister();
				String id = "";
				for (TrainRegister t : prepareRemove) {
					if (id.equals("")) {
						id = t.getId();
					} else {
						id = id + "," + t.getId();
					}
				}
				if (StringUtils.isNotEmpty(id)) {
					trainRegister.setId(id);
					response = trainRegisterService.deleteTrainRegister(trainRegister);
				}
			}
		}
		return response;
	}

	private List<TrainRegister> generateTrainRegisters(String trainId, List<String> userIds, String state) {
		List<TrainRegister> result = new ArrayList<TrainRegister>();
		if (!CollectionUtils.isEmpty(userIds)) {
			for (String userId : userIds) {
				if (StringUtils.isNotEmpty(userId)) {
					TrainRegister trainRegister = new TrainRegister();
					trainRegister.setState(state);
					trainRegister.setUser(new User(userId));
					trainRegister.setDefaultValue();
					trainRegister.setTrain(new Train(trainId));
					result.add(trainRegister);
				}
			}
		}

		return result;
	}

	@Override
	public Map<String, Object> importTrainRegister(String url, String trainId) {
		String tempFileDir = propertiesLoader.getProperty("file.temp.dir");
		File file = new File(tempFileDir + url);
		Map<String, Object> resultMap = Maps.newHashMap();
		List<TrainRegisterExport> successList = Lists.newArrayList();
		List<String> failList = Lists.newArrayList();
		ExcelImport<TrainRegisterModel> ei = new ExcelImport<TrainRegisterModel>(TrainRegisterModel.class);
		Collection<TrainRegisterModel> list = ei.importExcel(file, 0, 1);
		for (String str : ei.getErrorMsg()) {
			failList.add(str);
		}

		String pid = Identities.uuid2();

		try{
			// 循环插入excel数据到临时表
			createTemp(list, pid);

			List<com.haoyu.nts.user.entity.User> uesrs = Lists.newArrayList();

			// 查询excel中姓名，身份证号匹配的用户
			Map<String, Object> userMapSelect = Maps.newHashMap();
			userMapSelect.put("pid", pid);
			userMapSelect.put("roleCode", AccountRoleCode.STUDENT);
			uesrs = userBizService.selectForImport(userMapSelect);

			List<String> existsUserNames = Collections3.extractToList(uesrs, "realName");
			List<String> existsPaperworkNos = Collections3.extractToList(uesrs, "paperworkNo");
			Map<String, String> paperwork_userId = Collections3.extractToMap(uesrs, "paperworkNo", "id");

			Map<String, Object> trParam = Maps.newHashMap();
			trParam.put("trainId", trainId);
			List<TrainRegister> existTrainRegister = trainRegisterService.findTrainRegisters(trParam);
			List<String> registedUserIds = Collections3.extractToList(existTrainRegister, "user.id");

			List<TrainRegisterExport> exportList = Lists.newArrayList();
			for (TrainRegisterModel um : list) {
				TrainRegisterExport trainRegisterExport = new TrainRegisterExport();
				int dataRow = um.getLineNumber();
				if (existsPaperworkNos.contains(um.getPaperworkNo().trim().trim()) && existsUserNames.contains(um.getRealName().trim().trim())) {
					if (!registedUserIds.contains(paperwork_userId.get(um.getPaperworkNo().trim().trim()))) {
						TrainRegister trainRegister = new TrainRegister();
						trainRegister.setId(Identities.uuid2());
						trainRegister.setDefaultValue();
						trainRegister.setTrain(new Train(trainId));
						trainRegister.setUser(new User(paperwork_userId.get(um.getPaperworkNo().trim().trim())));
						trainRegister.setState(TrainRegisterState.PASS);
						trainRegisterService.createTrainRegister(trainRegister);
						registedUserIds.add(paperwork_userId.get(um.getPaperworkNo().trim().trim()));
					}
					trainRegisterExport.setRealName(um.getRealName().trim());
					trainRegisterExport.setPaperworkNo(um.getPaperworkNo().trim());
					trainRegisterExport.setMsg("导入成功");
					successList.add(trainRegisterExport);
				} else {
					trainRegisterExport.setMsg("导入失败,第" + dataRow + "行,不存在该用户或该用户不是学员");
					trainRegisterExport.setRealName(um.getRealName().trim());
					trainRegisterExport.setPaperworkNo(um.getPaperworkNo().trim());
					failList.add("第" + dataRow + "行,用户:" + um.getRealName().trim() + " 不存在");
					exportList.add(trainRegisterExport);
				}
			}
			resultMap.put("successList", successList);
			resultMap.put("failList", failList);
			return resultMap;
		}finally{
			tempImportService.deleteByPid(pid);
		}
	}

	private void createTemp(Collection<TrainRegisterModel> list, String pid) {
		List<TempImport> tis = Lists.newArrayList();
		for (TrainRegisterModel trm : list) {
			TempImport ti = new TempImport(pid);
			ti.setField1(trm.getRealName().trim());
			ti.setField2(trm.getPaperworkNo().trim());
			tis.add(ti);
		}
		tempImportService.createList(tis);
	}

}
