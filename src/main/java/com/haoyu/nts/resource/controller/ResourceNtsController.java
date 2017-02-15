package com.haoyu.nts.resource.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.nts.resource.service.IResourceNtsService;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tip.resource.entity.Resources;

@Controller
@RequestMapping("**/resource/nts")
public class ResourceNtsController extends AbstractBaseController{
	
	@Resource
	private IResourceNtsService resourceNtsService;
	
	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/resource/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Resources resource, Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("resource", resource);
		this.getPageBounds(10, true);
		return getLogicalViewNamePrefix() + "list_resource";
	}
	
	@RequestMapping(value="importResource")
	public void importResource(String path, HttpServletResponse response){
		resourceNtsService.importResource(path, response);
	}
	
	@RequestMapping(value="updateFilePath")
	public void updateFilePath(String path, HttpServletResponse response){
		resourceNtsService.updateFilePath(path,response);
	}
}
