package com.haoyu.nts.train.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.ncts.course.entity.Course;
import com.haoyu.ncts.course.service.ICourseService;
import com.haoyu.nts.train.service.ITrainBizService;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.tip.train.entity.TrainRelation;
import com.haoyu.tip.train.service.ITrainRelationService;
import com.haoyu.tip.train.service.ITrainService;

@Service
public class TrainBizService implements ITrainBizService{
	@Resource
	private ITrainRelationService trainRelationService;
	@Resource
	private ICourseService courseService;
	@Resource
	private ITrainService trainService;

	@Override
	public List<Course> listTrainCourses(String trainId) {
		List<Course> result = Lists.newArrayList();
		Map<String, Object> trainRelationParam = Maps.newHashMap();
		trainRelationParam.put("relationType", "course");
		trainRelationParam.put("trainId",trainId);
		List<TrainRelation> trainRelations = trainRelationService.findTrainRelations(trainRelationParam);
		List<String> relationIds = new ArrayList<String>();
		if(!CollectionUtils.isEmpty(trainRelations)){
			relationIds = Collections3.extractToList(trainRelations, "relation.id");
		}
		if(!CollectionUtils.isEmpty(relationIds)){
			Map<String,Object> courseParam = Maps.newHashMap();
			courseParam.put("ids",relationIds);
			result = courseService.listCourse(courseParam, null);
		}
		return result;
	}
	
	public List<CourseWarper> listTrainCourses(List<String> trainIds){
		List<CourseWarper> result = Lists.newArrayList();
		for(String trainId:trainIds){
			List<Course> courses = listTrainCourses(trainId);
			for(Course c:courses){
				CourseWarper cw = new CourseWarper();
				cw.setCourse(c);
				cw.setTrainId(trainId);
				result.add(cw);
			}
		}
		return result;
	}
	
	public class CourseWarper {
		public String trainId;

		public Course course;

		public Course getCourse() {
			return course;
		}

		public void setCourse(Course course) {
			this.course = course;
		}

		public String getTrainId() {
			return trainId;
		}

		public void setTrainId(String trainId) {
			this.trainId = trainId;
		}

	}
}
