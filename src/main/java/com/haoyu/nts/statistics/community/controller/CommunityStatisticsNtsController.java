package com.haoyu.nts.statistics.community.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.nts.statistics.community.entity.CommunityStatistics;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/statistics/community")
public class CommunityStatisticsNtsController extends AbstractBaseController{
	
	protected String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/statistics/community/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(CommunityStatistics communityStatistics,Model model){
		model.addAttribute("communityStatistics",communityStatistics);
		model.addAttribute("pageBounds", getPageBounds(10, true));
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "list_statistics_community";
	}
	
	@RequestMapping(value="studentStat",method=RequestMethod.GET)
	public String areaStat(CommunityStatistics communityStatistics,Model model){
		model.addAttribute("communityStatistics",communityStatistics);
		model.addAllAttributes(request.getParameterMap());
		getPageBounds(10, true);
		return getLogicalViewNamePrefix() + "list_student_stat";
	}
}
