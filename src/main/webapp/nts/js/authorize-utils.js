//添加用户
function initAuthorizeUtils(selectUserUrl, data) {
	if(selectUserUrl == null || selectUserUrl == ''){
		selectUserUrl = $('#ctx').val() + '/user/listUserByRealName.do';
	}
	var $tag_parents = $(".m-add-tag-user");
    $tag_parents.each(function(){
        var _ts = $(this);
            $ipt_parents = _ts.find(".m-tagipt"),
            $ipt = $ipt_parents.find(".u-ipt"),
            $hint_lst = $ipt_parents.find(".l-slt-lst"),
            $add_btn = _ts.find(".u-add-tag"),
            $tag_lst = _ts.find(".m-tag-lst");
        //显示用户提示框  
        tag_hint_show($ipt,$hint_lst,selectUserUrl,data, $add_btn);
        add_tag($ipt,$add_btn,$tag_lst,$hint_lst);  
        delete_tag($tag_lst);  
    });
    
	initAuthorizeParam();
}

// 显示用户提示框
function tag_hint_show($ipt, $hint_lst, selectUserUrl, data, $add_btn) {
	// 输入框获取焦点
	$ipt.on("focus", function() {
		if (!$(this).val() == "") {
			$hint_lst.show();
		}
	});
	$ipt.on("keyup", function() {
		// 判断输入文字是，提示框显示
		if (!$(this).val() == "") {
			var data1 = data + '&paramMap[realName]=' + $(this).val();
			$.ajax({
				url: selectUserUrl,
				data:  data1,
			//	data:  'paramMap[realName]='+$(this).val()+'&paramMap[relationId]=9155SA04',
				type: 'post',
				success: function(data){
					if(data.responseCode == '00'){
						var nameArray = data.responseData.items;
						if($(nameArray).length > 0){
							$hint_lst.find('.lst').empty();
							$(nameArray).each(function(index){
								$hint_lst.find('.lst').append('<a href="###" title="'+this.realName+'">'+this.realName+'  ('+this.deptName+')<input type="hidden" class="realNameClass"  value="'+ this.id +'"/>'+'</a>');
							});
							$hint_lst.show();
						}
					}
				}
			});
		} else {
			$hint_lst.hide();
		}
	});
	this.tag_hint_hide($ipt, $hint_lst, $add_btn);
}

// 关闭用户提示框
function tag_hint_hide($ipt, $hint_lst, $add_btn) {
	// 获取
	$(document).on("click", function(e) {
		var target = $(e.target);
		// 判断是否点击的是用户提示框和输入框，如果不是，隐藏用户提示框
		if (target.closest($hint_lst).length == 0 && target.closest($ipt).length == 0) {
			$hint_lst.hide();
		}
	});
	// 选择提示框选项关闭提示框
	$hint_lst.on("click", "a", function() {
		$hint_lst.hide();
		$ipt.val($(this).attr('title'));
		var userId = $(this).find('.realNameClass').val();
		$ipt.attr('id',userId);
		$add_btn.trigger('click');
	});
}
// 添加用户
function add_tag($ipt, $add_btn, $tag_lst, $hint_lst) {
	$add_btn.on("click", function() {
		var ss = false;
		var lengths = $tag_lst.children().length;
		// 判断输入框是否为空
		if ($ipt.val() != "") {
			// 遍历用户列表
			$ipt.closest('form').find('.userIdParam').each(function(){
				if($ipt.attr('id') == $(this).val()){
					alert("已有相同的用户存在");
					ss = true;
				}
			});
	/*
			for (var i = 0; i < lengths; i++) {
				// 如果已有相同用户
				if ($ipt.attr('id') == $tag_lst.children().eq(i).find(".txt").find('.userIdClass').val()) {
					alert("已有相同的用户");
					ss = true;
				}
			}
			*/
			// 如果没有相同用户，添加新的用户
			if($hint_lst.find('.lst').find('a[title="'+$ipt.val()+'"]').length == 0){
				alert('该用户不存在');
				return false;
			}
			if (!ss) {
				$tag_lst.append('<li class="authorizeLi">' 
									+ '<span class="txt">' + $ipt.val() +'<input class="userIdClass" type="hidden" value="'+$ipt.attr('id') +'"/>' +'</span>' 
									+ '<a href="javascript:void(0);" class="dlt" title="删除该用户">×</a>' 
								+ '</li>');
				// 添加用户后，清除输入框中的文字
				$ipt.val("");
				//更新参数
				initAuthorizeParam()
			}
		}else{
			alert('请输入用户名');
		}
	});
}
// 删除用户
function delete_tag($tag_lst) {
	$(document).on("click", "#authorizeList .dlt", function() {
		$(this).parent().remove();
		initAuthorizeParam();
	});
}

function initAuthorizeParam(){
	var $tag_parents = $(".m-add-tag-user");
	var addUserType = $tag_parents.find('.userType').text();
	var $form = $('#authorizeList').closest('form');
	$form.find('.authorizeParam').remove();
	$('#authorizeList').find('.authorizeLi').each(function(i) {
		var userId = $(this).find('.txt').find('.userIdClass').val();
		$form.append('<input class="userIdParam authorizeParam" name="'+addUserType+'s[' + i + '].id" value="' + userId + '" type="hidden"/>');
	});
}