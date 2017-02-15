<form id="listPrepareWorkshopForm" action="${ctx}/train/listPrepareWorkshop" method="post">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<@trainDirective id=train.id>
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
	                       	 全部工作坊
	                        <div class="course-ManastPower-srh">
	                            <div class="mis-btn mis-main-btn stPower-srh">
	                                <i class="mis-srh-ico"></i>
	                            </div>
	                            <div class="mis-course-Machoose-serch">
	                                <input type="text" name="title" placeholder="输入工作坊名称查找">  
	                                <button type="button" onclick="$.ajaxQuery('listPrepareWorkshopForm','list_prepare_workshop_div')" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
									<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
										<i class="mis-refresh-ico"></i>重置
									</a>
	                            </div>                                                
	                        </div>
	                    </dt>
	                    <div id="list_prepare_workshop_div">
	                   		<script>
	                   			$(function(){
	                   				$.ajaxQuery('listPrepareWorkshopForm','list_prepare_workshop_div')
	                   			});
	                   		</script>
	                    </div>
	                </dl>
	            </div>
                <div class="mis-stPower-arrow fl">
                    <span class="arrow"></span>
                </div>
                <#assign templateIds = []>
                <@workshopsDirective relationId = train.id page=1 limit=pageBounds.limit orders='CREATE_TIME.DESC'>
					<#if workshops??>
						<#list workshops as workshop>
							<#assign templateIds = templateIds + [workshop.sourceId]/>
						</#list>
					</#if>
					<#if (templateIds?size>0)>
						<@workshopsDirective ids=templateIds page=1 limit=pageBounds.limit orders='CREATE_TIME.DESC'>
							<#assign hasTemplates=workshops>
						</@workshopsDirective>
					</#if>
                </@workshopsDirective>
                <div class="mis-stPower-innerR fr">
                    <dl id="hasWorkshopList">
                    	<dt>已选<ins class="red"> ${paginator.totalCount } </ins>个工作坊</dt>
                    	<#if hasTemplates??>
		 					<#list hasTemplates as workshop>
	                      		<dd class="${(workshop.id)! }" sourceId="${(workshop.id)! }" branchId="${(workshop.id)! }">
	             					${workshop.title! }
	                 				<div class="discrible">
				                         <span></span>
	                                </div>
	                               <a href="javascript:;" class="mis-btn mis-inverse-btn mis-btn-move" ><i class="mis-delete-ico"></i>删除</a>
	                           </dd>
	                      	</#list>
                      	</#if>
                   </dl>
                </div>
	        </div>
            <div class="mis-course-Manachoose-btn">
            	<#if train.type?contains('community')>	
            		<button onclick="saveTrainWorkshop('community')" type="button" class="mis-btn mis-inverse-btn"><i class="mis-next-ico"></i>保存并进入下一步</button>
            	<#else>
            		<button onclick="saveTrainWorkshop()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-next-ico"></i>保存并退出</button>
            	</#if>
            </div>
	    </div>
	</div>  
</form>
<form id="saveTrainWorkshopForm" action="${ctx}/train/updateTrainWorkshop" method="post">
	<input type="hidden" name="trainId" value="${train.id}">
	<input id="workshopIds" type="hidden" name="workshopIds">
</form>
<dd id="allWorkshopDdTemplate" style="display: none;">
	<i class="mis-StMake-ico"></i>
	<span></span>	
	<a href="javascript:;" class="mis-btn mis-inverse-btn mis-btn-add" >
		<i class="mis-add-ico"></i>添加
	</a>
</dd>
<dd id="hasCourseDdTemplate"  style="display: none;">
	<i class="mis-StMake-ico"></i>
	<span></span>
	<a href="javascript:;" class="mis-btn mis-inverse-btn mis-btn-move" >
		<i class="mis-delete-ico"></i>删除
	</a>
</dd>
<script type="text/javascript">
	$(function(){
	    Sele_choose(".mis-srh-selectbox"); //模拟select 选择
	  	//显示搜索模块
	    showCourseSelectbox();
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
	
	function saveTrainWorkshop(type){
		var prepareUpdateCourseIds = '';
		$('#hasWorkshopList dd').each(function(i){
			var wsid = $(this).attr('branchId');
			if(prepareUpdateCourseIds == ''){
				prepareUpdateCourseIds = wsid;
			}else{
				prepareUpdateCourseIds = prepareUpdateCourseIds + ',' + wsid;
			}
		});
		$('#workshopIds').val(prepareUpdateCourseIds);
		var data = $.ajaxSubmit('saveTrainWorkshopForm');
		var json = $.parseJSON(data);
		if(json.responseCode == '00'){
			var itemName = '';
			var url = '';
			if(type == null || type == ''){
				$.ajaxQuery('listTrainForm');
				cancle();
			}if(type == 'community'){
				itemName = '配置社区';
				url = '/manage/nts/cmts/community/relation/edit?relation.id=${train.id}';
			}
			load_next_content(url, 'saveTrainWorkshopForm', itemName);
		}
	}
</script>