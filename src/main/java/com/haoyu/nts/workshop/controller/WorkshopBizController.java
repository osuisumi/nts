package com.haoyu.nts.workshop.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Maps;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.nts.workshop.service.IWorkshopBizService;
import com.haoyu.nts.workshop.web.Workshops;
import com.haoyu.sip.core.entity.TimePeriod;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.wsts.workshop.entity.Workshop;
import com.haoyu.wsts.workshop.entity.WorkshopUser;
import com.haoyu.wsts.workshop.service.IWorkshopService;
import com.haoyu.wsts.workshop.utils.DateUtils;

@Controller
@RequestMapping("**/manage/workshop")
public class WorkshopBizController extends AbstractBaseController{
	@Resource
	private IWorkshopService workshopService;
	@Resource
	private IWorkshopBizService workshopBizService;
	
	private String getLogicViewNamePerfix(){
		return TemplateUtils.getTemplatePath("/workshop/");
	}
	
	@RequestMapping(value="create",method=RequestMethod.GET)
	public String create(Model model){
		model.addAllAttributes(request.getParameterMap());
		return getLogicViewNamePerfix() + "edit_workshop"; 
	}
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response save(Workshop workshop,String startTime,String endTime){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		TimePeriod timePeriod = new TimePeriod();
		try{
			if(StringUtils.isNotEmpty(startTime)){
				Date start = DateUtils.getDayBegin(sdf.parse(startTime));
				timePeriod.setStartTime(start);
			}
			if(StringUtils.isNotEmpty(endTime)){
				Date end = DateUtils.getDayEnd(sdf.parse(endTime));
				timePeriod.setEndTime(end);
			}
		}catch(Exception e){
			throw new RuntimeException(e.getMessage());
		}
		workshop.setTimePeriod(timePeriod);
		return workshopService.createWorkshop(workshop);
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String list(Workshop workshop,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("workshop", workshop);
		getPageBounds(10, true);
		return getLogicViewNamePerfix() + "list_workshop";
	}

	@RequestMapping(value="{id}/edit",method=RequestMethod.GET)
	public String edit(@PathVariable String id,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("workshop",workshopService.findWorkshopById(id));
		return getLogicViewNamePerfix() + "edit_workshop";
	}
	
	@RequestMapping(value="{id}/update")
	@ResponseBody
	public Response update(Workshop workshop,String startTime,String endTime){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		TimePeriod timePeriod = new TimePeriod();
		try{
			if(StringUtils.isNotEmpty(startTime)){
				Date start = DateUtils.getDayBegin(sdf.parse(startTime));
				timePeriod.setStartTime(start);
			}
			if(StringUtils.isNotEmpty(endTime)){
				Date end = DateUtils.getDayEnd(sdf.parse(endTime));
				timePeriod.setEndTime(end);
			}
		}catch(Exception e){
			throw new RuntimeException(e.getMessage());
		}
		workshop.setTimePeriod(timePeriod);
		return workshopService.updateWorkshop(workshop);
	}
	
	@RequestMapping(value="batchUpdate",method=RequestMethod.PUT)
	@ResponseBody
	public Response batchUpdtae(Workshop workshop){
		return workshopService.updateWorkshop(workshop);
	}
	
	@RequestMapping(value="stat",method=RequestMethod.GET)
	public String stat(Workshop workshop,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("workshop",workshop);
		getPageBounds(10, true);
		return getLogicViewNamePerfix() + "list_workshop_stat";
	}
	
	@RequestMapping(value="schoolStat",method=RequestMethod.GET)
	public String schoolStat(String workshopId,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("workshopId",workshopId);
		getPageBounds(10, true);
		return getLogicViewNamePerfix() + "list_school_stat";
	}
	
	
	@RequestMapping(value="areaStat",method=RequestMethod.GET)
	public String areaStat(String workshopId,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("workshopId",workshopId);
		getPageBounds(10, true);
		return getLogicViewNamePerfix() + "list_area_stat";
	}

	@RequestMapping(value="memberStat",method=RequestMethod.GET)
	public String memberStat(WorkshopUser workshopUser,String workshopId,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("workshopUser", workshopUser);
		model.addAttribute("workshopId",workshopId);
		getPageBounds(10, true);
		return getLogicViewNamePerfix() + "list_member_stat";
	}
	
	@RequestMapping(value="studentStat",method=RequestMethod.GET)
	public String studentStat(String workshopId,String title ,String realName,String timeParam,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("title", title);
		model.addAttribute("realName", realName);
		model.addAttribute("timeParam", timeParam);
		model.addAttribute("workshopId",workshopId);
		getPageBounds(10, true);
		return getLogicViewNamePerfix() + "list_student_stat";
	}
	
	@RequestMapping(value="deleteByLogic",method=RequestMethod.DELETE)
	@ResponseBody
	public Response delete(Workshop workshop){
		return this.workshopService.deleteWorkshop(workshop);
	}
	
	@RequestMapping(value="point_rule",method=RequestMethod.GET)
	public String pointRule(Model model){
		model.addAllAttributes(request.getParameterMap());
		return getLogicViewNamePerfix() + "workshop_point_rule";
	}
	
	@RequestMapping(value="worker_stat")
	public String workerStat(Model model){
		model.addAllAttributes(request.getParameterMap());
		getPageBounds(10, true);
		return getLogicViewNamePerfix() + "list_workshop_worker_stat";
	}
	
	@RequestMapping(value="audit")
	public String audit(Workshops workshops,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("workshops",workshops);
		return getLogicViewNamePerfix() + "audit_workshop";
	}
	
	@RequestMapping(value="saveAudit",method=RequestMethod.POST)
	@ResponseBody
	public Response saveAudit(String state,String msg,Workshops workshops){
		return workshopBizService.audit(state, msg, workshops.getWorkshops());
	}
	
	@RequestMapping(value="worker_stat/editExport",method=RequestMethod.GET)
	public String editExpeortWorkerStat(Model model){
		model.addAllAttributes(request.getParameterMap());
		return getLogicViewNamePerfix() + "edit_worker_stat_export";
	}
	
	@RequestMapping(value="worker_stat/export",method=RequestMethod.GET)
	public void export(String realName,String title,HttpServletResponse response){
		Map<String,Object> parameter = Maps.newHashMap();
		PageBounds pageBounds = getPageBounds(10, true);
		if(StringUtils.isNotEmpty(realName)){
			parameter.put("realName", realName);
		}
		if(StringUtils.isNotEmpty(title)){
			parameter.put("title",title);
		}
		try {
			response.setCharacterEncoding("GBK");
			response.setContentType("application/xls;charset=GBK");
			int page = pageBounds.getPage();
			String outName = new String("工作坊管理工作统计.xls".getBytes("GBK"),"ISO-8859-1");
			if(page>0){
				outName = new String(("工作坊管理工作统计_page"+page+".xls").getBytes("GBK"),"ISO-8859-1");
			}
			response.setHeader("Content-disposition", "attachment; filename="+ outName);
			workshopBizService.exportWorkerStat(parameter,pageBounds, response.getOutputStream());
			//response.getOutputStream().write(FileUtils.readFileToByteArray());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	

	
}
