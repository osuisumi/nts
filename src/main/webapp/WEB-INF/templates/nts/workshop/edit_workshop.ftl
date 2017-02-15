<form id="saveWorkshopForm" action="${ctx}/manage/workshop" method="post">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	
	<span id="masterParam" style="display:none">
	</span>
	
	<span id="memberParam" style="display:none">
	</span>
	
	<#if (workshop.id)??>
		<script>
			$('#saveWorkshopForm').attr('method','put').attr('action', '${ctx }/manage/workshop/${(workshop.id)!}/update');
		</script>
		<#else>
		<input type="hidden" name="state" value="editing">
		<input type="hidden" name="type" value="train">
		<input type="hidden" name="workshopRelation.relation.id" value="noTrain">
		<input type="hidden" name="isTemplate" value="Y">
	</#if>
	
	<div class="mis-srh-layout">
    	<ul class="mis-ipt-lst">
			<li class="item w1">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>封面图片：</span>
                    </div>
					<div id="imageDiv" class="mis-uplad-Aclayer" style="padding:0px;text-align:left">
						<#import "/nts/common/upload_image_temp.ftl" as ui />
						<@ui.uploadImageFtl divId="imageDiv" relationId=(workshop.id)! paramName="image" paramType="entity" fileNumLimit=1 fileTypeLimit="jpg,jpeg,png" />
					</div>
                </div>
            </li>
			<li class="item w1">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>工作坊名称：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="title"  value="${(workshop.title)!}" placeholder="请输入名称..." class="mis-ipt required">
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item w1">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>简介：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text"  name="summary" value="${(workshop.summary)!}" placeholder="" class="mis-ipt">
	                    </div>
	                </div>
	            </div>
	       	 </li>
 	        <li class="item item-twoIpu">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>学科/学段：</span>
                    </div>
                    <div class="center">
                        <div class="tc">
							<div class="mis-select">
	                            <select name="stage">
	                               ${TextBookUtils.getEntryOptionsSelected('STAGE', (workshop.stage)!'') }
	                            </select>    
	                        </div>
                        </div>
                        <span class="to"></span>
                        <div class="tc">
							<div class="mis-select">
	                            <select name="subject">
	                                ${TextBookUtils.getEntryOptionsSelected('SUBJECT', (workshop.subject)!'') }
	                            </select>    
	                        </div>
                        </div>                                            
                    </div>
                </div>
            </li>
	        
		</ul>
		<div class="mis-btn-row indent1">
            <button onclick="saveWorkshop()" type="button" class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
        </div>
	</div>
</form>
<script type="text/javascript">

	function saveWorkshop() {
		if(!$('#saveWorkshopForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('saveWorkshopForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_tabs_update('listWorkshopForm','layout_center_tabs')
				easyui_modal_close('editWorkshopDiv');
			});
		}
	}
	
	
	function initMasterParam(){
		var masterParam = $('#masterParam');
		masterParam.empty();
		$('#masterList li a').each(function(i){
			masterParam.append('<input type="hidden" name="masters['+i+'].user.id" value="'+$(this).attr("uid")+'" />');
			masterParam.append('<input type="hidden" name="masters['+i+'].state" value="passed" />');
		});
	}
	
	function initMemberParam(){
		var memberParam = $('#memberParam');
		memberParam.empty();
		$('#memberList li a').each(function(i){
			memberParam.append('<input type="hidden" name="members['+i+'].user.id" value="'+$(this).attr("uid")+'" />');
			memberParam.append('<input type="hidden" name="members['+i+'].state" value="passed" />');
		});
	}
</script>