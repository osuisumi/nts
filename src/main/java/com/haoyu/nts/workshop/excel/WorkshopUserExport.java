package com.haoyu.nts.workshop.excel;

import java.io.Serializable;

import com.haoyu.sip.excel.annotations.ExcelEntity;
import com.haoyu.sip.excel.annotations.ExportField;
@ExcelEntity(sortHead = true, sheetName = "导入结果", wrapText = true)
public class WorkshopUserExport implements Serializable{

	private static final long serialVersionUID = 7095980835197154956L;

	@ExportField(colName = "姓名", colWidth = 3000, index = 1)
	private String realName;

	@ExportField(colName = "身份证号", colWidth = 6000, index = 2)
	private String paperworkNo;

	@ExportField(colName = "角色", colWidth = 6000, index = 3)
	private String role;

	@ExportField(colName = "结果", colWidth = 12000, index = 4)
	private String msg;

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

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

}
