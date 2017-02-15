package com.haoyu.nts.auth.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.auth.entity.AuthPermission;
import com.haoyu.sip.auth.service.IAuthPermissionService;
import com.haoyu.sip.auth.service.IAuthResourceService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/auth_permissions")
public class AuthPermissionBizController extends AbstractBaseController {

	@Resource
	private IAuthResourceService authResourceService;
	@Resource
	private IAuthPermissionService permissionService;

	protected String getLogicalViewNamePrefix() {
		return TemplateUtils.getTemplatePath("/auth/permission/");
	}

	@RequestMapping(method = RequestMethod.GET)
	public String listPermission(AuthPermission permission, Model model) {
		model.addAttribute("permission", permission);
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("pageBounds", getPageBounds(10, true));
		return getLogicalViewNamePrefix() + "list_permission";
	}

	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String create(Model model) {
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "edit_permission";
	}

	@RequestMapping(value = "save", method = RequestMethod.POST)
	@ResponseBody
	public Response save(AuthPermission permission) {
		return permissionService.createPermission(permission);
	}

	@RequestMapping(value = "batch/delete")
	@ResponseBody
	public Response batchDelete(@RequestParam("id") String ids) {
		return permissionService.batchDeleteByIds(ids);
	}

	@RequestMapping(value = "{id}/edit", method = RequestMethod.GET)
	public String edit(AuthPermission permission, Model model) {
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("permission", permissionService.findPermissionById(permission.getId()));
		return getLogicalViewNamePrefix() + "edit_permission";
	}

	@RequestMapping(value = "update", method = RequestMethod.PUT)
	@ResponseBody
	public Response update(AuthPermission permission) {
		return this.permissionService.updatePermission(permission);
	}
}
