package com.haoyu.nts.department.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.nts.department.entity.DepartmentExtend;
import com.haoyu.nts.department.service.IDepartmentNtsService;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.user.entity.Department;
import com.haoyu.sip.user.service.IDepartmentService;

@Controller
@RequestMapping("**/manage/departments")
public class DepartmentBizController extends AbstractBaseController {
	
	@Resource
	private IDepartmentService departmentService;
	@Resource
	private IDepartmentNtsService departmentNtsService;

	protected String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/department/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(DepartmentExtend department,Model model){
		model.addAttribute("department",department);
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("pageBounds", getPageBounds(10, true));
		return getLogicalViewNamePrefix() + "list_department";
	}
	
	@RequestMapping(value="create",method=RequestMethod.GET)
	public String create(DepartmentExtend department, Model model){
		model.addAttribute("department",department);
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "edit_department";
	}
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response save(DepartmentExtend department){
		return this.departmentNtsService.createDepartment(department);
	}
	
	@RequestMapping(value="{id}/edit",method=RequestMethod.GET)
	public String edit(DepartmentExtend department,Model model){
		model.addAttribute("department",this.departmentNtsService.findDepartmentById(department.getId()));
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "edit_department";
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	@ResponseBody
	public Response update(DepartmentExtend department){
		return this.departmentNtsService.updateDepartment(department);
	}
	
	@RequestMapping(value="batch/delete",method=RequestMethod.DELETE)
	@ResponseBody
	public Response batchDeleteByIds(@RequestParam("id")String ids){
		return this.departmentService.batchDeleteByIds(ids);
	}
	
	@RequestMapping(value="countForValidDeptNameIsExist",method = RequestMethod.GET)
	@ResponseBody
	public int validDeptNameIsExist(Department department){
		return this.departmentService.validDeptNameIsExist(department);
	}
	
	@RequestMapping(value="ValidDeptCodeIsExist",method = RequestMethod.GET)
	@ResponseBody
	public int validDeptCodeIsExist(Department department){
		return this.departmentService.validDeptCodeIsExist(department);
	}
}
