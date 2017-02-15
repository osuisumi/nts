package com.haoyu.nts.clazz.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.haoyu.ncts.clazz.entity.Class;

import com.haoyu.ncts.clazz.service.IClassService;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/manage/class")
public class ClassBizController extends AbstractBaseController{
	
	@Resource
	private IClassService classService;
	
	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/class/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Class clazz, Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("class", clazz);
		getPageBounds(10, true);
		return getLogicalViewNamePrefix() + "list_class";
	}
	
	@RequestMapping(value="create", method = RequestMethod.GET)
	public String create(Class clazz, Model model) {
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("class", clazz);
		return getLogicalViewNamePrefix() + "edit_class";
	}
	
	@RequestMapping(value="{id}/edit", method = RequestMethod.GET)
	public String create(Model model, Class clazz) {
		model.addAllAttributes(request.getParameterMap());
		clazz = classService.getClass(clazz.getId());
		model.addAttribute("class", clazz);
		return getLogicalViewNamePrefix() + "edit_class";
	}
	
	@RequestMapping(method = RequestMethod.DELETE)
	@ResponseBody
	public Response deleteByLogic(Class clazz) {
		return classService.deleteClassByLogic(clazz);
	}
	
	@RequestMapping(method = RequestMethod.POST)
	@ResponseBody
	public Response create(Class clazz) {
		return classService.createClass(clazz);
	}
	
	@RequestMapping(value="{id}", method = RequestMethod.PUT)
	@ResponseBody
	public Response update(Class clazz) {
		return classService.updateClass(clazz);
	}

}
