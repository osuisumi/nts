package com.haoyu.nts.train.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.nts.train.entity.TrainRegisterExtend;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.nts.workshop.service.IWorkshopBizService;
import com.haoyu.nts.workshop.service.IWorkshopUserBizService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.user.entity.UserInfo;
import com.haoyu.tip.train.entity.Train;
import com.haoyu.wsts.workshop.entity.Workshop;

@Controller
@RequestMapping("**/manage/train/workshop")
public class TrainWorkshopController extends AbstractBaseController{
	@Resource
	private IWorkshopBizService workshopBizService;
	@Resource
	private IWorkshopUserBizService workshopUserBizService;
	
	private String getLogicViewNamePerfix(){
		return TemplateUtils.getTemplatePath("/train/workshop/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Workshop workshop,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("workshop", workshop);
		getPageBounds(10, true);
		return getLogicViewNamePerfix() + "list_workshop";
	}
	
	
	@RequestMapping(value="editWorkshopUser/{workshopId}/{trainId}",method=RequestMethod.GET)
	public String editWorkshopUser(@PathVariable("workshopId")String workshopId,@PathVariable("trainId")String trainId,String role,TrainRegisterExtend trainRegisterExtend,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("workshopId",workshopId);
		model.addAttribute("trainId",trainId);
		model.addAttribute("role", role);
		//model.addAttribute("realName", realName);
		
		TrainRegisterExtend tr = new TrainRegisterExtend();
		UserInfo userInfo = new UserInfo();
		//userInfo.setRealName(realName);
		tr.setUserInfo(userInfo);
		tr.setTrain(new Train(trainId));
		model.addAttribute("trainRegisterExtend",tr);
		return getLogicViewNamePerfix() + "edit_workshop_user";
	}
	
	@RequestMapping(value="editTrainConfig/{workshopId}",method=RequestMethod.GET)
	public String editTrainConfig(@PathVariable("workshopId")String workshopId,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("workshopId",workshopId);
		return getLogicViewNamePerfix() + "edit_workshop_train_config";
	}
	
	@RequestMapping(value="createExtendWorkshop/{workshopId}",method=RequestMethod.GET)
	public String createExtendWorkshop(@PathVariable String workshopId, Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("workshopId", workshopId);
		return getLogicViewNamePerfix() + "edit_extend_workshop";
	}
	
	@RequestMapping(value="preapre_add_user",method=RequestMethod.GET)
	public String listAllPrepareAddUser(Model model,String role,String realName){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("role",role);
		model.addAttribute("realName",realName);
		getPageBounds(10, true);
		return getLogicViewNamePerfix() + "list_prepare_add_user";
	}
	
	@RequestMapping(value="saveExtendWorkshop/{workshopId}",method=RequestMethod.POST)
	@ResponseBody
	public Response saveExtendWorkshop(@PathVariable String workshopId,int extendNum,String extendNames,String relationId){
		return workshopBizService.createExtendWorkshops(workshopId, extendNames, extendNum, relationId);
	}
	
	@RequestMapping(value="workshopStudent/goImport")
	public String goImportTrainWorkshopStudent(Model model){
		model.addAllAttributes(request.getParameterMap());
		return getLogicViewNamePerfix() + "import_train_workshop_student";
	}
	
	@RequestMapping(value="workshopStudent/import")
	public String importTrainWorkshopStudent(String workshopId,String url,Model model){
		model.addAttribute("resultMap",workshopUserBizService.importTrainWorkshopStudent(url, workshopId));
		model.addAllAttributes(request.getParameterMap());
		return getLogicViewNamePerfix() + "import_result";
	}

}
