package com.haoyu.nts.train.entity;

import java.math.BigDecimal;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.google.common.collect.Lists;
import com.haoyu.cmts.community.entity.CommunityRelation;
import com.haoyu.cmts.community.entity.CommunityResult;
import com.haoyu.cmts.community.utils.CommunityResultState;
import com.haoyu.sip.core.mapper.JsonMapper;
import com.haoyu.sip.excel.annotations.ExcelEntity;
import com.haoyu.sip.excel.annotations.ExportField;
import com.haoyu.tip.train.entity.Train;
import com.haoyu.tip.train.entity.TrainRegister;
import com.haoyu.wsts.workshop.entity.WorkshopUser;

@ExcelEntity(sortHead = true, sheetName = "学员成绩统计", wrapText = true)
public class TrainRegisterStat {

	private TrainRegister trainRegister;

	private Train train;

	private CommunityResult communityResult;

	private CommunityRelation communityRelation;

	private int courseStudyHours;// 从课程学习中获得的学时

	private int workshopStudyHours;// 从工作坊中获得的学时

	private int registedCourseNum;// 选课数

	private int qualifiedCourseNum;// 合格的课程数

	private int joinWorkshopNum;// 参与工作坊数

	private int qualifiedWorkshopNum;// 合格工作坊数

	private BigDecimal totalStudyHours = new BigDecimal(0);// 总共获取的学时

	private String communityEvaluate;// 社区考核

	private String courseEvaluate;// 课程考核

	private String trainTotalStudyHours;// 培训总学时

	private String trainResult;// 培训结果

	private String assignmentSubmitState;// 作业提交情况
	
	private BigDecimal mainCourseScore;//核心课分数

	private int needAssignmentNum;// 需要提交的作业数
	private int assignmentNum;// 已经提交的作业数
	private int uploadResourceNum;
	private int faqQuestionNum;
	private int discussionNum;
	private int createMovementNum;
	private int completeCourseActNum;
	private int completeWorkshopActNum;
	private int createActNum;
	private int joinActNum;
	private int joinMovementNum;
	private int participateMovementNum;
	private int createLessonNum;
	private int participateLessonNum;
	private int createDiscussionNum;
	
	private String paperworkNo;

	private boolean hasCalculateTotalStudyHours = false;

	List<CourseRegisterExtend> courseRegisters = Lists.newArrayList();
	
	List<WorkshopUser> workshopUsers = Lists.newArrayList();

	// excel导出
	@ExportField(colName = "培训", colWidth = 3000, index = 0)
	private String etrainName;
	@ExportField(colName = "工作单位", colWidth = 3000, index = 1)
	private String edeptName;
	@ExportField(colName = "姓名", colWidth = 3000, index = 2)
	private String erealName;
	@ExportField(colName = "身份证号(手机号)",colWidth = 3000,index = 3)
	private String epaperworkNo;
	@ExportField(colName = "总学时", colWidth = 3000, index = 4)
	private String etrainStudyHours;
	@ExportField(colName = "课程情况", colWidth = 3000, index = 5)
	private String ecourseState;
	@ExportField(colName = "作业提交情况", colWidth = 3000, index = 6)
	private String eassignmentSubmitState;
	@ExportField(colName = "课程考核", colWidth = 3000, index = 7)
	private String ecourseEvaluate;
	@ExportField(colName = "工作坊情况", colWidth = 3000, index = 8)
	private String eworkshopState;
	@ExportField(colName = "社区积分", colWidth = 3000, index = 9)
	private String ecommunityScore;
	@ExportField(colName = "社区考核", colWidth = 3000, index = 10)
	private String ecommunotyEvaluate;
	@ExportField(colName = "获得学时", colWidth = 3000, index = 11)
	private String estudyHours;
	@ExportField(colName = "培训情况", colWidth = 3000, index = 12)
	private String etrainResult;
	@ExportField(colName = "核心课分数",colWidth = 3000, index = 13)
	private String emainCourseScore;

	public void setExportField() {
		this.etrainName = this.getTrain() != null ? this.getTrain().getName() : "";
		if (this.getTrainRegister() != null && this.getTrainRegister().getUser() != null) {
			this.edeptName = this.getTrainRegister().getUser().getDeptName();
		} else {
			this.edeptName = "";
		}

		if (this.getTrainRegister() != null && this.getTrainRegister().getUser() != null) {
			this.erealName = this.getTrainRegister().getUser().getRealName();
		} else {
			this.erealName = "";
		}

		this.etrainStudyHours = this.getTrainTotalStudyHours();

		this.ecourseState = this.qualifiedCourseNum + "/" + this.registedCourseNum;

		this.eworkshopState = this.qualifiedWorkshopNum + "/" + this.joinWorkshopNum;

		this.eassignmentSubmitState = this.getAssignmentSubmitState();

		this.ecourseEvaluate = this.getCourseEvaluate();

		if (this.getCommunityResult() != null && this.getCommunityRelation() != null) {
			this.ecommunityScore = this.getCommunityResult().getScore() + "/" + this.getCommunityRelation().getScore();
		} else {
			this.ecommunityScore = "-";
		}

		this.ecommunotyEvaluate = this.getCommunityEvaluate();

		this.estudyHours = String.valueOf(this.getTotalStudyHours());

		this.etrainResult = this.getTrainResult();
		
		this.emainCourseScore = this.getMainCourseScore() == null?"0":this.getMainCourseScore().toString();
		
		this.epaperworkNo = this.getPaperworkNo();

	}
	
	
	
	

	public String getPaperworkNo() {
		return paperworkNo;
	}





	public void setPaperworkNo(String paperworkNo) {
		this.paperworkNo = paperworkNo;
	}





	public List<WorkshopUser> getWorkshopUsers() {
		return workshopUsers;
	}



	public void setWorkshopUsers(List<WorkshopUser> workshopUsers) {
		this.workshopUsers = workshopUsers;
	}



	public BigDecimal getMainCourseScore() {
		return mainCourseScore;
	}



	public void setMainCourseScore(BigDecimal mainCourseScore) {
		this.mainCourseScore = mainCourseScore;
	}



	public List<CourseRegisterExtend> getCourseRegisters() {
		return courseRegisters;
	}

	public void setCourseRegisters(List<CourseRegisterExtend> courseRegisters) {
		this.courseRegisters = courseRegisters;
	}

	public int getCourseStudyHours() {
		return courseStudyHours;
	}

	public void setCourseStudyHours(int courseStudyHours) {
		this.courseStudyHours = courseStudyHours;
	}

	public int getRegistedCourseNum() {
		return registedCourseNum;
	}

	public void setRegistedCourseNum(int registedCourseNum) {
		this.registedCourseNum = registedCourseNum;
	}

	public int getQualifiedCourseNum() {
		return qualifiedCourseNum;
	}

	public void setQualifiedCourseNum(int qualifiedCourseNum) {
		this.qualifiedCourseNum = qualifiedCourseNum;
	}

	public int getJoinWorkshopNum() {
		return joinWorkshopNum;
	}

	public void setJoinWorkshopNum(int joinWorkshopNum) {
		this.joinWorkshopNum = joinWorkshopNum;
	}

	public int getQualifiedWorkshopNum() {
		return qualifiedWorkshopNum;
	}

	public void setQualifiedWorkshopNum(int qualifiedWorkshopNum) {
		this.qualifiedWorkshopNum = qualifiedWorkshopNum;
	}

	public String getTrainTotalStudyHours() {
		if ("no_limit".equals(this.train.getStudyHoursType())) {
			return "-";
		} else {
			BigDecimal total = new BigDecimal(0);
			StudyHourType studyHourType = getStudyHourType(this.train.getStudyHoursType());
			total = studyHourType.getCourse().add(studyHourType.getCommunity()).add(studyHourType.getWorkshop());
			return String.valueOf(total);
		}
	}

	public String getTrainResult() {
		if ("no_limit".equals(this.train.getStudyHoursType())) {
			return "-";
		} else {
			BigDecimal total = new BigDecimal(0);
			StudyHourType studyHourType = getStudyHourType(this.train.getStudyHoursType());
			total = studyHourType.getCourse().add(studyHourType.getCommunity()).add(studyHourType.getWorkshop());
			if (this.getTotalStudyHours().compareTo(total) >= 0) {
				return "合格";
			} else {
				return "不合格";
			}
		}
	}

	public int getAssignmentNum() {
		return assignmentNum;
	}

	public void setAssignmentNum(int assignmentNum) {
		this.assignmentNum = assignmentNum;
	}

	public int getUploadResourceNum() {
		return uploadResourceNum;
	}

	public void setUploadResourceNum(int uploadResourceNum) {
		this.uploadResourceNum = uploadResourceNum;
	}

	public int getFaqQuestionNum() {
		return faqQuestionNum;
	}

	public void setFaqQuestionNum(int faqQuestionNum) {
		this.faqQuestionNum = faqQuestionNum;
	}

	public int getDiscussionNum() {
		return discussionNum;
	}

	public void setDiscussionNum(int discussionNum) {
		this.discussionNum = discussionNum;
	}

	public int getCreateMovementNum() {
		return createMovementNum;
	}

	public void setCreateMovementNum(int createMovementNum) {
		this.createMovementNum = createMovementNum;
	}

	public int getCompleteCourseActNum() {
		return completeCourseActNum;
	}

	public void setCompleteCourseActNum(int completeCourseActNum) {
		this.completeCourseActNum = completeCourseActNum;
	}

	public int getCompleteWorkshopActNum() {
		return completeWorkshopActNum;
	}

	public void setCompleteWorkshopActNum(int completeWorkshopActNum) {
		this.completeWorkshopActNum = completeWorkshopActNum;
	}

	public int getCreateActNum() {
		return createActNum;
	}

	public void setCreateActNum(int createActNum) {
		this.createActNum = createActNum;
	}

	public int getJoinActNum() {
		return joinActNum;
	}

	public void setJoinActNum(int joinActNum) {
		this.joinActNum = joinActNum;
	}

	public int getJoinMovementNum() {
		return joinMovementNum;
	}

	public void setJoinMovementNum(int joinMovementNum) {
		this.joinMovementNum = joinMovementNum;
	}

	public void setTotalStudyHours(BigDecimal totalStudyHours) {
		this.totalStudyHours = totalStudyHours;
	}

	public void setCommunityEvaluate(String communityEvaluate) {
		this.communityEvaluate = communityEvaluate;
	}

	public String getCourseEvaluate() {
		if ("no_limit".equals(this.train.getStudyHoursType())) {
			return "-";
		} else {
			return new BigDecimal(courseStudyHours).compareTo(getStudyHourType(this.train.getStudyHoursType()).getCourse()) >= 0 ? "合格" : "未达标";
		}
	}

	public String getCommunityEvaluate() {
		if (this.communityResult == null || this.communityRelation == null) {
			this.communityEvaluate = "-";
		} else {
			if (StringUtils.isEmpty(communityResult.getState())) {
				this.communityEvaluate = "待评价";
			} else {
				BigDecimal qualifiedPoint = this.communityRelation.getScore() == null ? new BigDecimal(0) : this.communityRelation.getScore();
				BigDecimal point = this.communityResult.getScore() == null ? new BigDecimal(0) : this.communityResult.getScore();
				if (point.compareTo(qualifiedPoint) >= 0) {
					switch (communityResult.getState()) {
					case CommunityResultState.EXCELLENT:
						this.communityEvaluate = "优秀";
						break;
					case CommunityResultState.PASSED:
						this.communityEvaluate = "合格";
						break;
					case CommunityResultState.NO_PASS:
						this.communityEvaluate = "未达标";
						break;
					default:
						break;
					}
				} else {
					this.communityEvaluate = "未达标";
				}
			}
		}
		return communityEvaluate;
	}
	
	

	public TrainRegister getTrainRegister() {
		return trainRegister;
	}

	public void setTrainRegister(TrainRegister trainRegister) {
		this.trainRegister = trainRegister;
	}

	public Train getTrain() {
		return train;
	}

	public void setTrain(Train train) {
		this.train = train;
	}

	public CommunityResult getCommunityResult() {
		return communityResult;
	}

	public void setCommunityResult(CommunityResult communityResult) {
		this.communityResult = communityResult;
	}

	public CommunityRelation getCommunityRelation() {
		return communityRelation;
	}

	public void setCommunityRelation(CommunityRelation communityRelation) {
		this.communityRelation = communityRelation;
	}

	public int getParticipateMovementNum() {
		return participateMovementNum;
	}

	public void setParticipateMovementNum(int participateMovementNum) {
		this.participateMovementNum = participateMovementNum;
	}

	public int getCreateLessonNum() {
		return createLessonNum;
	}

	public void setCreateLessonNum(int createLessonNum) {
		this.createLessonNum = createLessonNum;
	}

	public int getParticipateLessonNum() {
		return participateLessonNum;
	}

	public void setParticipateLessonNum(int participateLessonNum) {
		this.participateLessonNum = participateLessonNum;
	}

	public int getCreateDiscussionNum() {
		return createDiscussionNum;
	}

	public void setCreateDiscussionNum(int createDiscussionNum) {
		this.createDiscussionNum = createDiscussionNum;
	}

	public int getNeedAssignmentNum() {
		return needAssignmentNum;
	}

	public void setNeedAssignmentNum(int needAssignmentNum) {
		this.needAssignmentNum = needAssignmentNum;
	}

	public BigDecimal getTotalStudyHours() {
		// 处理课程学时
		if (hasCalculateTotalStudyHours) {
			return this.totalStudyHours;
		} else {
			BigDecimal courseHours = new BigDecimal(courseStudyHours);
			if (!"no_limit".equals(this.train.getStudyHoursType())) {
				if (courseHours.compareTo(getStudyHourType(this.train.getStudyHoursType()).getCourse()) > 0) {
					courseHours = getStudyHourType(this.train.getStudyHoursType()).getCourse();
				}
			}

			// 处理社区
			BigDecimal comuHours = new BigDecimal(0);
			if (this.communityResult != null) {
				if (CommunityResultState.PASSED.equals(this.communityResult.getState()) || CommunityResultState.EXCELLENT.equals(this.getCommunityResult().getState())) {
					try {
						comuHours = comuHours.add("no_limit".equals(this.train.getStudyHoursType()) ? this.communityRelation.getStudyHours() : getStudyHourType(this.train.getStudyHoursType()).getCommunity());
					} catch (Exception e) {
					}

				}
			}

			// 处理工作坊
			BigDecimal workshopHours = new BigDecimal(workshopStudyHours);
			if (!"no_limit".equals(this.train.getStudyHoursType())) {
				if (workshopHours.compareTo(getStudyHourType(this.train.getStudyHoursType()).getWorkshop()) > 0) {
					workshopHours = getStudyHourType(this.train.getStudyHoursType()).getWorkshop();
				}
			}
			totalStudyHours = totalStudyHours.add(courseHours);
			totalStudyHours = totalStudyHours.add(comuHours);
			totalStudyHours = totalStudyHours.add(workshopHours);
			//如果是指定学时配置，必须达标才能获取学时，未达标为0
			if(!"no_limit".equals(this.train.getStudyHoursType())){
				BigDecimal total = new BigDecimal(0);
				StudyHourType studyHourType = getStudyHourType(this.train.getStudyHoursType());
				total = studyHourType.getCourse().add(studyHourType.getCommunity()).add(studyHourType.getWorkshop());
				if (totalStudyHours.compareTo(total) < 0) {
					totalStudyHours = new BigDecimal(0);
				}
				
			}
			this.hasCalculateTotalStudyHours = true;
			return totalStudyHours;
		}

	}

	public String getAssignmentSubmitState() {
		if (needAssignmentNum == 0) {
			return "-";
		} else {
			return assignmentNum >= needAssignmentNum ? "已提交" : "未提交";
		}
	}

	private StudyHourType getStudyHourType(String json) {
		JsonMapper jsonMapper = new JsonMapper();
		StudyHourType result = jsonMapper.fromJson(json, StudyHourType.class);
		if (result == null) {
			result = new StudyHourType();
			result.setCourse(new BigDecimal(0));
			result.setCommunity(new BigDecimal(0));
			result.setWorkshop(new BigDecimal(0));
		}
		if (result.getCommunity() == null) {
			result.setCommunity(new BigDecimal(0));
		}
		if (result.getCourse() == null) {
			result.setCourse(new BigDecimal(0));
		}
		if (result.getWorkshop() == null) {
			result.setWorkshop(new BigDecimal(0));
		}

		return result;
	}

}

class StudyHourType {
	private BigDecimal course = new BigDecimal(0);

	private BigDecimal workshop = new BigDecimal(0);

	private BigDecimal community = new BigDecimal(0);

	public BigDecimal getCourse() {
		return course;
	}

	public void setCourse(BigDecimal course) {
		this.course = course;
	}

	public BigDecimal getWorkshop() {
		return workshop;
	}

	public void setWorkshop(BigDecimal workshop) {
		this.workshop = workshop;
	}

	public BigDecimal getCommunity() {
		return community;
	}

	public void setCommunity(BigDecimal community) {
		this.community = community;
	}
	
	

}
