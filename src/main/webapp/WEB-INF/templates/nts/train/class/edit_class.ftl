<form id="editTrainClassForm" action="${ctx}/train/class"  method ="post">
	<#if id??>
		<input type="hidden" name="id" value="${id}">
		<script>
			$(function(){
				$('#editTrainClassForm').attr('method','put');
			});
		</script>
	<#else>
		<input type="hidden" name="relation.id" value="${(relationId[0])!}">
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
	                        <input type="text" name="name" value="${(clazz.name)!}" placeholder="请输入名称..." class="mis-ipt required">
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

<script>
	function saveClass(){
		if(!$('#editTrainClassForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('editTrainClassForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				closeNowPageAndrefreshParent('editTrainClassForm');
			});
		}
	}
	
</script>