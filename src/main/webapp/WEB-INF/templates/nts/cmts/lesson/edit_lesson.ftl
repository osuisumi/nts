<form id="saveCmtsLessonForm" action="${ctx}/manage/cmts/lesson" method="post">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	
	<@discussionDirective id=discussion.id!>
		<#if (discussionModel)??>
			<#assign discussion=discussionModel>
			<#assign discussionId=discussion.id >
			<script>
				$('#saveCmtsLessonForm').attr('method','put').attr('action', '${ctx }/manage/cmts/lesson/${(discussion.id)!}');
			</script>
		<#else>
			<input type="hidden" name="state" value="in_progress">
			<input type="hidden" name="discussionRelations[0].relation.id" value="${discussion.discussionRelations[0].relation.id }">
			<input type="hidden" name="discussionRelations[0].relation.type" value="${discussion.discussionRelations[0].relation.type }">
			<#assign discussionId=Identities.uuid2()>
		</#if>
		<input type="hidden" name="id" value="${discussionId }">	
		
		<div class="mis-srh-layout">
	    	<ul class="mis-ipt-lst">
				<li class="item">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>标题：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-ipt-mod">
		                        <input type="text" name="title" value="${(discussion.title)!}" placeholder="标题..." class="mis-ipt required">
		                    </div>
		                </div>
		            </div>
		        </li>
		        <li class="item w1">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>内容：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-ipt-mod">
		                        <script id="editor" type="text/plain" style="width:100%; height:370px;"></script>
								<input name="content" type="hidden">
		                    </div>
		                </div>
		            </div>
		        </li>
		        <@lessonAttributeDirective id=discussion.id>
	            	<li class="item w1">
		                <div class="mis-ipt-row">
		                    <div class="tl">
		                        <span>学段：</span>
		                    </div>
		                    <div class="tc">
		                        <div class="mis-select">
		                            <select id="stageSelect" name="stage" style="width: 200px;">
		                                ${TextBookUtils.getEntryOptionsSelected('STAGE', (lessonAttributeModel.stage)!'') }
		                            </select>   
		                        </div>
		                    </div>
		                </div>
		            </li>
		            <li class="item w1">
		                <div class="mis-ipt-row">
		                    <div class="tl">
		                        <span>学科：</span>
		                    </div>
		                    <div class="tc">
		                        <div class="mis-select">
		                            <select id="subjectSelect" name="subject" style="width: 200px;">
		                                ${TextBookUtils.getEntryOptionsSelected('SUBJECT', (lessonAttributeModel.subject)!'') }
		                            </select>   
		                        </div>
		                    </div>
		                </div>
		            </li>
	            </@lessonAttributeDirective>
			</ul>
			<div class="mis-btn-row indent1">
		        <button onclick="saveCmtsLesson()" type="button" class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
		    </div>
		</div>
	</@discussionDirective>
</form>
<#if '' != (discussion.content)!''>
	<#list discussion.content?split(discussion.id) as content>
		<#if content_index = 1>
			<#assign content=content>
		</#if>
	</#list>
</#if>
<script type="text/javascript">
	var ue = initProduceEditor('editor', '${content!}', '${(Session.loginer.id)!}');
	
	function saveCmtsLesson() {
		if(!$('#saveCmtsLessonForm').validate().form()){
			return false;
		}
		var content = ue.getContent();
		var text = ue.getContentTxt();
		if(content.length == 0){
			alert("内容不能为空");
			return false;
		}
		$('#saveCmtsLessonForm input[name="content"]').val(text + '${discussionId}' + content);
		var data = $.ajaxSubmit('saveCmtsLessonForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_tabs_update('listCmtsLessonForm','layout_center_tabs')
				easyui_modal_close('editCmtsLessonDiv');
			});
		}
	}
</script>