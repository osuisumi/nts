package com.haoyu.nts.course.entity;

import java.text.DecimalFormat;

import com.haoyu.ncts.course.entity.Course;
import com.haoyu.ncts.course.entity.CourseAuthorize;
import com.haoyu.sip.excel.annotations.ExcelEntity;
import com.haoyu.sip.excel.annotations.ExportField;
import com.haoyu.tip.train.entity.Train;

@ExcelEntity(sortHead = true, sheetName = "课程管理工作统计", wrapText = true)
public class CourseAuthorizeStat {

	private CourseAuthorize courseAuthorize;
	private Course course;
	private Train train;
	private int courseRegisterNum;
	private int courseSubmitAssignmentNum;
	private int courseQualifiedNum;
	private int uploadResourceNum;
	private int faqAnswerNum;
	private int markedAssignmentNum;
	private String passPersent;
	
	@ExportField(colName = "姓名", colWidth = 3000, index = 0)
	private String erealName;
	@ExportField(colName = "角色", colWidth = 3000, index = 1)
	private String erole;
	@ExportField(colName = "培训", colWidth = 3000, index = 2)
	private String etrainName;
	@ExportField(colName = "课程名称", colWidth = 3000, index = 3)
	private String ecourseName;
	@ExportField(colName = "选课人数", colWidth = 3000, index = 4)
	private String ecourseRegisterNum;
	@ExportField(colName = "通过率", colWidth = 3000, index = 5)
	private String ecoursePassPercent;
	@ExportField(colName = "回答问题", colWidth = 3000, index = 6)
	private String efaqAnswerNum;
	@ExportField(colName = "上传资源", colWidth = 3000, index = 7)
	private String euploadResourceNum;
	@ExportField(colName = "作业总数", colWidth = 3000, index = 8)
	private String ecourseSubmitAssignmentNum;
	@ExportField(colName = "批改作业", colWidth = 3000, index = 9)
	private String emarkedAssignmentNum;
	
	public void setExpertField(){
		erealName = getErealName();
		erole = getErole();
		etrainName = getEtrainName();
		ecourseName = getEcourseName();
		ecourseRegisterNum = getEcourseRegisterNum();
		ecoursePassPercent = getEcoursePassPercent();
		efaqAnswerNum = getEfaqAnswerNum();
		euploadResourceNum = getEuploadResourceNum();
		ecourseSubmitAssignmentNum = getEcourseSubmitAssignmentNum();
		emarkedAssignmentNum = getEmarkedAssignmentNum();
	}
	

	public CourseAuthorize getCourseAuthorize() {
		return courseAuthorize;
	}

	public void setCourseAuthorize(CourseAuthorize courseAuthorize) {
		this.courseAuthorize = courseAuthorize;
	}

	public Course getCourse() {
		return course;
	}

	public void setCourse(Course course) {
		this.course = course;
	}

	public Train getTrain() {
		return train;
	}

	public void setTrain(Train train) {
		this.train = train;
	}

	public int getUploadResourceNum() {
		return uploadResourceNum;
	}

	public void setUploadResourceNum(int uploadResourceNum) {
		this.uploadResourceNum = uploadResourceNum;
	}

	public int getFaqAnswerNum() {
		return faqAnswerNum;
	}

	public void setFaqAnswerNum(int faqAnswerNum) {
		this.faqAnswerNum = faqAnswerNum;
	}

	public int getMarkedAssignmentNum() {
		return markedAssignmentNum;
	}

	public void setMarkedAssignmentNum(int markedAssignmentNum) {
		this.markedAssignmentNum = markedAssignmentNum;
	}

	public int getCourseRegisterNum() {
		return courseRegisterNum;
	}

	public void setCourseRegisterNum(int courseRegisterNum) {
		this.courseRegisterNum = courseRegisterNum;
	}

	public int getCourseSubmitAssignmentNum() {
		return courseSubmitAssignmentNum;
	}

	public void setCourseSubmitAssignmentNum(int courseSubmitAssignmentNum) {
		this.courseSubmitAssignmentNum = courseSubmitAssignmentNum;
	}

	public int getCourseQualifiedNum() {
		return courseQualifiedNum;
	}

	public void setCourseQualifiedNum(int courseQualifiedNum) {
		this.courseQualifiedNum = courseQualifiedNum;
	}

	
	/*以下为excel*/
	public String getErealName() {
		if(courseAuthorize != null && courseAuthorize.getUser()!=null){
			return courseAuthorize.getUser().getRealName();
		}
		else{
			return "";
		}
	}

	public String getErole() {
		if(courseAuthorize != null && "teacher".equals(courseAuthorize.getRole())){
			return "助学";
		}else{
			return "";
		}
	}

	

	public String getEtrainName() {
		if(train!=null){
			return train.getName();
		}else{
			return "";
		}
	}


	public String getEcourseName() {
		if(course!=null){
			return course.getTitle();
		}
		return "";
	}

	public String getEcourseRegisterNum() {
		return String.valueOf(this.getCourseRegisterNum());
	}

	public String getEcoursePassPercent() {
		return getPassPersent();
	}

	public String getEfaqAnswerNum() {
		return String.valueOf(getFaqAnswerNum());
	}

	public String getEuploadResourceNum() {
		return String.valueOf(getUploadResourceNum());
	}

	public String getEcourseSubmitAssignmentNum() {
		return String.valueOf(getCourseSubmitAssignmentNum());
	}

	public String getEmarkedAssignmentNum() {
		return String.valueOf(getMarkedAssignmentNum());
	}


	public String getPassPersent() {
		if(getCourseQualifiedNum()!=0&&getCourseRegisterNum()!=0){
			DecimalFormat    df   = new DecimalFormat("######0.00"); 
			double result = getCourseQualifiedNum()*1.0/getCourseRegisterNum()*100;
			return df.format(result) + "%";
		}else{
			return "0%";
		}
	}
	

}
