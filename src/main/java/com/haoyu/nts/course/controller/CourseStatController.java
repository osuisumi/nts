package com.haoyu.nts.course.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.ncts.course.entity.Course;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.web.AbstractBaseController;
@Controller
@RequestMapping("**/course_stat")
public class CourseStatController extends AbstractBaseController{
	
	private String getLogicNamePerfix(){
		return TemplateUtils.getTemplatePath("/course/stat/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Course course,Model model){
		getPageBounds(10,true);
		model.addAttribute("course", course);
		model.addAllAttributes(request.getParameterMap());
		return getLogicNamePerfix() + "list_course_stat";
	}
	
	@RequestMapping(value="student",method=RequestMethod.GET)
	public String listStudentStat(String courseId,Model model){
		getPageBounds(10,true);
		model.addAllAttributes(request.getParameterMap());
		return getLogicNamePerfix() + "list_student_course_stat";
	}
	
	@RequestMapping(value="area",method=RequestMethod.GET)
	public String listAreaStat(String courseId,Model model){
		getPageBounds(10,true);
		model.addAllAttributes(request.getParameterMap());
		return getLogicNamePerfix() + "list_area_course_stat";
	}
	
	@RequestMapping(value="school",method=RequestMethod.GET)
	public String listSchoolStat(String courseId,Model model){
		getPageBounds(10,true);
		model.addAllAttributes(request.getParameterMap());
		return getLogicNamePerfix() + "list_school_course_stat";
	}
	

}
