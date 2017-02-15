<#macro importUser submitFunction templateName>

<input id="fileUrl" type="hidden" name="url">
<div class="mis-uplad-Aclayer">
    <div id="importDiv" class="mis-upLay-img">
        <a id="picker" href="javascript:;"  class="u-uplay-img"><input class="u-file"/></a>
        <p class="txt">请选择需要导入的文件，或者<a href="javascript:;" onclick="downloadExcel('${templateName}')"  class="mp">点击下载模版</a></p>  
        <div id="importModel" style="display:none" class="mis-pbar-mod">
            <h4 class="name"><span class="fileName"></span><!--<a href="javascript:;" class="dlt"><i class="mis-delete-ico"></i>删除</a>--></h4>
            <div class="mis-pbar-block state">
                  <div class="pbar-pro fileBar" style="width: 100%;">
                      <span class="pbar-txt"><span class="barTxt">导入完成：</span><strong class="barNum">100%</strong></span>
                  </div>
          	</div>    
        </div>
    </div>
    <div class="mis-btn-row mis-subBtn-row">
        <button type="button" onclick="${submitFunction}" class="mis-btn mis-main-btn">导入</button>
        <!--<button type="button" class="mis-btn mis-default-btn">取消</button>-->
    </div>

</div>

<script>
	$(function(){
		var uploader = WebUploader.create({
			swf : '${ctx}/js/webuploader/Uploader.swf',
			server : '${ctx}/file/uploadTemp.do',
			pick : '#picker',
			accept : {
			    extensions: 'xls, xlsx'
			}
		});
		uploader.on('fileQueued', function(file) {
			$('.importFile').remove();
			$importFile = $('#importModel').clone();
			$importFile.attr('id',file.id);
			$importFile.addClass('importFile');
			$('#importDiv').append($importFile);
			$importFile.show();
			uploader.upload();
		});
    	uploader.on('uploadProgress', function(file, percentage) {
    		var $li = $('#' + file.id);
    		var progress = Math.round(percentage * 100);
    		$li.find('.fileBar').css('width', progress + '%');
    		$li.find('.barNum').text(progress + '%');
    		$li.find('.barTxt').text('导入中');
    	});
		uploader.on('uploadSuccess', function(file, response) {
			if (response != null && response.responseCode == '00') {
				var fileInfo = response.responseData;
				var $li = $('#' + file.id);
				$li.find('.barTxt').text('导入完成');
				$li.find('.fileName').text(fileInfo.fileName);
				$li.find('.state').addClass('finish');
				$('#fileUrl').val(fileInfo.url);
			}
		});
		uploader.on('error', function(type) {
			if (type == 'Q_TYPE_DENIED') {
				alert('不支持该类型的文件');
			}
		});
	});



	function downloadExcel(fileName){
		$('#downloadExcelForm input[name="fileName"]').val(fileName);
		$('#downloadExcelForm').submit();
	}
	
</script>

</#macro>