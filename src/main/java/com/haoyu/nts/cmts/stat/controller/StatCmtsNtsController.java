package com.haoyu.nts.cmts.stat.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.haoyu.cmts.community.entity.CommunityResult;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/nts/cmts/stat")
public class StatCmtsNtsController extends AbstractBaseController{
	
	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/cmts/stat/");
	}
	
	@RequestMapping
	public String list(Model model){
		getPageBounds(10, true);
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "list_stat";
	}
	
	@RequestMapping("editCommunityResultState")
	public String editCommunityResultState(CommunityResult communityResult, Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("communityResult", communityResult);
		return getLogicalViewNamePrefix() + "edit_community_result_state";
	}
	

}
