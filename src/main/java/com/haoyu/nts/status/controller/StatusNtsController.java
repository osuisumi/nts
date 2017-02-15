package com.haoyu.nts.status.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.status.entity.Status;

@Controller
@RequestMapping("**/nts/status")
public class StatusNtsController extends AbstractBaseController{
	
	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/common/");
	}

	@RequestMapping("goUpdateStatus")
	public String goUpdateStatus(Status status, Model model){
		model.addAttribute("status", status);
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "update_status";
	}
	
}
