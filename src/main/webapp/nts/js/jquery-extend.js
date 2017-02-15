/*$.fn.serializeObject = function() {
	var o = {};
	var a = this.serializeArray();
	$.each(a, function() {
		if (o[this.name] !== undefined) {
			if (!o[this.name].push) {
				o[this.name] = [ o[this.name] ];
			}
			o[this.name].push(this.value || '');
		} else {
			o[this.name] = this.value || '';
		}
	});
	return o;
};*/
jQuery.prototype.serializeObject=function(){  
    var a,o,h,i,e;  
    a=this.serializeArray();  
    o={};  
    h=o.hasOwnProperty;  
    for(i=0;i<a.length;i++){  
        e=a[i];  
        if(!h.call(o,e.name)){  
            o[e.name]=e.value;  
        }  
    }  
    return o;  
};

$(function(){
	jQuery.extend({
		messager: {}
	});
	
	jQuery.messager.alert=function(txt1, msg, txt2, callbackFn){
		alert(msg, callbackFn);
	};
	
	jQuery.messager.confirm=function(txt1, msg, confirmFn, cancleFn){
		confirm(msg, confirmFn, cancleFn);
	};
});

(function($){
	$.fn.extend({
		datagrid:function(option){
			//获取表头信息
			var ths = $(this).find('thead th');
			var properties = new Array();
			$.each(ths,function(i,n){
				var dataOptions = $(n).attr('data-options');
				if(dataOptions){
					dataOptions = '{'+ dataOptions +'}';
					var options = eval("("+dataOptions+")");
					if(options.field){
						properties.push(options.field);
					}else{
						properties.push(i);
					}
				}else{
					properties.push(i);
				}
			});
			if(option=='getSelections'){
				var rows = new Array();
				var selected = $(this).find('tbody').find('tr').find('input:checked');
				$.each(selected,function(i,n){
					var row = $(this).closest('tr');
					var tds = row.find('td');
					var rowObj = new Object();
					$.each(tds,function(i,n){
						var pro = properties[i];
						if($(n).find('input').size()>0){
							$(rowObj).prop(pro,$(n).find('input').eq(0).val());
						}else{
							$(rowObj).prop(pro,$(n).text());	
						}
					});
					rowObj.target=row;
					rows.push(rowObj);
				});
				return rows;
			}else if(!option){
				var tables = $(this);
				$.each(tables,function(i,n){
					var ths = $(n).find('thead th');
					var rows = $(n).find('tbody tr');
					$.each(ths,function(i,n){
						var dataOptions = $(n).attr('data-options');
						if(dataOptions){
							dataOptions = '{'+ dataOptions +'}';
							var options = eval("("+dataOptions+")");
							if(options.checkbox){
								var isCheckbox = options.checkbox;
								if(isCheckbox == true || isCheckbox == 'true'){
									$(n).empty();
									$(n).append('<label class="mis-checkbox"><strong><i class="ico"></i><input type="checkbox" name="" class="checkTableAll"  value=""></strong></label>');
									$.each(rows,function(q,n){
										var tds = $(n).find('td');
										var checkboxTd = tds.eq(i);
										if(checkboxTd){
											var checkValue = checkboxTd.text();
											checkboxTd.empty();
											//checkboxTd.append('<input type="checkbox" name="'+options.field+'" value="'+checkValue+'">');
											checkboxTd.append('<label class="mis-checkbox"><strong><i class="ico"></i><input type="checkbox" name="'+options.field+'" class="checkRow" value="'+checkValue+'"></strong></label>');
										}
									});
								}
							}
							//处理th的dataoption中的hidden
							if(options.hidden){
								var isHidden = options.hidden;
								if(isHidden == true || isHidden == 'true'){
									$(n).hide();
									$.each(rows,function(q,n){
										var tds = $(n).find('td');
										tds.eq(i).hide();
									});
								}
							}
						}
					});
				});
				//以下为checbox多选样式处理
				$(tables).closest('form').find('.mis-opt-row').append('<div class="selectedNum fr"><span>已选中<strong class="num">0</strong>条记录</span></div>');
			    //后台管理系统通用js
			    misFn.init();
			    misFn.checkboxAll($(".mis-table .checkTableAll"),$(".mis-table .checkRow"),function(){
			        $('.mis-checkbox input').bindCheckboxRadioSimulate();
			        misFn.checkboxCorrelationBtn($('.mis-table'),true);
			    });
			    //多选按钮模拟
			    $('.mis-checkbox input').bindCheckboxRadioSimulate();
			    //点选按钮模拟
			    $('.mis-radio-tick input').bindCheckboxRadioSimulate();
			}
		},
	});
 
	
	$.extend({
		messager:{
			alert:function(msg){
				window.alert(msg);
			}
		}
	});
})(jQuery);