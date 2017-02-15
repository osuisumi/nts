package com.haoyu.nts.auth.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.auth.entity.AuthResource;
import com.haoyu.sip.auth.service.IAuthResourceService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
@Controller
@RequestMapping("**/auth_resources")
public class AuthResourceBizController extends AbstractBaseController {
	
	@Resource
	private IAuthResourceService authResourceService;
	
	protected String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/auth/resource/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Model model){
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "list_resource";
	}
	
	@RequestMapping(value="create",method = RequestMethod.GET)
	public String create(Model model){
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "edit_resource";
	}
	
	@RequestMapping(method = RequestMethod.POST)
	@ResponseBody
	public Response save(AuthResource resource){
		return authResourceService.createResource(resource);
	}
	
	@RequestMapping(value="{id}/edit",method = RequestMethod.GET)
	public String edit(AuthResource resource,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("resource",authResourceService.findResourceById(resource.getId()));
		return getLogicalViewNamePrefix() + "edit_resource";
	}
	
	@RequestMapping(method = RequestMethod.PUT)
	@ResponseBody
	public Response update(AuthResource resource){
		return authResourceService.updateResource(resource);
	}
	
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	@ResponseBody
	public Response delete(AuthResource resource){
		return authResourceService.deleteResource(resource);
	}
	
	@RequestMapping(value="batch/delete",method = RequestMethod.DELETE)
	@ResponseBody
	public Response batchDelete(String ids){
		return authResourceService.batchDeleteByIds(ids);
	}
	
	
	@RequestMapping(value="api",method=RequestMethod.GET)
	@ResponseBody
	public List<AuthResource> getResources(AuthResource resource){
		return authResourceService.findResource(resource, getPageBounds(10, true),false);
	}
}
