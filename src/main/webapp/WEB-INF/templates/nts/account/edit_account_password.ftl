<form id="saveAccountPasswordForm" action="${ctx!}/manage/accounts/batch/resetPassword" method="put">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<input id="ctx" type="hidden" name="ctx" value="${ctx!}">
	<#if (account.id)??>
		<input id="id" type="hidden" name="id" value="${(account.id)!}">
	</#if>
	<div class="mis-srh-layout">
    	<ul class="mis-ipt-lst">
	    	<li class="item">
				<div class="mis-ipt-row">
	                <div class="tl">
	                    <span>用户名：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" id="userName" name="userName" value="${(account.userName)!}" placeholder="请输入用户名..." class="mis-ipt required" readonly="readonly">
	                    </div>
	                </div>
	            </div>
			</li>
			<li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>重置密码：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="password" id="password" name="password" placeholder="请输入重置密码..." class="mis-ipt required">
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>重置密码确认：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="password" name="repassword" placeholder="请输入重置密码..." class="mis-ipt required">
	                    </div>
	                </div>
	            </div>
	        </li>
		</ul>
	</div>
	<div class="mis-btn-row indent1">
        <button onclick="saveAccountPassword()" type="button" class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
    </div>
</form>
<script type="text/javascript">

	$(function(){
		$('#saveAccountPasswordForm').validate({
			rules : {
				repassword : {
					required: true,
			        minlength: 6,
			        equalTo: "#password"
				}
			},
			messages : {
				repassword : {
					required : '必填',
					equalTo: "两次密码输入不一致"
				}
			}
		});
	});
	
	function saveAccountPassword() {
		if(!$('#saveAccountPasswordForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('saveAccountPasswordForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_tabs_update('listAccountForm', 'layout_center_tabs');
				easyui_modal_close('editAccountDiv');
			});
		}
	}
</script>