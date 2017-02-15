<form id="saveTrainConfigForm" action="${ctx }/manage/workshop/${(workshopId)!}/update" method="post">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<@workshopDirective id=workshopId>
		<@trainDirective id=(workshop.workshopRelation.relation.id)!''>
			<#assign train=trainModel>
		<div class="mis-srh-layout">
	    	<ul class="mis-ipt-lst">
				<li class="item w1">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>所属项目：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-ipt-mod">
		                        <#if (train.project.id)??>
		                        	<@projectDirective id=train.project.id>
		                        		${(project.name)!}
		                        	</@projectDirective>
		                        </#if>
		                    </div>
		                </div>
		            </div>
		        </li>
				<li class="item w1">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>所属培训：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-ipt-mod">
		                        <#if train??>
		                        	${(train.name)!}
		                        </#if>
		                    </div>
		                </div>
		            </div>
		        </li>
				<li class="item w1">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>工作坊名称：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-ipt-mod">
	                    		<input required style="width:300px" type="text" name="title" value="${(workshop.title)!}" placeholder="" class="mis-ipt">
		                    </div>
		                </div>
		            </div>
		        </li>
	 	        <li class="item item-twoIpu">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>学科/学段：</span>
	                    </div>
	                    <div class="center">
	                        <div class="tc">
								<div class="mis-select">
		                            <select name="stage">
		                               ${TextBookUtils.getEntryOptionsSelected('STAGE', (workshop.stage)!'') }
		                            </select>    
		                        </div>
	                        </div>
	                        <span class="to"></span>
	                        <div class="tc">
								<div class="mis-select">
		                            <select name="subject">
		                                ${TextBookUtils.getEntryOptionsSelected('SUBJECT', (workshop.subject)!'') }
		                            </select>    
		                        </div>
	                        </div>                                            
	                    </div>
	                </div>
	            </li>
				<li class="item w1">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>坊主：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-ipt-mod">
		                        <@workshopUsersDirective role="master" workshopId=workshopId>
		                        	<#if workshopUsers?? && (workshopUsers?size>0)>
		                        		<#list workshopUsers as wu>
		                        			${(wu.userInfo.realName)!}
		                        		</#list>
		                        	<#else>
		                        		待指定
		                        	</#if>
		                        </@workshopUsersDirective>
		                    </div>
		                </div>
		            </div>
		        </li>
				<li class="item w1">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>助理坊主：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-ipt-mod">
		                        <@workshopUsersDirective role="member" workshopId=workshopId>
		                        	<#if workshopUsers?? && (workshopUsers?size>0)>
		                        		<#list workshopUsers as wu>
		                        			${(wu.userInfo.realName)!}
		                        		</#list>
		                        	<#else>
		                        		待指定
		                        	</#if>
		                        </@workshopUsersDirective>
		                    </div>
		                </div>
		            </div>
		        </li>
				<li class="item w1">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>有效学时：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-ipt-mod">
		                       <input min="0" style="width:300px" type="text" name="studyHours" value="${(workshop.studyHours)!}" placeholder="" class="mis-ipt">
		                    </div>
		                </div>
		            </div>
		        </li>
	      		<li class="item w1">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>达标积分：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-scoreIpt mis-ipt-mod">
		                        <input type="text" min="1" required name="qualifiedPoint" value="${(workshop.qualifiedPoint)!}" placeholder="" class="mis-ipt">
		                        <span>分</span>
		                        <a href="javascript:;" onclick="load_next_content('${ctx}/manage/workshop/point_rule', 'saveTrainConfigForm', '积分规则')" class="score-link">了解工作坊评分规则？</a>
		                    </div>
		                </div>
		            </div>
		        </li>
		        <li class="item item-twoIpu">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>研修时间：</span>
	                    </div>
	                    <div class="center">
	                        <div class="tc">
	                            <div class="mis-ipt-mod">
	                                <input name="startTime" required type="text" value="${(workshop.timePeriod.startTime?string("yyyy-MM-dd"))!}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="mis-ipt">
	                            </div>
	                        </div>
	                        <span class="to">至</span>
	                        <div class="tc">
	                            <div class="mis-ipt-mod">
	                                <input name="endTime" required type="text" value="${(workshop.timePeriod.endTime?string("yyyy-MM-dd"))!}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="mis-ipt" >
	                            </div>
	                        </div>                                            
	                    </div>
	                </div>
	            </li>
			</ul>
			<div class="mis-btn-row indent1">
	            <button onclick="updateWorkshopTrainConfig()" type="button" class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
	        </div>
		</div>
		</@trainDirective>
	</@workshopDirective>
</form>

<script>
	function updateWorkshopTrainConfig() {
		if(!$('#saveTrainConfigForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('saveTrainConfigForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_tabs_update('listWorkshopForm','layout_center_tabs');
				easyui_modal_close('editTrainConfig');
			});
		}
	}
</script>