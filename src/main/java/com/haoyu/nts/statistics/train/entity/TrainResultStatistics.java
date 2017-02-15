package com.haoyu.nts.statistics.train.entity;

import com.haoyu.sip.core.entity.BaseEntity;
import com.haoyu.sip.user.entity.UserInfo;
import com.haoyu.tip.train.entity.Train;

public class TrainResultStatistics extends BaseEntity{

	private static final long serialVersionUID = 3688764676576576954L;
		
	private String id;
	
	private Train train;
	
	private UserInfo userInfo;
	
	private double workshopScore;
	
	private double communityScore;

	public TrainResultStatistics() {
	}

	public Train getTrain() {
		return train;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setTrain(Train train) {
		this.train = train;
	}

	public UserInfo getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(UserInfo userInfo) {
		this.userInfo = userInfo;
	}

	public double getWorkshopScore() {
		return workshopScore;
	}

	public void setWorkshopScore(double workshopScore) {
		this.workshopScore = workshopScore;
	}

	public double getCommunityScore() {
		return communityScore;
	}

	public void setCommunityScore(double communityScore) {
		this.communityScore = communityScore;
	}
}
