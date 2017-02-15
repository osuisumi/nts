package com.haoyu.nts.statistics.community.entity;

import java.text.ParseException;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.format.annotation.DateTimeFormat;

import com.haoyu.sip.core.entity.BaseEntity;
import com.haoyu.sip.core.entity.TimePeriod;
import com.haoyu.sip.sign.entity.SignStat;
import com.haoyu.sip.user.entity.UserInfo;
import com.haoyu.tip.train.entity.Train;

public class CommunityStatistics extends BaseEntity{

	private static final long serialVersionUID = -5090230955861237185L;

	private String id;
		
	private Train train;
	
	//研说数
	private int discussionNum;
	
	//创课数
	private int lessonNum;
	
	//社区活动数
	private int movementNum;
	
	//培训人数
	private int trainHeadcount;
	
	//合格率
	private double passPercent;
	
	//合格总人数
	private int passHeadcount;
	
	private TimePeriod trainingTime;
	
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private String trainingStartTime;

	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private String trainingEndTime;

	private UserInfo userInfo;
	
	private int score;
	
	private int userScore;
	
	private SignStat signStat;
	
	private String state;
		
	public CommunityStatistics() {
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Train getTrain() {
		return train;
	}

	public void setTrain(Train train) {
		this.train = train;
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

	public int getTrainHeadcount() {
		return trainHeadcount;
	}

	public void setTrainHeadcount(int trainHeadcount) {
		this.trainHeadcount = trainHeadcount;
	}

	public double getPassPercent() {
		return passPercent;
	}

	public void setPassPercent(double passPercent) {
		this.passPercent = passPercent;
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

	public int getPassHeadcount() {
		return passHeadcount;
	}

	public void setPassHeadcount(int passHeadcount) {
		this.passHeadcount = passHeadcount;
	}

	public UserInfo getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(UserInfo userInfo) {
		this.userInfo = userInfo;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public SignStat getSignStat() {
		return signStat;
	}

	public void setSignStat(SignStat signStat) {
		this.signStat = signStat;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public int getUserScore() {
		return userScore;
	}

	public void setUserScore(int userScore) {
		this.userScore = userScore;
	}
	
}
