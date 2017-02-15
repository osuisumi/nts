(function($){
	
	$.userSelect = function(element,config){
		this.element = element;
		this.config = config;
		this.param = '';
		this.init();
		
		if(this.config.afterInit){
			this.config.afterInit(this.userSelectDiv);
		};
		
		var _this = this;
		
		this.input.on('keyup',function(event){
			if (!$(this).val() == "") {
				var data1 = _this.param + '&'+_this.config.paramName+'=' + $(this).val();
				$.ajax({
					url: _this.config.url,
					data:  data1,
					type: 'post',
					success: function(data){
						_this.hintList.empty();
						$.each(data,function(i,n){
							var userItem = $('<a href="###" title="'+n.realName+'">'+n.realName+'<input type="hidden" class="realNameClass"  value="'+ n.id +'"/>'+'</a>');
							userItem.on('click',function(){
								if(_this.config.userList.find('#userLabel'+n.id).size()>0){
									alert('该用户已添加');
									return;
								}
								
								/*外部校验*/
								var flg = true;
								if(_this.config.onBeforeSelect){
									flg = _this.config.onBeforeSelect(n.id);
								}
								if(!flg){
									return;
								}	
								
								var userLabel = $('<li class="labelLi">' 
														+ '<span class="txt">' + n.realName +'<input class="userIdClass" type="hidden" value="'+n.id +'"/>' +'</span>' 
														+ '<a id="userLabel'+n.id+'" uid="'+n.id+'" href="javascript:void(0);" class="dlt" title="删除该用户">×</a>' 
													+ '</li>');
								userLabel.find('.dlt').on('click',function(){
									this.closest('li').remove();
								});
								if(_this.config.single){
									if(_this.config.single == true){
										_this.config.userList.empty();
									}
								}
								_this.config.userList.append(userLabel);
								//添加完成后清空
								_this.hintList.hide();
								_this.input.val('');
								_this.hintList.empty();
								
							});
							_this.hintList.append(userItem);
						});
						_this.hintList.show();
					}
				});
			} else {
				_this.hintList.hide();
			}
		});
		
	};
	
	var $sU = $.userSelect;
	
	$sU.fn = $sU.prototype = {
		version:'0.0.1'
	};
	
	$sU.fn.extend = $sU.extend = $.extend;
	
	$sU.fn.extend({
		init:function(){
			var _this = this;
			var elementHeight = $(this.element).height();
			var elementWidth = $(this.element).width();
			this.element.hide();
			
			this.userSelectDiv = $('<div tabindex="0" class="userSelect"></div>');
			this.input = $('<input type="text" placeholder="请输入关键字" id="" value="" class="u-ipt"> <a class="u-nbtn u-add-tag">+添加</a>');
			this.hintList = $('<div class="l-slt-lst"></div>');
			this.input.css('width',elementWidth).css('height',elementHeight);
			
			this.input.next().css('position','absolute').css('background-color','#d3d3d3').css('color','#fff').css('height',elementHeight+14).css('width','45px').css('margin-left','-55px');
			
			this.hintList.css('position','relative').css('top',0);
			
			$(document).on("click", function(e) {
				var target = $(e.target);
				// 判断是否点击的是用户提示框和输入框，如果不是，隐藏用户提示框
				if (target.closest(_this.hintList).length == 0 && target.closest(_this.input).length == 0) {
					_this.hintList.hide();
				}
			});
			
			this.input.on('click',function(){
				if(_this.hintList.find('a').size()>0){
					_this.hintList.show();
				}
			});
			
			
			this.userSelectDiv.append(this.input);
			this.userSelectDiv.append(this.hintList);
			this.hintList.hide();
			this.element.after(this.userSelectDiv);
			
			this.userSelectDiv.find('.u-add-tag').on('click',function(event){
				event.stopPropagation();
				var text = _this.input.val().trim();
				if( text== ''){
					return;
				}
				
				if(_this.hintList.find('a').size()<=0){
					alert('用户不存在');
					return;
				}
				
				var userItem = _this.hintList.find('a[title="'+text+'"]');
				
				if(userItem.size()<=0){
					alert('用户不存在');
					return;
				}
				
				userItem.eq(0).click();
			});
			
			_this.config.userList.find('li .dlt').on('click',function(){
				this.closest('li').remove();
			});
			
		},
		
	});
	
	
	
	$.fn.userSelect = function(config){
		var sU = new $sU($(this),config);
	};
})(jQuery);
