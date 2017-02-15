package com.haoyu.nts.account.excel;

import com.haoyu.sip.excel.DataType;
import com.haoyu.sip.excel.annotations.ImportField;
import com.haoyu.sip.excel.model.ImportModel;

public class StudentAccountModel extends ImportModel {

	@ImportField(colName = "用户名", validate = { DataType.REQURIED })
	private String userName;
	@ImportField(colName = "姓名", validate = { DataType.REQURIED })
	private String realName;
	@ImportField(colName = "身份证号(手机号)", validate = { DataType.REQURIED })
	private String paperworkNo;
	@ImportField(colName = "所在单位")
	private String deptName;

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getPaperworkNo() {
		return paperworkNo;
	}

	public void setPaperworkNo(String paperworkNo) {
		this.paperworkNo = paperworkNo;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

}
