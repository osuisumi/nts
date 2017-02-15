<form id="saveCmtsDiscussionForm" action="${ctx}/manage/nts/cmts/discussion" method="post">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	
	<@discussionDirective id=discussion.id!>
		<#if (discussionModel)??>
			<#assign discussion=discussionModel>
			<#assign discussionId=discussion.id >
			<script>
				$('#saveCmtsDiscussionForm').attr('method','put').attr('action', '${ctx }/manage/nts/cmts/discussion/${(discussion.id)!}');
			</script>
		<#else>
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
			</ul>
			<div class="mis-btn-row indent1">
		        <button onclick="saveCmtsDiscussion()" type="button" class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
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
	
	function saveCmtsDiscussion() {
		if(!$('#saveCmtsDiscussionForm').validate().form()){
			return false;
		}
		var content = ue.getContent();
		var text = ue.getContentTxt();
		if(content.length == 0){
			alert("内容不能为空");
			return false;
		}
		$('#saveCmtsDiscussionForm input[name="content"]').val(text + '${discussionId}' + content);
		var data = $.ajaxSubmit('saveCmtsDiscussionForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			alert("操作成功！", function() {
				easyui_tabs_update('listCmtsDiscussionForm','layout_center_tabs')
				easyui_modal_close('editCmtsDiscussionDiv');
			});
		}
	}
</script>