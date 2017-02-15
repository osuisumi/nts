package com.haoyu.nts.train.excel;

import java.io.Serializable;

import com.haoyu.sip.excel.annotations.ExcelEntity;
import com.haoyu.sip.excel.annotations.ExportField;

@ExcelEntity(sortHead = true, sheetName = "导入结果", wrapText = true)
public class TrainAuthorizeExport implements Serializable {
	private static final long serialVersionUID = -5110399065221277229L;

	@ExportField(colName = "用户名", colWidth = 3000, index = 1)
	private String userName;

	@ExportField(colName = "结果", colWidth = 12000, index = 3)
	private String msg;

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

}
