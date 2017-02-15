<form id="saveTrainRegisterForm" action="${ctx}/manage/trainRegister/updateTrainRegister" method="post">
	<input id="userIds" type="hidden" name="userIds">
	<input type="hidden" name="trainId" value="${(trainRegisterExtend.train.id)!}">
	<input type="hidden" name="state" value="pass">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<div class="mis-column-intl">
		<div class="mis-opt-mod fr">
			<button onclick="saveTrainRegister()" type="button" class="mis-btn mis-main-btn">
				<i class="mis-pass-ico"></i>保存
			</button>
		</div>
	</div>
	<div class="mis-column-innerBox">
		<div class="mis-stPower-innerL fl">
			<@usersTag roleCode = '2'>
				<dl id="allUserList">
					<dt>
						全部成员<span>（ <ins class="red" id="allNum"></ins>）</span>
					</dt>
					<#list users as user>
						<dd userId="${user.id }">
							<i class="mis-StMake-ico"></i>
							<em>${user.realName }</em>
							<a href="javascript:;" class="mis-btn mis-inverse-btn mis-btn-add" >
								<i class="mis-add-ico"></i>添加
							</a>
						</dd>
					</#list>
				</dl>
			</@usersTag>
		</div>
		<div class="mis-stPower-arrow fl">
			<span class="arrow"></span>
		</div>
		<div class="mis-stPower-innerR fr">
			<dl id="registerList">
				<dt>
					已选课成员<span>（ <ins class="red" id="hasNum"></ins>）</span>
				</dt>
				<@trainRegisterExtendsDirective trainRegisterExtend=trainRegisterExtend>
					<#list trainRegisterExtends as tre>
						<dd class="btnL0" userId="${(tre.userInfo.id)!}">
							<i class="mis-StMake-ico"></i>
							<em>${(tre.userInfo.realName)!}</em>
							<a href="javascript:;" class="mis-btn mis-inverse-btn mis-btn-move" >
								<i class="mis-delete-ico"></i>删除
							</a>
						</dd>
					</#list>
				</@trainRegisterExtendsDirective>
			</dl>
		</div>

	</div>
</form>
<dd id="allUserTemplate" style="display: none;">
	<i class="mis-StMake-ico"></i>
	<em></em>	
	<a href="javascript:;" class="mis-btn mis-inverse-btn mis-btn-add" >
		<i class="mis-add-ico"></i>添加
	</a>
</dd>
<dd id="registerTemplate"  style="display: none;">
	<i class="mis-StMake-ico"></i>
	<em></em>
	<a href="javascript:;" class="mis-btn mis-inverse-btn mis-btn-move" >
		<i class="mis-delete-ico"></i>删除
	</a>
</dd>
<script type="text/javascript">
	$(function(){
		$('#allUserList dd').each(function(){
			var $this = $(this);
			var userId = $this.attr('userId');
			$('#registerList dd').each(function(){
				var userId1 = $(this).attr('userId');
				if(userId == userId1){
					$this.remove();
					return;
				}
			});
		});
		
		$('#saveTrainRegisterForm #allNum').text($('#allUserList dd').size());
		$('#saveTrainRegisterForm #hasNum').text($('#registerList dd').size());
		
		$('#saveTrainRegisterForm').on('click', '#allUserList a', function(){
			var $remove_dd = $(this).parents('dd');
			var userId = $remove_dd.attr('userId');
			var title = $remove_dd.find('em').text();
			$remove_dd.remove();
			var $add_dd = $('#registerTemplate').clone();
			$add_dd.find('em').text(title);
			$('#registerList').append($add_dd.css('display', 'block').removeAttr('id').attr('userId', userId));
		});
		
		$('#saveTrainRegisterForm').on('click', '#registerList a', function(){
			var $remove_dd = $(this).parents('dd');
			var userId = $remove_dd.attr('userId');
			var title = $remove_dd.find('em').text();
			$remove_dd.remove();
			var $add_dd = $('#allUserTemplate').clone();
			$add_dd.find('em').text(title);
			$('#allUserList').append($add_dd.css('display', 'block').removeAttr('id').attr('userId', userId));
		});
	});
	
	function saveTrainRegister(){
		var prepareUpdateCourseIds = '';
		$('#registerList dd').each(function(i){
			var userId = $(this).attr('userId');
			if(prepareUpdateCourseIds == ''){
				prepareUpdateCourseIds = userId;
			}else{
				prepareUpdateCourseIds  = prepareUpdateCourseIds + ',' + userId;
			}
		});
		$('#userIds').val(prepareUpdateCourseIds);
		var data = $.ajaxSubmit('saveTrainRegisterForm');
		var json = $.parseJSON(data);
		if(json.responseCode == '00'){
			alert('提交成功');
			easyui_modal_close('editTrainRegisterDiv');
			easyui_window_update('listTrainRegisterForm','listTrainRegisterDiv');
		}
	}
	
</script>