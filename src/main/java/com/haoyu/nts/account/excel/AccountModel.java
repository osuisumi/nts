package com.haoyu.nts.account.excel;

import com.haoyu.sip.excel.DataType;
import com.haoyu.sip.excel.annotations.ImportField;
import com.haoyu.sip.excel.model.ImportModel;

public class AccountModel extends ImportModel {

	@ImportField(colName = "用户名", validate = { DataType.REQURIED })
	private String userName;
	@ImportField(colName = "姓名", validate = { DataType.REQURIED })
	private String realName;

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

}
