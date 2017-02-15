package com.haoyu.nts.train.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.ncts.course.entity.Course;
import com.haoyu.ncts.course.utils.CourseState;
import com.haoyu.nts.train.service.ITrainBizService;
import com.haoyu.nts.train.service.impl.TrainBizService.CourseWarper;
import com.haoyu.nts.utils.TemplateUtils;
import com.haoyu.sip.core.entity.TimePeriod;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.excel.utils.StringUtils;
import com.haoyu.tip.train.entity.Train;
import com.haoyu.tip.train.service.ITrainRelationService;
import com.haoyu.tip.train.service.ITrainService;
import com.haoyu.tip.train.web.param.TrainParam;
import com.haoyu.wsts.workshop.service.IWorkshopRelationService;
import com.haoyu.wsts.workshop.utils.DateUtils;

@Controller
@RequestMapping("**/train")
public class TrainController extends AbstractBaseController{

	@Resource
	private ITrainService trainService;
	
	@Resource
	private ITrainRelationService trainRelationService;
	
	@Resource
	private ITrainBizService trainBizService;
	
	@Resource
	private IWorkshopRelationService workshopRelationService;
	
	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/train/");
	}
	
	@InitBinder  
	public void initBinder(WebDataBinder binder) {  
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
	dateFormat.setLenient(false);  
	//true:允许输入空值，false:不能为空值
	binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
	
	@RequestMapping(value="create",method = RequestMethod.GET)
	public String create(Model model){
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "edit_train";
	}
	
	@RequestMapping(method = RequestMethod.POST)
	@ResponseBody
	public Response create(Train train){
		return trainService.createTrain(train);
	}
	
	@RequestMapping(value="{id}/edit",method = RequestMethod.GET)
	public String edit(Train train,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("train", trainService.findTrainById(train.getId()));
		return getLogicalViewNamePrefix() + "edit_train";
	}
	
	@RequestMapping(value="{id}", method = RequestMethod.PUT)
	@ResponseBody
	public Response update(Train train){
		return trainService.updateTrain(train);
	}
	
	@RequestMapping(method = RequestMethod.GET)
	public String list(TrainParam trainParam,Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("pageBounds",getPageBounds(10, true));
		model.addAttribute("trainParam", trainParam);
		return getLogicalViewNamePrefix() + "list_train";
	}
	
	@RequestMapping(value="deleteByLogic",method = RequestMethod.DELETE)
	@ResponseBody
	public Response delete(Train train){
		return trainService.deleteTrain(train);
	}
	
	@RequestMapping(value="editTrainCourse")
	public String editTrainCourse(Train train,Model model){
		Course c = new Course();
		c.setState(CourseState.PASS);
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("course",c);
		model.addAttribute("train", train);
		return getLogicalViewNamePrefix() + "edit_train_course";
	}
	
	@RequestMapping(value="editTrainWorkshop")
	public String editTrainWorkshop(Train train,Model model,String trainingStartTime,String trainingEndTime){
		this.getPageBounds(Integer.MAX_VALUE, true);
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("train", train);
		model.addAttribute("trainingStartTime", trainingStartTime);
		model.addAttribute("trainingEndTime", trainingEndTime);
		return getLogicalViewNamePrefix() + "edit_train_workshop";
	}
	
	@RequestMapping(value="updateTrainWorkshop")
	@ResponseBody
	public Response updateTrainWorkshop(String trainId,String workshopIds,String trainingStartTime,String trainingEndTime){
		TimePeriod timePeriod = new TimePeriod();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if(StringUtils.isNotEmpty(trainingStartTime)){
			Date start;
			try {
				start = sdf.parse(trainingStartTime);
				timePeriod.setStartTime(DateUtils.getDayBegin(start));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if(StringUtils.isNotEmpty(trainingEndTime)){
			Date end;
			try {
				end = sdf.parse(trainingEndTime);
				timePeriod.setEndTime(DateUtils.getDayEnd(end));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		return workshopRelationService.updateWorkshopRelations(trainId, Arrays.asList(workshopIds.split(",")),timePeriod);
	}
	
	@RequestMapping(value="updateTrainCourse")
	@ResponseBody
	public Response updateTrainCourse(String trainId,String courseIds){
		return trainRelationService.updateTrainRelations(trainId, Arrays.asList(courseIds.split(",")),"course");
	}
	
	@RequestMapping(value="api/trains",method=RequestMethod.GET)
	@ResponseBody
	public List<Train> api(TrainParam train){
		return this.trainService.findTrains(train);
	}
	
	@RequestMapping(value="api/trainCourses",method=RequestMethod.GET)
	@ResponseBody
	public List<CourseWarper> api(String trainIds){
		return trainBizService.listTrainCourses(Arrays.asList(trainIds.split(",")));
	}
	
	@RequestMapping(value="editTrainConfig")
	public String editTrainConfig(Train train, Model model){
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("train", train);
		return getLogicalViewNamePrefix() + "edit_train_config";
	}
	
	@RequestMapping(value="listPrepareWorkshop",method=RequestMethod.GET)
	public String listPrepareWorkshop(Model model){
		setParameterToModel(request, model);
		return getLogicalViewNamePrefix() + "/workshop/list_prepare_workshop";
	}
	
}
