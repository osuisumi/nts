function easyui_form_query(formId, divId){
	$('#'+divId).panel('options').queryParams= $('#'+formId).serializeObject();
	tab.panel('refresh',$('#'+formId).attr('action'));
}

function easyui_tabs_update(formId, divId){
	var divId = $('#'+formId).parents('.contentDiv').attr('id');
	$.ajaxQuery(formId, divId);
}

function easyui_panel_update(formId,panelId){
	var panel = getCurrentTab().find('#'+panelId);
	panel.panel('options').queryParams= $('#'+formId).serializeObject();
	panel.panel('refresh',$('#'+formId).attr('action'));
	
}

function easyui_window_update(formId,windowId){
	easyui_tabs_update(formId,windowId);
}

function easyui_modal_open(id,title,width,height,href,model,onCloseFunction){
	/*if(width == 0){
		width = $(window).width() * 75 / 100;
	}
	if(height == 0){
		height = $(window).height() * 95 / 100;
	}
	var top=10;
	if($(window).height()>height){
		top=($(window).height() - height)*0.5;
	}
	$("<div id='"+id+"'/>").window({    
		title:title,
	    width: width,    
	    height: height,
	    href: href,    
	    modal: model,
	    collapsible: false,
	    minimizable: false,
	    draggable:true,
	    onClose:function(){
	    	$(this).window('destroy');
	    	if(onCloseFunction!=undefined){
				var $callback = onCloseFunction;
				if (! $.isFunction($callback)) $callback = eval('(' + onCloseFunction + ')');
				$callback();
			}
	    },
	});*/
	
	load_next_content(href, null, title);
}

function easyui_modal_open_list(id,title,width,height,href,model,onCloseFunction){
	load_next_content(href,null,title);
}

function easyui_modal_close(id){
	cancle();
}

function getCurrentTab(){
	return $('#layout_center_tabs').tabs('getSelected');
}

function easyui_tabs_add(tab, url, title,isCache){
	load_next_content(url,null,title);
}

function cancle(){
	$('.contentDiv').nextAll('.contentDiv').remove();
	$('#content').show();
	
}

function closeNowPageAndrefreshParent(objId){
	$('#'+objId).parents('.contentDiv').remove();
	var content = $('.contentDiv').last();
	if(content){
		content.show();
		var form = (content.find('form'));
		if(form.size()>0){
			easyui_tabs_update(form.eq(0).attr('id'));
		}
	}
}

function load_next_content(url, objId, itemName, data, type){
	var items = '';
	if(objId){
		items = $('#'+objId).parents('.contentDiv').find('input[name="items"]').val();
	}else{
		items = $('.contentDiv:last').find('input[name="items"]').val();
	}
	var item_array = $.parseJSON(items);
	item_array.push(itemName);
	if(data){
		data = data + "&items="+JSON.stringify(item_array);
	}else{
		data = "items="+JSON.stringify(item_array);
	}
	var length = $('.contentDiv').length;
	var div = '<div class="mis-mod contentDiv" id="content_'+length+'"></div>'
	if(!objId){
		$('.contentDiv:last').after($(div));
	}else{
		$('#'+objId).parents('.contentDiv').nextAll('.contentDiv').remove();
		$('#'+objId).parents('.contentDiv').after($(div));
	}
	ajaxLoading();
	if(type == 'post'){
		$.post(url, data, function(html){
			$('.contentDiv:last').html(html);
			ajaxEnd();
		});
	}else{
		$('.contentDiv:last').load(encodeURI(url), encodeURI(data),function(){
			ajaxEnd();
		});
	}
	$('.contentDiv').hide();
	$('.contentDiv:last').show();
}

function return_prev_content(obj){
	var items = $(obj).parents('.contentDiv').find('input[name="items"]').val();
	var item_array = $.parseJSON(items);
	var index = $(obj).parents('.contentDiv').find('#tag_div .tag_name').index($(obj));
	$(item_array).each(function(i,j){
		if(j > index){
			item_array.remove(j);
		}
	});
	var data = 'items='+JSON.stringify(item_array);
	$('.contentDiv').eq(index).nextAll('.contentDiv').remove();
	$('.contentDiv').eq(index).show();
}

