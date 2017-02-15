package com.haoyu.nts.cmts.community.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/nts/cmts/community")
public class CommunityNtsController extends AbstractBaseController{

	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/cmts/community/");
	}
	
	@RequestMapping("point")
	public String point(Model model){
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "point";
	}
}
