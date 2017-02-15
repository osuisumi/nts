package com.haoyu.nts.statistics.train.entity;

import java.text.ParseException;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.format.annotation.DateTimeFormat;

import com.haoyu.sip.core.entity.BaseEntity;
import com.haoyu.sip.core.entity.TimePeriod;
import com.haoyu.sip.user.entity.Department;
import com.haoyu.sip.user.entity.UserInfo;
import com.haoyu.tip.project.entity.Project;

public class TrainStatistics extends BaseEntity{

	private static final long serialVersionUID = 4042284048996796931L;
	
	private String id;
	
	private String name;
	
	private Project project;
	
	private String state;
	
	private TimePeriod trainingTime;
	
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private String trainingStartTime;

	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private String trainingEndTime;
	
	//培训人数
	private int trainHeadcount;
	
	//合格人数
	private int passHeadcount;
	
	//合格率
	private double passPercent;
	
	//培训形式
	private String type;
	
	//参训人数
	private int participateHeadcount;
	
	//课程活动（参与人次）
	private int activityParticipateNum;
	
	//工作坊任务（参与人次）
	private int workshopParticipateNum;
	
	//研说数
	private int discussionNum;
	
	//创课数
	private int lessonNum;
	
	//社区活动数
	private int movementNum;
	
	//省
	private String province;
	
	//市
	private String city;
	
	//区县
	private String counties;
	
	private String provinceRegionsCode;
	
	private String cityRegionsCode;
	
	private String countiesRegionsCode;
	
	private Department department;

	private String trainStudyHoursType;
	
	private UserInfo userInfo;
	
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
	
	public double getPassPercent() {
		return passPercent;
	}

	public void setPassPercent(double passPercent) {
		this.passPercent = passPercent;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public int getParticipateHeadcount() {
		return participateHeadcount;
	}

	public void setParticipateHeadcount(int participateHeadcount) {
		this.participateHeadcount = participateHeadcount;
	}

	public int getWorkshopParticipateNum() {
		return workshopParticipateNum;
	}

	public void setWorkshopParticipateNum(int workshopParticipateNum) {
		this.workshopParticipateNum = workshopParticipateNum;
	}
	
	public int getDiscussionNum() {
		return discussionNum;
	}

	public void setDiscussionNum(int discussionNum) {
		this.discussionNum = discussionNum;
	}

	public int getLessonNum() {
		return lessonNum;
	}

	public void setLessonNum(int lessonNum) {
		this.lessonNum = lessonNum;
	}

	public int getMovementNum() {
		return movementNum;
	}

	public void setMovementNum(int movementNum) {
		this.movementNum = movementNum;
	}

	public int getActivityParticipateNum() {
		return activityParticipateNum;
	}

	public void setActivityParticipateNum(int activityParticipateNum) {
		this.activityParticipateNum = activityParticipateNum;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public TimePeriod getTrainingTime() {
		if (trainingTime == null) {
			if (StringUtils.isNotEmpty(trainingStartTime) || StringUtils.isNotEmpty(trainingEndTime)) {
				trainingTime = new TimePeriod();
				try {
					if (StringUtils.isNotEmpty(trainingStartTime)) {
						String[] array = trainingStartTime.split(" ");
						if (array.length == 1) {
							trainingStartTime += " 00:00:00";
						}
						trainingTime.setStartTime(DateUtils.parseDate(trainingStartTime, "yyyy-MM-dd HH:mm:ss"));
					}
					if (StringUtils.isNotEmpty(trainingEndTime)) {
						String[] array = trainingEndTime.split(" ");
						if (array.length == 1) {
							trainingEndTime += " 23:59:59";
						}
						trainingTime.setEndTime(DateUtils.parseDate(trainingEndTime, "yyyy-MM-dd HH:mm:ss"));
					}
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}
		}
		return trainingTime;
	}

	public void setTrainingTime(TimePeriod trainingTime) {
		this.trainingTime = trainingTime;
	}

	public String getTrainingStartTime() {
		return trainingStartTime;
	}

	public void setTrainingStartTime(String trainingStartTime) {
		this.trainingStartTime = trainingStartTime;
	}

	public String getTrainingEndTime() {
		return trainingEndTime;
	}

	public void setTrainingEndTime(String trainingEndTime) {
		this.trainingEndTime = trainingEndTime;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getCounties() {
		return counties;
	}

	public void setCounties(String counties) {
		this.counties = counties;
	}

	public String getCountiesRegionsCode() {
		return countiesRegionsCode;
	}

	public void setCountiesRegionsCode(String countiesRegionsCode) {
		this.countiesRegionsCode = countiesRegionsCode;
	}

	public String getProvinceRegionsCode() {
		return provinceRegionsCode;
	}

	public void setProvinceRegionsCode(String provinceRegionsCode) {
		this.provinceRegionsCode = provinceRegionsCode;
	}

	public String getCityRegionsCode() {
		return cityRegionsCode;
	}

	public void setCityRegionsCode(String cityRegionsCode) {
		this.cityRegionsCode = cityRegionsCode;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public String getTrainStudyHoursType() {
		return trainStudyHoursType;
	}

	public void setTrainStudyHoursType(String trainStudyHoursType) {
		this.trainStudyHoursType = trainStudyHoursType;
	}

	public UserInfo getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(UserInfo userInfo) {
		this.userInfo = userInfo;
	}
	
}
