package com.haoyu.nts.statistics.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.nts.statistics.project.entity.ProjectStatistics;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/statistics/project")
public class ProjectStatisticsController extends AbstractBaseController {

	protected String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/statistics/project/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(ProjectStatistics projectStatistics,Model model){
		model.addAttribute("projectStatistics",projectStatistics);
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("pageBounds", getPageBounds(10, true));
		return getLogicalViewNamePrefix() + "list_statistics_project";
	}
	
	@RequestMapping(value="areaStat",method=RequestMethod.GET)
	public String areaStat(ProjectStatistics projectStatistics,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("projectStatistics",projectStatistics);
		getPageBounds(10, true);
		return getLogicalViewNamePrefix() + "list_area_stat";
	}
	
}
