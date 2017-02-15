package com.haoyu.nts.account.service.impl;

import java.io.File;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.nts.account.dao.IAccountBizDao;
import com.haoyu.nts.account.excel.AccountExport;
import com.haoyu.nts.account.excel.AccountModel;
import com.haoyu.nts.account.excel.StudentAccountExport;
import com.haoyu.nts.account.excel.StudentAccountModel;
import com.haoyu.nts.account.service.IAccountBizService;
import com.haoyu.nts.account.utils.AccountRoleCode;
import com.haoyu.nts.teacher.excel.TeacherModel;
import com.haoyu.sip.core.utils.PropertiesLoader;
import com.haoyu.sip.excel.ExcelImport;
import com.haoyu.sip.user.entity.Account;
import com.haoyu.sip.user.entity.Department;
import com.haoyu.sip.user.entity.UserInfo;
import com.haoyu.sip.user.service.IAccountService;
import com.haoyu.sip.user.service.IDepartmentService;
import com.haoyu.sip.utils.Collections3;

@Service
public class AccountBizService implements IAccountBizService{
	
	@Resource
	private IAccountBizDao accountBizDao;
	@Resource
	private PropertiesLoader propertiesLoader;
	@Resource
	private IAccountService accountService;
	@Resource
	private IDepartmentService departmentService;
	
	@Override
	public List<Account> getAccountsByUser(Map<String, Object> parameter, PageBounds pageBounds) {
		return accountBizDao.findAccountsFromBaseUserView(parameter, pageBounds);
	}

	@Override
	public Account findAccountById(String id) {
		Map<String,Object> parameter = Maps.newHashMap();
		parameter.put("userId",id);
		List<Account> accounts = getAccountsByUser(parameter,null);
		if(CollectionUtils.isNotEmpty(accounts)&& accounts.size() == 1){
			return accounts.get(0);
		}
		return null;
	}

	@Override
	public Map<String, Object> importAccount(String url) {
		String tempFileDir = propertiesLoader.getProperty("file.temp.dir");
		File file = new File(tempFileDir + url);
		Map<String, Object> resultMap = Maps.newHashMap();
		List<AccountExport> successList = Lists.newArrayList();
		List<String> failList = Lists.newArrayList();
		ExcelImport<AccountModel> ei = new ExcelImport<AccountModel>(AccountModel.class);
		Collection<AccountModel> list = ei.importExcel(file, 0, 1);
		for (String str : ei.getErrorMsg()) {
			failList.add(str);
		}
		
		if(CollectionUtils.isNotEmpty(list)){
			for(AccountModel am:list){
				am.setUserName(am.getUserName().trim());
				am.setRealName(am.getRealName().trim());
			}
		}
		List<String> userNames = Collections3.extractToList(list, "userName");
		List<Account> accounts = Lists.newArrayList();
		if (Collections3.isNotEmpty(userNames)) {
			Map<String, Object> param = Maps.newHashMap();
			param.put("userNames", userNames);
			accounts = accountBizDao.findAccountsByParameter(param, null);
		}
		
		List<String> existsUserNames = Collections3.extractToList(accounts, "userName");//已经存在的用户
		
		
		List<AccountExport> exportList = Lists.newArrayList();
		for (AccountModel um : list) {
			AccountExport acountExport = new AccountExport();
			int dataRow = um.getLineNumber();
			if (!existsUserNames.contains(um.getUserName())) {
				Account account = new Account();
				UserInfo userInfo = new UserInfo();
				userInfo.setRealName(um.getRealName());
				userInfo.setPaperworkNo(um.getUserName());
				account.setUser(userInfo);
				account.setUserName(um.getUserName().trim());
				account.setRoleCode(AccountRoleCode.USER);
				account.setPassword("888888");
				if(accountService.createAccount(account).isSuccess()){
					acountExport.setUserName(um.getUserName());
					acountExport.setRealName(um.getRealName());
					acountExport.setMsg("导入成功");
					successList.add(acountExport);
					existsUserNames.add(um.getUserName());
				};
			} else {
				acountExport.setMsg("导入失败,第" + dataRow + "行,用户名已经存在");
				acountExport.setUserName(um.getUserName());
				acountExport.setRealName(um.getRealName());
				failList.add("第" + dataRow + "行,用户名:"+um.getUserName()+"已存在");
				exportList.add(acountExport);
			}
		}
		resultMap.put("successList", successList);
		resultMap.put("failList", failList);
		return resultMap;
	}

	@Override
	public Map<String, Account> getMap(Map<String,Object> parameter) {
		return accountBizDao.selectMap(parameter);
	}

	@Override
	public List<Account> getAccountFromAccount(Map<String, Object> parameter, PageBounds pageBounds) {
		return accountBizDao.findAccountsByParameter(parameter, pageBounds);
	}

	@Override
	public Map<String, Object> importStudent(String url) {
		String tempFileDir = propertiesLoader.getProperty("file.temp.dir");
		File file = new File(tempFileDir + url);
		Map<String, Object> resultMap = Maps.newHashMap();
		List<StudentAccountExport> successList = Lists.newArrayList();
		List<String> failList = Lists.newArrayList();
		ExcelImport<StudentAccountModel> ei = new ExcelImport<StudentAccountModel>(StudentAccountModel.class);
		Collection<StudentAccountModel> list = ei.importExcel(file, 0, 1);
		for (String str : ei.getErrorMsg()) {
			failList.add(str);
		}
		
		if(CollectionUtils.isNotEmpty(list)){
			for(StudentAccountModel am:list){
				am.setUserName(am.getUserName().trim());
				am.setRealName(am.getRealName().trim());
				am.setPaperworkNo(am.getPaperworkNo().trim());
				if(StringUtils.isNotEmpty(am.getDeptName())){
					am.setDeptName(am.getDeptName().trim());
				}
			}
		}
		List<String> userNames = Collections3.extractToList(list, "userName");
		List<Account> accounts = Lists.newArrayList();
		if (Collections3.isNotEmpty(userNames)) {
			Map<String, Object> param = Maps.newHashMap();
			param.put("userNames", userNames);
			accounts = accountBizDao.findAccountsByParameter(param, null);
		}
		
		List<String> existsUserNames = Collections3.extractToList(accounts, "userName");//已经存在的用户
		List<String> existsPaperworkNos = Collections3.extractToList(accounts,"user.paperworkNo");//已存在的身份证号
		
		List<Department> departments = departmentService.list(Maps.newHashMap(), null);
		Map<String,Department> deptNameMap = Maps.newHashMap();
		if(CollectionUtils.isNotEmpty(departments)){
			deptNameMap = Collections3.extractToMap(departments, "deptName", null);
		}
		
		
		List<StudentAccountExport> exportList = Lists.newArrayList();
		for (StudentAccountModel um : list) {
			StudentAccountExport acountExport = new StudentAccountExport();
			int dataRow = um.getLineNumber();
			if(existsUserNames.contains(um.getUserName())){
				acountExport.setMsg("导入失败,第" + dataRow + "行,用户名已经存在");
				acountExport.setUserName(um.getUserName());
				acountExport.setRealName(um.getRealName());
				failList.add("第" + dataRow + "行,用户名:"+um.getUserName()+"已存在");
				exportList.add(acountExport);
			}else if(existsPaperworkNos.contains(um.getPaperworkNo())){
				acountExport.setMsg("导入失败,第" + dataRow + "行,身份证(手机)已存在");
				acountExport.setUserName(um.getUserName());
				acountExport.setRealName(um.getRealName());
				failList.add("第" + dataRow + "行,身份证:"+um.getPaperworkNo()+"已存在");
				exportList.add(acountExport);
			}else{
				Account account = new Account();
				UserInfo userInfo = new UserInfo();
				userInfo.setRealName(um.getRealName());
				userInfo.setPaperworkNo(um.getPaperworkNo());
				account.setUser(userInfo);
				account.setUserName(um.getUserName().trim());
				account.setRoleCode(AccountRoleCode.STUDENT);
				account.setPassword("888888");
				if(StringUtils.isNotEmpty(um.getDeptName())){
					if(deptNameMap.containsKey(um.getDeptName())){
						userInfo.setDepartment(deptNameMap.get(um.getDeptName()));
					}else{
						failList.add("第" + dataRow + "行,部门:"+um.getDeptName()+"不存在");
						continue;
					}
				}
				if(accountService.createAccount(account).isSuccess()){
					acountExport.setUserName(um.getUserName());
					acountExport.setRealName(um.getRealName());
					acountExport.setMsg("导入成功");
					successList.add(acountExport);
					existsUserNames.add(um.getUserName());
					existsPaperworkNos.add(um.getPaperworkNo());
				};
			}
		}
		resultMap.put("successList", successList);
		resultMap.put("failList", failList); 
		return resultMap;
	}

}
