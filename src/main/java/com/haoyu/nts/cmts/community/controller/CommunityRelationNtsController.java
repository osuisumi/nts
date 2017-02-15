package com.haoyu.nts.cmts.community.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.haoyu.cmts.community.entity.CommunityRelation;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/nts/cmts/community/relation")
public class CommunityRelationNtsController extends AbstractBaseController{

	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/cmts/community/");
	}
	
	@RequestMapping("edit")
	public String update(CommunityRelation communityRelation, Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("communityRelation", communityRelation);
		return getLogicalViewNamePrefix() + "edit_community_relation";
	}

}
