package com.haoyu.nts.teacher.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.ncts.teacher.entity.UserTeacher;
import com.haoyu.ncts.teacher.service.IUserTeacherService;
import com.haoyu.nts.teacher.service.ITeacherBizService;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/teacher")
public class TeacherBizController extends AbstractBaseController{
	@Resource
	private IUserTeacherService teacherService;
	@Resource
	private ITeacherBizService teacherBizService;
	
	private String getLogicViewNamePerfix(){
		return TemplateUtils.getTemplatePath("/teacher/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Model model){
		getPageBounds(10, true);
		model.addAllAttributes(request.getParameterMap());
		return getLogicViewNamePerfix() + "list_teacher";
	}
	
	@RequestMapping(method=RequestMethod.DELETE)
	@ResponseBody
	public Response delete(UserTeacher teacher){
		return teacherService.deleteTeacher(teacher);
	}
	
	
	@RequestMapping(value="goImport",method=RequestMethod.GET)
	public String goImport(Model model){
		model.addAllAttributes(request.getParameterMap());
		return getLogicViewNamePerfix() + "import_teacher";
	}
	
	@RequestMapping(value="importTeacher", method=RequestMethod.POST)
	public String importTrainAuthorize(String url,Model model){
		model.addAttribute("resultMap",teacherBizService.importTeacher(url,""));
		model.addAllAttributes(request.getParameterMap());
		return getLogicViewNamePerfix() + "import_result";
	}
	

}
