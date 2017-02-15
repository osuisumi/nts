package com.haoyu.nts.account.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.dict.entity.DictEntry;
import com.haoyu.nts.account.service.IAccountBizService;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.user.entity.Account;
import com.haoyu.sip.user.service.IAccountService;

@Controller
@RequestMapping("**/accounts")
public class AccountBizController extends AbstractBaseController {
	
	@Resource
	private IAccountService accountService;
	@Resource
	private IAccountBizService accountBizService;

	protected String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/account/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Account account,Model model){
		model.addAttribute("account",account);
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("pageBounds", getPageBounds(10, true));
		if ("2".equals(account.getRoleCode())) {
			return getLogicalViewNamePrefix() + "list_student";
		}
		return getLogicalViewNamePrefix() + "list_account";
	}
	
	@RequestMapping(value="create",method=RequestMethod.GET)
	public String create(Account account, Model model){
		model.addAttribute("account",account);
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "edit_account";
	}
	
//	@RequestMapping(method=RequestMethod.POST)
//	@ResponseBody
//	public Response save(Account account){
//		return this.accountService.createAccount(account);
//	}
	
	@RequestMapping(value="{id}/edit",method=RequestMethod.GET)
	public String edit(Account account,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("account",this.accountService.findAccountById(account.getId()));
		return getLogicalViewNamePrefix() + "edit_account";
	}
	
	@RequestMapping(value = "/editPersonalPassword",method=RequestMethod.GET)
	public String getEditPersonalPassword(){
		return getLogicalViewNamePrefix()+"edit_personal_password";
	}
	
//	@RequestMapping(method=RequestMethod.PUT)
//	@ResponseBody
//	public Response update(Account account){
//		return this.accountService.updateAccount(account);
//	}
	
//	@RequestMapping(value="batch/delete",method=RequestMethod.DELETE)
//	@ResponseBody
//	public Response batchDeleteByIds(@RequestParam("id")String ids){
//		return this.accountService.batchDeleteByIds(ids);
//	}
	
//	@RequestMapping(value="batch/resetPassword",method=RequestMethod.PUT)
//	@ResponseBody
//	public Response batchResetPasswordByIds(Account account){
//		return this.accountService.batchResetPasswordByIds(account);
//	}
	
//	@RequestMapping(value="countForValidUserNameIsExist",method = RequestMethod.GET)
//	@ResponseBody
//	public int getAccountForValidUserNameIsExist(Account account){
//		return this.accountService.getAccountCountForValidUserNameIsExist(account);
//	}
	
	@RequestMapping(value="/editAuthAccountRoleAuthorize",method=RequestMethod.GET)
	public String editAccountRoleAuthorize(Account account,Model model) {
		model.addAttribute("account",account);
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "edit_account_role_authorize";
	}
	
	@RequestMapping(value="editAccountGroupRoleAuthorize",method=RequestMethod.GET)
	public String editAccountGroupRoleAuthorize(DictEntry dictEntry,Model model) {
		model.addAttribute("dictEntry",dictEntry);
		return getLogicalViewNamePrefix() + "edit_account_group_role_authorize";
	}
	
	@RequestMapping(value="goImport",method=RequestMethod.GET)
	public String goImport(Model model){
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "import_account";
	}
	
	@RequestMapping(value="importAccount", method=RequestMethod.POST)
	public String importTrainAuthorize(String url,Model model){
		model.addAttribute("resultMap",accountBizService.importAccount(url));
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "import_result";
	}
	
	@RequestMapping(value="{id}/editPassword",method=RequestMethod.GET)
	public String editPassword(Account account,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("account",this.accountService.findAccountById(account.getId()));
		return getLogicalViewNamePrefix() + "edit_account_password";
	}
	
	//新增学员账户
	@RequestMapping(value="create_student",method=RequestMethod.GET)
	public String createStudent(Model model){
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "edit_student";
	}
	
	//编辑学员信息
	@RequestMapping(value="{id}/edit_student",method=RequestMethod.GET)
	public String editStudent(@PathVariable String id,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("account", accountService.findAccountById(id));
		return getLogicalViewNamePrefix() + "edit_student";
	}
	
	//导入学员账户UI
	@RequestMapping(value="student/goImport",method=RequestMethod.GET)
	public String goImportStudentAccount(Model model){
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "import_student";
	}
	
	@RequestMapping(value="student/importAccount",method=RequestMethod.POST)
	public String importStudentAccount(String url,Model model){
		model.addAttribute("resultMap",accountBizService.importStudent(url));
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "import_student_result";
	}
	
}
