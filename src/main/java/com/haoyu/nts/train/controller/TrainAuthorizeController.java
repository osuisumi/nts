package com.haoyu.nts.train.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.nts.train.service.ITrainAuthorizeBizService;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tip.train.entity.TrainAuthorize;
import com.haoyu.tip.train.service.ITrainAuthorizeService;

@Controller
@RequestMapping("**/manage/train/authorize")
public class TrainAuthorizeController extends AbstractBaseController{
	@Resource
	private ITrainAuthorizeService trainAuthorizeService;
	@Resource
	private ITrainAuthorizeBizService trainAuthorizeBizService;
	
	private String getLogicViewNamePerfix(){
		return TemplateUtils.getTemplatePath("/train/authorize/");
	}
	
	@RequestMapping(value="{trainId}",method=RequestMethod.GET)
	public String list(@PathVariable String trainId,TrainAuthorize trainAuthorize,Model model){
		model.addAttribute("trainId", trainId);
		model.addAttribute("trainAuthorize", trainAuthorize);
		model.addAllAttributes(request.getParameterMap());
		getPageBounds(10, true);
		return this.getLogicViewNamePerfix() + "list_train_authorize";
	}
	
	@RequestMapping(value="goImport",method=RequestMethod.GET)
	public String goImport(String trainId,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("trainId", trainId);
		return getLogicViewNamePerfix() + "import_train_authorize";
	}
	
	@RequestMapping(value="importTrainAuthorize", method=RequestMethod.POST)
	public String importTrainAuthorize(String url,String trainId,Model model){
		model.addAttribute("resultMap",trainAuthorizeBizService.importTrainAuthorize(url, trainId));
		model.addAllAttributes(request.getParameterMap());
		return getLogicViewNamePerfix() + "import_result";
	}
	
	@RequestMapping(value="deleteByLogic",method=RequestMethod.DELETE)
	@ResponseBody
	public Response deleteByLogic(TrainAuthorize trainAuthorize){
		return trainAuthorizeService.deleteTrainAuthorize(trainAuthorize);
	}

}
