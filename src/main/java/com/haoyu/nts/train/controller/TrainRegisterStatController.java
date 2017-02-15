package com.haoyu.nts.train.controller;

import java.io.IOException;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Maps;
import com.haoyu.nts.train.service.ITrainRegisterStatService;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/train_register_stat")
public class TrainRegisterStatController extends AbstractBaseController{
	@Resource
	private ITrainRegisterStatService trainRegisterStatService;
	
	
	private String getViewNamePerfix(){
		return TemplateUtils.getTemplatePath("/train/registerStat/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Model model){
		getPageBounds(10, true);
		model.addAllAttributes(request.getParameterMap());
		return getViewNamePerfix() + "list_train_register_stat";
	}
	
	@RequestMapping(value="/detail/{trainRegisterId}",method=RequestMethod.GET)
	public String detail(@PathVariable String trainRegisterId,String trainId,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("trainRegisterStat",trainRegisterStatService.get(trainRegisterId,trainId));
		return this.getViewNamePerfix() + "train_register_stat_detail";
	}
	@RequestMapping(value="editExport",method=RequestMethod.GET)
	public String editExport(Model model){
		model.addAllAttributes(request.getParameterMap());
		return getViewNamePerfix() + "edit_export";
	}
	
	@RequestMapping(value="export",method=RequestMethod.GET)
	public void export(String realName,String trainId,String deptId,String deptName,String assignmentSubmitType,HttpServletResponse response){
		Map<String,Object> parameter = Maps.newHashMap();
		PageBounds pageBounds = getPageBounds(10, true);
		if(StringUtils.isNotEmpty(realName)){
			parameter.put("realName", realName);
		}
		if(StringUtils.isNotEmpty(trainId)){
			parameter.put("trainId", trainId);
		}
		if(StringUtils.isNotEmpty(deptId)){
			parameter.put("deptId",deptId);
		}
		if(StringUtils.isNotEmpty(deptName)){
			parameter.put("deptName",deptName);
		}
		if(StringUtils.isNotEmpty(assignmentSubmitType)){
			parameter.put("assignmentSubmitType", assignmentSubmitType);
		}
		try {
			response.setCharacterEncoding("GBK");
			response.setContentType("application/xls;charset=GBK");
			int page = pageBounds.getPage();
			String outName = new String("学员成绩统计.xls".getBytes("GBK"),"ISO-8859-1");
			if(page>0){
				outName = new String(("学员成绩统计_page"+page+".xls").getBytes("GBK"),"ISO-8859-1");
			}
			response.setHeader("Content-disposition", "attachment; filename="+ outName);
			trainRegisterStatService.export(parameter,pageBounds, response.getOutputStream());
			//response.getOutputStream().write(FileUtils.readFileToByteArray());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
