package com.haoyu.nts.cmts.movement.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.cmts.movement.entity.Movement;
import com.haoyu.cmts.movement.entity.MovementRegister;
import com.haoyu.cmts.movement.service.IMovementCmtsService;
import com.haoyu.cmts.movement.service.IMovementRegisterCmtsService;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/nts/cmts/movement")
public class MovementNtsController extends AbstractBaseController {
	
	@Resource
	private IMovementCmtsService movementService;
	@Resource
	private IMovementRegisterCmtsService movementRegisterService;

	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/cmts/movement/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Movement movement, Model model){
		model.addAttribute("movement", movement);
		model.addAllAttributes(request.getParameterMap());
		getPageBounds(10, true);
		return getLogicalViewNamePrefix() + "list_movement";
	}
	
	@RequestMapping(value="create", method=RequestMethod.GET)
	public String create(Movement movement, Model model){
		model.addAttribute("movement", movement);
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "edit_movement";
	}
	
	@RequestMapping(value="{id}/edit", method=RequestMethod.GET)
	public String edit(Movement movement, Model model){
		model.addAttribute("movement", movement);
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "edit_movement";
	}

	@RequestMapping(value="{id}",method=RequestMethod.PUT)
	@ResponseBody
	public Response update(Movement movement){
		return movementService.update(movement);
	}
	
	@RequestMapping(value="{id}",method=RequestMethod.DELETE)
	@ResponseBody
	public Response delete(Movement movement){		
		return movementService.delete(movement);
	}
	
	@RequestMapping(value="{id}/view", method=RequestMethod.GET)
	public String view(Movement movement,Model model){	
		model.addAttribute("movement",movement);
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "view_movement";
	}
	
	@RequestMapping(value="register",method = RequestMethod.GET)
	public String list(MovementRegister movementRegister,Model model){
		model.addAttribute("movementRegister",movementRegister);
		model.addAllAttributes(request.getParameterMap());
		getPageBounds(10, true);
		return getLogicalViewNamePrefix() + "list_movement_register";
	}
	
	@RequestMapping(value="register/grantTicketNo",method=RequestMethod.PUT)
	@ResponseBody
	public Response update(MovementRegister movementRegister){
		return movementRegisterService.grantTicketNo(movementRegister);
	}
}
