package com.haoyu.nts.index.controller;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.common.collect.Lists;
import com.haoyu.nts.utils.RoleCodeConstant;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.login.Loginer;

@Controller
@RequestMapping("nts")
public class NtsIndexController extends AbstractBaseController{
	
	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/");
	}
	
	@RequestMapping("index")
	public String index(Model model){
		Subject currentUser = SecurityUtils.getSubject();
		if(currentUser.hasRole("course_preview")){
			return "redirect:course/list_preview_course";
		}
		String url = "";
		List<String> enters = Lists.newArrayList();
		Loginer loginer = (Loginer) request.getSession().getAttribute("loginer");
		if (loginer != null ) {
			String roleCode = (String) loginer.getAttributes().get("roleCode");
			if ("1".equals(roleCode)) {
				if (!currentUser.hasRole(RoleCodeConstant.COURSE_MAKER) 
						&& !currentUser.hasRole(RoleCodeConstant.COURSE_ASSISTANT)
						&& !currentUser.hasRole("course_preview")) {
					enters.add(RoleCodeConstant.SUPER_MANAGER);
					url = "redirect:/nts/manage";
				}
			}
//			else{
//				if (currentUser.hasRole(RoleCodeConstant.SUPER_MANAGER) || currentUser.hasRole(RoleCodeConstant.DEV_MANAGER) || currentUser.hasRole(RoleCodeConstant.COMMUNITY_MANAGER)
//						|| currentUser.hasRole(RoleCodeConstant.RESOURCE_MANAGER) || currentUser.hasRole("custom_service")) {
//					enters.add(RoleCodeConstant.SUPER_MANAGER);
//					url = "redirect:/nts/manage";
//				}
//			}
		}
		if (currentUser.hasRole(RoleCodeConstant.COURSE_MAKER)) {
			enters.add(RoleCodeConstant.COURSE_MAKER);
			url = "redirect:/make/course";
		}
		if(currentUser.hasRole(RoleCodeConstant.COURSE_TEACHER)){
			enters.add(RoleCodeConstant.COURSE_TEACHER);
			url = "redirect:/teach/course";
		}
		if(currentUser.hasRole(RoleCodeConstant.COURSE_STUDY)){
			if (!enters.contains("user_center")) {
				enters.add("user_center");
			}
		}
		if(currentUser.hasRole(RoleCodeConstant.WORKSHOP_MEMBER)){
			if (!enters.contains(RoleCodeConstant.WORKSHOP_MEMBER)) {
				enters.add(RoleCodeConstant.WORKSHOP_MEMBER);
			}
			url = "redirect:/userCenter/workshop/manage";
		}
//		if (currentUser.hasRole(RoleCodeConstant.SUPER_MANAGER) || currentUser.hasRole(RoleCodeConstant.DEV_MANAGER) || currentUser.hasRole(RoleCodeConstant.COMMUNITY_MANAGER)
//				|| currentUser.hasRole(RoleCodeConstant.RESOURCE_MANAGER)) {
//			
//		}
		if (currentUser.hasRole(RoleCodeConstant.TRAIN_INSPECTOR)) {
			if (!enters.contains("user_center")) {
				enters.add("user_center");
			}
		}
		if (enters.size() > 1) {
			model.addAttribute("enters", enters);
			return "/user-center/my_enters";
		}else{
			if (StringUtils.isNotEmpty(url)) {
				return url;
			}else{
				return "redirect:/userCenter";
			}
		}
	}
	
	@RequestMapping("manage")
	public String manage(){
		return getLogicalViewNamePrefix() + "index";
	}
	
}
