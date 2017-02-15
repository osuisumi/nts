package com.haoyu.nts.teacher.service.impl;

import java.io.File;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.ncts.teacher.entity.UserTeacher;
import com.haoyu.ncts.teacher.service.IUserTeacherService;
import com.haoyu.nts.account.dao.IAccountBizDao;
import com.haoyu.nts.account.service.IAccountBizService;
import com.haoyu.nts.account.utils.AccountRoleCode;
import com.haoyu.nts.teacher.excel.TeacherExport;
import com.haoyu.nts.teacher.excel.TeacherModel;
import com.haoyu.nts.teacher.service.ITeacherBizService;
import com.haoyu.sip.core.entity.User;
import com.haoyu.sip.core.utils.PropertiesLoader;
import com.haoyu.sip.excel.ExcelImport;
import com.haoyu.sip.user.entity.Account;
import com.haoyu.sip.user.entity.UserInfo;
import com.haoyu.sip.user.service.IAccountService;
import com.haoyu.sip.user.service.IUserInfoService;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.sip.utils.Identities;

@Service
public class TeacherBizService implements ITeacherBizService{
	@Resource
	private PropertiesLoader propertiesLoader;
	@Resource
	private IUserTeacherService teacherService;
	@Resource
	private IUserInfoService userInfoService;
	@Resource
	private IAccountBizDao accountBizDao;
	@Resource
	private IAccountService accountService;
	@Override
	public Map<String, Object> importTeacher(String url, String relationId) {
		String tempFileDir = propertiesLoader.getProperty("file.temp.dir");
		File file = new File(tempFileDir + url);
		Map<String, Object> resultMap = Maps.newHashMap();
		List<TeacherExport> successList = Lists.newArrayList();
		List<String> failList = Lists.newArrayList();
		ExcelImport<TeacherModel> ei = new ExcelImport<TeacherModel>(TeacherModel.class);
		Collection<TeacherModel> list = ei.importExcel(file, 0, 1);
		for (String str : ei.getErrorMsg()) {
			failList.add(str);
		}
		
		if(CollectionUtils.isNotEmpty(list)){
			for(TeacherModel tm:list){
				tm.setUserName(tm.getUserName().trim());
				tm.setRealName(tm.getRealName().trim());
				tm.setPaperworkNo(tm.getPaperworkNo().trim());
			}
		}
		
		//待导入的所有username
		//按username查出已存在的account，
		//拿到需要添加的account ，需要添加的account最后插入account和userTeacher
		//查看已存在的account的userIds，根据userids查userTeacher，不存在的，往userTeacher中添加记录
		Map<String,String> paperworkNoMap = Collections3.extractToMap(list, "userName", "paperworkNo");
		List<String> userNames = Collections3.extractToList(list, "userName");
		Map<String,String> userName_realName=  Collections3.extractToMap(list, "userName", "realName");
		
		List<Account> accounts = Lists.newArrayList();
		if(CollectionUtils.isNotEmpty(userNames)){
			Map<String, Object> param = Maps.newHashMap();
			param.put("userNames", userNames);
			accounts = accountBizDao.findAccountsByParameter(param, null);
		}
		
//		Map<String,String> userName_userId = Collections3.extractToMap(accounts, "userName", "user.id");
		
		
		//构造待添加的accoutUserName,已存在的accountUserIds备用
		List<String> notExistUserNames = Lists.newArrayList();notExistUserNames.addAll(userNames);
		List<String> existUserIds = Lists.newArrayList();
		
		for(Account account:accounts){
			if(userNames.contains(account.getUserName())){
				notExistUserNames.remove(account.getUserName());
				existUserIds.add(account.getUser().getId());
			}
		}
		
		//处理existUserIds
		if(CollectionUtils.isNotEmpty(existUserIds)){
			List<UserTeacher> existTeacher = teacherService.findTeachers(Maps.newHashMap(), null);
			List<String> existTeacherIds = Collections3.extractToList(existTeacher, "user.id");
			for(String userId:existUserIds){
				if(!existTeacherIds.contains(userId)){
					UserTeacher teacher = new UserTeacher();
					teacher.setId(Identities.uuid2());
					teacher.setDefaultValue();
					teacher.setUser(new User(userId));
					teacherService.createTeacher(teacher);
				}
			}
		}
		
		//处理notExistUserNames
		List<String> conflictPaperworkNo = Lists.newArrayList();//冲突的身份证号
		if(CollectionUtils.isNotEmpty(notExistUserNames)){
			for(String userName:notExistUserNames){
				String paperworkNo = paperworkNoMap.get(userName).trim();
				UserInfo check = new UserInfo();check.setPaperworkNo(paperworkNo);
				if(userInfoService.countForValidpaperworkNoIsExist(check)<=0){
					Account account = new Account();
					UserInfo userInfo = new UserInfo();
					userInfo.setId(Identities.uuid2());
					userInfo.setRealName(userName_realName.get(userName));
					userInfo.setPaperworkNo(paperworkNo);
					account.setUser(userInfo);
					account.setUserName(userName.trim());
					account.setRoleCode(AccountRoleCode.USER);
					account.setPassword("888888");
					if(accountService.createAccount(account).isSuccess()){
						UserTeacher teacher = new UserTeacher();
						teacher.setId(Identities.uuid2());
						teacher.setDefaultValue();
						teacher.setUser(new User(userInfo.getId()));
						teacherService.createTeacher(teacher);
					};
				}else{
					conflictPaperworkNo.add(paperworkNo);
				};
			}
		}
		
		
		for (TeacherModel um : list) {
			TeacherExport teacherExport = new TeacherExport();
			int dataRow = um.getLineNumber();
			if(!conflictPaperworkNo.contains(um.getPaperworkNo().trim())){
				teacherExport.setUserName(um.getUserName());
				teacherExport.setRealName(um.getRealName());
				teacherExport.setMsg("导入成功");
				successList.add(teacherExport);
			}else{
				failList.add("第"+dataRow+"行导入失败，身份证号(手机号)已存在。用户名：" + um.getUserName() + " 姓名：" + um.getRealName() + " 身份证号：" + um.getPaperworkNo() );
			}

		}
		resultMap.put("successList", successList);
		resultMap.put("failList", failList);
		return resultMap;
	}
	


}
