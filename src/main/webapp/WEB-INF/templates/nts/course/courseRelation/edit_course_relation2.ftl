<form id="listPrepareCourseForm" action="${ctx}/manage/courseRelation/listPrepareCourse" method="post">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<@trainDirective id=relationId>
		<#assign train=trainModel>
	</@trainDirective>
	<div class="mis-content">
	    <div class="mis-course-Manachoose">
	        <div class="mis-course-Manachoose-tl">
	            <i></i>
	          	${train.name }
	        </div>
	        <div class="mis-stPower-innerBox">
	            <div class="mis-stPower-innerL fl" style="max-height: 960px; min-height: 400px; overflow: auto;">
	                <dl>
	                    <dt>
	                       	 全部课程
	                        <div class="course-ManastPower-srh">
	                            <div class="mis-btn mis-main-btn stPower-srh">
	                                <i class="mis-srh-ico"></i>
	                            </div>
	                            <div class="mis-course-Machoose-serch">
	                                <input type="text" name="title" placeholder="输入课程名称查找">  
	                                <button type="button" onclick="$.ajaxQuery('listPrepareCourseForm','list_prepare_course_div')" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
	                                <button type="reset" class="mis-btn mis-inverse-btn"><i class="mis-refresh-ico"></i>重置</button>
	                            </div>                                                
	                        </div>
	                    </dt>
	                    <div id="list_prepare_course_div">
	                   		<script>
	                   			$(function(){
	                   				
	                   			});
	                   		</script>
	                   </div>
	                </dl>
	            </div>
                <div class="mis-stPower-arrow fl">
                    <span class="arrow"></span>
                </div>
                <div id="list_added_course_div" class="mis-stPower-innerR fr">
                	<script>
                    $(function(){
                    });
                    </script>
                </div>
	        </div>
            <div class="mis-course-Manachoose-btn">
            	<#if train.type?contains('workshop')>
            		<button onclick="saveCourseRelation('workshop')" type="button" class="mis-btn mis-inverse-btn"><i class="mis-next-ico"></i>保存并进入下一步</button>
            	<#elseif train.type?contains('community')>	
            		<button onclick="saveCourseRelation('community')" type="button" class="mis-btn mis-inverse-btn"><i class="mis-next-ico"></i>保存并进入下一步</button>
            	<#else>
            		<button onclick="saveCourseRelation()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-next-ico"></i>保存并退出</button>
            	</#if>
            </div>
	    </div>
	</div>  
</form>
<form id="saveCourseRelationForm" action="${ctx}/manage/courseRelation/updateCourseRelations" method="post">
	<input type="hidden" name="relationId" value="${relationId}">
	<input id="courseIds" type="hidden" name="courseIds">
</form>
<script type="text/javascript">
	$(function(){
	    Sele_choose(".mis-srh-selectbox"); //模拟select 选择
	    //显示搜索模块
		showCourseSelectbox();
		
		var dtd1 = $.Deferred();
		var dtd2 = $.Deferred();
		
		$('#list_prepare_course_div').load('${ctx}/manage/courseRelation/listPrepareCourse', $('#listPrepareCourseForm').serialize(),function(){
			dtd1.resolve();
		});
		
		$('#list_added_course_div').load('${ctx}/manage/courseRelation/listAddedCourse','relationId=${relationId}',function(){
			dtd2.resolve();
		});
		
		$.when(dtd1,dtd2).done(function(){add_move(".mis-btn-add",".mis-btn-move",".mis-stPower-innerL",".mis-stPower-innerR");});
		
		/*$('#list_prepare_course_div').load('${ctx}/manage/courseRelation/listPrepareCourse', $('#listPrepareCourseForm').serialize(),function(){
			$('#list_added_course_div').load('${ctx}/manage/courseRelation/listAddedCourse','relationId=${relationId}',function(){
				add_move(".mis-btn-add",".mis-btn-move",".mis-stPower-innerL",".mis-stPower-innerR");
			});
		});*/
	});
	
	function Sele_choose(selectbox){//模拟select 选择
	    var Sele=true;
	    $(selectbox).on("click","strong",function(event){
	        if(Sele==true){
	            $(this).siblings('.mis-srh-Sel').css({"display":"block"});
	            $(this).find('.trg').addClass('trgup');
	            Sele=false;
	        }else{
	            $(this).siblings('.mis-srh-Sel').css({"display":"none"});
	            $(this).find('.trg').removeClass('trgup');
	            Sele=true;
	        }
	         $(document).on("click",function(e){
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

	
	function saveCourseRelation(type){
		var prepareUpdateCourseIds = '';
		$('#hasCourseList dd').each(function(i){
			var cid = $(this).attr('branchId');
			if(prepareUpdateCourseIds == ''){
				prepareUpdateCourseIds = cid;
			}else{
				prepareUpdateCourseIds = prepareUpdateCourseIds + ',' + cid;
			}
		});
		$('#courseIds').val(prepareUpdateCourseIds);
		var data = $.ajaxSubmit('saveCourseRelationForm');
		var json = $.parseJSON(data);
		if(json.responseCode == '00'){
			var itemName = '';
			var url = '';
			if(type == null || type == ''){
				$.ajaxQuery('listTrainForm');
				cancle();
			}else if(type == 'workshop'){
				itemName = '配置工作坊';
				url = '/manage/train/editTrainWorkshop?id=${train.id}';
			}else if(type == 'community'){
				itemName = '配置社区';
				url = '/manage/nts/cmts/community/relation/edit?relation.id=${train.id}';
			}
			load_next_content(url, 'saveCourseRelationForm', itemName);
		}
	}
	

	function add_move(addBtn,moveBtn,faterL,faterR){
		console.log('callbask');
	    var btnnum=0;
	    $("body").on("click",addBtn,function(){
	        btnnum++;
	        var addmoveBtn = $(' <a href="javascript:;" class="mis-btn mis-inverse-btn mis-btn-move" ><i class="mis-delete-ico"></i>删除</a>');
	        var addsign = $('<span class="had-add"><i class="mis-Gpass-ico"></i>已添加</span>');
	        var Flabel = $(this).parent(),
	            FR = Flabel.parents(faterL).siblings(faterR);
	        Flabel.addClass("btnL"+btnnum+""); //添加类是为了当移除计划的时候起关联作用;        
	        FR.children().append(Flabel.clone()).find(".btnL"+btnnum+"").append(addmoveBtn).find(addBtn).remove();
	        Flabel.append(addsign);
	        $(this).remove();
	    });
	    $("body").on("click",moveBtn,function(){
	    	var flag = true;
	    	var courseRegisterNum = $(this).parent().attr("courseRegisterNum");
	    	if(courseRegisterNum != null){
	    		courseRegisterNum = parseInt(courseRegisterNum); 
	    		if(courseRegisterNum > 0){
	    			alert('已有选课的课程不能删除');
	    			flag = false;
	    		}
	    	}
	    	if(flag){
	    		removeRight($(this));
	    	}
	    });
	    
	    function removeRight(obj){
	    	var addBtn =  $(' <a href="javascript:;" class="mis-btn mis-inverse-btn mis-btn-add" ><i class="mis-add-ico"></i>添加</a>');
	        var Fclass = $(obj).parent().attr("sourceId"),
	            FL = $(obj).parents(faterR).siblings(faterL);
	        FL.find("."+Fclass+"").children(".had-add").remove();
	        FL.find("."+Fclass+"").append(addBtn).removeClass(Fclass);
	        $(obj).parent().remove();
	    }
	    
	    //载入页面时判断哪些课程是已添加的
	    $('.mis-stPower-innerL dd').each(function(){
	    	var sourceId = $(this).attr('sourceId');
	    	var hasSourceIds = '';
	    	$.each($('#hasCourseList dd'),function(i,n){
	    		hasSourceIds = hasSourceIds +"," +  $(n).attr('sourceId');
	    	});
	    	if(hasSourceIds.indexOf(sourceId) >= 0){
	    		$(this).find('.mis-btn-add').remove();
		        $(this).append('<span class="had-add"><i class="mis-Gpass-ico"></i>已添加</span>');
		        var branchId = $('.mis-stPower-innerR dd.'+sourceId).attr('branchId');
		        $(this).attr('branchId', branchId);
	    	}
	    });
	}
</script>