package com.haoyu.nts.resource.excel;

import java.io.Serializable;

import com.haoyu.sip.excel.annotations.ExcelEntity;
import com.haoyu.sip.excel.annotations.ExportField;

@ExcelEntity(sortHead = true, sheetName = "导出结果", wrapText = true)
public class RecourceExport implements Serializable {

	private static final long serialVersionUID = 8451679649078502528L;

	@ExportField(colName = "资源名", colWidth = 6000, index = 0)
	private String fileName;
	@ExportField(colName = "路径", colWidth = 12000, index = 1)
	private String url;
	@ExportField(colName = "结果", colWidth = 12000, index = 2)
	private String msg;

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

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

}
