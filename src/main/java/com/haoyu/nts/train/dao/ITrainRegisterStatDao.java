package com.haoyu.nts.train.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.ncts.course.entity.CourseStat;
import com.haoyu.nts.train.entity.CourseRegisterExtend;
import com.haoyu.nts.train.entity.TrainRegisterStat;

public interface ITrainRegisterStatDao {
	
	List<TrainRegisterStat> list(Map<String,Object> parameter,PageBounds pageBounds);
	
	List<CourseRegisterExtend> findCourseRegister(Map<String,Object> parameter);
	
	List<TrainRegisterStat> listFromSimpleTable(Map<String,Object> parameter,PageBounds pageBounds);
	
	List<CourseStat> findCourseAssignmentNum(String trainId);

}
