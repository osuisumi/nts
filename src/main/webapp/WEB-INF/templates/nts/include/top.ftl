<div class="mis-hd">
	<div class="mis-hd-inner">
		<h1 class="mis-logo">
			<a href="###"> <img src="${app_path }/images/logo.png">
			</a>
		</h1>
		<ul class="mis-hd-opt">
			<li class="item1"><a href="javascript:;" title="浏览痕迹"></a></li>
			<li class="item2"><a href="javascript:;" title="系统消息"></a></li>
		</ul>
		<div class="mis-tuser">
			<a href="javascript:;" class="tuser-show"> 
				<#import "/common/image.ftl" as image/>
				<@image.imageFtl url="${Session.loginer.avatar! }" default="/nts/images/defaultAvatarImg.png" class="img" />
				<!-- <strong class="txt"><span class="name">Nick</span></strong>  -->
				<span class="status"><i class="mis-super-ico"></i>${Session.loginer.realName }</span> 
				<i class="trg"></i> 
			</a>
			<div class="tuser-lst">
				<i class="trg"></i>
				<ul class="lst">
					<!-- <li class="item"><a href="javascript:;" class="cmt"><span class="txt">我的评论</span><strong class="num">56</strong></a></li>
					<li class="item"><a href="javascript:;" class="user"><span class="txt">个人资料</span></a></li>
					<li class="item"><a href="javascript:;" class="record"><span class="txt">系统记录</span></a></li>
					<li class="item"><a href="javascript:;" class="setting"><span class="txt">账号设置</span></a></li> -->
					<li class="item"><a href="javascript:openUpdatePersonalPassword();" class="setting"><span class="txt">修改密码</span></a></li>
					<li class="item last"><a href="/logout" class="exit"><span class="txt">退出</span></a></li>
				</ul>
			</div> 
		</div>
	</div>
</div>
<script>
function openUpdatePersonalPassword(){
	mylayerFn.open({
		id: "updateUserPasswordLayer",
		type: 2,
		title: '修改密码',
		content: '${ctx}/manage/accounts/editPersonalPassword',
		area: [500,400],
		zIndex: 19999,
		yes: {
				close: true,
				btnName: '.mylayer-confirm',
				yesFn : function(){
					                
				}
		}

	});
}
</script>