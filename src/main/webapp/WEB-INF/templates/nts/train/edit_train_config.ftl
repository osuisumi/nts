<form id="saveTrainConfigForm" action="${ctx}/manage/train/${train.id}" method="put">
	<input type="hidden" name="studyHoursType" value="${(train.studyHoursType)!'' }">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	
	<@trainDirective id=train.id >
		<#assign train=trainModel>
	</@trainDirective>
	<div class="mis-content">
		<ul class="mis-course-config">
		    <li class="mis-course-configLi">
		        <h3 class="tl">
		            <span class="num">1.</span>
		            <span>请选择培训方式：</span>
		        </h3>
		        <ul class="mis-course-config-cont">
		            <li>
		                <div class="course-pic">
		                    <i></i>                                            
		                </div>
		                <label class="mis-checkbox">
		                    <strong>
		                        <i class="ico"></i>
		                        <input type="checkbox" name="type" class="trainTypeCheckbox" value="course" txt="在线课程" <#if ((train.type)!'')?contains('course')>checked</#if>>
		                    </strong>
		                    <span>在线课程</span>
		                </label>                                                                               
		            </li>
		            <li>
		                <div class="course-pic course-pic2">
		                    <i></i>                                            
		                </div>
		                <label class="mis-checkbox">
		                    <strong>
		                        <i class="ico"></i>
		                        <input type="checkbox" name="type" class="trainTypeCheckbox" value="workshop" txt="工作坊" <#if ((train.type)!'')?contains('workshop')>checked</#if>>
		                    </strong>
		                    <span>工作坊</span>
		                </label>                                                                               
		            </li>
		            <li>
		                <div class="course-pic course-pic3">
		                    <i></i>                                            
		                </div>
		                <label class="mis-checkbox">
		                    <strong>
		                        <i class="ico"></i>
		                        <input type="checkbox" name="type" class="trainTypeCheckbox"  value="community" txt="研修社区" <#if ((train.type)!'')?contains('community')>checked</#if>>
		                    </strong>
		                    <span>研修社区</span>
		                </label>                                                                               
		            </li>                                    
		        </ul>
		        <div class="mis-course-configTxt">
		          	   您选择了： <span id="trainTypeTxt"></span>
		        </div>
		    </li>
		    <li class="mis-course-configLi">
		        <h3 class="tl">
		            <span class="num">2.</span>
		            <span>请选择有效学时计算方式：</span>
		        </h3> 
		        <div class="mis-course-config-cont2">
		            <label class="mis-radio-tick">
		                <strong>
		                    <i class="ico"></i>
		                    <input type="radio" name="sh" class="studyHoursType" value="no_limit" <#if 'no_limit' = (train.studyHoursType)!"">checked</#if>>
		                </strong>
		                <span>累计学时，学员选修不设限制，学时可累计提交。</span>
		            </label>     
		            <br>
		            <label class="mis-radio-tick">
		                <strong>
		                    <i class="ico"></i>
		                    <input type="radio" name="sh" class="studyHoursType" value="limit" <#if 'no_limit' != (train.studyHoursType)!"">checked</#if>>
		                </strong>
		                <span>指定学时，学员选修指定达标总学时，并按要求完成学时选修。</span>
		            </label>                                                                               
		            <div id="studyHoursTypeDiv" class="mis-course-configTxt">
		                <span class="hd">指定学时要求：</span>
		                <p>  本次培训学员必须完成所有的学时，并按以下要求完成学时选修（超出学时不进行累加计算）：</p>
		                <ul>
		                    <li class="mis-choosecourse-config studyHoursLi" id="course_studyHours_li" style="display: none;">
		                        <i></i>
		                        <span class="score">在线课程学习达到</span>
		                        <input type="text" value="0" class="{number:true, required:true}" key="course" />
		                        <span>学时</span>
		                    </li>
		                    <li class="mis-choosecourse-config studyHoursLi" id="workshop_studyHours_li" style="display: none;">
		                        <i></i>
		                        <span class="score">工作坊研修达到</span>
		                        <input type="text" value="0" class="{number:true, required:true}" key="workshop"/>
		                        <span>学时</span>
		                    </li>    
		                    <li class="mis-choosecourse-config studyHoursLi" id="community_studyHours_li" style="display: none;">
		                        <i></i>
		                        <span class="score">研修社区实践达到 </span>
		                        <input type="text" value="0" class="{number:true, required:true}" key="community"/>
		                        <span>学时</span>
		                    </li>      
		                    <li class="mis-choosecourse-config">
		                        <i></i>
		                        <span class="score">培训学员总学时</span>
		                        <span id="totalStudyHours">0</span>
		                        <span>学时</span>
		                    </li>                                                                              
		                </ul>
		            </div>                                   
		        </div>
		    </li>
		    <li class="mis-course-configLi">
		        <button onclick="saveTrainConfig()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-next-ico"></i>保存并进入下一步</button>
		    </li>
		</ul>
	</div>
</form>
<script type="text/javascript">
	$(function(){
		//多选按钮模拟
		$('.mis-checkbox input').bindCheckboxRadioSimulate();
		$('.mis-radio-tick input').bindCheckboxRadioSimulate();
		
	    //填写学时
	    getStudyHours();
	    //选择培训方式
	    chooseTrainType();
		//选择学时方式
		chooseStudyHoursType();
	});
	
	function getStudyHours(){
		var $input = $('.mis-choosecourse-config input');
		$input.keyup(function(){
			if(!$('#saveTrainConfigForm').validate().form()){
				return false;
			}
			var studyHours = 0;
			$input.each(function(){
				studyHours = studyHours + parseFloat($(this).val());
			});
			$('#totalStudyHours').text(studyHours);
		});
	}
	
	function chooseStudyHoursType(){
		$(':radio.studyHoursType').click(function(){
			if($(this).val() == 'no_limit'){
				$('#studyHoursTypeDiv').hide();
			}else{
				$('#studyHoursTypeDiv').show();
			}
		});
		if('${(train.studyHoursType)!""}' == 'no_limit'){
			$('#studyHoursTypeDiv').hide();
		}else{
			var json = $.parseJSON('${(train.studyHoursType)!"{}"}');
			if(json.course != null){
				$('.studyHoursLi input[key="course"]').val(json.course);
			}
			if(json.workshop != null){
				$('.studyHoursLi input[key="workshop"]').val(json.workshop);
			}
			if(json.community != null){
				$('.studyHoursLi input[key="community"]').val(json.community);
			}
			$('.studyHoursLi input[key="course"]').trigger('keyup');
		}
	}
	
	function chooseTrainType(){
		getTrainTypeTxt();
		$(':checkbox[name=type]').click(function(){
			getTrainTypeTxt();
		});
		
		function getTrainTypeTxt(){
			if($(':checkbox[name=type]:checked').length > 0){
				var txt = '';
				$('.studyHoursLi').hide();
				$(':checkbox[name=type]:checked').each(function(){
					txt = txt + $(this).attr('txt') + ' + ';
					$('#'+$(this).val()+'_studyHours_li').show();
				});
				txt = txt.substring(0, txt.length - 3) + ' ，共'+$(':checkbox[name=type]:checked').length+'种混合培训方式';
				$('#trainTypeTxt').text(txt);
			}
		}
	}
	
	function saveTrainConfig(){
		if(!$('#saveTrainConfigForm').validate().form()){
			return false;
		}
		if($(':checkbox[name=type]:checked').length == 0){
			alert('培训方式至少选择一项');
			return false;
		}
		var studyHoursType = $('.studyHoursType:checked').val();
		if(studyHoursType == 'limit'){
			studyHoursType = '{';
			$('.studyHoursLi input').each(function(){
				var key = $(this).attr('key');
				var studyHours = $(this).val();
				studyHoursType = studyHoursType + '"'+key+'"'+':"'+studyHours+'"'+',';
			});
			studyHoursType = studyHoursType.substring(0, studyHoursType.length-1) + '}';
		}
		$('#saveTrainConfigForm input[name="studyHoursType"]').val(studyHoursType);
		var data = $.ajaxSubmit('saveTrainConfigForm');
		var json = $.parseJSON(data);
		if(json.responseCode == '00'){
			var itemName = '';
			var url = '';
			if($('.trainTypeCheckbox[value="course"]').prop('checked')){	
				itemName = '配置课程';
				url = '/manage/courseRelation/create?relationId=${train.id}';
			}else if($('.trainTypeCheckbox[value="workshop"]').prop('checked')){
				itemName = '配置工作坊';
				url = '/manage/train/editTrainWorkshop?id=${train.id}';
			}else if($('.trainTypeCheckbox[value="community"]').prop('checked')){
				itemName = '配置社区';
				url = '/manage/nts/cmts/community/relation/edit?relation.id=${train.id}';
			}
			load_next_content(url, 'saveTrainConfigForm', itemName);
		}else{
			alert('操作失败, 请稍后再试');
		}
	}
</script>