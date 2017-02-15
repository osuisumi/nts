<form id="listPrepareUserForm" action="${ctx}/manage/course/listPrepareUser" method="post">
	<input type="hidden" name="role" value="${courseAuthorize.role}">
	<input type="hidden" name="trainId" value="${(trainId[0])!}">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<#if (trainId[0])??>
		<@trainDirective id=(trainId[0])!''>
			<#assign train=trainModel>
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
	                    	<#if 'maker' == (courseAuthorize.role)!''>
	                    		 全部制作教师
	                    	<#elseif 'teacher' == (courseAuthorize.role)!''>
	                    		全部助学教师
	                    	<#else>
	                    		全部辅导教师
	                    	</#if>
	                        <div class="course-ManastPower-srh">
	                            <div class="mis-btn mis-main-btn stPower-srh">
	                                <i class="mis-srh-ico"></i>
	                            </div>
	                            <div class="mis-course-Machoose-serch">
	                                <input type="text" name="realName" placeholder="输入姓名查找">  
	                                <button type="button" onclick="$.ajaxQuery('listPrepareUserForm','list_prepare_user_div')" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
	                                <button type="reset" class="mis-btn mis-inverse-btn"><i class="mis-refresh-ico"></i>重置</button>
	                            </div>                                                
	                        </div>
	                    </dt>
	                    <div id="list_prepare_user_div">
	                   		<script>
	                   			$(function(){
	                   				$('#list_prepare_user_div').load('${ctx}/manage/course/listPrepareUser', $('#listPrepareUserForm').serialize());
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
                    	<@courseAuthorizes courseId=courseAuthorize.course.id role=courseAuthorize.role page=pageBounds.page limit=pageBounds.limit orders='REAL_NAME'>
	                    	<#if 'teacher' == (courseAuthorize.role)!''>
	                    		<dt>课程助学,已选
	                    	<#elseif 'maker' == (courseAuthorize.role)!''>
	                    		<dt>课程制作,已授权
	                    	<#elseif 'assistant' == (courseAuthorize.role)!''>
	                    		<dt>课程授课,已授权
	                    	</#if>
                    		<span class="red">${paginator.totalCount }</span>人</dt>
		 					<#list courseAuthorizes as ca>
                          		<dd class="${ca.user.id }" sourceId="${ca.user.id }" branchId="${ca.user.id }" caid="${ca.id }">
                 					${(ca.user.realName)! }
                                   <a href="javascript:;" class="mis-btn mis-inverse-btn mis-btn-move" ><i class="mis-delete-ico"></i>删除</a>
                               </dd>
                          	</#list>
                        </@courseAuthorizes>
                   </dl>
                </div>
	        </div>
            <div class="mis-course-Manachoose-btn">
                <button onclick="saveCourseAuthorize()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-next-ico"></i>保存</button>
            </div>
        </div>
    </div>
</form>
<form id="saveCourseAuthorizeForm" action="${ctx}/manage/course/updateCourseAuthorize" method="post">
	<input type="hidden" name="role" value="${courseAuthorize.role}">
	<input type="hidden" name="courseId" value="${courseAuthorize.course.id}">
</form>
<script type="text/javascript">
	$(function(){
	    Sele_choose(".mis-srh-selectbox"); //模拟select 选择
	  	//显示搜索模块
		showCourseSelectbox();
	    
		$('#allNum').text($('#allList dd').size()-1);
	});
	
	function Sele_choose(selectbox){//模拟select 选择
	    var Sele=true;
	    $(selectbox).on("click","strong",function(event){
	        if(Sele==true){
	            $(this).siblings('.mis-srh-Sel').css({"display":"block"});
	            $(this).find('.trg').addClass('trgup')
	            Sele=false;
	        }else{
	            $(this).siblings('.mis-srh-Sel').css({"display":"none"});
	            $(this).find('.trg').removeClass('trgup');
	            Sele=true;
	        }
	         $(document).on("click",function(e){
	             // alert(11)
	             var target = $(e.target);              
	            if(target.closest(selectbox).length == 0){
	                $(selectbox).children(".mis-srh-Sel").css({"display":"none"});
	                $(selectbox).find('.trg').removeClass('trgup');
	                Sele=true;
	
	            }
	         });
	    });
	    $(".mis-srh-Sel").on("click","li",function(event){
	        var Sel_text = $(this).text();
	        $(this).addClass('crt').siblings().removeClass('crt');
	        $(this).parents(".mis-srh-selectbox").find(".simulateSelect-text").text(Sel_text);
	        $(this).parents(".mis-srh-Sel").css({"display":"none"});
	        $(this).parents(".mis-srh-selectbox").find('.trg').removeClass('trgup');
	        Sele=true;
	    });
	}
	
	function saveCourseAuthorize(){
		$('#saveCourseAuthorizeForm .courseAuthorizeParam').remove();
		$('#hasList dd').each(function(i){
			var caid = $(this).attr('caid');
			if(caid != null && caid != ''){
				$('#saveCourseAuthorizeForm').append('<input type="hidden" name="courseAuthorizes['+i+'].id" class="courseAuthorizeParam" value="'+caid+'">');
			}else{
				var userId  = $(this).attr('branchId');
				$('#saveCourseAuthorizeForm').append('<input type="hidden" name="courseAuthorizes['+i+'].user.id" class="courseAuthorizeParam" value="'+userId+'">');
			}
		});
		var data = $.ajaxSubmit('saveCourseAuthorizeForm');
		var json = $.parseJSON(data);
		if(json.responseCode == '00'){
			alert('提交成功');
		}
	}
	
</script>