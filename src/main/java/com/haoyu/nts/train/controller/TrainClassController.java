package com.haoyu.nts.train.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.ncts.clazz.service.IClassService;
import com.haoyu.nts.train.entity.TrainClassStat;
import com.haoyu.nts.train.service.ITrainClassStatService;
import com.haoyu.nts.train.service.impl.TrainClassStatService;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/train/class")
public class TrainClassController extends AbstractBaseController{
	@Resource
	private IClassService classService;
	@Resource
	private ITrainClassStatService trainClassStatService;
	
	private String getLogicViewNamePerfix(){
		return TemplateUtils.getTemplatePath("/train/class/");
	}
	
	@RequestMapping(value="stat",method=RequestMethod.GET)
	public String stat(TrainClassStat trainClassStat,Model model){
		model.addAttribute("trainClassStat",trainClassStat);
		model.addAllAttributes(request.getParameterMap());
		return getLogicViewNamePerfix() + "list_train_class_stat";
	}
	
	@RequestMapping(value="user",method=RequestMethod.GET)
	public String listUser(com.haoyu.ncts.clazz.entity.Class clazz,Model model){
		model.addAttribute("clazz", clazz);
		model.addAllAttributes(request.getParameterMap());
		getPageBounds(10, true);
		return getLogicViewNamePerfix() + "list_class_user";
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String listClass(com.haoyu.ncts.clazz.entity.Class clazz,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("clazz", clazz);
		getPageBounds(10, true);
		return getLogicViewNamePerfix() + "list_class";
	}
	
	@RequestMapping(value="create",method=RequestMethod.GET)
	public String create(Model model){
		model.addAllAttributes(request.getParameterMap());
		return getLogicViewNamePerfix() + "edit_class";
	}
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response save(com.haoyu.ncts.clazz.entity.Class clazz){
		return classService.createClass(clazz);
	}
	
	@RequestMapping(value="{id}/edit",method=RequestMethod.GET)
	public String edit(@PathVariable("id")String id,Model model){
		model.addAttribute("id", id);
		model.addAttribute("clazz", classService.getClass(id));
		model.addAllAttributes(request.getParameterMap());
		return getLogicViewNamePerfix() + "edit_class";
	}
	
	@RequestMapping(value="editUser",method=RequestMethod.GET)
	public String editTrainRegisterClass(Model model){
		model.addAllAttributes(request.getParameterMap());
		return getLogicViewNamePerfix() + "edit_class_user";
	}
	
	
	@RequestMapping(value="saveClassUser",method=RequestMethod.POST)
	@ResponseBody
	public Response saveClassUser(String trainRegisterIds,String classId,String trainId){
		return trainClassStatService.saveClassUser(trainRegisterIds, classId, trainId);
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	@ResponseBody
	public Response update(com.haoyu.ncts.clazz.entity.Class clazz,Model model){
		return classService.updateClass(clazz);
	}
	
	@RequestMapping(method=RequestMethod.DELETE)
	@ResponseBody
	public Response delete(com.haoyu.ncts.clazz.entity.Class clazz){
		return classService.deleteClassByLogic(clazz);
	}
	
	@RequestMapping(value="prepare_add_user",method=RequestMethod.GET)
	public String listPrepareAddUser(Model model){
		model.addAllAttributes(request.getParameterMap());
		return getLogicViewNamePerfix() + "list_prepare_add_user";
	}
	
	

}
