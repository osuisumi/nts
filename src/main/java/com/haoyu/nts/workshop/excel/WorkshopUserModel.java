package com.haoyu.nts.workshop.excel;

import com.haoyu.sip.excel.DataType;
import com.haoyu.sip.excel.annotations.ImportField;
import com.haoyu.sip.excel.model.ImportModel;

public class WorkshopUserModel extends ImportModel {

	@ImportField(colName = "姓名", validate = { DataType.REQURIED })
	private String realName;
	@ImportField(colName = "身份证号(手机号)", validate = { DataType.REQURIED })
	private String paperworkNo;
	@ImportField(colName = "角色(坊主、管理成员、学员)")
	private String role;

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

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

}
