<form id="createMessageForm" action="/manage/message/createBatch" method="post">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	
	<input type="hidden" name="type" value="system_message">
	<@followsDirective relationId=discussion.id >
		<#list follows as follow>
			<input type="hidden" name="receiver.id" value="${(follow.creator.id)!'' }">
		</#list>
	</@followsDirective> 
	<div class="mis-srh-layout">
	    <ul class="mis-ipt-lst">
			<li class="item w1">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>通知内容：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <textarea rows="10" style="font-size: 14px;" class="mis-textarea" name="content" required>您所关注的创课《${discussion.title }》已经筹备成功，现邀请您参与创课观摩活动请点击以下链接参加【请将活动链接地址复制到此处】或通过研修社区>活动栏目中找到相关活动信息。再次感谢您对创课的支持！
	                        </textarea>
	                    </div>
	                </div>
	            </div>
	        </li>
	     </ul>
		 <div class="mis-btn-row indent1">
	     	<button onclick="createMessage()" type="button" class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
		</div>
	</div>
</form>
<script type="text/javascript">
	function createMessage() {
		if(!$('#createMessageForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('createMessageForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.put('/manage/cmts/lesson/${discussion.id}', 'state=start_lesson', function(data){
				if (data.responseCode == '00') {
					$.messager.alert("提示信息", "操作成功！", 'info', function() {
						easyui_tabs_update('listCmtsLessonForm','layout_center_tabs')
						easyui_modal_close('createMessageDiv');
					});
				}
			});
		}else{
			if(json.responseMsg == 'receive is null'){
				alert('暂时没有人关注这个创课');
			}
		}
	}
</script>