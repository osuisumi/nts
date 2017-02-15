package com.haoyu.nts.train.controller;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;

import javax.annotation.Resource;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.nts.train.entity.TrainRegisterExtend;
import com.haoyu.nts.train.service.ITrainRegisterBizService;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tip.train.entity.TrainRegister;
import com.haoyu.tip.train.service.ITrainRegisterService;

@Controller
@RequestMapping("**/trainRegister")
public class TrainRegisterController extends AbstractBaseController{
	
	@InitBinder  
	public void initBinder(WebDataBinder binder) {  
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
	dateFormat.setLenient(false);  
	//true:允许输入空值，false:不能为空值
	binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
	
	@Resource
	private ITrainRegisterBizService trainRegisterBizService;
	
	@Resource
	private ITrainRegisterService trainRegisterService;
	
	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/train/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String listTrainRegisterExtend(TrainRegisterExtend trainRegisterExtend,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("trainRegisterExtend", trainRegisterExtend);
		getPageBounds(10, true);
		return getLogicalViewNamePrefix() + "list_train_register";
	}
	
	@RequestMapping(value="create",method=RequestMethod.GET)
	public String createTrainRegister(TrainRegisterExtend trainRegisterExtend ,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("trainRegisterExtend", trainRegisterExtend);
		return getLogicalViewNamePrefix() + "edit_train_register";
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	@ResponseBody
	public Response update(TrainRegister trainRegister){
		return trainRegisterService.updateTrainRegister(trainRegister);
	}
	
	@RequestMapping(value="updateTrainRegister")
	@ResponseBody
	public Response saveTrainRegisters(String trainId,String userIds,String state){
		return trainRegisterBizService.updateTrainRegisters(trainId, Arrays.asList(userIds.split(",")),state);
	}
	
	@RequestMapping(value="goImport",method=RequestMethod.GET)
	public String goImport(String trainId,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("trainId", trainId);
		return getLogicalViewNamePrefix() + "import_trainRegister";
	}
	
	@RequestMapping(value="importTrainRegister", method=RequestMethod.POST)
	public String importCourseRegister(String trainId,String url,Model model){
		model.addAttribute("resultMap",trainRegisterBizService.importTrainRegister(url,trainId));
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "import_result";
	}
	
	@RequestMapping(value="deleteByLogic",method=RequestMethod.DELETE)
	@ResponseBody
	public Response deleteTrainRegister(TrainRegister trainRegister){
		return trainRegisterService.deleteTrainRegister(trainRegister);
	}

}
