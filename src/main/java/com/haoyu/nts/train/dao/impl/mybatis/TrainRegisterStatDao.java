package com.haoyu.nts.train.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.ncts.course.entity.CourseStat;
import com.haoyu.nts.train.dao.ITrainRegisterStatDao;
import com.haoyu.nts.train.entity.CourseRegisterExtend;
import com.haoyu.nts.train.entity.TrainRegisterStat;
import com.haoyu.sip.core.jdbc.MybatisDao;

@Repository
public class TrainRegisterStatDao extends MybatisDao implements ITrainRegisterStatDao{

	@Override
	public List<TrainRegisterStat> list(Map<String, Object> parameter, PageBounds pageBounds) {
		return super.selectList("select", parameter, pageBounds);
	}

	@Override
	public List<CourseRegisterExtend> findCourseRegister(Map<String, Object> parameter) {
		return super.selectList("selectCourseRegister", parameter);
	}
	
	public List<TrainRegisterStat> listFromSimpleTable(Map<String,Object> parameter,PageBounds pageBounds){
		return super.selectList("selectFromSimpleTable",parameter,pageBounds);
	}

	@Override
	public List<CourseStat> findCourseAssignmentNum(String trainId) {
		return super.selectList("countCourseAssignmentNum",trainId);
	}

}
