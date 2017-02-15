<form id="editWorkshopUserForm" action="${ctx}/manage/train/workshop/preapre_add_user"  method="get">
	<input type="hidden" name="role" value="${role}">
	<input type="hidden" name="trainId" value="${trainId!}">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<#if trainId??>
		<@trainDirective id=trainId!>
			<#if trainModel??>
				<#assign train=trainModel>
			</#if>
		</@trainDirective>
	</#if>
	<div class="mis-content">
	    <div class="mis-course-Manachoose">
	    	<#if train??>
		        <div class="mis-course-Manachoose-tl">
		            <i></i>
		          	${(train.name)! }
		        </div>
	        </#if>
	        <div class="mis-stPower-innerBox">
	            <div class="mis-stPower-innerL fl" style="max-height: 960px; min-height: 400px; overflow: auto;">
	                <dl id="allList">
	                    <dt>
	                    	<#if role == 'student'>
	                    		 全部学员
	                    	<#elseif role == 'master'>
	                    		全部坊主
	                    	<#else>
	                    		全部助学
	                    	</#if>
	                        <div class="course-ManastPower-srh">
	                            <div class="mis-btn mis-main-btn stPower-srh">
	                                <i class="mis-srh-ico"></i>
	                            </div>
	                            <div class="mis-course-Machoose-serch">
									<div class="mis-selectbox">
										<strong><span class="simulateSelect-text">请选择省</span><i class="trg"></i></strong>
										<select id="province" name="province">
											<option class="static" value="" >请选择省</option>
											${RegionsUtils.getEntryOptionsSelected('1',(province[0])!)}
										</select>
									</div>
									<div class="mis-selectbox">
										<strong><span class="simulateSelect-text">请选择市</span><i class="trg"></i></strong>
										<select id="city" name="city">
											<option class="static" value="" >请选择市</option>
											<#if (province[0])??>
												${RegionsUtils.getEntryOptionsSelected('2',province[0],(city[0])!)}
											</#if>
										</select>
									</div>
									<div class="mis-selectbox">
										<strong><span class="simulateSelect-text">请选择区</span><i class="trg"></i></strong>
										<select id="area" name="counties">
											<option class="static" value="" >请选择区</option>
											<#if (city[0])??>
												${RegionsUtils.getEntryOptionsSelected('3',city[0],(counties[0])!)}
											</#if>
										</select>
									</div>
									<div class="mis-selectbox">
										<strong><span class="simulateSelect-text">请选学段</span><i class="trg"></i></strong>
										<select id="stage" name="stage">
											<option class="static" value="" >请选学段</option>
												${TextBookUtils.getEntryOptionsSelected('STAGE',(stage[0])!)}
										</select>
									</div>
									<div class="mis-selectbox">
										<strong><span class="simulateSelect-text">请选学科</span><i class="trg"></i></strong>
										<select id="subject" name="subject">
											<option class="static" value="" >请选学科</option>
												${TextBookUtils.getEntryOptionsSelected('SUBJECT',(subject[0])!)}
										</select>
									</div>
	                               	<input type="text" name="realName" value="${realName!}"  placeholder="输入姓名查找"> 
	                                <button type="button" onclick="$.ajaxQuery('editWorkshopUserForm','workshop_prepare_add_user')" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
	                                <button type="reset" onclick="resetWorkshopUser()" class="mis-btn mis-inverse-btn"><i class="mis-refresh-ico"></i>重置</button>
	                            </div>                                                
	                        </div>
	                    </dt>
	                   <div id="workshop_prepare_add_user">
	                   		<script>
	                   			$(function(){
	                   				$('#workshop_prepare_add_user').load('${ctx}/manage/train/workshop/preapre_add_user?role=${role}&trainId=${trainId!}');
	                   			});
	                   		</script>
	                   </div>
	                </dl>
	            </div>
                <div class="mis-stPower-arrow fl">
                    <span class="arrow"></span>
                </div>
                <div class="mis-stPower-innerR fr">
                    <dl id="hasList">
                    	<#if role == 'student'>
                    		<dt>工作坊学员,已选<span class="red" id="hasNum"></span>人</dt>
                    	<#elseif role == 'master'>
                    		<dt>工作坊坊主,已授权<span class="red" id="hasNum"></span>人</dt>
                    	<#elseif role == 'member'>
                    		<dt>工作坊助理坊主,已授权<span  class="red"id="hasNum"></span>人</dt>
                    	</#if>
                        <@workshopUsersDirective workshopId=workshopId role=role state="passed">
                        	<#assign hasSourceIds = ''>
		 					<#list workshopUsers as wu>
		 						<!-- 改动 -->
                          		<dd class="${wu.user.id }" sourceId="${wu.user.id }" branchId="${wu.user.id }">
                 					${(wu.user.realName)! }
                                   <a href="javascript:;" class="mis-btn mis-inverse-btn mis-btn-move" ><i class="mis-delete-ico"></i>删除</a>
                               </dd>
                               <#assign hasSourceIds = hasSourceIds + ',' + wu.user.id>
                          	</#list>
                        </@workshopUsersDirective>
                   </dl>
                </div>
	        </div>
            <div class="mis-course-Manachoose-btn">
                <button onclick="saveStudent()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-next-ico"></i>保存</button>
            </div>
	    </div>
	</div>  
</form>

<form id="saveWorkshopUserForm" action="${ctx}/manage/workshopUser/saveWorkshopUsers" method="post">
	<input type="hidden" name="workshopId" value="${(workshopId)!}" >
	<input type="hidden" name="userIds">
	<input type="hidden" name="role" value="${role}">
</form>
<script>
	$(function(){
		//显示搜索模块
	    showCourseSelectbox();
		
		//模拟下拉框
	    $(".mis-selectbox select").each(function(){
	    	var _this = $(this);
	    	$(this).simulateSelectBox({
	    		byValue:_this.find('option[selected="selected"]').attr('value'),
	    	});
	    });
	    //省市区联动
	    $('#province').on('change',function(){
	    	var _this = $(this);
	    	$.get('${ctx}/regions/entities',{
	    		"level":'2',
	    		"parentCode":_this.val(),
	    	},function(regions){
	    		$('#city .cityOption').remove();
	    		$('#city .static').attr('selected','selected');
	    		$('#city').parent().find('.simulateSelect-text').text($('#city').find('option:selected').text());
	    		$('#city').trigger('change');
	    		$.each(regions,function(i,n){
	    			$('#city').append('<option class="cityOption" value="'+n.regionsCode+'" >'+n.regionsName+'</option>');
	    		});
	    	});
	    });
	    
	    $('#city').on('change',function(){
	    	var _this = $(this);
	    	$.get('${ctx}/regions/entities',{
	    		"level":'3',
	    		"parentCode":_this.val(),
	    	},function(regions){
	    		$('#area .areaOption').remove();
	    		$('#area .static').attr('selected','selected');
	    		$('#area').parent().find('.simulateSelect-text').text($('#area').find('option:selected').text());
	    		$.each(regions,function(i,n){
	    			$('#area').append('<option class="areaOption" value="'+n.regionsCode+'" >'+n.regionsName+'</option>');
	    		});
	    	});
	    });
	    
	});

	function saveStudent(){
		var userIds = '';
		$.each($('#hasList dd'),function(i,n){
			if(userIds == ''){
				userIds = $(n).attr('branchid');
			}else{
				userIds = userIds + "," + $(n).attr('branchid');
			}
		});
		$('#saveWorkshopUserForm input[name="userIds"]').val(userIds);
		var data = $.ajaxSubmit('saveWorkshopUserForm');
		var json = $.parseJSON(data);
		if(json.responseCode == '00'){
			alert('提交成功');
			easyui_window_update('editWorkshopStudentForm','listTrainRegisterDiv');
		}
		
	}
	
	
	function resetWorkshopUser(){
		$(':input','#editWorkshopUserForm')  
		 .not(':button, :submit, :reset, :hidden')  
		 .val('')  
		 .removeAttr('checked')  
		 .removeAttr('selected');
		$('.simulateSelect-text').text('请选择');
		 $.ajaxQuery('editWorkshopUserForm','workshop_prepare_add_user');
	}
</script>

