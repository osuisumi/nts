<form id="updateStatusForm" action="/status/" method="put">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	
	<input type="hidden" name="relation.id" value="${status.id }">
	<input type="hidden" name="relation.type" value="${status.relation.type }"> 
	<input type="hidden" name="state" value="${status.state }">
	<div class="mis-srh-layout">
    	<ul class="mis-ipt-lst">
    		<li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>置顶天数：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="days" value="${(course.studyHours)!}" placeholder="请输入置顶天数..." class="mis-ipt {required:true, number:true, }">
	                    </div>
	                </div>
	            </div>
	        </li>
	    </ul>
	    <div class="mis-btn-row indent1">
            <button onclick="updateStatus()" type="button" class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
        </div>
	</div>
</form>
<script type="text/javascript">
	function updateStatus() {
		if(!$('#updateStatusForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('updateStatusForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			alert("操作成功！", function() {
				easyui_tabs_update('${formId[0]}', 'layout_center_tabs');
				easyui_modal_close('updateStatusDiv');
			});
		}
	}
</script>