package com.haoyu.nts.statistics.train.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.nts.statistics.train.entity.TrainResultStatistics;
import com.haoyu.nts.statistics.train.entity.TrainStatistics;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/statistics/train")
public class TrainStatisticsController extends AbstractBaseController {

	protected String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/statistics/train/");
	}
	
	@InitBinder  
	public void initBinder(WebDataBinder binder) {  
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
	dateFormat.setLenient(false);  
	binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(TrainStatistics trainStatistics,Model model){
		model.addAttribute("trainStatistics",trainStatistics);
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("pageBounds", getPageBounds(10, true));
		return getLogicalViewNamePrefix() + "list_statistics_train";
	}
	
	@RequestMapping(value="/result",method=RequestMethod.GET)
	public String listRegister(TrainResultStatistics trainResultStatistics,Model model){
		model.addAttribute("trainResultStatistics",trainResultStatistics);
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("pageBounds", getPageBounds(10, true));
		return getLogicalViewNamePrefix() + "list_statistics_train_result";
	}
	
	@RequestMapping(value="areaStat",method=RequestMethod.GET)
	public String areaStat(TrainStatistics trainStatistics,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("trainStatistics",trainStatistics);
		model.addAttribute("pageBounds", getPageBounds(10, true));
		return getLogicalViewNamePrefix() + "list_area_stat";
	}
	
	@RequestMapping(value="schoolStat",method=RequestMethod.GET)
	public String schoolStat(TrainStatistics trainStatistics,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("trainStatistics",trainStatistics);
		model.addAttribute("pageBounds", getPageBounds(10, true));
		return getLogicalViewNamePrefix() + "list_school_stat";
	}
	
	@RequestMapping(value="studentStat",method=RequestMethod.GET)
	public String studentStat(TrainStatistics trainStatistics,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("trainStatistics",trainStatistics);
		model.addAttribute("pageBounds", getPageBounds(10, true));
		return getLogicalViewNamePrefix() + "list_student_stat";
	}
}
