package com.haoyu.nts.workshop.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.wsts.workshop.entity.Workshop;
import com.haoyu.wsts.workshop.entity.WorkshopUser;
import com.haoyu.wsts.workshop.service.IWorkshopUserService;
import com.haoyu.nts.workshop.service.IWorkshopUserBizService;

@Controller
@RequestMapping("**/manage/workshopUser")
public class WorkshopUserBizController extends AbstractBaseController{
	
	@Resource
	private IWorkshopUserService workshopUserService;
	@Resource
	private IWorkshopUserBizService workshopUserBizService;
	
	private String getLogicViewNamePerfix(){
		return TemplateUtils.getTemplatePath("/workshop/user/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(WorkshopUser workshopUser,Model model){
		getPageBounds(10,true);
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("workshopUser", workshopUser);
		return getLogicViewNamePerfix() + "list_workshop_user";
		
	}
	
	@RequestMapping(value="create",method=RequestMethod.GET)
	public String create(WorkshopUser workshopUser,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("workshopUser", workshopUser);
		return getLogicViewNamePerfix() + "edit_workshop_user"; 
	}
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response save(Workshop workshop){
		return workshopUserService.batchSave(workshop);
	}
	
	@RequestMapping(value="saveWorkshopUsers",method=RequestMethod.POST)
	@ResponseBody
	public Response saveStudent(String workshopId,String userIds,String role){
		return workshopUserBizService.saveWorkshopUsers(workshopId, Arrays.asList(userIds.split(",")), role);
	}
	
	@RequestMapping(value="{id}/edit",method=RequestMethod.GET)
	public String edit(@PathVariable String id,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("workshopUser",workshopUserService.findWorkshopUserById(id));
		return getLogicViewNamePerfix() + "edit_workshop_user";
	}
	
	@RequestMapping(value="{id}",method=RequestMethod.PUT)
	@ResponseBody
	public Response update(WorkshopUser workshopUser){
		return workshopUserService.updateWorkshopUser(workshopUser);
	}
	
	@RequestMapping(method = RequestMethod.DELETE)
	@ResponseBody
	public Response delete(WorkshopUser workshopUser){
		return workshopUserService.deleteWorkshopUser(workshopUser);
	}
	
	@RequestMapping(value="isAllow",method=RequestMethod.GET)
	@ResponseBody
	public Response isAllow(String userId,String workshopId){
		Map<String,Object> parameter  = Maps.newHashMap();
		parameter.put("userId", userId);
		parameter.put("workshopId", workshopId);
		List<WorkshopUser> workshopUsers = workshopUserService.findWorkshopUsers(parameter, null);
		if(CollectionUtils.isNotEmpty(workshopUsers)){
			return Response.failInstance().responseMsg("该用户已经在该工作坊内了");
		}else{
			return Response.successInstance();
		}
	}
	
	@RequestMapping(value="goImport",method=RequestMethod.GET)
	public String goImport(String workshopId,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("workshopId", workshopId);
		return getLogicViewNamePerfix() + "import_workshop_user";
	}
	
}
