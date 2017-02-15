<form id="editClassUserForm" action="${ctx}/manage/train/class/prepare_add_user"  method="post">
	<input type="hidden" name="classId" value="${(classId[0])!}">
	<input type="hidden" name="trainId" value="${(trainId[0])!}">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<div class="mis-content">
	    <div class="mis-course-Manachoose">
	        <div class="mis-stPower-innerBox">
	            <div class="mis-stPower-innerL fl" style="max-height: 960px; min-height: 400px; overflow: auto;">
	                <dl id="allList">
	                    <dt>
	                  		全部学员
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
	                                <input type="text" name="realName" value="${realName!}"  placeholder="输入姓名查找">  
	                                <button type="button" onclick="$.ajaxQuery('editClassUserForm','class_prepare_add_user_div')" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
	                                <button type="reset" onclick="resetClassUser()" class="mis-btn mis-inverse-btn"><i class="mis-refresh-ico"></i>重置</button>
	                            </div>                                                
	                        </div>
	                    </dt>
	                    <div id="class_prepare_add_user_div">
	                    	<script>
	                    	$(function(){
	                    		$('#class_prepare_add_user_div').load('${ctx}/manage/train/class/prepare_add_user?trainId=${(trainId[0])!}');
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
						<dt>班级学员,已分配<span class="red" id="hasNum"></span>人</dt>
                        <@trainRegisterExtendsDirective classId=(classId[0])! state="pass" trainIn=(trainId[0])!>
                        	<#assign hasSourceIds = ''>
		 					<#list trainRegisterExtends as tre>
		 						<!-- 改动 -->
                          		<dd class="${tre.id}" sourceId="${tre.id}" branchId="${tre.id}">
                 					${(tre.userInfo.realName)! }
                                   <a href="javascript:;" class="mis-btn mis-inverse-btn mis-btn-move" ><i class="mis-delete-ico"></i>删除</a>
                               </dd>
                               <#assign hasSourceIds = hasSourceIds + ',' + tre.id>
                          	</#list>
                        </@trainRegisterExtendsDirective>
                   </dl>
                </div>
	        </div>
            <div class="mis-course-Manachoose-btn">
                <button onclick="saveClassUser()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-next-ico"></i>保存</button>
            </div>
	    </div>
	</div>  
</form>

<form id="saveClassUserForm" action="${ctx}/train/class/saveClassUser" method="post">
	<input type="hidden" name="trainId" value="${(trainId[0])!}" >
	<input type="hidden" name="trainRegisterIds">
	<input type="hidden" name="classId" value="${(classId[0])!}">
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

	function saveClassUser(){
		var userIds = '';
		$.each($('#hasList dd'),function(i,n){
			if(userIds == ''){
				userIds = $(n).attr('branchid');
			}else{
				userIds = userIds + "," + $(n).attr('branchid');
			}
		});
		$('#saveClassUserForm input[name="trainRegisterIds"]').val(userIds);
		var data = $.ajaxSubmit('saveClassUserForm');
		var json = $.parseJSON(data);
		if(json.responseCode == '00'){
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				closeNowPageAndrefreshParent('editClassUserForm');
			});
		}
		
	}
	
	function resetClassUser(){
		$(':input','#editClassUserForm')  
		 .not(':button, :submit, :reset, :hidden')  
		 .val('')  
		 .removeAttr('checked')  
		 .removeAttr('selected');
		$('.simulateSelect-text').text('请选择');
		 $.ajaxQuery('editClassUserForm','class_prepare_add_user_div');
	}

</script>