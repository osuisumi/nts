function initRemoteUploader(server, fileNumLimit,isImage,isList,prefix) {
	if (fileNumLimit == null) {
		fileNumLimit = 0;
	}
//	$('#uploadBtn').hide();
	initFileParam(isList,prefix);
	//对图片文件进行特殊处理
	if(isImage==undefined||isImage==''||isImage=='false'){	
		var uploader = WebUploader.create({
			// swf文件路径
			swf : $('#ctx').val() + '/js/webuploader/Uploader.swf',
			// 文件接收服务端。
			server : server,
			// 选择文件的按钮。可选。
			// 内部根据当前运行是创建，可能是input元素，也可能是flash.
			pick : '#picker',
			// 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
			resize : true,
			fileNumLimit : fileNumLimit
		});
	}else if(isImage=='true'){
		var uploader = WebUploader.create({
			// swf文件路径
			swf : $('#ctx').val() + '/js/webuploader/Uploader.swf',
			// 文件接收服务端。
			server : server,
			// 选择文件的按钮。可选。
			// 内部根据当前运行是创建，可能是input元素，也可能是flash.
			pick : '#picker',
			// 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
			resize : true,
			fileNumLimit : fileNumLimit,
			accept:{
		        title: 'Images',
		        extensions: 'gif,jpg,jpeg,bmp,png',
		        mimeTypes: 'image/*'
		    }
		});
	}
	
	
	// 当有文件被添加进队列的时候
	uploader.on('fileQueued', function(file) {
		$list = $('#fileList');
		if(isImage==undefined||isImage==''||isImage=='false'){			
			$list.append('<li id="' + file.id + '" class="fileLi fileItem item">' + '<a href="#" class="txt">' + file.name + '</a>' + '<div class="state">' + '<span class="status">等待上传...</span>' + '</div>' + '<a class="dlt" title="删除附件">×</a>' + '</li>');
	//		initUploadBtn();
			uploader.upload();
		}else{
			var $li = $(
		            '<div id="' + file.id + '" class="fileLi file-item thumbnail">' +
		                '<img>' +
		                '<div class="info">' + file.name + '</div>' +
		            '</div>'
		            ),
		        $img = $li.find('img');

			 $btns = $('<div class="file-panel">' +
	                    '<span class="cancel">删除</span>' +
	                    '<span class="rotateRight">向右旋转</span>' +
	                    '<span class="rotateLeft">向左旋转</span></div>').appendTo( $li );
			$list.empty();
			 // $list为容器jQuery实例
		    $list.append( $li );

		    // 创建缩略图
		    // 如果为非图片文件，可以不用调用此方法。
		    // thumbnailWidth x thumbnailHeight 为 100 x 100
		    uploader.makeThumb( file, function( error, src ) {
		        if ( error ) {
		            $img.replaceWith('<span>不能预览</span>');
		            return;
		        }

		        $img.attr( 'src', src );
		    }, 100, 100 );
		    uploader.upload();

            $li.on( 'mouseenter', function() {
                $btns.stop().animate({height: 30});
            });

            $li.on( 'mouseleave', function() {
                $btns.stop().animate({height: 0});
            });
		}
	});
	// 文件上传过程中创建进度条实时显示。
	uploader.on('uploadProgress', function(file, percentage) {
		var $li = $('#' + file.id), $percent = $li.find('.sche');
		// 避免重复创建
		if (!$percent.length) {
			$li.find('.state').html('<div class="sche">' + '<div class="bl">' + '<div class="bs" role="progressbar" style="width: 0%"></div>' + '</div>' + '<span class="num">' + '0%' + '</span>' + '<span class="status"></span>' + '</div>');
			$percent = $li.find('.sche');
		}
		var progress = Math.round(percentage * 100);
		$percent.find('.bs').css('width', progress + '%');
		$percent.find('.num').text(progress + '%');
		$percent.find('.status').text('上传中');
	});
	uploader.on('uploadSuccess', function(file, response) {
		if (response != null && response.responseCode == '00') {
			$('#' + file.id).find('.state .status').text('已上传');
			var fileInfo = response.responseData;
			$('#' + file.id).attr('fileId', fileInfo.id);
			$('#' + file.id).attr('url', fileInfo.url);
			$('#' + file.id).attr('fileName', fileInfo.fileName);
			$('#' + file.id).addClass('success');
			initFileParam(isList,prefix);
		}
	});
	uploader.on('uploadError', function(file) {
		$('#' + file.id).find('.state .status').text('上传出错');
	});
	uploader.on('uploadComplete', function(file) {
		$('#' + file.id).find('.progress').fadeOut();
	});
//	$('#uploadBtn').click(function() {
//		uploader.upload();
//	});
	$('#fileList').on('click', '.dlt', function() {
		var _this = $(this);
		confirm('是否确定删除该附件?',function(){
			if ($(this).parents('.fileLi').hasClass('fileItem')) {
				uploader.removeFile($(this).parents('.fileLi').attr('id'));
			}
			_this.parents('.fileLi').remove();
			initFileParam(isList);
		});
	});
	uploader.on('error', function(type) {
		if (type == 'Q_EXCEED_NUM_LIMIT') {
			alert('只允许上传' + fileNumLimit + '个附件');
		}
	});
//	function initUploadBtn() {
//		var count = $('#fileList').find('.fileItem').length;
//		if (count > 0) {
//			$('#uploadBtn').show();
//		} else {
//			$('#uploadBtn').hide();
//		}
//	}
};

function initFileParam(isList,prefix) {
	var $form = $('#fileList').closest('form');
	$form.find('.fileParam').remove();
	var filePrefix = "";
	if(prefix!=undefined&&prefix!=''){
		filePrefix = prefix+".";
	}
	$('#fileList').find('.fileLi.success').each(function(i) {
		var fileId = $(this).attr('fileId');
		var fileName = $(this).attr('fileName');
		var url = $(this).attr('url');
		if(isList==undefined||isList==''||isList=='true'){			
			$form.append('<input class="fileParam" name="'+filePrefix+'fileInfos[' + i + '].id" value="' + fileId + '" type="hidden"/>');
			$form.append('<input class="fileParam" name="'+filePrefix+'fileInfos[' + i + '].fileName" value="' + fileName + '" type="hidden"/>');
			$form.append('<input class="fileParam" name="'+filePrefix+'fileInfos[' + i + '].url" value="' + url + '" type="hidden"/>');
		}else{
			$form.append('<input class="fileParam" name="'+filePrefix+'fileInfo.id" value="' + fileId + '" type="hidden"/>');
			$form.append('<input class="fileParam" name="'+filePrefix+'fileInfo.fileName" value="' + fileName + '" type="hidden"/>');
			$form.append('<input class="fileParam" name="'+filePrefix+'fileInfo.url" value="' + url + '" type="hidden"/>');
		}
	});
}


var initFileResourceMng = function(obj) {
	// 备课增加文件夹功能
	add_folder(obj);
	// 备课操作功能
	opa(obj);
	
	initFileType(obj);
};

//备课操作功能
function opa(obj) {
	// 备课文件重命名
	file_rename(obj);
	// 显示隐藏文件夹操作功能
	show_file_opa(obj);
}

// 显示隐藏文件夹操作功能
function show_file_opa(obj) {
	 var show_file_part = ".am-file-lst";
     //判断传入的父级参数是否存在，存在则用传入参数绑定事件，不存在则用默认父级绑定
     if(obj == "" || obj == 'undefined' || obj == null || obj == undefined) {
     }else {
         show_file_part = obj;
     }
     //鼠标移动到文件模块时
     $(show_file_part).on('mouseenter','.am-file-block',function(){
         var $block = $(this),
             $opa = $block.find(".f-opa"), //操作按钮行
             $info = $block.find(".f-info"); //信息行
         //如果正在重命名，则隐藏操作按钮行和信息行，否则隐藏信息行，隐藏操作按钮行
         if($block.find(".rename-box").length != 0){
             $opa.hide();
             $info.hide();
         }else {
             $(this).find(".f-opa").show();
             $(this).find(".f-info").hide();
         };   
     });
     //鼠标移出到文件模块时
     $(show_file_part).on('mouseleave','.am-file-block',function(){
         var $block = $(this),
             $opa = $block.find(".f-opa"), //操作按钮行
             $info = $block.find(".f-info"); //显示信息行
         //如果正在重命名，则隐藏操作按钮行和信息行，否则隐藏操作按钮行，隐藏信息行
         if($block.find(".rename-box").length != 0){
             $opa.hide();
             $info.hide();
         }else {
             $opa.hide();
             $info.show();
         };
     });
}

// 备课增加文件夹
function add_folder(obj) {
	var $add_folder_btn = obj.find(".au-add-folder");
	var onoff = true;
	$add_folder_btn.unbind('click');
	$add_folder_btn.click(function() {
		var $file_lst_par = obj.find('.common-file-lst');
		var $file_lst_par1 = obj.find('.common-file-lst1');
		// 判断是否正在创建文件夹
		if (onoff) {
			onoff = false;
			// 增加新文件夹
			$file_lst_par.prepend(
				'<li class="fileLi">' 
					+ '<div class="am-file-block am-file-folder">' 
						+ '<div class="file-view">' 
							+ '<div class="au-folder"></div>' 
						+ '</div>' 
						+ '<div class="add-rename-box" style="display: block">' 
							+ '<input type="text" value="" class="rename-ipt">' 
							+ '<div>' 
								+ '<a href="javascript:void(0);" class="confirm">创建</a>' 
								+ '<a href="javascript:void(0);" class="cancel">取消</a>' 
							+ '</div>' 
						+ '</div>' 
					+ '</div>' 
				+ '</li>');
			$file_lst_par1.prepend(
				'<tr>'+
                    '<td>'+
                        '<div class="rename">'+
                            '<input type="text" value="新建文件夹">'+
                            '<a href="javascript:void(0);" class="confirm">创建</a>'+
                            '<a href="javascript:void(0);" class="cancel">取消</a>'+
                        '</div>'+
                    '</td>'+
                    '<td></td>'+
                '</tr>'
			);
			// 设置新建的文件夹
			var _ts = $file_lst_par.find('li:first'), 
			_ts1 = $file_lst_par1.find('tr:first'), 
			$add_rename_box = _ts.find(".add-rename-box"), 
			tsArray = _ts.add(_ts1);
			$rename_ipt = tsArray.find(".rename-ipt"), 
			$found_btn = tsArray.find(".confirm"), 
			$cancel_btn = tsArray.find(".cancel");
			
			// 输入框获取焦点和默认文件夹名字
			$rename_ipt.focus().val("新建文件夹");
			/*
			 * var strs = String($rename_ipt.val()).replace(/[^\x00-\xff]/g, 'xx'); var strLength = strs.length; alert(strLength);
			 */
			// 取消创建文件夹
			$cancel_btn.on("click", function() {
				_ts.remove();
				_ts1.remove();
				onoff = true;
			})
			// 创建文件夹
			$found_btn.on("click", function() {
				onoff = true;
				var $rename_box = $add_rename_box;
				$('#saveFolderForm input[name="name"]').val($rename_ipt.val());
				var data = $.ajaxSubmit('saveFolderForm');
				var json = $.parseJSON(data);
				if(json.responseCode == '00'){
					var fileResource = json.responseData;
					$rename_box.before('<b class="f-name">'
							+ '<span>' 
								+ $rename_ipt.val() 
							+ '</span>'
							+ '<em>(0)</em>'
						+'</b>' 
						+ '<div class="f-opa">' 
							+ '<a onclick="listMoreFileResource(\''+fileResource.id+'\',\''+fileResource.name+'\')" class="open">打开</a>' 
							+ '<a class="move" onclick="moveFile(\''+fileResource.name+'\',\''+fileResource.id+'\')">移动</a>' 
							+ '<a href="javascript:void(0);" class="rename">重命名</a>' 
							+ '<a onclick="deleteFile(this, \''+fileResource.id+'\', \'folder\')" class="delete">删除</a>' 
						+ '</div>'
						+ '<input type="hidden" class="fileId" value="'+fileResource.id+'">'
						/*+ '<div class="rename-box">' 
							+ '<input type="text" value="" class="rename-ipt" fileId="'+fileResource.id+'">' 
							+ '<div>' 
								+ '<a href="javascript:void(0);" class="confirm">确定</a>' 
								+ '<a href="javascript:void(0);" class="cancel">取消</a>' 
							+ '</div>' 
						+ '</div>'*/
						);
					$rename_box.prevAll(".f-opa").show();
					$rename_box.hide();
					opa(obj);
					
					_ts1.after(
						'<tr>'+
                            '<td>'+
                                '<a onclick="listMoreFileResource(\''+fileResource.id+'\',\''+fileResource.name+'\')" class="name">'+
                                    '<i class="au-sFile-folder au-sFile-ico"></i>'+$rename_ipt.val()+
                                '</a>'+
                            '</td>'+
                            '<td>'+
                                '<span class="time"></span>'+
                                '<div class="opa">'+
                                    '<a onclick="listMoreFileResource(\''+fileResource.id+'\',\''+fileResource.name+'\')" class="au-opens z-crt">'+
                                        '<i class="au-ico"></i>打开'+
                                    '</a>'+
                                    '<a onclick="moveFile(\''+fileResource.name+'\', \''+fileResource.id+'\')" class="au-classify z-crt"><i class="au-ico"></i>移动</a>'+
                                    '<a onclick="deleteFile(this, \''+fileResource.id+'\', \'folder\')" class="au-delete z-crt">'+
                                        '<i class="au-ico"></i>删除'+
                                    '</a>'+
                                '</div>'+
                            '</td>'+
                        '</tr>'
	                );
					_ts1.remove();
				}
			});
		} else {
			// 如果正在创建文件夹，让创建文件夹输入框获取焦点
			$file_lst_par.children().eq(0).find(".rename-ipt").focus();
		}
	});

}

// 备课文件重命名
function file_rename(obj) {
	var $rename_button = obj.find('.am-file-block .rename');
    var renameHtml = '<div class="rename-box">'+
                        '<input type="text" class="rename-ipt">'+
                        '<div>'+
                            '<a href="javascript:void(0);" class="confirm">确定</a>'+
                            '<a href="javascript:void(0);" class="cancel">取消</a>'+
                        '</div>'+
                    '</div>';
    $rename_button.off().on('click',function(){
        var $this = $(this),
            $part = $this.parents('.am-file-block'),  //文件模块
            $siblings_part = $part.parents(".am-file-lst").find(".am-file-block"),
            $file_name = $part.find(".f-name"), //文件名字
            $file_info = $part.find(".f-info"), //文件信息块
            $file_opa = $this.parent(); //操作模块

        //获取后缀名
        var names = $file_name.find("span").text(),
            strings = names.split("."),
            //c = /\.[^\.]+$/.exec(files);
            s_length = strings.length,
            suffix = strings[s_length -1];


        //点击时删除其他所有重命名框
        $siblings_part.find(".rename-box").remove();
        $siblings_part.find(".f-name").show();
        $file_name.hide();
        $file_opa.hide().after(renameHtml); //插入重命名框

        //设置重命名框
        var $rename_box = $part.find(".rename-box"), //重命名模块
            $rename_ipt = $part.find(".rename-ipt"), //重命名输入框
            $rename_confirm = $part.find(".confirm"), //确定按钮
            $rename_cancel = $part.find(".cancel"); //取消按钮
        //重命名框获取文件名
        $rename_ipt.val(names.split(".")[0]).focus();

        //确定保存名字
        $rename_confirm.off().on("click",function(){
            if($rename_ipt.val() == ""){
                alert("文件名不能为空");
                $rename_ipt.focus();
            }else {
                $file_name.show().children("span").text($rename_ipt.val());
                if(strings.length == 1){
                   $file_name.show().children("span").text($rename_ipt.val());
                }else {
                    $file_name.show().children("span").text($rename_ipt.val() + "." + suffix);
                }
                var text = '';
                if(strings.length == 1){
                	text = $rename_ipt.val();
                }else {
                	text = $rename_ipt.val() + "." + strings[strings.length - 1];
                }
                //后台保存
                var fileId = $rename_ipt.parent().next('.fileId').val();
                updateFileResource(fileId, text);
                
                $file_opa.show();
                $rename_box.remove();
            }
        })
        //取消重命名
        $rename_cancel.off().on("click",function(){
            $file_name.show();
            $file_opa.show();
            $rename_box.remove();

        })
        //失去焦点时，
        /*$rename_ipt.on("blur",function(){
            $rename_box.hide();
            $file_name.show().children("span").text($rename_ipt.val());
            $file_opa.show();
        })*/

    });
	
	
	/*var $file_name_par = obj.find(".am-file-block");
	$file_name_par.each(function(){
		var _ts = $(this);
		var $rename = _ts.find(".rename"); //重命名按钮
        var $file_ico = _ts.find(".file-view").children();
        var $rename_box = _ts.find(".rename-box"); //重命名模块
        var $rename_ipt = _ts.find(".rename-ipt"); //重命名输入框
        var $rename_confirm = _ts.find(".confirm"); //确定按钮
		var $rename_cancel = _ts.find(".cancel"); //取消按钮
		var $file_name = _ts.find(".f-name"); //文件名字
        var $file_info = _ts.find(".f-info"); //重命名按钮
		var $file_opa = _ts.find(".f-opa"); //操作模块
        var $names = $file_name.find("span").text();

        var strings = $names.split(".");
        //console.log($file_ico.html());
        //var c = /\.[^\.]+$/.exec(files);
        var s_length = strings.length;

        if(s_length == 1){
            //alert(1);
        }else {
            if(strings[s_length -1] == "doc"){
                $file_ico.removeClass().addClass("au-word");
                //alert(1);
            }else if(strings[s_length -1] == "xlsx"){
                $file_ico.removeClass().addClass("au-excel");
            }else if(strings[s_length -1] == "ppt"){
                $file_ico.removeClass().addClass("au-ppt");
            }else if(strings[s_length -1] == "pdf"){
                $file_ico.removeClass().addClass("au-pdf");
            }else if(strings[s_length -1] == "mp4"){
                $file_ico.removeClass().addClass("au-video");
            }
        }

        //点击重命名按钮执行操作
		$rename.on("click",function(){
            var names = $file_name.children("span").text();
            $file_name_par.find(".rename-box").hide();
            $file_name_par.find(".f-name").show();
            $rename_box.show();
            $file_name.hide();
            $(this).parent().hide();
            $rename_ipt.val(names.split(".")[0]).focus();
        })
        //失去焦点时，
        $rename_ipt.on("blur",function(){
            $rename_box.hide();
            $file_name.show().children("span").text($rename_ipt.val());
            $file_opa.show();
        })
        //确定保存名字
        $rename_confirm.on("click",function(){
            $rename_box.hide();
            $file_name.show().children("span").text($rename_ipt.val());
            var text = '';
            if(strings.length == 1){
            	text = $rename_ipt.val();
            }else {
            	text = $rename_ipt.val() + "." + strings[strings.length - 1];
            }
            $file_name.show().children("span").text(text);
            $file_opa.show();
            //后台保存
            var fileId = $rename_ipt.attr('fileId');
            updateFileResource(fileId, text);
            
        })
        //取消重命名
        $rename_cancel.on("click",function(){
            $rename_box.hide();
            $file_name.show();
            $file_opa.show();
            
        })
		
	});*/
}

function initFileResourceUploader(relationId, type, parentId, obj, btn){
	var url = $('#ctx').val() + '/file/uploadRemote.do?relationId='+relationId+'&type='+type;
	if(parentId != null && parentId != ''){
		url += '&parentId='+parentId;
	}
	var uploader = WebUploader.create({
		// swf文件路径
		swf : $('#ctx').val() + '/js/webuploader/Uploader.swf',
		// 文件接收服务端。
		server : url,
		// 选择文件的按钮。可选。
		// 内部根据当前运行是创建，可能是input元素，也可能是flash.
		pick : btn,
		// 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		resize : true
	});
	uploader.on('fileQueued', function(file) {
		uploader.upload();
	});
	uploader.on('uploadError', function(file, reason) {
		alert('上传失败,请重新上传');
	});
	uploader.on('uploadSuccess', function(file, response) {
		if(response.responseCode == '00'){
			var fileResource = response.responseData;
			var $file_lst_par = obj.find('.common-file-lst');
			$file_lst_par.prepend('<li class="fileBlock fileLi">' 
									+'<div class="am-file-block am-file-word">'
										+'<div class="fileIcon file-view">'
											+'<div url="'+fileResource.newestFile.remark+'" class="au-word"></div>'
										+'</div>'
										+'<b class="f-name"><span class="fileName">'+fileResource.name+'</span></b>'
										+'<div class="f-info">'
										+'</div>'
										+'<div class="f-opa">'
											+'<a onclick="downloadFile(\''+fileResource.newestFile.id+'\',\''+fileResource.name+'\')" class="download">下载</a>'
											+'<a class="move" onclick="moveFile(\''+fileResource.name+'\',\''+fileResource.id+'\')">移动</a>' 
											+'<a class="rename">重命名</a>' 
											+'<a onclick="deleteFile(this, \''+fileResource.id+'\')" class="delete">删除</a>'
										+'</div>'
										+ '<input type="hidden" class="fileId" value="'+fileResource.id+'">'
										/*+'<div class="rename-box">'
											+'<input type="text" class="rename-ipt" fileId="'+fileResource.id+'">'
											+'<div>'
												+'<a class="confirm">确定</a>'
												+'<a class="cancel">取消</a>'
											+'</div>'
										+'</div>'*/
									+'</div>'
								+ '</li>');
			var _ts = $file_lst_par.find('li:first'), 
			$add_rename_box = _ts.find(".add-rename-box");
			$add_rename_box.prevAll(".f-opa").show();
			
			var $file_lst_par1 = obj.find('.common-file-lst1');
			$file_lst_par1.prepend(
					'<tr class="fileLi fileBlock">'+
						'<td><a href="javascript:void(0);" class="name"><span class="fileIcon"><i class="au-file-ico"></i></span><span class="fileName">'+fileResource.name+'</span></a></td>'+
						'<td>'+
							'<span class="time"></span>'+
							'<div class="opa">'+
							'<a onclick="downloadFile(\''+fileResource.newestFile.id+'\',\''+fileResource.name+'\')" class="au-download z-crt"><i class="au-ico fileIcon"></i>下载</a>'+
							'<a onclick="moveFile(\''+fileResource.name+'\', \''+fileResource.id+'\')" class="au-classify z-crt"><i class="au-ico"></i>移动</a>'+
							'<a onclick="deleteFile(this, \''+fileResource.id+'\')" class="au-delete z-crt"> <i class="au-ico"></i>删除</a>'+
							'</div>'+
						'</td>'+
					'</tr>'
			);
			
			opa(obj);
			initFileType(obj);
		}
	});
};

function initImageUploader(relationId, type){
	var uploader = WebUploader.create({
		// swf文件路径
		swf : $('#ctx').val() + '/js/webuploader/Uploader.swf',
		// 文件接收服务端。
		server : $('#ctx').val() + '/file/uploadRemote.do?relationId='+relationId+'&type='+type,
		// 选择文件的按钮。可选。
		// 内部根据当前运行是创建，可能是input元素，也可能是flash.
		pick : '#picker',
		// 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		resize : true,
		accept : {
		    extensions: 'jpg,jpeg,png'
		}
	});
	uploader.on('fileQueued', function(file) {
		uploader.upload();
	});
	uploader.on('uploadError', function(file, reason) {
		alert('上传失败,请重新上传');
	});
	uploader.on('uploadSuccess', function(file, response) {
		if(response.responseCode == '00'){
			var fileResource = response.responseData;
			$('#imagePreView').attr('src', fileResource.newestFile.remark);
			$('#imagePreView input[name="imageUrl"]').remove();
			$('#imagePreView').append('<input type="hidden" name="imageUrl" value="'+fileResource.newestFile.url+'">');
		}
	});
	uploader.on('error', function(type) {
		if (type == 'Q_TYPE_DENIED') {
			alert('不支持该类型的文件');
		}
	});
};

function initFileType(obj){
	var $file_name_par = obj.find(".fileBlock");
	$file_name_par.each(function(){
		var _ts = $(this);
		var $names = _ts.find(".fileName").text(); //文件名字
        var $file_ico = _ts.find(".fileIcon");
        var strings = $names.split(".");
        var s_length = strings.length;
        var suffix = strings[s_length -1];
        if(s_length == 1){
           
        }else {
            if(suffix == "doc" || suffix == "docx"){
            	if($file_ico.hasClass('file-view')){
            		$file_ico.children().removeClass().addClass("au-file-word");
            	}else{
            		$file_ico.children().removeClass().addClass("au-sFile-word").addClass('au-sFile-ico');
            	}
            }else if(suffix == "xls" || suffix == "xlsx"){
            	if($file_ico.hasClass('file-view')){
            		$file_ico.children().removeClass().addClass("au-file-excel");
            	}else{
            		$file_ico.children().removeClass().addClass("au-sFile-excel").addClass('au-sFile-ico');
            	}	
            }else if(suffix == "ppt" || suffix == "pptx"){
            	if($file_ico.hasClass('file-view')){
            		$file_ico.children().removeClass().addClass("au-file-ppt");
            	}else{
            		$file_ico.children().removeClass().addClass("au-sFile-ppt").addClass('au-sFile-ico');
            	}
            }else if(suffix == "pdf"){
            	if($file_ico.hasClass('file-view')){
            		$file_ico.children().removeClass().addClass("au-file-pdf");
            	}else{
            		$file_ico.children().removeClass().addClass("au-sFile-pdf").addClass('au-sFile-ico');
            	}
            }else if(suffix == "txt"){
            	if($file_ico.hasClass('file-view')){
            		$file_ico.children().removeClass().addClass("au-file-txt");
            	}else{
            		$file_ico.children().removeClass().addClass("au-sFile-txt").addClass('au-sFile-ico');
            	}
            }else if(suffix == "zip" || suffix == "rar"){
            	if($file_ico.hasClass('file-view')){
            		$file_ico.children().removeClass().addClass("au-file-zip");
            	}else{
            		$file_ico.children().removeClass().addClass("au-sFile-zip").addClass('au-sFile-ico');
            	}
            }else if(suffix == "jpg" || suffix == "jpeg" || suffix == "png" || suffix == "gif"){
            	if($file_ico.hasClass('file-view')){
            		var url = $file_ico.children().attr('url');
                    $file_ico.children().removeClass().html('<img src="'+url+'" width="175px" height="89px" >');
            	}else{
            		$file_ico.children().removeClass().addClass("au-sFile-pic").addClass('au-sFile-ico');
            	}
            }else if(
                suffix == "mp4" || 
                suffix == "avi" || 
                suffix == "rmvb" || 
                suffix == "rm" || 
                suffix == "asf" || 
                suffix == "divx" || 
                suffix == "mpg" || 
                suffix == "mpeg" || 
                suffix == "mpe" || 
                suffix == "wmv" || 
                suffix == "mkv" || 
                suffix == "vob" || 
                suffix == "3gp"
                ){
            	if($file_ico.hasClass('file-view')){
            		$file_ico.children().removeClass().addClass("au-file-video");
            	}else{
            		$file_ico.children().removeClass().addClass("au-sFile-video").addClass('au-sFile-ico');
            	}
            }else {
            	if($file_ico.hasClass('file-view')){
            		$file_ico.children().removeClass().addClass("au-file-other");
            	}else{
            		$file_ico.children().removeClass().addClass("au-sFile-other").addClass('au-sFile-ico');
            	}
            }
        }
	});
}
