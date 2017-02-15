<form id="saveExtendWorkshopForm" action="${ctx}/manage/train/workshop/saveExtendWorkshop/${workshopId}" method="post">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<@workshopDirective id=workshopId>
		<input type="hidden" name="relationId" value="${(workshop.workshopRelation.relation.id)!}">
		<@trainDirective id=(workshop.workshopRelation.relation.id)!''>
			<#assign train=trainModel>
		<div class="mis-srh-layout">
	    	<ul class="mis-ipt-lst" id="extendList">
				<li class="item w1">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>所属项目：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-ipt-mod">
		                        <#if (train.project.id)??>
		                        	<@projectDirective id=train.project.id>
		                        		${(project.name)!}
		                        	</@projectDirective>
		                        </#if>
		                    </div>
		                </div>
		            </div>
		        </li>
				<li class="item w1">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>所属培训：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-ipt-mod">
		                        <#if train??>
		                        	${(train.name)!}
		                        </#if>
		                    </div>
		                </div>
		            </div>
		        </li>
				<li class="item w1">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>工作坊名称：</span>
		                </div>
		                <div class="tc">
		                    <div id="workshopTitle" class="mis-ipt-mod">
		                       ${(workshop.title)!}
		                    </div>
		                </div>
		            </div>
		        </li>
				<li class="item w1">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>分坊数量：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-ipt-mod">
		                       <input id="extendNum" required min="1" style="width:300px" type="text" name="extendNum" value="" placeholder="" class="mis-ipt">
		                    </div>
		                </div>
		            </div>
		        </li>
				<li id="extendModel" class="item w1" style="display:none">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span class="title"></span>
		                </div>
		                <div class="tc">
		                    <div class="mis-ipt-mod">
		                       <input style="width:300px" type="text" value="${(workshop.title)!}" placeholder="" class="mis-ipt extendTitle">
		                    </div>
		                </div>
		            </div>
		        </li>
			</ul>
			<div class="mis-btn-row indent1">
	            <button onclick="saveExtendWorkshop()" type="button" class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
	        </div>
		</div>
		</@trainDirective>
	</@workshopDirective>
</form>

<script>
	$(function(){
		$('#extendNum').on('keyup',function(){
			var num = parseInt($('#extendNum').val());
			if(num){
				$('.extendWorkshop').remove();
				for(var i=1;i<=num;i++){
					var $extendW = $('#extendModel').clone();
					$extendW.attr('style','');
					$extendW.addClass('extendWorkshop');
					$extendW.find('.title').text('工作坊' + i + ':');
					$extendW.find('.extendTitle').val($extendW.find('.extendTitle').val() + i);
					$extendW.find('.extendTitle').addClass('required');
					$extendW.find('.extendTitle').attr('name','title' + i);
					$extendW.find('.extendTitle').addClass('submitTitle');
					$('#extendList').append($extendW);
				}
			}
		});
	});
	
	function saveExtendWorkshop(){
		if(!$('#saveExtendWorkshopForm').validate().form()){
			return false;
		};
		$('.submitTitle').attr('name','extendNames');
		var response = $.ajaxSubmit('saveExtendWorkshopForm');
		var json = $.parseJSON(response);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
					
			});
		}
		
	}
	
</script>