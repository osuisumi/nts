<form id="saveAnnouncementForm" action="${ctx}/manage/announcement" method="post">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<#if (announcement.id)??>
		<script>
			$('#saveAnnouncementForm').attr('method','put').attr('action', '${ctx }/manage/announcement/${(announcement.id)!}');
		</script>
	<#else>
		<input type="hidden" name="announcementRelations[0].relation.type" value="userCenter">
	</#if>
	<div class="mis-srh-layout">
    	<ul class="mis-ipt-lst">
    		<li class="item w1" >
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>标题：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="title" value="${(announcement.title)!}" placeholder="请输入标题..." class="mis-ipt ">
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item w1">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>内容：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <script id="editor" type="text/plain" style="width:100%; height:370px;"></script>
							<input id="announcementContent" name="content" type="hidden">
	                    </div>
	                </div>
	            </div>
	        </li>
	        <#if ((announcement.announcementRelations[0].relation.type)!'') != 'workshop'>
	        <li class="item w1">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>发布范围：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-select">
	                        <select name="announcementRelations[0].relation.id" value="${(announcement.announcementRelations[0].relation.id)!}">
	                            <option value="system">请选择...</option>
								<@trains>
									<#list trains as train>
										<option value="${(train.id)!}" <#if (announcement.announcementRelations[0].relation.id)! == (train.id)!>selected="selected"</#if> >${(train.name)!}</option>
									</#list>
								</@trains>
	                        </select>    
	                    </div>
	                </div>
	            </div>
	        </li>
	        </#if>
	        <#if ((announcement.announcementRelations[0].relation.type)!'') != 'workshop'>
	        <li class="item w1">
	        	<div class="mis-ipt-row">
	            	<div class="tl">
	                    <span>类型：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-select">
	                        <select name="type" value="${(announcement.type)!}">
	                            <option value="">请选择...</option>
	                            <option value="system_announcement">通知公告</option>
	                            <option value="train_report">培训简报</option>
	                        </select>  
	                        <script>
	                        	$(function(){
	                        		var type = '${(announcement.type)!}';
	                        		if(type != ''){
	                        			$("select[name=type]").val(type);
	                        		}
	                        	});
	                        </script>
	                    </div>
	                </div>
	            </div>
	        </li>
	        </#if>
	        <li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>附件：</span>
	                </div>
	                <div class="tc">
		                <div id="fileDiv">
		                	<#import "/nts/common/upload_file_list.ftl" as uploadFileList />
							<@uploadFileList.uploadFileListFtl relationId="${announcement.id!}" paramName="fileInfos" />
		                </div>
	                </div>
	            </div>
	        </li>
    	</ul>
	</div>
	<div class="mis-btn-row indent1">
        <button onclick="saveAnnouncement()" type="button" class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
    </div>    
</form>

<script type="text/javascript">
	var ue = initProduceEditor('editor', '${(announcement.content)!}', '${(Session.loginer.id)!}');

	function saveAnnouncement() {
		if(!$('#saveAnnouncementForm').validate().form()){
			return false;
		}
		var content = ue.getContent();
		if(content.length == 0){
			alert("提示信息","内容不能为空");
			return;
		}
		$('#announcementContent').val(content);
		
		
		var relationId = $("select[name='announcementRelations[0].relation.id']").val(); 
		
		if(relationId != null && relationId != undefined){
			if(relationId == 'system'){
				$('input[name="announcementRelations[0].relation.type"]').val('');
			}else{
				$('input[name="announcementRelations[0].relation.type"]').val('userCenter');
			}
		}
		
		var data = $.ajaxSubmit('saveAnnouncementForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_tabs_update('listAnnouncementForm','layout_center_tabs')
				easyui_modal_close('editAnnouncementDiv');
			});
		}
	}
	
</script>