<#global app_path=PropertiesLoader.get('app.nts.path') >
<#if app_path = '/nts/nea'>
	<form id="saveTrainForm" action="${ctx}/manage/nea/train/createTrainTerm" method="post">
<#elseif app_path = '/nts/lego'>
	<form id="saveTrainForm" action="${ctx}/manage/lego/train/createTrainTerm" method="post">	
<#else>
	<form id="saveTrainForm" action="${ctx}/manage/train" method="post">
</#if>
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	
	<#if train??>
		<#if app_path = '/nts/nea'>
			<script>
				$(function(){
					$('#saveTrainForm').attr('method','put');
					$('#saveTrainForm').attr('action','${ctx}/manage/nea/train/${train.id}/updateTrainTerm');
				});
			</script>
		<#elseif app_path = '/nts/lego'>
			<script>
				$(function(){
					$('#saveTrainForm').attr('method','put');
					$('#saveTrainForm').attr('action','${ctx}/manage/lego/train/${train.id}/updateTrainTerm');
				});
			</script>
		<#else>
			<script>
				$(function(){
					$('#saveTrainForm').attr('method','put');
					$('#saveTrainForm').attr('action','${ctx}/manage/train/${train.id}');
				});
			</script>
		</#if>
	</#if>
	
	<div class="mis-srh-layout">
    	<ul class="mis-ipt-lst">
			<li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>名称：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="<#if app_path = '/nts/nea' || app_path = '/nts/lego'>train.</#if>name" value="${(train.name)!}" placeholder="请输入名称..." class="mis-ipt required">
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>描述：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="<#if app_path = '/nts/nea' || app_path = '/nts/lego'>train.</#if>description" value="${(train.description)!}" placeholder="请输入描述" class="mis-ipt">
	                    </div>
	                </div>
	            </div>
	        </li>
            <li class="item w1">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>项目：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-select">
                            <select name="<#if app_path = '/nts/nea' || app_path = '/nts/lego'>train.</#if>project.id" style="width:200px" >
                            	<#assign projectId=(train.project.id)!'' />
                            	<@projects>
	                               	<#list projects as project>
										<option <#if projectId = project.id>selected="selected"</#if> value="${project.id}">${project.name}</option> 
									</#list>
                                </@projects>
                            </select>    
                        </div>
                    </div>
                </div>
            </li>
      		<li class="item w1">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>培训对象：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-select">
                            <select name="<#if app_path = '/nts/nea' || app_path = '/nts/lego'>train.</#if>target" style="width:200px" >
                            	${DictionaryUtils.getEntryOptionsSelected('POST',(train.target)!'')}
                            </select>    
                        </div>
                    </div>
                </div>
            </li>
	        <li class="item item-twoIpu">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>培训时间：</span>
                    </div>
                    <div class="center">
                        <div class="tc">
                            <div class="mis-ipt-mod">
                                <input name="<#if app_path = '/nts/nea' || app_path = '/nts/lego'>train.</#if>trainingTime.startTime" required type="text" value="${(train.trainingTime.startTime?string("yyyy-MM-dd"))!}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="mis-ipt">
                            </div>
                        </div>
                        <span class="to">至</span>
                        <div class="tc">
                            <div class="mis-ipt-mod">
                                <input name="<#if app_path = '/nts/nea' || app_path = '/nts/lego'>train.</#if>trainingTime.endTime" required type="text" value="${(train.trainingTime.endTime?string("yyyy-MM-dd"))!}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="mis-ipt" >
                            </div>
                        </div>                                            
                    </div>
                </div>
            </li>
	        <li class="item item-twoIpu">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>报名时间：</span>
                    </div>
                    <div class="center">
                        <div class="tc">
                            <div class="mis-ipt-mod">
                                <input name="<#if app_path = '/nts/nea' || app_path = '/nts/lego'>train.</#if>registerTime.startTime" type="text" value="${(train.registerTime.startTime?string("yyyy-MM-dd"))!}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="mis-ipt">
                            </div>
                        </div>
                        <span class="to">至</span>
                        <div class="tc">
                            <div class="mis-ipt-mod">
                                <input name="<#if app_path = '/nts/nea' || app_path = '/nts/lego'>train.</#if>registerTime.endTime" type="text" value="${(train.registerTime.endTime?string("yyyy-MM-dd"))!}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="mis-ipt" >
                            </div>
                        </div>                                            
                    </div>
                </div>
            </li>
	        <li class="item item-twoIpu">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>选课时间：</span>
                    </div>
                    <div class="center">
                        <div class="tc">
                            <div class="mis-ipt-mod">
                                <input name="<#if app_path = '/nts/nea' || app_path = '/nts/lego'>train.</#if>electivesTime.startTime" type="text" value="${(train.electivesTime.startTime?string("yyyy-MM-dd"))!}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="mis-ipt">
                            </div>
                        </div>
                        <span class="to">至</span>
                        <div class="tc">
                            <div class="mis-ipt-mod">
                                <input name="<#if app_path = '/nts/nea' || app_path = '/nts/lego'>train.</#if>electivesTime.endTime" type="text" value="${(train.electivesTime.endTime?string("yyyy-MM-dd"))!}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="mis-ipt" >
                            </div>
                        </div>                                            
                    </div>
                </div>
            </li>
            <#if app_path = '/nts/nea' || app_path = '/nts/lego'>
            	<@pinfoTermDirective trainId=(train.id)!''>
	            	<#if '' = (pinfoTerm.termName)!''>
	            		<li class="item w1">
			                <div class="mis-ipt-row">
			                    <div class="tl">
			                        <span>关联期次：</span>
			                    </div>
			                    <div class="tc">
			                        <div class="mis-select">
			                        	<@pinfoTermsDirective>
				                            <select name="termId" style="width:400px" >
				                            	<option value="">请选择期次...</option> 
				                               	<#list pinfoTerms as term>
													<option value="${term.id}">${term.termName}</option> 
												</#list>
				                            </select>    
				                        </@pinfoTermsDirective>
			                        </div>
			                    </div>
			                </div>
			            </li>
			        <#else>   
			            <li class="item w1">
			                <div class="mis-ipt-row">
			                    <div class="tl">
			                        <span>关联期次：</span>
			                    </div>
			                    <div class="tc">
			                        <div class="mis-select">
				                    	${pinfoTerm.termName!}
			                        </div>
			                    </div>
			                </div>
			            </li>
	            	</#if>
	            </@pinfoTermDirective>
	    	</#if>
			<li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>培训范围：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="<#if app_path = '/nts/nea' || app_path = '/nts/lego'>train.</#if>trainScope" value="${(train.trainScope)!}" placeholder="请输入培训范围..." class="mis-ipt">
	                    </div>
	                </div>
	            </div>
	        </li>
			<li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>培训学时：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" min="0" name="<#if app_path = '/nts/nea' || app_path = '/nts/lego'>train.</#if>studyHours" value="${(train.studyHours)!}" placeholder="请输入培训学时..." class="mis-ipt">
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>培训费用：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" min="0" name="<#if app_path = '/nts/nea' || app_path = '/nts/lego'>train.</#if>price" value="${(train.price)!}" placeholder="请输入培训费用..." class="mis-ipt">
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>收费方式：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-check-mod">
                            <label class="mis-radio-tick">
                                <strong class="on">
                                    <i class="ico"></i>
                                    <input type="radio" name="<#if app_path = '/nts/nea' || app_path = '/nts/lego'>train.</#if>chargeType" <#if ((train.chargeType)!'other') == 'other'>checked="checked"</#if>  value="other">
                                </strong>
                                <span>其他支付</span>
                            </label>
                            <label class="mis-radio-tick">
                                <strong>
                                    <i class="ico"></i>
                                    <input type="radio" name="<#if app_path = '/nts/nea' || app_path = '/nts/lego'>train.</#if>chargeType" <#if ((train.chargeType)!'other') == 'online'>checked="checked"</#if> value="online">
                                </strong>
                                <span>在线支付</span>
                            </label>
                            <label class="mis-radio-tick">
                                <strong>
                                    <i class="ico"></i>
                                    <input type="radio" name="<#if app_path = '/nts/nea' || app_path = '/nts/lego'>train.</#if>chargeType" <#if ((train.chargeType)!'other') == 'bycourse'>checked="checked"</#if> value="bycourse">
                                </strong>
                                <span>按课支付</span>
                            </label>                                            
                        </div>
                    </div>
                </div>
            </li>
            
            <#if (train.id)??>
       		  <@filesDirective relationId=train.id>
       		  	<#if fileInfos??>
					<#list fileInfos as fileInfo>
						<#if (fileInfo.fileRelations)?? && (fileInfo.fileRelations?size >0)>
							<#if fileInfo.fileRelations?first.type == 'zcwj'>
								<#assign zcwjFile = fileInfo/>
							<#elseif fileInfo.fileRelations?first.type == 'ssfa'>
								<#assign ssfaFile = fileInfo/>
							<#elseif fileInfo.fileRelations?first.type == 'khfa'>
								<#assign khfaFile = fileInfo/>
							</#if>
						</#if>
					</#list>       		  	
       		  	</#if>
          	  </@filesDirective>
            </#if>
	        <li class="item w1">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>政策文件：</span>
	                </div>
	                <div class="tc">
	                   <div class="fileDiv">
	                		<div class="m-pbMod-udload">
						        <a id="zcwj" class="mis-opt-upbtn mis-inverse-btn"><i class="mis-upload-ico"></i>选择文件</a>
						    </div>
						    <ul class="mis-sfile-lst fileList" ftype="zcwj" style="width:800px;">
						    	<#if zcwjFile??>
						    		<li class="fileLi fileItem success" style="display: list-item;" fileid="${(zcwjFile.id)!}" url="${(zcwjFile.url)!}" filename="${(zcwjFile.fileName)!}">
									    <i class="mis-sfile-ico "></i>
									    <a class="name fileName" title="">${(zcwjFile.fileName)!}</a>
									    <span class="size"></span>
									    <div class="mis-pbar finish">
									        <div class="bar"><div class="yet" style="width: 100%;"><span class="barNum">100%</span></div></div>
									        <span class="bar-txt">已上传</span>
									    </div>
									    <a class="dlt"><i class="mis-delete-ico1"></i>删除</a>
									</li>
						    	</#if>
						    </ul>
		                </div>
	                </div>
	            </div>
	        </li>
	        <li class="item w1">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>实施方案：</span>
	                </div>
	                <div class="tc">
		                <div class="fileDiv">
	                		<div class="m-pbMod-udload">
						        <a id="ssfa" class="mis-opt-upbtn mis-inverse-btn"><i class="mis-upload-ico"></i>选择文件</a>
						    </div>
						    <ul class="mis-sfile-lst fileList" ftype="ssfa" style="width:800px;">
					    		<li class="fileLi fileItem success" style="display: list-item;" fileid="${(ssfaFile.id)!}" url="${(ssfaFile.url)!}" filename="${(ssfaFile.fileName)!}">
								    <i class="mis-sfile-ico "></i>
								    <a class="name fileName" title="">${(ssfaFile.fileName)!}</a>
								    <span class="size"></span>
								    <div class="mis-pbar finish">
								        <div class="bar"><div class="yet" style="width: 100%;"><span class="barNum">100%</span></div></div>
								        <span class="bar-txt">已上传</span>
								    </div>
								    <a class="dlt"><i class="mis-delete-ico1"></i>删除</a>
								</li>
						    </ul>
		                </div>
	                </div>
	            </div>
	        </li>
	        <li class="item w1">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>考核方案：</span>
	                </div>
	                <div class="tc">
		                <div class="fileDiv">
                			<div class="m-pbMod-udload">
						        <a id="khfa" class="mis-opt-upbtn mis-inverse-btn"><i class="mis-upload-ico"></i>选择文件</a>
						    </div>
						    <ul class="mis-sfile-lst fileList" ftype="khfa" style="width:800px;">
					    		<li class="fileLi fileItem success" style="display: list-item;" fileid="${(khfaFile.id)!}" url="${(khfaFile.url)!}" filename="${(khfaFile.fileName)!}">
								    <i class="mis-sfile-ico "></i>
								    <a class="name fileName" title="">${(khfaFile.fileName)!}</a>
								    <span class="size"></span>
								    <div class="mis-pbar finish">
								        <div class="bar"><div class="yet" style="width: 100%;"><span class="barNum">100%</span></div></div>
								        <span class="bar-txt">已上传</span>
								    </div>
								    <a class="dlt"><i class="mis-delete-ico1"></i>删除</a>
								</li>
						    </ul>
		                </div>
	                </div>
	            </div>
	        </li>
		</ul>
		<div id="fileParam"></div>
		<div class="mis-btn-row indent1">
            <button onclick="saveTrain()" type="button" class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
        </div>
	</div>
</form>

<li id="fileLiTemplet" class="fileLi" style="display:none;">
    <i class="mis-sfile-ico "></i>
    <a class="name fileName" title="">二元二次方程教学方案.doc</a>
    <span class="size"></span>
    <div class="mis-pbar">
        <div class="bar"><div class="yet" style="width: 50%;"><span class="barNum">50%</span></div></div>
        <span class="bar-txt">上传中....</span>
    </div>
    <a class="dlt"><i class="mis-delete-ico1"></i>删除</a>
</li>
<script type="text/javascript">
	$(function(){
		$('.mis-radio-tick input').bindCheckboxRadioSimulate();
		
		initUploader($('#zcwj'));
		initUploader($('#ssfa'));
		initUploader($('#khfa'));
	});

	function saveTrain() {
		if(!$('#saveTrainForm').validate().form()){
			return false;
		}
		initFileParam();
		var data = $.ajaxSubmit('saveTrainForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_tabs_update('listTrainForm','layout_center_tabs');
				easyui_modal_close('editTrainDiv');
			});
		}
	}
	
	function initUploader(btn){
		var fileTypeLimit = 'doc,docx,pdf';
		var uploader = WebUploader.create({
        		swf : '/common/js/webuploader/Uploader.swf',
        		server : '${ctx}/file/uploadTemp',
        		pick : btn,
        		resize : true,
        		duplicate : true,
        		accept : {
        		    extensions: fileTypeLimit
        		}
        	});
        	// 当有文件被添加进队列的时候
        	uploader.on('fileQueued', function(file) {
        		var $li = $('#fileLiTemplet').clone();
        		$li.attr('id', file.id).addClass('fileItem').show();
        		$li.find('.fileName').text(file.name);
        		$(btn).closest('.fileDiv').find(".fileList").empty();
        		$(btn).closest('.fileDiv').find(".fileList").append($li);
        		uploader.upload();
        	});
        	// 文件上传过程中创建进度条实时显示。
        	uploader.on('uploadProgress', function(file, percentage) {
        		var $li = $('#' + file.id), $bar = $li.find('.bar');
        		var progress = Math.round(percentage * 100);
        		$bar.find('.yet').css('width', progress + '%');
        		$bar.find('.barNum').text(progress + '%');
        		$bar.closest('.bar-txt').text('上传中');
        	});
        	uploader.on('uploadSuccess', function(file, response) {
        		if (response != null && response.responseCode == '00') {
        			$('#' + file.id).find('.mis-pbar').addClass('finish');
        			$('#' + file.id).find('.bar-txt').text('已上传');
        			var fileInfo = response.responseData;
        			$('#' + file.id).attr('fileId', fileInfo.id);
        			$('#' + file.id).attr('url', fileInfo.url);
        			$('#' + file.id).attr('fileName', fileInfo.fileName);
        			$('#' + file.id).addClass('success');
        		}
        	});
        	uploader.on('uploadError', function(file) {
        		$('#' + file.id).find('.mis-pbar').addClass('error');
        		$('#' + file.id).find('.bar-txt').text('上传出错');
        	});
        	uploader.on('uploadComplete', function(file) {
        		$('#' + file.id).find('.progress').fadeOut();
        	});
        	$(btn).closest('.fileDiv').find(".fileList").on('click', '.dlt', function() {
        		var _this = $(this);
        		confirm('是否确定删除该附件?',function(){
        			if ($(this).parents('.fileLi').hasClass('fileItem')) {
        				uploader.removeFile($(this).parents('.fileLi').attr('id'));
        			}
        			_this.parents('.fileLi').remove();
        		});
        	});
        	uploader.on('error', function(type) {
        		if (type == 'Q_TYPE_DENIED') {
        			alert('请检查上传的文件类型');
        		}
        	}); 
	}
	

	function initFileParam(){
		var fileInfos = $('.fileLi.success');
		var fileParam = $('#fileParam');
		fileParam.empty();
		$.each(fileInfos,function(i,n){
			fileParam.append('<input type="hidden" name="<#if app_path = "/nts/nea" || app_path = "/nts/lego">train.</#if>fileInfos['+i+'].id" value="'+$(n).attr("fileid")+'">');
			fileParam.append('<input type="hidden" name="<#if app_path = "/nts/nea" || app_path = "/nts/lego">train.</#if>fileInfos['+i+'].fileName" value="'+$(n).attr("fileName")+'">');
			fileParam.append('<input type="hidden" name="<#if app_path = "/nts/nea" || app_path = "/nts/lego">train.</#if>fileInfos['+i+'].url" value="'+$(n).attr("url")+'">');
			fileParam.append('<input type="hidden" name="<#if app_path = "/nts/nea" || app_path = "/nts/lego">train.</#if>fileInfos['+i+'].fileRelations[0].type" value="'+$(n).closest("ul").attr("ftype")+'">');
		});
	}
</script>