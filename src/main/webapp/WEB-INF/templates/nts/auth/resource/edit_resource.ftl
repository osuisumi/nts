<form id="saveResourceForm" action="${ctx!}/auth_resources" method="post">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0]/>
	<#if (resource.id)??>
		<input type="hidden" name="id" value="${(resource.id)!}"/>
		<script type="text/javascript">
		$('#saveResourceForm').attr('action','${ctx!}/auth_resources').attr('method','put');
		</script>
	</#if>
	<input type="hidden" value="test" name="relationId">
	<div class="mis-srh-layout">
    	<ul class="mis-ipt-lst">
	    	<li class="item">
				<div class="mis-ipt-row">
	                <div class="tl">
	                    <span>名称：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="name" value="${(resource.name)!}" placeholder="请输入名称..." class="mis-ipt required">
	                    </div>
	                </div>
	            </div>
			</li>
			<li class="item">
				<div class="mis-ipt-row">
	                <div class="tl">
	                    <span>code：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="code" value="${(resource.code)!}" placeholder="请输入code..." class="mis-ipt required">
	                    </div>
	                </div>
	            </div>
			</li>
			<li class="item">
				<div class="mis-ipt-row">
	                <div class="tl">
	                    <span>父分组：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-select">
	                        <select name="parent.id" id="parentId">
	                            <option value="">请选择...</option>
	                        </select>    
	                    </div>
	                </div>
	            </div>
			</li>
		</ul>
	</div>
	<div class="mis-btn-row indent1">
        <button onclick="saveResource();" type="button" class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
    </div>
</form>

<script type="text/javascript">
	$(function () {
		$.ajaxSetup({
			cache : false
		});
		
		var parentId = '${(resource.id)!}';
		
		$.get("${ctx!}/auth_resources/api?limit=9999",null,function(responseData){
			for(var i = 0 ; i < responseData.length ; i++){
				if(parentId != responseData[i].id){				
					if(parentId == responseData[i].id){
						var optionStr = '<option value="'
										+ responseData[i].id
										+ '" selected >'
										+ responseData[i].name
										+ '</option>';
					}else{				
						var optionStr = '<option value="'
										+ responseData[i].id
										+ '">'
										+ responseData[i].name
										+ '</option>';
					}
					$('#saveResourceForm #parentId').append(optionStr);			
				}
			}
		});
	});

	function saveResource() {
		if(!$('#saveResourceForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('saveResourceForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_tabs_update('listResourceForm','layout_center_tabs');
				easyui_modal_close('editResourceDiv');
			});
		}
	}
</script>