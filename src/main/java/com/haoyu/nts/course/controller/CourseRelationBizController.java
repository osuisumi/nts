package com.haoyu.nts.course.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.haoyu.ncts.course.entity.Course;
import com.haoyu.ncts.course.entity.CourseRelation;
import com.haoyu.ncts.course.service.ICourseRelationBizService;
import com.haoyu.ncts.course.service.ICourseRelationService;
import com.haoyu.ncts.course.utils.CourseState;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.tip.train.service.ITrainService;

@Controller
@RequestMapping("**/courseRelation")
public class CourseRelationBizController extends AbstractBaseController{
	
	@Resource
	private ICourseRelationService courseRelationService;
	@Resource
	private ITrainService trainService;
	@Resource
	private ICourseRelationBizService courseRelationBizService;
	
	private String getLogicViewNamePerfix(){
		return TemplateUtils.getTemplatePath("/course/courseRelation/");
	}
	
	@RequestMapping(value="create",method=RequestMethod.GET)
	public String create(String relationId,Model model){
		this.getPageBounds(Integer.MAX_VALUE, true);
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("relationId", relationId);
		Course course = new Course();
		course.setState(CourseState.PASS);;
		model.addAttribute("course", course);
		return getLogicViewNamePerfix() + "edit_course_relation";
	}
	
	@RequestMapping(value="updateCourseRelations",method=RequestMethod.POST)
	@ResponseBody
	public Response updateCourseRelations(String courseIds,String relationId,String courseTopicId){
		return courseRelationBizService.updateCourseRelations(courseIds, relationId,courseTopicId);
	}
	
	@RequestMapping
	@ResponseBody
	public Response save(CourseRelation courseRelation){
		return courseRelationService.createCourseRelation(courseRelation);
	}
	
	@RequestMapping(value="entities/course",method=RequestMethod.GET)
	@ResponseBody
	public List<Course> entities(CourseRelation courseRelation){
		List<CourseRelation> courseRelations = courseRelationService.listCourseRelations(courseRelation, null);
		List<Course> courses = Collections3.extractToList(courseRelations, "course");
		return courses;
	}
	
	@RequestMapping(value="api/listCourseRelationByTrainIds",method=RequestMethod.GET)
	@ResponseBody
	public List<CourseRelation> api(String trainIds){
		Map<String,Object> parameter = Maps.newHashMap();
		parameter.put("relationIds",Arrays.asList(trainIds.split(",")));
		return courseRelationService.listCourseRelations(parameter, null);
	}
	
	@RequestMapping(value="listPrepareCourse",method=RequestMethod.GET)
	public String listPrepareCourse(Model model){
		setParameterToModel(request, model);
		return getLogicViewNamePerfix() + "list_prepare_course";
	}
	
	@RequestMapping(value="listAddedCourse",method=RequestMethod.GET)
	public String listAddedCourse(Model model){
		setParameterToModel(request, model);
		return getLogicViewNamePerfix() + "list_added_course";
	}

}
