package com.haoyu.nts.course.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.ncts.course.entity.CourseTopic;
import com.haoyu.ncts.course.service.ICourseTopicService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/course_topic")
public class CourseTopicController extends AbstractBaseController{
	@Resource
	private ICourseTopicService courseTopicService;
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response save(CourseTopic courseTopic){
		return courseTopicService.createCourseTopic(courseTopic);
	}
	
	@RequestMapping(value="{id}",method=RequestMethod.DELETE)
	@ResponseBody
	public Response delete(CourseTopic courseTopic){
		return courseTopicService.deleteCourseTopic(courseTopic);
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	@ResponseBody
	public Response update(CourseTopic courseTopic){
		return courseTopicService.updateCourseTopic(courseTopic);
	}
	

}
