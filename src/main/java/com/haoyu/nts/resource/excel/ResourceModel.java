package com.haoyu.nts.resource.excel;

import com.haoyu.sip.excel.DataType;
import com.haoyu.sip.excel.annotations.ExcelEntity;
import com.haoyu.sip.excel.annotations.ImportField;
import com.haoyu.sip.excel.model.ImportModel;

@ExcelEntity
public class ResourceModel extends ImportModel {
	@ImportField(colName = "资源名", validate = { DataType.REQURIED })
	private String fileName;
	@ImportField(colName = "路径", validate = { DataType.REQURIED })
	private String url;
	
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}

}