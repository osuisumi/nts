package com.haoyu.nts.account.excel;

import java.io.Serializable;

import com.haoyu.sip.excel.annotations.ExcelEntity;
import com.haoyu.sip.excel.annotations.ExportField;

@ExcelEntity(sortHead = true, sheetName = "导入结果", wrapText = true)
public class StudentAccountExport implements Serializable{
	private static final long serialVersionUID = -3176439593846373571L;
	@ExportField(colName = "用户名", colWidth = 3000, index = 1)
	private String userName;
	@ExportField(colName = "姓名", colWidth = 3000, index = 2)
	private String realName;
	@ExportField(colName = "身份证号(手机号)", colWidth = 3000, index = 3)
	private String paperworkNo;
	@ExportField(colName = "所在单位", colWidth = 3000, index = 4)
	private String deptName;
	@ExportField(colName = "结果", colWidth = 12000, index = 5)
	private String msg;

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

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	

}
