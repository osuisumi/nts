package com.haoyu.nts.course.controller;

import java.util.Arrays;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.ncts.course.entity.Course;
import com.haoyu.ncts.course.entity.CourseRegister;
import com.haoyu.ncts.course.service.ICourseRegisterService;
import com.haoyu.nts.course.entity.CourseRegisterExtend;
import com.haoyu.nts.course.service.ICourseRegisterBizService;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/courseRegister")
public class CourseRegisterBizController extends AbstractBaseController{
	
	@Resource
	private ICourseRegisterService courseRegisterService;
	
	@Resource
	private ICourseRegisterBizService courseRegisterBizService;
	
	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/course/");
	}
	
	@RequestMapping(value="updateCourseCourseRegister",method=RequestMethod.POST)
	@ResponseBody
	public Response saveCourseRegisters(CourseRegister courseRegister,String userIds){
		return courseRegisterService.updateCourseRegister(courseRegister,Arrays.asList(userIds.split(",")));
	}
	
	@RequestMapping(value="create",method=RequestMethod.GET)
	public String createCourseRegister(String courseId,String trainId,Model model){
		model.addAttribute("courseId", courseId);
		model.addAttribute("trainId", trainId);
		CourseRegisterExtend courseRegisterExtend = new CourseRegisterExtend();
		courseRegisterExtend.setCourse(new Course(courseId));
		model.addAttribute("courseRegisterExtend", courseRegisterExtend);
		return getLogicalViewNamePrefix() + "edit_course_register";
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(CourseRegister courseRegister,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("courseRegister", courseRegister);
		getPageBounds(10, true);
		return getLogicalViewNamePrefix() + "list_course_register";
	}
	
	@RequestMapping(value="editCourseRegisterClass", method=RequestMethod.GET)
	public String editClass(CourseRegister courseRegister, Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("courseRegister", courseRegister);
		PageBounds pageBounds = getPageBounds(Integer.MAX_VALUE, true);
		pageBounds.setOrders(Order.formString("CREATE_TIME.DESC"));
		return getLogicalViewNamePrefix() + "edit_course_register_class";
	}
	
	@RequestMapping(value="updateCourseRegisterClass", method=RequestMethod.PUT)
	@ResponseBody
	public Response updateCourseRegisterClass(CourseRegister courseRegister){
		return courseRegisterService.updateCourseRegister(courseRegister);
	}
	
	@RequestMapping(value="goImport",method=RequestMethod.GET)
	public String goImport(String courseId,String trainId,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("courseId",courseId);
		model.addAttribute("trainId", trainId);
		return getLogicalViewNamePrefix() + "import_courseRegister";
	}
	
	@RequestMapping(value="goAutoImport",method=RequestMethod.GET)
	public String goAutoImport(String courseId,String trainId,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("courseId",courseId);
		model.addAttribute("trainId", trainId);
		return getLogicalViewNamePrefix() + "auto_import_courseRegister";
	}
	
	@RequestMapping(value="importCourseRegister", method=RequestMethod.POST)
	public String importCourseRegister(String courseId,String trainId, String url,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("resultMap",courseRegisterBizService.importCourseRegister(url, courseId, trainId));
		return getLogicalViewNamePrefix() + "import_result";
	}
	
	@RequestMapping(value="autoImportCourseRegister", method=RequestMethod.POST)
	@ResponseBody
	public Response autoImportCourseRegister(String courseId,String trainId,String stage){
		return courseRegisterBizService.autoImportCourseRegister(courseId, trainId, stage);
	}
	
}
