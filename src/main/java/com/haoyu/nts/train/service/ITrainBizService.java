package com.haoyu.nts.train.service;

import java.util.List;

import com.haoyu.ncts.course.entity.Course;
import com.haoyu.nts.train.service.impl.TrainBizService.CourseWarper;

public interface ITrainBizService {
	
	public List<Course> listTrainCourses(String trainId);
	
	public List<CourseWarper> listTrainCourses(List<String> trainId);


}
