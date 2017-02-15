<div class="g-layer-box">
    <div class="m-lg">
        <form id="updatePersonalPasswordForm" method="put" action="${ctx}/manage/accounts/updatePersonalPassword">
		<ul class="mis-ipt-lst">
            <li class="item">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>旧密码：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-ipt-mod">
                            <input type="password" id="sourcePassword" name="sourcePassword" value="" class="mis-ipt">
                        </div>
                    </div>
                </div>
            </li>
            
            <li class="item">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>新密码：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-ipt-mod">
                            <input type="password" id="newPassword" name="newPassword" value="" class="mis-ipt">
                        </div>
                    </div>
                </div>
            </li>
            <li class="item">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>重复新密码：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-ipt-mod">
                            <input type="password" id="repeatPassword" name="repeatPassword" value="" class="mis-ipt">
                        </div>
                    </div>
                </div>
            </li>
 		</ul>
		<div class="mis-btn-row indent1">
			<button  type="button" onClick="updatePersonalPassword()" class="mis-btn mis-main-btn">保存</button>
		    <button type="button"  class="mis-btn mis-default-btn mylayer-cancel">取消</button>
	    </div>
		</form>        
    </div>
</div>
<script>
		
	function updatePersonalPassword(){
		if($("#sourcePassword").val()==''){
			mylayerFn.msg('请输入旧密码！',{icon: 0, time: 2000});
			return;
		}
		if($("#newPassword").val()==''||$("#newPassword").val().length<6){
			mylayerFn.msg('新密码不能为空且不能小于6位长度！',{icon: 0, time: 2000});
			return;
		}
		if($("#repeatPassword").val()!=$("#newPassword").val()){
			mylayerFn.msg('输入的新密码与重复密码不一致！',{icon: 0, time: 2000});
			return;
		}
		
		var data = $.ajaxSubmit("updatePersonalPasswordForm");
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
				mylayerFn.msg('操作成功！',{icon: 0, time: 2000},function(){
					//reloadWindow();
					mylayerFn.closelayer($('#updatePersonalPasswordForm'));
				});
		}else{
				mylayerFn.msg(json.responseMsg,{icon: 0, time: 3000});
		}
		
	}
</script>