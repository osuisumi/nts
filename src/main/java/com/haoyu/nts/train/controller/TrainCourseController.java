package com.haoyu.nts.train.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.ncts.course.entity.Course;
import com.haoyu.ncts.course.entity.CourseRelation;
import com.haoyu.ncts.course.service.ICourseAuthorizeService;
import com.haoyu.ncts.course.service.ICourseService;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/train/course")
public class TrainCourseController extends AbstractBaseController{

	@Resource
	private ICourseService courseService;
	@Resource
	private ICourseAuthorizeService courseAuthorizeService;
	
	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/train/course/");
	}
	
	@RequestMapping(method = RequestMethod.GET)
	public String list(Course course, Model model) {
		getPageBounds(10, true);
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("course", course);
		return getLogicalViewNamePrefix() + "list_course";
	}
	
	@RequestMapping(value="editCourseConfig", method = RequestMethod.GET)
	public String editCourseConfig(Model model, CourseRelation courseRelation) {
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("courseRelation", courseRelation);
		return getLogicalViewNamePrefix() + "edit_course_config";
	}
}
