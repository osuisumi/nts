package com.haoyu.nts.train.entity;

import java.io.Serializable;

import com.haoyu.tip.train.entity.Train;

public class TrainParam implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private Train train;

	public Train getTrain() {
		return train;
	}

	public void setTrain(Train train) {
		this.train = train;
	}
	

}
