package com.haoyu.nts.course.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.ncts.course.entity.CourseResult;
import com.haoyu.ncts.course.service.ICourseResultBizService;
import com.haoyu.ncts.course.service.ICourseResultService;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/manage/course/result")
public class CourseResultBizController extends AbstractBaseController{
	
	@Resource
	private ICourseResultService courseResultService;
	@Resource
	private ICourseResultBizService courseResultBizService;
	
	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/course/result/");
	}
	
	@RequestMapping(method = RequestMethod.GET)
	public String list(CourseResult courseResult, Model model){
		model.addAttribute("courseResult", courseResult);
		model.addAttribute("pageBounds", getPageBounds(10, true));
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "list_course_result";
	}
	
	@RequestMapping(method = RequestMethod.PUT)
	@ResponseBody
	public Response update(CourseResult courseResult){
		return courseResultBizService.updateCourseResult(courseResult.getCourse().getId(), null, true, true);
	}
	
	@RequestMapping(value="updateAndNotMarkAss", method = RequestMethod.PUT)
	@ResponseBody
	public Response updateAndNotMarkAss(CourseResult courseResult){
		return courseResultBizService.updateCourseResult(courseResult.getCourse().getId(), null, false, false);
	}
	
	@RequestMapping("updateCourseResultTmp")
	@ResponseBody
	public Response updateCourseResultTmp(String trainId, String courseId, String userId){
		List<String> userIds = null;
		if (StringUtils.isNotEmpty(userId)) {
			userIds = Lists.newArrayList(userId);
		}
		return courseResultBizService.updateCourseResultTmp(trainId, courseId, userIds, false);
	}
	
	@RequestMapping(value="editExport", method=RequestMethod.GET)
	public String editExport(Model model){
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "edit_export";
	}
	
	@RequestMapping(value="export",method=RequestMethod.GET)
	public void export(String realName,String trainId,String deptId,String deptName,String state,HttpServletResponse response){
		Map<String,Object> parameter = Maps.newHashMap();
		PageBounds pageBounds = getPageBounds(10, true);
		if(StringUtils.isNotEmpty(realName)){
			parameter.put("realName", realName);
		}
		if(StringUtils.isNotEmpty(trainId)){
			parameter.put("trainId", trainId);
		}
		if(StringUtils.isNotEmpty(deptName)){
			parameter.put("deptName",deptName);
		}
		if(StringUtils.isNotEmpty(state)){
			parameter.put("state",state);
		}
		try {
			response.setCharacterEncoding("GBK");
			response.setContentType("application/xls;charset=GBK");
			int page = pageBounds.getPage();
			String outName = new String("学员成绩统计.xls".getBytes("GBK"),"ISO-8859-1");
			if(page>0){
				outName = new String(("学员成绩统计_page"+page+".xls").getBytes("GBK"),"ISO-8859-1");
			}
			response.setHeader("Content-disposition", "attachment; filename="+ outName);
			courseResultBizService.export(parameter,pageBounds, response.getOutputStream());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
