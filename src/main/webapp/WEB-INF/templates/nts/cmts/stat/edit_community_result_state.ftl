<form id="updateCommunityResultStateForm" action="/manage/community/result" method="put">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	
	<input type="hidden" name="id" value="${communityResult.id }">
	<input type="hidden" name="state" value="excellent">
	
	<div class="mis-content">
	    <ol class="mis-topic-lst">
	        <li>
	            <div class="mis-topic-in">
	                <h3 class="title">以下学员将评为“社区优秀学员”，评选后将不能撤回，请核实以下学员名单：</h3>
	                <ol class="mis-question-lst">
	                    <li>
	                        <label class="mis-radio-tick">
	                            <span>${communityResult.user.realName }</span>
	                        </label>
	                    </li>
	                </ol>
	        	</div>
	        </li>
		</ol>
		<div class="mis-btn-row mis-subBtn-row">
            <button onclick="updateCommunityResultState()" type="button" class="mis-btn mis-main-btn">提交</button>
        </div>
	</div>
</form>
<script type="text/javascript">
	function updateCommunityResultState() {
		if(!$('#updateCommunityResultStateForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('updateCommunityResultStateForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_tabs_update('listCmtsStatForm', 'layout_center_tabs');
				easyui_modal_close('editCommunityResultStateDiv');
			});
		}
	}
</script>