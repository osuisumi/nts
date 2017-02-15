package com.haoyu.nts.course.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Maps;
import com.haoyu.ncts.course.entity.Course;
import com.haoyu.ncts.course.entity.CourseAuthorize;
import com.haoyu.ncts.course.service.ICourseAuthorizeService;
import com.haoyu.ncts.course.service.ICourseService;
import com.haoyu.nts.course.controller.param.CourseAuthorizeParam;
import com.haoyu.nts.course.service.ICourseAuthorizeStatService;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/manage/course")
public class CourseManageController extends AbstractBaseController{
	
	@Resource
	private ICourseService courseService;
	@Resource
	private ICourseAuthorizeService courseAuthorizeService;
	@Resource
	private ICourseAuthorizeStatService courseAuthorizeStatService;
	
	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/course/");
	}
	
	@RequestMapping(method = RequestMethod.GET)
	public String list(Course course, Model model) {
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("course", course);
		model.addAttribute("pageBounds", getPageBounds(10, true));
		return getLogicalViewNamePrefix() + "list_course";
	}
	
	@RequestMapping(value="create", method = RequestMethod.GET)
	public String create(Model model) {
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "edit_course";
	}
	
	@RequestMapping(value="{id}/edit", method = RequestMethod.GET)
	public String create(Model model, Course course) {
		model.addAllAttributes(request.getParameterMap());
		course = courseService.getCourse(course.getId());
		model.addAttribute("course", course);
		return getLogicalViewNamePrefix() + "edit_course";
	}
	
	@RequestMapping(method = RequestMethod.POST)
	@ResponseBody
	public Response createCourse(Course course) {
		return courseService.createCourse(course);
	}
	
	@RequestMapping(value="{id}", method = RequestMethod.PUT)
	@ResponseBody
	public Response updateCourse(Course course) {
		return courseService.updateCourse(course);
	}
	
	@RequestMapping(method = RequestMethod.PUT)
	@ResponseBody
	public Response updateCourseBatch(Course course){
		return courseService.updateCourseByIds(course);
	}
	
	@RequestMapping(value="deleteByPhycics", method = RequestMethod.DELETE)
	@ResponseBody
	public Response deleteByPhycics(String id) {
		return courseService.deleteCourseByPhysics(id);
	}
	
	@RequestMapping("editCourseAuthorize")
	public String editCourseAuthorize(CourseAuthorize courseAuthorize, Model model) {
		getPageBounds(Integer.MAX_VALUE, true);
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("courseAuthorize", courseAuthorize);
		return getLogicalViewNamePrefix() + "edit_course_authorize";
	}
	
	@RequestMapping(value="updateCourseAuthorize", method=RequestMethod.POST)
	@ResponseBody
	public Response updateCourseAuthorize(CourseAuthorizeParam courseAuthorizeParam) {
		return courseAuthorizeService.updateCourseAuthorizeByCourseId(courseAuthorizeParam.getCourseId(), courseAuthorizeParam.getRole(), courseAuthorizeParam.getCourseAuthorizes());
	}
	
	@RequestMapping(value="review/{id}",method=RequestMethod.GET)
	public String review(@PathVariable String id,String type,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("type", type);
		model.addAttribute("id",id);
		return getLogicalViewNamePrefix() +  "/review/course_review";
	}
	
	@RequestMapping(value="activityDetail/{activityId}")
	public String activityDetail(@PathVariable String activityId,String cid,Model model){
		model.addAttribute("activityId", activityId);
		model.addAttribute("cid", cid);
		return getLogicalViewNamePrefix() + "/review/activityDetail/activity_detail";
	}
	
	@RequestMapping(value="surveyQuestion",method=RequestMethod.GET)
	public String surveyQuestion(String surveyId,Model model){
		model.addAttribute("surveyId", surveyId);
		return getLogicalViewNamePrefix() + "/review/activityDetail/survey_question";
	}
	
	@RequestMapping(value="testQuestion",method=RequestMethod.GET)
	public String surveyTest(String testId,Model model){
		model.addAttribute("testId", testId);
		return getLogicalViewNamePrefix() + "/review/activityDetail/test_question";
	}
	
	@RequestMapping(value="entities", method = RequestMethod.GET)
	@ResponseBody
	public List<Course> entities(Course course) {
		return courseService.listCourse(course, null);
	}
	
	@RequestMapping(value="listPrepareUser",method=RequestMethod.GET)
	public String listPrepareUser(Model model){
		setParameterToModel(request, model);
		return getLogicalViewNamePrefix() +  "/list_prepare_user";
	}
	
	@RequestMapping(value="/worker_stat")
	public String workerStat(Model model){
		getPageBounds(10, true);
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "list_course_worker_stat";
	}
	
	@RequestMapping(value="editExport",method=RequestMethod.GET)
	public String editExport(Model model){
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "edit_export";
	}
	
	@RequestMapping(value="export",method=RequestMethod.GET)
	public void export(String realName,String role,HttpServletResponse response){
		Map<String,Object> parameter = Maps.newHashMap();
		PageBounds pageBounds = getPageBounds(10, true);
		if(StringUtils.isNotEmpty(realName)){
			parameter.put("realName", realName);
		}
		if(StringUtils.isNotEmpty(role)){
			parameter.put("role",role);
		}
		try {
			response.setCharacterEncoding("GBK");
			response.setContentType("application/xls;charset=GBK");
			int page = pageBounds.getPage();
			String outName = new String("课程管理工作统计.xls".getBytes("GBK"),"ISO-8859-1");
			if(page>0){
				outName = new String(("课程管理工作统计_page"+page+".xls").getBytes("GBK"),"ISO-8859-1");
			}
			response.setHeader("Content-disposition", "attachment; filename="+ outName);
			courseAuthorizeStatService.export(parameter,pageBounds, response.getOutputStream());
			//response.getOutputStream().write(FileUtils.readFileToByteArray());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
