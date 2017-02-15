package com.haoyu.nts.cmts.discussion.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.aip.discussion.entity.Discussion;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/nts/cmts/discussion")
public class DiscussionCmtsNtsController extends AbstractBaseController{
	
	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/cmts/discussion/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Discussion discussion, Model model){
		getPageBounds(10, true);
		model.addAttribute("discussion", discussion);
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "list_discussion";
	}
	
	@RequestMapping(value="create", method=RequestMethod.GET)
	public String create(Discussion discussion, Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("discussion", discussion);
		return getLogicalViewNamePrefix() + "edit_discussion";
	}
	
	@RequestMapping(value="{id}/edit", method=RequestMethod.GET)
	public String edit(Discussion discussion, Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("discussion", discussion);
		return getLogicalViewNamePrefix() + "edit_discussion";
	}

}
