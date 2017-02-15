<#assign relationId='cmts'>
<#assign relationType='movement'>
<form id="saveCmtsMovementForm" action="${ctx!}/manage/nts/cmts/movement" method="post">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<@movementViewData id=(movement.id)! relationId=relationId! relationType=relationType!>
		<#if (movementModel)??>
			<#assign movement=movementModel>
			<script>
				$('#saveCmtsMovementForm').attr('method','put').attr('action', '${ctx!}/manage/nts/cmts/movement/${(movement.id)!}');
				$('#movementRelationsLi').remove();
				if('${movement.participationType!}' == 'ticket'){
					$('#ticketNumLi').show();
					$('#registerEndTimeLi').show();
					$('#ticketNum').attr("disabled",""); 
					$('#registerEndTime').attr("disabled",""); 
				}else{
					$('#ticketNumLi').hide();
					$('#registerEndTimeLi').hide();
					$('#ticketNum').attr("disabled",true); 
					$('#registerEndTime').attr("disabled",true); 
				}
			</script>
			<#else>
			<input type="hidden" name="status" value="verifying">
			<input type="hidden" name="movementRelations[0].relation.id" value="${movement.movementRelations[0].relation.id }">
			<input type="hidden" name="movementRelations[0].relation.type" value="${movement.movementRelations[0].relation.type }">
		</#if>
		<div class="mis-srh-layout">
	    	<ul class="mis-ipt-lst">
		    	<li class="item">
					<div class="mis-ipt-row">
		                <div class="tl">
		                    <span>活动类型：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-select">
		                        <select name="type" id="">
		                            <option value="communicationMeeting" <#if (movement.type)! = 'communicationMeeting'>selected="selected"</#if> >跨校交流会</option>
							        <option value="expertInteraction" <#if (movement.type)! = 'expertInteraction'>selected="selected"</#if>>专家互动</option>
							        <option value="lessonViewing" <#if (movement.type)! = 'lessonViewing'>selected="selected"</#if>>创课观摩</option>
		                        </select>    
		                    </div>
		                </div>
		            </div>
				</li>
				<li class="item">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>活动主题：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-ipt-mod">
		                        <input type="text" name="title" value="${(movement.title)!}" placeholder="请输入活动主题..." class="mis-ipt required">
		                    </div>
		                </div>
		            </div>
		        </li>
		        <li class="item">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>活动地点：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-ipt-mod">
		                        <input type="text" name="location" value="${(movement.location)!}" placeholder="活动地点..." class="mis-ipt required">
		                    </div>
		                </div>
		            </div>
		        </li>
		        <li class="item item-twoIpu">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>活动时间：</span>
	                    </div>
	                    <div class="center">
	                        <div class="tc">
	                            <div class="mis-ipt-mod">
	                                <input name="movementRelations[0].startTime" required type="text" value="${(movement.movementRelations[0].timePeriod.startTime?string("yyyy-MM-dd HH:mm:ss"))!}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="mis-ipt required">
	                            </div>
	                        </div>
	                        <span class="to">至</span>
	                        <div class="tc">
	                            <div class="mis-ipt-mod">
	                                <input name="movementRelations[0].endTime" required type="text" value="${(movement.movementRelations[0].timePeriod.endTime?string("yyyy-MM-dd HH:mm:ss"))!}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="mis-ipt required" >
	                            </div>
	                        </div>                                            
	                    </div>
	                </div>
	            </li>
	        	<li class="item">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>主办单位：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-ipt-mod">
		                        <input type="text" name="sponsor" value="${(movement.sponsor)!}" placeholder="主办单位..." class="mis-ipt required">
		                    </div>
		                </div>
		            </div>
		        </li>
		        <li class="item w1">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>活动详情：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-ipt-mod">
		                        <script id="editor" type="text/plain" style="width:100%; height:370px;"></script>
								<input name="content" type="hidden">
		                    </div>
		                </div>
		            </div>
		        </li>
		        <li class="item">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>参与方式：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-select">
		                        <select name="participationType" id="movementParticipationTypeSelect">
		                        	<option value="ticket" <#if (movement.participationType)! = 'ticket'>selected="selected"</#if>>须报名预约，凭电子票入场</option>
							        <option value="free" <#if (movement.participationType)! = 'free'>selected="selected"</#if>>在线报名，免费入场</option>
							        <option value="chair" <#if (movement.participationType)! = 'chair'>selected="selected"</#if>>讲座视频录像+在线问答交流</option>
		                        </select>    
		                    </div>
		                </div>
		            </div>
		        </li>
		        <script>
					$(function(){
						$('#movementParticipationTypeSelect').on('change',function(){
							if($(this).children('option:selected').val() == 'ticket'){
								$('#ticketNumLi').show();
								$('#registerEndTimeLi').show();
								$('#ticketNum').attr("disabled",""); 
								$('#registerEndTime').attr("disabled",""); 
							}else{
								$('#ticketNumLi').hide();
								$('#registerEndTimeLi').hide();
								$('#ticketNum').attr("disabled",true); 
								$('#registerEndTime').attr("disabled",true); 
							}
						});
					});
				</script>
		        <li class="item" id="ticketNumLi">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>人数限制：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-ipt-mod">
		                        <input type="text" name="movementRelations[0].ticketNum" value="${(movement.movementRelations[0].ticketNum)!}" placeholder="人数限制..." class="mis-ipt required">
		                    </div>
		                </div>
		            </div>
		        </li>
		        <li class="item" id="registerEndTimeLi">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>报名截止时间：</span>
		                </div>
		                <div class="center">
	                        <div class="tc">
	                            <div class="mis-ipt-mod">
	                                <input name="movementRelations[0].registerEndTime" type="text" value="${(movement.movementRelations[0].registerTimePeriod.endTime?string("yyyy-MM-dd HH:mm:ss"))! }" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="mis-ipt required">
	                            </div>
	                        </div>
	                    </div>
		            </div>
		        </li>
		        <li class="item" id="movementRelationsLi">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>邀请参与：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-ipt-mod">
		                        <input id="registerUserName" type="text" name="name" value="" placeholder="请输入名称..." class="mis-ipt ">
		                        <div id="userList" class="m-name-lst">
								</div>
		                    </div>
		                </div>
		            </div>
		        </li>
			</ul>
		</div>
		<div class="mis-btn-row indent1">
	        <button onclick="saveCmtsMovement()" type="button" class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
	    </div>
    </@movementViewData>
</form>
<script type="text/javascript">
	$(function(){
		//邀请
		var ul = $('#userList');
		$('#registerUserName').userSelect({
			url:'${ctx!}/users/entities',
			userList:ul,
			paramName:'paramMap[realName]',
			afterInit:function(selectDiv){
				selectDiv.find('.labelLi').css('height','26px');
				selectDiv.find('.u-add-tag').addClass('u-btn-add');
				selectDiv.append(ul);
			},
			onBeforeSelect:function(value){
				var isAllow = true;
				return isAllow;	
			}
		});
		
		$('.u-nbtn.u-add-tag').hide();
	});

	var ue = initProduceEditor('editor', '${(movement.content)!}', '${(Session.loginer.id)!}');
	
	function saveCmtsMovement() {
		if(!$('#saveCmtsMovementForm').validate().form()){
			return false;
		}
		var content = ue.getContent();
		if(content.length == 0){
			alert("提示信息","内容不能为空");
			return;
		}
		$('#saveCmtsMovementForm input[name="content"]').val(content);
		var data = $.ajaxSubmit('saveCmtsMovementForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_tabs_update('listCmtsMovementForm','layout_center_tabs');
				easyui_modal_close('editCmtsMovementDiv');
			});
		}
	}
</script>