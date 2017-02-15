/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 * panel关闭时回收内存，主要用于layout使用iframe嵌入网页时的内存泄漏问题
 */
$.fn.panel.defaults.onBeforeDestroy = function() {
	var frame = $('iframe', this);
	try {
		if (frame.length > 0) {
			for ( var i = 0; i < frame.length; i++) {
				frame[i].contentWindow.document.write('');
				frame[i].contentWindow.close();
			}
			frame.remove();
			if ($.browser.msie) {
				CollectGarbage();
			}
		}
	} catch (e) {
	}
};
/**
 * 修改了清空的逻辑，对分页和非参数的表单不清空
 */
$.fn.form.methods.clear=function(jq) {
	return jq.each(function(){
		easyui_override_form_clear(this);
	});
}

function easyui_override_form_clear(target) {
	$('input,select,textarea', target).each(function(){
		var t = this.type, tag = this.tagName.toLowerCase();
		var name = $(this).attr("name");
		var textboxname = $(this).attr("textboxname")
		if((name!=undefined&&name.indexOf('paramMap[')!=-1)||(textboxname!=undefined&&textboxname.indexOf('paramMap[')!=-1)) {//只有查询参数才重置
			if (t == 'text' || t == 'password' || tag == 'textarea'){
				this.value = '';
			} else if (t == 'file'){
				var file = $(this);
				if (!file.hasClass('textbox-value')){
					var newfile = file.clone().val('');
					newfile.insertAfter(file);
					if (file.data('validatebox')){
						file.validatebox('destroy');
						newfile.validatebox();
					} else {
						file.remove();
					}
				}
			} else if (t == 'checkbox' || t == 'radio'){
				this.checked = false;
			} else if (tag == 'select'){
				this.selectedIndex = -1;
			} else if (t == 'hidden') {//隐藏的不做任何操作
				
			}
		}
	});
	/*
	 * 分页的信息不清空
	 */
	var tabId = $(target).find(":hidden[name='tabId']").val();
	var page = $(target).find(":hidden[name='pagination.page']").val();
	var limit = $(target).find(":hidden[name='pagination.limit']").val();
	
	var form = $(target);
	var opts = $.data(target, 'form').options;
	for(var i=opts.fieldTypes.length-1; i>=0; i--){
		var type = opts.fieldTypes[i];
		var field = form.find('.'+type+'-f');
		if (field.length && field[type]){
			field[type]('clear');
		}
	}
	form.form('validate');
	$(target).find(":hidden[name='tabId']").val(tabId);
	$(target).find(":hidden[name='pagination.page']").val(page);
	$(target).find(":hidden[name='pagination.limit']").val(limit);
}
/**
 * 使panel和datagrid在加载时提示
 * 
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 */
$.fn.panel.defaults.loadingMessage = '加载中....';
$.fn.datagrid.defaults.loadMsg = '加载中....';

/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 * 通用错误提示
 * 
 * 用于datagrid/treegrid/tree/combogrid/combobox/form加载数据出错时的操作
 */
var easyuiErrorFunction = function(XMLHttpRequest) {
	//console.log(XMLHttpRequest);
	$.messager.progress('close');
	if($.trim(XMLHttpRequest.responseText)==''){
		$.messager.alert('错误', '数据加载失败！返回数据为空！<br/>'+XMLHttpRequest.responseText);
	}
	else{
		$.messager.alert('错误', '数据加载错误!返回数据格式不正确!<br/>'+XMLHttpRequest.responseText);
	}
};
$.fn.datagrid.defaults.onLoadError = easyuiErrorFunction;
$.fn.treegrid.defaults.onLoadError = easyuiErrorFunction;
$.fn.tree.defaults.onLoadError = easyuiErrorFunction;
$.fn.combogrid.defaults.onLoadError = easyuiErrorFunction;
$.fn.combobox.defaults.onLoadError = easyuiErrorFunction;
$.fn.form.defaults.onLoadError = easyuiErrorFunction;

/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 * 为datagrid、treegrid增加表头菜单，用于显示或隐藏列，注意：冻结列不在此菜单中
 */
var createGridHeaderContextMenu = function(e, field) {
	e.preventDefault();
	var grid = $(this);/* grid本身 */
	var headerContextMenu = this.headerContextMenu;/* grid上的列头菜单对象 */
	if (!headerContextMenu) {
		var tmenu = $('<div style="width:100px;"></div>').appendTo('body');
		var fields = grid.datagrid('getColumnFields');
		for ( var i = 0; i < fields.length; i++) {
			var fildOption = grid.datagrid('getColumnOption', fields[i]);
			if (!fildOption.hidden) {
				$('<div iconCls="icon-ok" field="' + fields[i] + '"/>').html(fildOption.title).appendTo(tmenu);
			} else {
				$('<div iconCls="icon-empty" field="' + fields[i] + '"/>').html(fildOption.title).appendTo(tmenu);
			}
		}
		headerContextMenu = this.headerContextMenu = tmenu.menu({
			onClick : function(item) {
				var field = $(item.target).attr('field');
				if (item.iconCls == 'icon-ok') {
					grid.datagrid('hideColumn', field);
					$(this).menu('setIcon', {
						target : item.target,
						iconCls : 'icon-empty'
					});
				} else {
					grid.datagrid('showColumn', field);
					$(this).menu('setIcon', {
						target : item.target,
						iconCls : 'icon-ok'
					});
				}
			}
		});
	}
	headerContextMenu.menu('show', {
		left : e.pageX,
		top : e.pageY
	});
};
$.fn.datagrid.defaults.onHeaderContextMenu = createGridHeaderContextMenu;
$.fn.treegrid.defaults.onHeaderContextMenu = createGridHeaderContextMenu;

/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 * 扩展validatebox，添加验证两次密码功能
 */
$.extend($.fn.validatebox.defaults.rules, {
	eqPwd : {
		validator : function(value, param) {
			return value == $(param[0]).val();
		},
		message : '密码不一致！'
	},
	idcard: {// 验证身份证
        validator: function (value) {
            return /^\d{15}(\d{2}[A-Za-z0-9])?$/i.test(value);
        },
        message: '身份证号码格式不正确'
    },
    mobilePhone: {// 验证手机号码
        validator: function (value) {
            return /^(13|15|18|14|17)\d{9}$/i.test(value);
        },
        message: '手机号码格式不正确'
     },
    telPhone: {// 验证电话号码
    	validator: function (value) {
    		return /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i.test(value);
    	},
    	message: '格式不正确,请使用下面格式:020-88888888'
    },
    endDate: {  //结束时间验证
        validator: function(endDate,startDate){    
            return endDate >= startDate;    
        },    
        message: '结束时间不能小于开始时间'   
    },
    idcared: {
        validator: function(value,param){
    		var flag= isCardID(value);console.log(flag);
            return flag==true?true:false;  
        },   
        message: '不是有效的身份证号码'  
    },
    
    /*扩展remote，可传多个参数,后台以参数ID接收
     例：
     validType="myRemote['/common/user/checkExistUser.do',formId(所属范围ID),
                  'userName'(验证文本ID),'paramId1'(后面都是是传递参数ID，多个以逗号隔开),'paramId2']"
    */
    myRemote : {
		validator : function(value, param) {
			var url=param[0];
			var data=param[2]+"="+value;
			if(param.length>3){
				data+="&";
				for(var i=3;i<param.length;i++){
					data+=($("#"+param[i],"#"+param[1])[0].id+"="+$("#"+param[i],"#"+param[1])[0].value);
					if(i!=param.length-1){
						data+="&";
					}
				}
			}
			var result=$.ajax({
                        url:url,
                        dataType:"json",
                        data:data,
                        async:false,
                        cache:false,
                        type:"post"
                    }).responseText;
            return eval(result)=="true";
		},
		message :"输入已经存在!"
	},
	minLength: {
	        validator: function(value, param){    
	            return value.length >= param[0];    
	        },    
	        message: '输入长度至少为 {0}位数.'   
	},
	username: {//验证用户名  
        validator: function (value) {  
            return /^[a-zA-Z][a-zA-Z0-9_]{5,50}$/i.test(value);  
        },  
        message: '用户名不合法（字母开头，允许6-50字节，允许字母、数字、下划线）'  
    },
    equalTo:{//验证两次输入是否相同
        validator: function (value, param) {  
            if ($("#" + param[0]).val() != "" && value != "") {  
                return $("#" + param[0]).val() == value;  
            } else {  
                return true;  
            }  
        },  
        message: '两次输入的密码不一致！'
    },
    eqOldPwd : {
		validator : function(value, param) {
			return value == $(param[0]).val();
		},
		message : '原密码输入不正确！'
	},
	password: {
		validator: function (value) {
    		return /[a-zA-Z0-9_]{6,15}$/i.test(value);
    	},
        message: '密码不符合要求，可输入字母、数字、下划线，长度在6-15之间'
	}
});

/**
 * @author 夏悸
 * 
 * @requires jQuery,EasyUI
 * 
 * 扩展tree，使其支持平滑数据格式
 */
$.fn.tree.defaults.loadFilter = function(data, parent) {
	var opt = $(this).data().tree.options;
	var idFiled, textFiled, parentField;
	if (opt.parentField) {
		idFiled = opt.idFiled || 'id';
		textFiled = opt.textFiled || 'text';
		parentField = opt.parentField;
		var i, l, treeData = [], tmpMap = [];
		for (i = 0, l = data.length; i < l; i++) {
			tmpMap[data[i][idFiled]] = data[i];
		}
		for (i = 0, l = data.length; i < l; i++) {
			if (tmpMap[data[i][parentField]] && data[i][idFiled] != data[i][parentField]) {
				if (!tmpMap[data[i][parentField]]['children'])
					tmpMap[data[i][parentField]]['children'] = [];
				data[i]['text'] = data[i][textFiled];
				tmpMap[data[i][parentField]]['children'].push(data[i]);
			} else {
				data[i]['text'] = data[i][textFiled];
				treeData.push(data[i]);
			}
		}
		return treeData;
	}
	return data;
};

/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 * 扩展treegrid，使其支持平滑数据格式
 */
$.fn.treegrid.defaults.loadFilter = function(data, parentId) {
	var opt = $(this).data().treegrid.options;
	var idFiled, textFiled, parentField;
	if (opt.parentField) {
		idFiled = opt.idFiled || 'id';
		textFiled = opt.textFiled || 'text';
		parentField = opt.parentField;
		var i, l, treeData = [], tmpMap = [];
		for (i = 0, l = data.length; i < l; i++) {
			tmpMap[data[i][idFiled]] = data[i];
		}
		for (i = 0, l = data.length; i < l; i++) {
			if (tmpMap[data[i][parentField]] && data[i][idFiled] != data[i][parentField]) {
				if (!tmpMap[data[i][parentField]]['children'])
					tmpMap[data[i][parentField]]['children'] = [];
				data[i]['text'] = data[i][textFiled];
				tmpMap[data[i][parentField]]['children'].push(data[i]);
			} else {
				data[i]['text'] = data[i][textFiled];
				treeData.push(data[i]);
			}
		}
		return treeData;
	}
	return data;
};

/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 * 扩展combotree，使其支持平滑数据格式
 */
$.fn.combotree.defaults.loadFilter = $.fn.tree.defaults.loadFilter;

/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 * 防止panel/window/dialog组件超出浏览器边界
 * @param left
 * @param top
 */
var easyuiPanelOnMove = function(left, top) {
	var l = left;
	var t = top;
	if (l < 1) {
		l = 1;
	}
	if (t < 1) {
		t = 1;
	}
	var width = parseInt($(this).parent().css('width')) + 14;
	var height = parseInt($(this).parent().css('height')) + 14;
	var right = l + width;
	var buttom = t + height;
	var browserWidth = $(window).width();
	var browserHeight = $(window).height();
	if (right > browserWidth) {
		l = browserWidth - width;
	}
	if (buttom > browserHeight) {
		t = browserHeight - height;
	}
	$(this).parent().css({/* 修正面板位置 */
		left : l,
		top : t
	});
};
//$.fn.dialog.defaults.onMove = easyuiPanelOnMove;
//$.fn.window.defaults.onMove = easyuiPanelOnMove;
//$.fn.panel.defaults.onMove = easyuiPanelOnMove;

/**
 * @author chao
 * 
 * @requires jQuery,EasyUI
 * 
 * 防止window/dialog组件的高度大于浏览器窗口高度时，title无法显示
 */
var easyuiWindowTop = function() {
	var width = parseInt($(this).parent().css('width'));
	var height = parseInt($(this).parent().css('height'));
	var browserWidth = $(window).width();
	var browserHeight = $(window).height();
	//top增加滚动条的高度，防止页面有滚动时，弹出框看不见-wuwentao
	var scrollTop = $(document).scrollTop();
	//console.log('browserWidth:'+browserWidth+' browserHeight:'+browserHeight+' width:'+width+' height:'+height+'scrollTop:'+scrollTop);
	var top=scrollTop+10;
	/*if(browserHeight>height){
		top=(browserHeight - height)*0.5;
	}*/
	return top;
};
$.messager.defaults.top = easyuiWindowTop;
$.fn.dialog.defaults.top = easyuiWindowTop;
$.fn.window.defaults.top = easyuiWindowTop;
//$.fn.panel.defaults.onMove = easyuiPanelOnMove;

/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI,jQuery cookie plugin
 * 
 * 更换EasyUI主题的方法
 * 
 * @param themeName
 *            主题名称
 */
changeTheme = function(themeName) {
	var $easyuiTheme = $('#easyuiTheme');
	var url = $easyuiTheme.attr('href');
	var href = url.substring(0, url.lastIndexOf('themes')) + 'themes/' + themeName + '/easyui.css';
	$easyuiTheme.attr('href', href);

	var $iframe = $('iframe');
	if ($iframe.length > 0) {
		for ( var i = 0; i < $iframe.length; i++) {
			var ifr = $iframe[i];
			$(ifr).contents().find('#easyuiTheme').attr('href', href);
		}
	}

	$.cookie('easyuiThemeName', themeName, {
		expires : 7
	});
};

/**
 * @author 孙宇
 * 
 * @requires jQuery
 * 
 * 将form表单元素的值序列化成对象
 * 
 * @returns object
 */
serializeObject = function(form) {
	var o = {};
	$.each(form.serializeArray(), function(index) {
		if (o[this['name']]) {
			o[this['name']] = o[this['name']] + "," + this['value'];
		} else {
			o[this['name']] = this['value'];
		}
	});
	return o;
};

/**
 * @author 孙宇
 * 
 * 增加formatString功能
 * 
 * 使用方法：formatString('字符串{0}字符串{1}字符串','第一个变量','第二个变量');
 * 
 * @returns 格式化后的字符串
 */
formatString = function(str) {
	for ( var i = 0; i < arguments.length - 1; i++) {
		str = str.replace("{" + i + "}", arguments[i + 1]);
	}
	return str;
};

/**
 * @author 孙宇
 * 
 * 接收一个以逗号分割的字符串，返回List，list里每一项都是一个字符串
 * 
 * @returns list
 */
stringToList = function(value) {
	if (value != undefined && value != '') {
		var values = [];
		var t = value.split(',');
		for ( var i = 0; i < t.length; i++) {
			values.push('' + t[i]);/* 避免他将ID当成数字 */
		}
		return values;
	} else {
		return [];
	}
};

/**
 * @author 孙宇
 * 
 * @requires jQuery
 * 
 * 改变jQuery的AJAX默认属性和方法
 */
$.ajaxSetup({
	type : 'POST',
	error : function(XMLHttpRequest, textStatus, errorThrown) {
		//console.log(XMLHttpRequest);
		//console.log(textStatus);
		//console.log(errorThrown);
		$.messager.progress('close');
		$.messager.alert('错误', XMLHttpRequest.responseText);
	}
});

/*
	让panel的高度100%
*/
var fullHeight=function(){    
		var windowHeight = $(window).height();
		console.log(windowHeight);
		$('.fullHeight').css('min-height', windowHeight - 200 + 'px'); 
};

//$.fn.panel.defaults.onOpen=fullHeight;
//$.fn.datagrid.defaults.onOpen = fullHeight;


//身份证验证方法，使用方法data-options="validType:'idcared'"
var aCity={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外"}
function isCardID(sId){
	var iSum=0 ;
	var info="" ;
	if(!/^\d{17}(\d|x)$/i.test(sId)) return "你输入的身份证长度或格式错误"; 
	sId=sId.replace(/x$/i,"a"); 
	if(aCity[parseInt(sId.substr(0,2))]==null) return "你的身份证地区非法"; 
	sBirthday=sId.substr(6,4)+"-"+Number(sId.substr(10,2))+"-"+Number(sId.substr(12,2)); 
	var d=new Date(sBirthday.replace(/-/g,"/")) ;
	if(sBirthday!=(d.getFullYear()+"-"+ (d.getMonth()+1) + "-" + d.getDate()))return "身份证上的出生日期非法"; 
	for(var i = 17;i>=0;i --) iSum += (Math.pow(2,i) % 11) * parseInt(sId.charAt(17 - i),11) ;
	if(iSum%11!=1) return "你输入的身份证号非法"; 
	return true;
}

(function($){
     
    //初始化清除按钮
    function initClear(target){
        var jq = $(target);
        var opts = jq.data('combo').options;
        var combo = jq.data('combo').combo;
        var arrow = combo.find('span .combo-arrow');
        //var arrow = $('.combo-arrow');
         
        var clear = arrow.siblings("span .combo-clear");
        if(clear.size()==0){
            //创建清除按钮。
            clear = $('<span class="combo-clear" style="height: 20px;"></span>');
             
            //清除按钮添加悬停效果。
            clear.unbind("mouseenter .combo mouseleave .combo").bind("mouseenter .combo mouseleave .combo",
                function(event){
                    var isEnter = event.type=="mouseenter";
                    clear[isEnter ? 'addClass' : 'removeClass']("combo-clear-hover");
                }
            );
            //清除按钮添加点击事件，清除当前选中值及隐藏选择面板。
            clear.unbind("click .combo").bind("click .combo",function(){
                jq.combo("setValue","").combo("setText","");
                jq.combo('hidePanel');
            });
            arrow.before(clear);
        };
        var input = combo.find("input .combo-text");
        input.outerWidth(input.outerWidth()-clear.outerWidth());
         
        opts.initClear = true;//已进行清除按钮初始化。
    }
     
    //扩展easyui combo添加清除当前值。
    var oldResize = $.fn.combo.methods.resize;
    $.extend($.fn.combo.methods,{
        initClear:function(jq){
            return jq.each(function(){
                 initClear(this);
            });
        },
        resize:function(jq){
            //调用默认combo resize方法。
            var returnValue = oldResize.apply(this,arguments);
            var opts = jq.data("combo").options;
            if(opts.initClear){
                jq.combo("initClear",jq);
            }
            return returnValue;
        }
    });
}(jQuery));

