package com.haoyu.nts.statistics.course.entity;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.haoyu.ncts.course.entity.Course;
import com.haoyu.tip.project.entity.Project;
import com.haoyu.tip.train.entity.Train;

public class CourseStatistics extends Course{

	private static final long serialVersionUID = 6514115831289701619L;
	
	/**
	 * 培训总数
	 */
	private int trainNum;
	
	/**
	 * 培训总人数
	 */
	private int trainHeadcount;
	
	/**
	 * 合格总人数
	 */
	private int passHeadcount;
	
	/**
	 * 合格率
	 */
	private double passProportion;
	
	/**
	 * 项目
	 */
	private Project project;
	
	/**
	 * 培训
	 */
	private Train train;
	
	public int getTrainNum() {
		return trainNum;
	}

	public void setTrainNum(int trainNum) {
		this.trainNum = trainNum;
	}

	public int getTrainHeadcount() {
		return trainHeadcount;
	}

	public void setTrainHeadcount(int trainHeadcount) {
		this.trainHeadcount = trainHeadcount;
	}

	public int getPassHeadcount() {
		return passHeadcount;
	}

	public void setPassHeadcount(int passHeadcount) {
		this.passHeadcount = passHeadcount;
	}

	public double getPassProportion() {
		return passProportion;
	}

	public void setPassProportion(double passProportion) {
		this.passProportion = passProportion;
	}

	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}

	public Train getTrain() {
		return train;
	}

	public void setTrain(Train train) {
		this.train = train;
	}
	
	public void setParam(Map<String, Object> parameter) {
		if (StringUtils.isNotEmpty(this.getTitle())) {
			parameter.put("title", this.getTitle());
		}
		if (this.getProject() != null && StringUtils.isNotEmpty(this.getProject().getId())) {
			parameter.put("projectId", this.getProject().getId());
		}
		if (this.getTrain() != null && StringUtils.isNotEmpty(this.getTrain().getId())) {
			parameter.put("trainId", this.getTrain().getId());
		}
	}
}
