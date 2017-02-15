<#macro uploadImageFtl relationId relationType="" paramName="fileInfos" paramType="list" divId="fileDiv" btnTxt="上传文件" fileNumLimit=0 fileTypeLimit="">
	<#if relationId != ''>
		<script>
			$.get('/file','relationId=${relationId}&relationType=${relationType}',function(data) {
				if (data != null) {
					$.each(data,function(i, tag) {
						var $li = $('#imageLiTemplate').clone();
						$li.addClass('success').attr('fileId', this.id).show();
						$li.find('.fileName').text(this.fileName);
						$li.find('.fileBar').remove();
						$li.find('img').attr('src',"${FileUtils.getFileUrl("")}" + tag.url);
						$li.insertBefore($('#${divId}').find('.imageList #uploadBtn'));
					});
					initImageParam('${divId}', '${paramName}');
				}
			});
		</script>
	</#if>
        <ul class="imageList mis-hadup-img">
            <li id="imageLiTemplate" class="fileLi" style="display: none; float: left; margin-right: 15px;">
            	<img src="../images/uplaod-img1.jpg" alt="">
            	<i class="u-close deleteBtn">×</i>
            	<div class="u-progress fileBar">
            		<ins class="progressW barLength"></ins><span class="txt barNum">40%</span>
            	</div>
            </li>
            <li id="uploadBtn">
                <div class="img">
                    <a href="javascript:;" class="picker">
                        <i class="u-add"></i>
                        <input  class="u-file">
                        <p class="txt">继续添加</p>
                    </a>
                </div>
            </li>
        </ul>
    <script>
    	$(function(){
    		var imageUploader = WebUploader.create({
        		swf : $('#ctx').val() + '/js/webimageUploader/Uploader.swf',
        		server : '${ctx}/file/uploadTemp',
        		pick : '#${divId} .picker',
        		resize : true,
        		duplicate : true,
        		accept : {
        		    extensions: '${fileTypeLimit!}'
        		}
        	});
        	// 当有文件被添加进队列的时候
        	imageUploader.on('fileQueued', function(file) {
        		var fileNumLimit = parseInt('${fileNumLimit}');
        		if(fileNumLimit != 0){
        			var fileNum = $('#${divId}').find('.imageList').find(".fileLi").length;
            		if(fileNum > fileNumLimit){
            			alert('只允许上传'+fileNumLimit+'个附件');
            			imageUploader.removeFile(file.id);
            			return false;
            		}
        		}
        		var $li = $('#imageLiTemplate').clone();
        		$li.attr('id', file.id).addClass('fileItem').show();
        		$li.find('.fileName').text(file.name);
        		$li.insertBefore($('#${divId}').find('.imageList #uploadBtn'));
        		//$('#${divId}').find(".imageList").append($li);
        					    // 创建缩略图
			    imageUploader.makeThumb( file, function( error, src ) {
			    	$img = $('#'+file.id).find('img');
			        if ( error ) {
			            $img.replaceWith('<span>不能预览</span>');
			            return;
			        }
			        $img.attr( 'src', src );
			    });
        		imageUploader.upload();
        	});
        	// 文件上传过程中创建进度条实时显示。
        	imageUploader.on('uploadProgress', function(file, percentage) {
        		var $li = $('#' + file.id), $bar = $li.find('.fileBar');
        		// 避免重复创建
        		/* if (!$percent.length) {
        			$li.find('.state').html('<div class="sche">' + '<div class="bl">' + '<div class="bs" role="progressbar" style="width: 0%"></div>' + '</div>' + '<span class="num">' + '0%' + '</span>' + '<span class="status"></span>' + '</div>');
        			$percent = $li.find('.sche');
        		} */
        		var progress = Math.round(percentage * 100);
        		$bar.find('.barLength').css('width', progress + '%');
        		$bar.find('.barNum').text(progress + '%');
        		$bar.find('.barTxt').text('上传中');
        	});
        	imageUploader.on('uploadSuccess', function(file, response) {
        		if (response != null && response.responseCode == '00') {
        			//$('#' + file.id).find('.fileBar').addClass('finish');
        			//$('#' + file.id).find('.barTxt').text('已上传');
        			var fileInfo = response.responseData;
        			$('#' + file.id).attr('fileId', fileInfo.id);
        			$('#' + file.id).attr('url', fileInfo.url);
        			$('#' + file.id).attr('fileName', fileInfo.fileName);
        			$('#' + file.id).addClass('success');
        			initImageParam('${divId}', '${paramName}');
        		}
        	});
        	imageUploader.on('uploadError', function(file) {
        		$('#' + file.id).find('.fileBar').addClass('error');
        		$('#' + file.id).find('.barTxt').text('上传出错');
        	});
        	imageUploader.on('uploadComplete', function(file) {
        		$('#' + file.id).find('.progress').fadeOut();
        	});
        	$('#${divId}').find(".imageList").on('click', '.deleteBtn', function() {
        		var _this = $(this);
        		confirm('是否确定删除该附件?',function(){
        			if ($(this).parents('.fileLi').hasClass('fileItem')) {
        				imageUploader.removeFile($(this).parents('.fileLi').attr('id'));
        			}
        			_this.parents('.fileLi').remove();
        			initImageParam('${divId}', '${paramName}');
        		});
        	});
        	imageUploader.on('error', function(type) {
        		if (type == 'Q_TYPE_DENIED') {
        			alert('请检查上传的文件类型');
        		}
        	}); 
    	});
	
	    function initImageParam(divId, paramName) {
	    	var $list = $('#'+divId).find(".imageList");
	    	$list.find('.fileParam').remove();
	    	$list.find('.fileLi.success').each(function(i) {
	    		var fileId = $(this).attr('fileId');
	    		var fileName = $(this).attr('fileName');
	    		var url = $(this).attr('url');
	    		if('${paramType}' == 'entity'){
	    			$(this).append('<input class="fileParam" name="'+paramName+'.id" value="' + fileId + '" type="hidden"/>');
		    		$(this).append('<input class="fileParam" name="'+paramName+'.fileName" value="' + fileName + '" type="hidden"/>');
		    		$(this).append('<input class="fileParam" name="'+paramName+'.url" value="' + url + '" type="hidden"/>');
	    		}else{
	    			$(this).append('<input class="fileParam" name="'+paramName+'[' + i + '].id" value="' + fileId + '" type="hidden"/>');
		    		$(this).append('<input class="fileParam" name="'+paramName+'[' + i + '].fileName" value="' + fileName + '" type="hidden"/>');
		    		$(this).append('<input class="fileParam" name="'+paramName+'[' + i + '].url" value="' + url + '" type="hidden"/>');
	    		}
	    	});
	    	initFileType($list);
	    }
	    
	    function initFileType(obj){
	    	var $file_name_par = obj.find(".fileLi");
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
	                	$file_ico.addClass("doc");
	                }else if(suffix == "xls" || suffix == "xlsx"){
	                	$file_ico.addClass("excel");
	                }else if(suffix == "ppt" || suffix == "pptx"){
	                	$file_ico.addClass("ppt");
	                }else if(suffix == "pdf"){
	                	$file_ico.addClass("pdf");
	                }else if(suffix == "txt"){
	                	$file_ico.addClass("txt");
	                }else if(suffix == "zip" || suffix == "rar"){
	                	$file_ico.addClass("zip");
	                }else if(suffix == "jpg" || suffix == "jpeg" || suffix == "png" || suffix == "gif"){
	                	$file_ico.addClass("pic");
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
	                	$file_ico.addClass("video");
	                }else {
	                	$file_ico.addClass("other");
	                }
	            }
	    	});
	    }
    </script>
</#macro>