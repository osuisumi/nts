package com.haoyu.nts.statistics.course.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.nts.statistics.course.entity.CourseStatistics;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/statistics/course")
public class CourseStatisticsController extends AbstractBaseController {

	protected String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/statistics/course/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(CourseStatistics courseStatistics ,Model model){
		model.addAttribute("courseStatistics",courseStatistics);
		model.addAttribute("pageBounds", getPageBounds(10, true));
		return getLogicalViewNamePrefix() + "list_statistics_course";
	}
}
