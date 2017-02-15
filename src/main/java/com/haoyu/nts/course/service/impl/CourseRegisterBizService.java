package com.haoyu.nts.course.service.impl;

import java.io.File;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.ncts.clazz.entity.Class;
import com.haoyu.ncts.clazz.service.IClassService;
import com.haoyu.ncts.course.entity.Course;
import com.haoyu.ncts.course.entity.CourseRegister;
import com.haoyu.ncts.course.service.ICourseRegisterService;
import com.haoyu.ncts.course.utils.CourseRegisterState;
import com.haoyu.nts.course.dao.ICourseRegisterBizDao;
import com.haoyu.nts.course.entity.CourseRegisterExtend;
import com.haoyu.nts.course.excel.CourseRegisterExport;
import com.haoyu.nts.course.excel.CourseRegisterModel;
import com.haoyu.nts.course.service.ICourseRegisterBizService;
import com.haoyu.nts.tempimport.entity.TempImport;
import com.haoyu.nts.tempimport.service.ITempImportService;
import com.haoyu.nts.user.service.IUserBizService;
import com.haoyu.sip.core.entity.Relation;
import com.haoyu.sip.core.entity.User;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.PropertiesLoader;
import com.haoyu.sip.excel.ExcelImport;
import com.haoyu.sip.excel.utils.StringUtils;
import com.haoyu.sip.user.service.IUserInfoService;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.sip.utils.Identities;
import com.haoyu.tip.train.entity.TrainRegister;
import com.haoyu.tip.train.service.ITrainRegisterService;
import com.haoyu.tip.train.utils.TrainRegisterState;

@Service
public class CourseRegisterBizService implements ICourseRegisterBizService {
	@Resource
	private ICourseRegisterBizDao courseRegisterBizDao;
	@Resource
	private ICourseRegisterService courseRegisterService;
	@Resource
	private PropertiesLoader propertiesLoader;
	@Resource
	private IUserInfoService userInfoService;
	@Resource
	private IClassService classService;
	@Resource
	private ITrainRegisterService trainRegisterService;
	@Resource
	private ITempImportService tempImportService;
	@Resource
	private IUserBizService userBizService;

	@Override
	public List<CourseRegisterExtend> findCourseRegisterExtend(Map<String, Object> param, PageBounds pageBounds) {
		return courseRegisterBizDao.selectByParameter(param, pageBounds);
	}

	@Override
	public List<CourseRegisterExtend> findCourseRegisterExtend(CourseRegisterExtend courseRegisterExtend, PageBounds pageBounds) {
		return this.findCourseRegisterExtend(courseRegisterExtend.setParam(), pageBounds);
	}

	@Override
	public Map<String, Object> importCourseRegister(String url, String courseId, String trainId) {
		String tempFileDir = propertiesLoader.getProperty("file.temp.dir");
		File file = new File(tempFileDir + url);
		Map<String, Object> resultMap = Maps.newHashMap();
		List<CourseRegisterExport> successList = Lists.newArrayList();
		List<String> failList = Lists.newArrayList();
		ExcelImport<CourseRegisterModel> ei = new ExcelImport<CourseRegisterModel>(CourseRegisterModel.class);
		Collection<CourseRegisterModel> list = ei.importExcel(file, 0, 1);
		for (String str : ei.getErrorMsg()) {
			failList.add(str);
		}
		List<String> realNames = Collections3.extractToList(list, "realName");
		
		String pid = Identities.uuid2();
		
		try{
			// 循环插入excel数据到临时表
			createTemp(list, pid);
			
			List<com.haoyu.nts.user.entity.User> uesrs = Lists.newArrayList();

			// 查询excel中姓名，身份证号匹配的用户
			Map<String, Object> userMapSelect = Maps.newHashMap();
			userMapSelect.put("pid", pid);
			uesrs = userBizService.selectForImport(userMapSelect);
			
			
			List<String> existsPaperworkNos = Collections3.extractToList(uesrs, "paperworkNo");
			Map<String, String> paperwork_userId = Collections3.extractToMap(uesrs, "paperworkNo", "id");

			Map<String, Object> crParam = Maps.newHashMap();
			crParam.put("courseId", courseId);
			crParam.put("relationId", trainId);
			List<CourseRegister> existCourseRegister = courseRegisterService.listCourseRegister(crParam, null);
			List<String> registedUserIds = Collections3.extractToList(existCourseRegister, "user.id");

			Map<String, Object> classParam = Maps.newHashMap();
			classParam.put("courseId", courseId);
			classParam.put("relationId", trainId);
			List<com.haoyu.ncts.clazz.entity.Class> classes = classService.listClass(classParam, null);
			Map<String, String> className_classId = Collections3.extractToMap(classes, "name", "id");

			Map<String, Object> trainRegisterSelectParam = Maps.newHashMap();
			trainRegisterSelectParam.put("trainId", trainId);
			trainRegisterSelectParam.put("state", TrainRegisterState.PASS);
			List<TrainRegister> trainRegisters = trainRegisterService.findTrainRegisters(trainRegisterSelectParam);
			List<String> trainRegisterUserIds = CollectionUtils.isEmpty(trainRegisters) ? Lists.newArrayList() : Collections3.extractToList(trainRegisters, "user.id");

			List<CourseRegisterExport> exportList = Lists.newArrayList();
			for (CourseRegisterModel um : list) {
				CourseRegisterExport courseResgisterExport = new CourseRegisterExport();
				int dataRow = um.getLineNumber();
				if (existsPaperworkNos.contains(um.getPaperworkNo().trim())) {
					if (!registedUserIds.contains(paperwork_userId.get(um.getPaperworkNo().trim()))) {

						// 如果没报名培训，导入失败
						if (!trainRegisterUserIds.contains(paperwork_userId.get(um.getPaperworkNo().trim()))) {
							courseResgisterExport.setMsg("导入失败,第" + dataRow + "行,该用户没有报名本培训");
							courseResgisterExport.setRealName(um.getRealName().trim());
							courseResgisterExport.setPaperworkNo(um.getPaperworkNo().trim());
							failList.add("第" + dataRow + "行,用户:" + um.getRealName().trim() + " 没有报名本培训");
						} else {
							CourseRegister courseRegister = new CourseRegister();
							courseRegister.setId(CourseRegister.getId(courseId, paperwork_userId.get(um.getPaperworkNo().trim())));
							courseRegister.setDefaultValue();
							courseRegister.setCourse(new Course(courseId));
							courseRegister.setUser(new User(paperwork_userId.get(um.getPaperworkNo().trim())));
							courseRegister.setState(CourseRegisterState.PASS);
							courseRegister.setRelation(new Relation(trainId));
							if (StringUtils.isNotEmpty(um.getClazz())) {
								String clazzId = className_classId.get(um.getClazz());
								if (StringUtils.isNotEmpty(clazzId)) {
									com.haoyu.ncts.clazz.entity.Class clazz = new Class();
									clazz.setId(clazzId);
									courseRegister.setClazz(clazz);
								}
							}
							courseRegisterService.createCourseRegister(courseRegister);
							courseResgisterExport.setRealName(um.getRealName().trim());
							courseResgisterExport.setPaperworkNo(um.getPaperworkNo().trim());
							courseResgisterExport.setMsg("导入成功");
							successList.add(courseResgisterExport);
						}
					}

				} else {
					courseResgisterExport.setMsg("导入失败,第" + dataRow + "行,不存在该用户");
					courseResgisterExport.setRealName(um.getRealName().trim());
					courseResgisterExport.setPaperworkNo(um.getPaperworkNo().trim());
					failList.add("第" + dataRow + "行,用户:" + um.getRealName().trim() + " 不存在");
					exportList.add(courseResgisterExport);
				}
			}
			resultMap.put("successList", successList);
			resultMap.put("failList", failList);
			return resultMap;
		}finally{
			tempImportService.deleteByPid(pid);
		}
		

	}

	@Override
	public Response autoImportCourseRegister(String courseId, String trainId, String stage) {
		if (StringUtils.isNotEmpty(courseId) && StringUtils.isNotEmpty(trainId)) {
			CourseRegister courseRegister = new CourseRegister();
			courseRegister.setId(PropertiesLoader.get("db.uuid"));
			courseRegister.setDefaultValue();
			courseRegister.setCourse(new Course(courseId));
			courseRegister.setState(CourseRegisterState.PASS);
			courseRegister.setRelation(new Relation(trainId));
			
			Map<String, Object> param = Maps.newHashMap();
			param.put("trainId", trainId);
			param.put("state", TrainRegisterState.PASS);
			param.put("stage", stage);
			param.put("courseRegister", courseRegister);
			
			courseRegisterBizDao.insertByTrainId(param);
			return Response.successInstance();
		}
		return Response.failInstance();
	}
	
	private void createTemp(Collection<CourseRegisterModel> list, String pid) {
		List<TempImport> tis = Lists.newArrayList();
		for (CourseRegisterModel trm : list) {
			TempImport ti = new TempImport(pid);
			ti.setField1(trm.getRealName().trim());
			ti.setField2(trm.getPaperworkNo().trim());
			tis.add(ti);
		}
		tempImportService.createList(tis);
	}

}
