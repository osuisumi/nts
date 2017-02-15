<form id="auditWorkshopForm" action="${ctx}/manage/workshop/saveAudit" method="post">
	<#if (workshops.workshops)??>
		<#list workshops.workshops as workshop>
			<input type="hidden" name="workshops[${workshop_index}].id" value="${(workshop.id)!}">
			<input type="hidden" name="workshops[${workshop_index}].title" value="${(workshop.title)!}">
			<#if (workshop.masters)??>
				<#list workshop.masters as master>
					<input type="hidden" name="workshops[${workshop_index}].masters[${master_index}].id" value="${(master.id)!}">
				</#list>
			</#if>
		</#list>
	</#if>
<div class="g-layer-box">
	<ul class="mis-ipt-lst">
		<li class="item">
		    <div class="mis-ipt-row">
		        <div class="tl">
		            <span>结果：</span>
		        </div>
		        <div class="tc">
		            <div class="mis-check-mod">
		                <label class="mis-radio-tick">
		                    <strong class="on">
		                        <i class="ico"></i>
		                        <input type="radio" name="state" checked="checked" value="published">
		                    </strong>
		                    <span>通过</span>
		                </label>
		                <label class="mis-radio-tick">
		                    <strong>
		                        <i class="ico"></i>
		                        <input type="radio" name="state" value="reject">
		                    </strong>
		                    <span>不通过</span>
		                </label>
		            </div>
		        </div>
		    </div>
		</li>
		<li class="item">
		    <div class="mis-ipt-row">
		        <div class="tl">
		            <span>意见：</span>
		        </div>
		        <div class="tc">
		            <div class="mis-ipt-mod">
		                <textarea name="msg" class="mis-textarea" placeholder="" required="" aria-required="true"></textarea>
		            </div>
		        </div>
		    </div>
		</li>
	</ul>
	<div class="mis-btn-row mis-subBtn-row">
        <button type="button" onclick="saveAudit()" class="mis-btn mis-main-btn">提交</button>
        <button type="button" onclick="mylayerFn.closelayer($('#auditWorkshopForm'))"  class="mis-btn mis-default-btn">取消</button>
    </div>
</div>
</form>
<script>
	$(function(){
		$('.mis-radio-tick input').bindCheckboxRadioSimulate();
	});
	
	function saveAudit(){
		var response = $.ajaxSubmit('auditWorkshopForm');
		response = $.parseJSON(response);
		if(response.responseCode == '00'){
			alert('操作成功',function(){
				mylayerFn.closelayer($('#auditWorkshopForm'));
				easyui_tabs_update('listWorkshopForm','content');
			});
		}
		
	}
	
</script>
