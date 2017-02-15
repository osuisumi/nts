package com.haoyu.nts.template;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import com.google.common.collect.Maps;
import com.haoyu.ncts.course.entity.Course;
import com.haoyu.ncts.course.service.ICourseService;
import com.haoyu.ncts.course.utils.CourseState;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.tip.train.entity.TrainRelation;
import com.haoyu.tip.train.service.ITrainRelationService;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class TrainCourseDataDirective implements TemplateDirectiveModel{
	@Resource
	private ITrainRelationService trainRelationService;
	@Resource
	private ICourseService courseService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> trainRelationParam = Maps.newHashMap();
		trainRelationParam.put("relationType", "course");
		if (params.containsKey("trainId")) {
			String trainId = params.get("trainId").toString();
			trainRelationParam.put("trainId", trainId);
		}
		List<TrainRelation> trainRelations = trainRelationService.findTrainRelations(trainRelationParam);
		List<String> relationIds = new ArrayList<String>();
		if(!CollectionUtils.isEmpty(trainRelations)){
			relationIds = Collections3.extractToList(trainRelations, "relation.id");
		}
		if(!CollectionUtils.isEmpty(relationIds)){
			Map<String,Object> courseParam = Maps.newHashMap();
			courseParam.put("ids",relationIds);
			courseParam.put("state",CourseState.PASS);
			List<Course> courses = courseService.listCourse(courseParam, null);
			env.setVariable("trainCourses", new DefaultObjectWrapper().wrap(courses));
		}
		body.render(env.getOut());
		
	}

}
