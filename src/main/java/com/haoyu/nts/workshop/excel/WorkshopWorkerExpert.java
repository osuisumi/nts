package com.haoyu.nts.workshop.excel;

import java.io.Serializable;

import com.haoyu.sip.excel.annotations.ExcelEntity;
import com.haoyu.sip.excel.annotations.ExportField;

@ExcelEntity(sortHead = true, sheetName = "工作坊管理工作统计", wrapText = true)
public class WorkshopWorkerExpert implements Serializable{
	private static final long serialVersionUID = -9162302817871718594L;
	@ExportField(colName = "姓名", colWidth = 3000, index = 0)
	private String realName;
	@ExportField(colName = "角色", colWidth = 3000, index = 1)
	private String role;
	@ExportField(colName = "培训", colWidth = 3000, index = 2)
	private String trainName;
	@ExportField(colName = "工作坊名称", colWidth = 3000, index = 3)
	private String workshopTitle;
	@ExportField(colName = "参与学员", colWidth = 3000, index = 4)
	private String studentNum;
	@ExportField(colName = "通过率", colWidth = 3000, index = 5)
	private String passPercent;
	@ExportField(colName = "发起任务", colWidth = 3000, index = 6)
	private String createActNum;
	@ExportField(colName = "回答问题", colWidth = 3000, index = 7)
	private String faqAnswerNum;
	@ExportField(colName = "上传资源", colWidth = 3000, index = 8)
	private String uploadResourceNum;
	@ExportField(colName = "评论", colWidth = 3000, index = 9)
	private String commentsNum;
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getTrainName() {
		return trainName;
	}
	public void setTrainName(String trainName) {
		this.trainName = trainName;
	}
	public String getWorkshopTitle() {
		return workshopTitle;
	}
	public void setWorkshopTitle(String workshopTitle) {
		this.workshopTitle = workshopTitle;
	}
	public String getStudentNum() {
		return studentNum;
	}
	public void setStudentNum(String studentNum) {
		this.studentNum = studentNum;
	}
	public String getPassPercent() {
		return passPercent;
	}
	public void setPassPercent(String passPercent) {
		this.passPercent = passPercent;
	}
	public String getCreateActNum() {
		return createActNum;
	}
	public void setCreateActNum(String createActNum) {
		this.createActNum = createActNum;
	}
	public String getFaqAnswerNum() {
		return faqAnswerNum;
	}
	public void setFaqAnswerNum(String faqAnswerNum) {
		this.faqAnswerNum = faqAnswerNum;
	}
	public String getUploadResourceNum() {
		return uploadResourceNum;
	}
	public void setUploadResourceNum(String uploadResourceNum) {
		this.uploadResourceNum = uploadResourceNum;
	}
	public String getCommentsNum() {
		return commentsNum;
	}
	public void setCommentsNum(String commentsNum) {
		this.commentsNum = commentsNum;
	}
	
	
	

}
