package com.haoyu.nts.course.excel;

import com.haoyu.sip.excel.DataType;
import com.haoyu.sip.excel.annotations.ExcelEntity;
import com.haoyu.sip.excel.annotations.ImportField;
import com.haoyu.sip.excel.model.ImportModel;

@ExcelEntity
public class CourseRegisterModel extends ImportModel{

	@ImportField(colName = "姓名", validate = { DataType.REQURIED })
	private String realName;
	@ImportField(colName = "身份证号(手机号)", validate = { DataType.REQURIED })
	private String paperworkNo;
	@ImportField(colName = "班级")
	private String clazz;

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

	public String getClazz() {
		return clazz;
	}

	public void setClazz(String clazz) {
		this.clazz = clazz;
	}

}
