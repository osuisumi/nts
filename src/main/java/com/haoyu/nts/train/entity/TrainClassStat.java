package com.haoyu.nts.train.entity;

import com.haoyu.tip.train.entity.Train;

public class TrainClassStat {

	private Train train;

	private int registerNum;

	private int classNum;

	private int classRegisterNum;

	private int unClassRegisterNum;

	public Train getTrain() {
		return train;
	}

	public void setTrain(Train train) {
		this.train = train;
	}

	public int getRegisterNum() {
		return registerNum;
	}

	public void setRegisterNum(int registerNum) {
		this.registerNum = registerNum;
	}

	public int getClassNum() {
		return classNum;
	}

	public void setClassNum(int classNum) {
		this.classNum = classNum;
	}

	public int getClassRegisterNum() {
		return classRegisterNum;
	}

	public void setClassRegisterNum(int classRegisterNum) {
		this.classRegisterNum = classRegisterNum;
	}

	public int getUnClassRegisterNum() {
		return unClassRegisterNum;
	}

	public void setUnClassRegisterNum(int unClassRegisterNum) {
		this.unClassRegisterNum = unClassRegisterNum;
	}

}
