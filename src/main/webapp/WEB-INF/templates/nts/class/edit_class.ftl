<#if (class.id)??>
	<form id="saveClassForm" action="${ctx }/manage/class/${(class.id)!}" method="put">
<#else>
	<form id="saveClassForm" action="${ctx}/manage/class" method="post">
		<input type="hidden" name="course.id" value="${(class.course.id)! }">
		<input type="hidden" name="relation.id" value="${(class.relation.id)! }">
</#if>
		<#import "/nts/include/tab.ftl" as tab/>
		<@tab.tabFtl items=items[0] />
		
		<div class="mis-srh-layout">
	    	<ul class="mis-ipt-lst">
				<li class="item">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>班级名称：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-ipt-mod">
		                        <input type="text" name="name" value="${(class.name)!}" placeholder="班级名称..." class="mis-ipt required">
		                    </div>
		                </div>
		            </div>
		        </li>
			</ul>
			<div class="mis-btn-row indent1">
	            <button onclick="saveClass()" type="button" class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
	        </div>
		</div>
	</form>
<script type="text/javascript">
	function saveClass() {
		if(!$('#saveClassForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('saveClassForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			alert("操作成功！", function() {
				easyui_tabs_update('listClassForm','layout_center_tabs')
				easyui_modal_close('editClassDiv');
			});
		}
	}
	
</script>