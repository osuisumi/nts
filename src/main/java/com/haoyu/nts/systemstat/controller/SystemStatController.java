package com.haoyu.nts.systemstat.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.nts.systemstat.service.ISystemStatService;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/system_stat")
public class SystemStatController extends AbstractBaseController{
	@Resource
	private ISystemStatService systemStatService;
	
	private String getLogicViewNamePerfix(){
		return TemplateUtils.getTemplatePath("/systemStat/");
	}

	
	@RequestMapping(method=RequestMethod.GET)
	public String stat(Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("systemStat", systemStatService.get());
		return getLogicViewNamePerfix() + "system_stat";
	}
}
