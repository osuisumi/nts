package com.haoyu.nts.train.excel;

import com.haoyu.sip.excel.DataType;
import com.haoyu.sip.excel.annotations.ImportField;
import com.haoyu.sip.excel.model.ImportModel;

public class TrainRegisterModel extends ImportModel {

	@ImportField(colName = "姓名", validate = { DataType.REQURIED })
	private String realName;
	@ImportField(colName = "身份证号(手机号)", validate = { DataType.REQURIED })
	private String paperworkNo;

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

}
