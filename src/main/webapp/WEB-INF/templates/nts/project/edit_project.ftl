<form id="saveProjectForm" action="${ctx}/project" method="post">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	
	<#if project??>
		<script>
			$(function(){
				$('#saveProjectForm').attr('method','put');
				$('#saveProjectForm').attr('action','${ctx}/project?id=${project.id}');
			});
		</script>
	</#if>
	
	<div class="mis-srh-layout">
    	<ul class="mis-ipt-lst">
			<li class="item w1">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>项目名称：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input style="width:400px" type="text" name="name" value="${(project.name)!}" placeholder="请输入名称..." class="mis-ipt required">
	                    </div>
	                </div>
	            </div>
	        </li>
            <li class="item">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>项目类型：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-select">
                            <select name="type" style="width:200px" >
                            	${DictionaryUtils.getEntryOptionsSelected('PROJECT_TYPE',(project.type)!'')}
                            </select>    
                        </div>
                    </div>
                </div>
            </li>
            <li class="item">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>项目级别：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-select">
                            <select name="projectLevel" style="width:200px" >
                            	${DictionaryUtils.getEntryOptionsSelected('AREA_LEVEL',(project.projectLevel)!'')}
                            </select>    
                        </div>
                    </div>
                </div>
            </li>
	        
	        <li class="item item-twoIpu">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>执行时间：</span>
                    </div>
                    <div class="center">
                        <div class="tc">
                            <div class="mis-ipt-mod">
                                <input name="timePeriod.startTime" required type="text" value="${(project.timePeriod.startTime?string("yyyy-MM-dd"))!}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="mis-ipt">
                            </div>
                        </div>
                        <span class="to">至</span>
                        <div class="tc">
                            <div class="mis-ipt-mod">
                                <input name="timePeriod.endTime" required type="text" value="${(project.timePeriod.endTime?string("yyyy-MM-dd"))!}" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="mis-ipt" >
                            </div>
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
		                <div id="fileDiv">
		                	<#import "/nts/common/upload_file_list.ftl" as uploadFileList />
							<@uploadFileList.uploadFileListFtl relationId="${(project.id)!}" paramName="fileInfos" relationType="project_files" />
		                </div>
	                </div>
	            </div>
	        </li>
            
	        <li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>项目简介：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                   		<textarea class="mis-textarea valid required" placeholder="输入项目简介" name="description">${(project.description)!}</textarea>
	                    </div>
	                </div>
	            </div>
	        </li>
	        
			<li class="item w1">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>宣传图片：</span>
                    </div>
					<div id="imageDiv" class="mis-uplad-Aclayer" style="padding:0px;text-align:left">
						<#import "../common/upload_image_temp.ftl" as ui />
						<@ui.uploadImageFtl divId="imageDiv" relationId=(project.id)! paramName="fileInfo" paramType="entity" fileNumLimit=1 fileTypeLimit="jpg,jpeg,png" relationType="cms-project-weixinqrcode" />
					</div>
                </div>
            </li>
	        
            <li class="item" id="courseTimeTr" <#if (course.id)?? && ('lead' != (course.type)!'')>style="display:none;"</#if>>
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>介绍视频：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="introVideo" value="${(project.introVideo)!}" placeholder="请输入介绍视频地址" class="mis-ipt">
	                    </div>
	                </div>
	            </div>
	        </li>
		</ul>
		<div class="mis-btn-row indent1">
            <button onclick="saveProject()" type="button" class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
        </div>
	</div>
</form>
<script type="text/javascript">
	$(function(){
		//$('#imageDiv .webuploader-pick').css('height','80px');;
	});

	function saveProject() {
		if(!$('#saveProjectForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('saveProjectForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_tabs_update('listProjectForm','layout_center_tabs')
				easyui_modal_close('editProjectDiv');
			});
		}
	}
	
</script>