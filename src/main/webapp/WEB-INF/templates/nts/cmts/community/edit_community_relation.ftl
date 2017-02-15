<form id="saveCommunityRelationForm" action="${ctx}/manage/community/relation" method="post">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<@trainDirective id=communityRelation.relation.id>
		<#assign train=trainModel>
	</@trainDirective>
	<@communityRelationDirective relationId=communityRelation.relation.id>
		<input type="hidden" name="relation.id" value="${communityRelation.relation.id }">
		<#if (communityRelationModel)??>
			<#assign communityRelation=communityRelationModel>
			<script>
				$('#saveCommunityRelationForm').attr('method','put').attr('action', '${ctx }/manage/community/relation/${(communityRelation.id)!}');
			</script>
		</#if>
		
		<div class="mis-srh-layout">
    		<ul class="mis-ipt-lst">
    			<li class="item item-twoIpu">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>培训：</span>
	                    </div>
	                    <div class="center">
	                        <div class="tc">
	                            <div class="mis-ipt-mod">
	                                ${train.name }
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </li>
	            <li class="item item-twoIpu">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>培训时间：</span>
	                    </div>
	                    <div class="center">
	                        <div class="tc">
	                            <div class="mis-ipt-mod">
	                                ${(train.trainingTime.startTime?string("yyyy/MM/dd"))! }
	                                -
	                                ${(train.trainingTime.endTime?string("yyyy/MM/dd"))! }
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </li>
    			<li class="item item-twoIpu">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>社区培训时间：</span>
	                    </div>
	                    <div class="center">
	                        <div class="tc">
	                            <div class="mis-ipt-mod">
	                                <input name="startTime" value="${(communityRelation.timePeriod.startTime?string("yyyy-MM-dd"))! }" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="mis-ipt required">
	                            </div>
	                        </div>
	                        <span class="to">至</span>
	                        <div class="tc">
	                            <div class="mis-ipt-mod">
	                                <input name="endTime" value="${(communityRelation.timePeriod.endTime?string("yyyy-MM-dd"))!}" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="mis-ipt required">
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </li>
	            <li class="item w1">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>合格积分：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-scoreIpt mis-ipt-mod">
		                        <input type="text" min="1" required name="score" value="${(communityRelation.score)!}" placeholder="请输入合格积分.." class="mis-ipt">
		                        <span>分</span>
		                        <a href="javascript:;" onclick="load_next_content('${ctx}/manage/nts/cmts/community/point', 'saveCommunityRelationForm', '积分规则')" class="score-link">了解研修社区评分规则？</a>
		                    </div>
		                </div>
		            </div>
		        </li>
		        <#if train.studyHoursType = 'no_limit'>
		        	<li class="item w1">
			            <div class="mis-ipt-row">
			                <div class="tl">
			                    <span>学时：</span>
			                </div>
			                <div class="tc">
			                    <div class="mis-scoreIpt mis-ipt-mod">
			                        <input type="text" min="1" required name="studyHours" value="${(communityRelation.studyHours)!}" placeholder="请输入学时.." class="mis-ipt">
			                    </div>
			                </div>
			            </div>
			        </li>
		        </#if>
			</ul>
			<div class="mis-btn-row indent1">
	            <button onclick="saveCommunityRelation()" type="button" class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
	        </div>
		</div>
	</@communityRelationDirective>
</form>
<script type="text/javascript">
	function saveCommunityRelation() {
		if(!$('#saveCommunityRelationForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('saveCommunityRelationForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			alert("操作成功！", function() {
				easyui_tabs_update('listTrainForm','layout_center_tabs')
				easyui_modal_close('editCommunityRelationDiv');
			});
		}
	}
</script>