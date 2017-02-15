<#import "/nts/include/tab.ftl" as tab/>
<@tab.tabFtl items=items[0] />
<#assign userIds = [trainRegisterStat.trainRegister.user.id]>
<@baseUserViewMapDirective userIds=userIds! >
	<#assign BUVUserMap=BUVUserMap>
	<#assign user = (BUVUserMap[trainRegisterStat.trainRegister.user.id])!/>
</@baseUserViewMapDirective>

<#if (trainRegisterStat.train.project.id)??>
	<@projectDirective id=trainRegisterStat.train.project.id>
		<#assign project=project>
	</@projectDirective>
</#if>
<div class="mis-content">
	<ul class="mis-community-scoreinner">
		<li>
			<table class=" mis-table" style="width:800px">
				<tbody>
					<tr>
						<td colspan="4">基本信息</td>
					</tr>
					<tr>
						<td colspan="1">姓名</td>
						<td colspan="1">${(user.userName)!}</td>
						<td colspan="1">所在单位</td>
						<td colspan="1">${(user.deptName)!}</td>
					</tr>
					<tr>
						<!--<td colspan="1">性别</td>
						<td colspan="3">xxx</td>
						-->
						<td colspan="1">身份证(手机)号</td>
						<td colspan="3">${(user.paperworkNo)!}</td>
					</tr>
					<!--
					<tr>
						<td colspan="1">所在区域</td>
						<td colspan="3">xxx</td>
					</tr>
					-->
					<tr>
						<td colspan="1">学段</td>
						<td colspan="1">${(user.stage)!}</td>
						<td colspan="1">学科</td>
						<td colspan="1">${(user.subject)!}</td>
					</tr>
					<tr>
						<td colspan="1">参与项目</td>
						<td colspan="3">${(project.name)!}</td>
					</tr>
					<tr>
						<td colspan="1">培训期次</td>
						<td colspan="3">${(trainRegisterStat.train.name)!}</td>
					</tr>
					<tr>
						<td colspan="1">培训时间</td>
						<td colspan="3">${(trainRegisterStat.train.trainingTime.startTime?string('yyyy-MM-dd'))!}至${(trainRegisterStat.train.trainingTime.endTime?string('yyyy-MM-dd'))!}</td>
					</tr>
					<tr>
						<td colspan="1">获得学时</td>
						<td colspan="3">${(trainRegisterStat.totalStudyHours)!}</td>
					</tr>
					<tr>
						<td colspan="4">考核详情</td>
					</tr>
					<tr>
						<td colspan="1">课程学习</td>
						<td colspan="1">${(trainRegisterStat.registedCourseNum)!0}门课</td>
						<td colspan="1">评定</td>
						<td colspan="1">${(trainRegisterStat.courseEvaluate)!}</td>
					</tr>
					<tr>
						<td colspan="1">社区拓展</td>
						<td colspan="1"><#if trainRegisterStat.communityRelation??>1项<#else>-</#if></td>
						<td colspan="1">评定</td>
						<td colspan="1">${(trainRegisterStat.communityEvaluate)!}</td>
					</tr>
					<#if (trainRegisterStat.workshopUsers)??>
					<tr>
						<td colspan="4">工作坊研修</td>
					</tr>
						<#list trainRegisterStat.workshopUsers as wu>
							<tr>
								<td colspan="1">工作坊名称</td>
								<td colspan="1">${(wu.workshop.title)!}</td>
								<td colspan="1">积分</td>
								<td colspan="1">${(wu.workshopUserResult.point)!0}</td>
							</tr>
						</#list>
					</#if>
					<tr>
						<td colspan="4">选课明细</td>
					</tr>
					<#if (trainRegisterStat.courseRegisters)??>
						<#list trainRegisterStat.courseRegisters as cr>
							<tr>
								<td colspan="1">课程名</td>
								<td colspan="1">${(cr.course.title)!}</td>
								<td colspan="1">成绩</td>
								<td colspan="1">${(cr.courseResult.score)!0}</td>
							</tr>
						</#list>
					</#if>
					<tr>
						<td colspan="4">数据统计</td>
					</tr>
					<tr>
						<td colspan="1">作业数(篇)</td>
						<td colspan="1">${(trainRegisterStat.assignmentNum)!}</td>
						<td colspan="1">完成学习活动(个)</td>
						<td colspan="1">${(trainRegisterStat.completeCourseActNum)!}</td>
					</tr>
					<tr>
						<td colspan="1">上传资源(个)</td>
						<td colspan="1">${(trainRegisterStat.uploadResourceNum)!}</td>
						<td colspan="1">完成工作坊任务(个)</td>
						<td colspan="1">${(trainRegisterStat.completeWorkshopActNum)!}</td>
					</tr>
					<tr>
						<td colspan="1">提问(个)</td>
						<td colspan="1">${(trainRegisterStat.faqQuestionNum)!}</td>
						<td colspan="1">发起活动(项)</td>
						<td colspan="1">${(trainRegisterStat.createMovementNum)!0}</td>
					</tr>
					<tr>
						<td colspan="1">发表研说(篇)</td>
						<td colspan="1">${(trainRegisterStat.createDiscussionNum)!0}</td>
						<td colspan="1">参与活动(项)</td>
						<td colspan="1">${(trainRegisterStat.participateMovementNum)!0}</td>
					</tr>
					<tr>
						<td colspan="1">发起创课(个)</td>
						<td colspan="1">${(trainRegisterStat.createLessonNum)!0}</td>
						<td colspan="1">参与创课(个)</td>
						<td colspan="1">${(trainRegisterStat.participateLessonNum)!0}</td>
					</tr>
				</tbody>
			</table>
		</li>
	</ul>
</div>
