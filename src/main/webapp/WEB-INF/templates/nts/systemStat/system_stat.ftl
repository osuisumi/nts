	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<div class="mis-content">
		<ul class="mis-community-scoreinner">
			<li>
				<div class="mis-comm-Rtl">
					<h3><i class="mis-comm-decrib"></i>远教教育培训平台学情概况 </h3>
				</div>
				<table class=" mis-table">
                        <thead>
                            <tr>
                                <th width="20%">统计项</th>
                                <th width="50%">结果</th>
                            </tr>                                
                        </thead>

                        <tbody>
                            <tr>
                                <td>项目开展总数</td>
                                <td>${(systemStat.projectNum)!}项</td>
                            </tr>
                            <tr>
                                <td>项目培训合计</td>
                                <td>${(systemStat.trainNum)!}次</td>
                            </tr>
                            <tr>
                                <td>师资总数</td>
                                <td>${(systemStat.userTeacherNum)!}人</td>
                            </tr>
                            <tr>
                                <td>学员总数</td>
                                <td>${(systemStat.studentNum)!}人</td>
                            </tr>
                            <tr>
                                <td>培训参与人数</td>
                                <td>${(systemStat.joinedTrainStudentNum)!}人</td>
                            </tr>
                            <tr>
                                <td>平台培训人次</td>
                                <td>${(systemStat.trainRegisterNum)!}人</td>
                            </tr>
                            <tr>
                                <td>参训率</td>
                                <td><#if (systemStat.studentNum)?? && (systemStat.studentNum >0)>${(systemStat.joinedTrainStudentNum)/systemStat.studentNum*100}%<#else>0%</#if></td>
                            </tr>
                            <tr>
                                <td>人均参训次数</td>
                                <td><#if (systemStat.studentNum)?? && (systemStat.studentNum>0)>${systemStat.trainRegisterNum/systemStat.studentNum}</#if></td>
                            </tr>
                    </tbody>
                </table>
			</li>
		</ul>
	</div>
