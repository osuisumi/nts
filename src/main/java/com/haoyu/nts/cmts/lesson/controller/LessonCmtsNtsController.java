package com.haoyu.nts.cmts.lesson.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.aip.discussion.entity.Discussion;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/nts/cmts/lesson")
public class LessonCmtsNtsController extends AbstractBaseController{
	
	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/cmts/lesson/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Discussion discussion, Model model){
		getPageBounds(10, true);
		model.addAttribute("discussion", discussion);
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "list_lesson";
	}
	
	@RequestMapping(value="create", method=RequestMethod.GET)
	public String create(Discussion discussion, Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("discussion", discussion);
		return getLogicalViewNamePrefix() + "edit_lesson";
	}
	
	@RequestMapping(value="{id}/edit", method=RequestMethod.GET)
	public String edit(Discussion discussion, Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("discussion", discussion);
		return getLogicalViewNamePrefix() + "edit_lesson";
	}
	
	@RequestMapping(value="goAuditLesson", method=RequestMethod.GET)
	public String goAuditLesson(Discussion discussion, Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("discussion", discussion);
		return getLogicalViewNamePrefix() + "audit_lesson";
	}
	
	@RequestMapping(value="goCreateMessage", method=RequestMethod.GET)
	public String goCreateMessage(Discussion discussion, Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("discussion", discussion);
		return getLogicalViewNamePrefix() + "create_message";
	}

}
