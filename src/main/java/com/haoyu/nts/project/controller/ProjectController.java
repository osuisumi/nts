package com.haoyu.nts.project.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tip.project.entity.Project;
import com.haoyu.tip.project.service.IProjectService;

@Controller
@RequestMapping("**/project")
public class ProjectController extends AbstractBaseController {
	
	@InitBinder  
	public void initBinder(WebDataBinder binder) {  
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
	dateFormat.setLenient(false);  
	//true:允许输入空值，false:不能为空值
	binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}

	@Resource
	private IProjectService projectService;

	private String getLogicalViewNamePrefix() {
		return TemplateUtils.getTemplatePath("/project/");
	}

	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String create(Model model) {
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "edit_project";
	}

	@RequestMapping(method = RequestMethod.POST)
	@ResponseBody
	public Response save(Project project) {
		return projectService.createProject(project);
	}

	@RequestMapping(value = "{id}/edit", method = RequestMethod.GET)
	public String edit(Project project, Model model) {
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("project", projectService.findProjectById(project.getId()));
		return getLogicalViewNamePrefix() + "edit_project";
	}

	@RequestMapping(method = RequestMethod.PUT)
	@ResponseBody
	public Response update(Project project) {
		return projectService.updateProject(project);
	}

	@RequestMapping(method = RequestMethod.GET)
	public String list(Model model, Project project) {
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("project", project);
		model.addAttribute("pageBounds", getPageBounds(10, true));
		return getLogicalViewNamePrefix() + "list_project";
	}

	@RequestMapping(value = "deleteByLogic", method = RequestMethod.DELETE)
	@ResponseBody
	public Response delete(String id) {
		return projectService.deleteProjects(id);
	}
	
	@RequestMapping(value="api",method =RequestMethod.GET)
	@ResponseBody
	public List<Project> api(Project project){
		return projectService.findProjects(project);
	}

}
