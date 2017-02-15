package com.haoyu.nts.teacher.excel;

import com.haoyu.sip.excel.DataType;
import com.haoyu.sip.excel.annotations.ImportField;
import com.haoyu.sip.excel.model.ImportModel;

public class TeacherModel extends ImportModel {

	@ImportField(colName = "用户名", validate = { DataType.REQURIED })
	private String userName;
	@ImportField(colName = "姓名", validate = { DataType.REQURIED })
	private String realName;
	@ImportField(colName = "身份证号(手机号)")
	private String paperworkNo;

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPaperworkNo() {
		return paperworkNo;
	}

	public void setPaperworkNo(String paperworkNo) {
		this.paperworkNo = paperworkNo;
	}

}
