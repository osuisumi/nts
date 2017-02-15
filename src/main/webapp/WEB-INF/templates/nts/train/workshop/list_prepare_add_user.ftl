 <#if role == 'student'>
	<@trainRegisterExtendsDirective limit=(pageBounds.limit)!10 orders=orders!'CREATE_TIME.DESC' page=(pageBounds.page)!1 stage=(stage[0])! subject=(subject[0])! province=(province[0])! city=(city[0])! trainId=(trainId[0])! counties=(counties[0])!  realName=realName!''  trainRegisterExtend=trainRegisterExtend>
		<#assign userWappers = trainRegisterExtends!/>
	</@trainRegisterExtendsDirective>
<#elseif role == 'member'>
	<@trainAuthorizesDirective limit=(pageBounds.limit)!10 orders=orders!'CREATE_TIME.DESC' page=(pageBounds.page)!1 stage=(stage[0])! subject=(subject[0])! province=(province[0])! city=(city[0])! counties=(counties[0])!  trainId=(trainId[0])! realName=realName!''>
		<#assign userWappers = trainAuthorizes!>
	</@trainAuthorizesDirective>
<#elseif role == 'master'>
	 <@userTeachersDirective limit=(pageBounds.limit)!10 orders=orders!'CREATE_TIME.DESC' page=(pageBounds.page)!1 stage=(stage[0])! subject=(subject[0])! province=(province[0])! city=(city[0])! counties=(counties[0])! realName=realName!''>
	 	<#assign userWappers = teachers/>
	 </@userTeachersDirective>
</#if>
	<dd class="all-course">
     	共 <span class="red" id="allNum">${(paginator.totalCount)!0}</span>人 
    </dd>
 	<#list userWappers as uw>
		<dd class="${uw.user.id }" sourceId="${uw.user.id }" branchId="${uw.user.id }">
  			${(uw.user.realName)!}
            <div class="discrible">
                <span>${TextBookUtils.getEntryName('STAGE', (uw.userInfo.stage)!)}</span>
                <span class="line">|</span>
                <span>${TextBookUtils.getEntryName('SUBJECT', (uw.userInfo.subject)!)}</span>
            </div>
            <a href="javascript:;" class="mis-btn mis-inverse-btn mis-btn-add allBtn" ><i class="mis-add-ico"></i>添加</a>
    	</dd>
    </#list>
    <form id="prepareAddUserForm" action="${ctx}/manage/train/workshop/preapre_add_user" method="get">
    	<input type="hidden" name="stage" value="${(stage[0])!}">
    	<input type="hidden" name="subject" value="${(subject[0])!}">
    	<input type="hidden" name="province" value="${(province[0])!}">
    	<input type="hidden" name="city" value="${(city[0])!}">
    	<input type="hidden" name="trainId" value="${(trainId[0])!}">
    	<input type="hidden" name="counties" value="${(counties[0])!}">
    	<input type="hidden" name="realName" value="${realName!}">
    	<input type="hidden" name="role" value="${role!}">
    	<div id="prepareAddUserPage"></div>
	    <#import "/nts/common/pagination-ajax.ftl" as p/>
	    <@p.paginationAjaxFtl formId='prepareAddUserForm' divId="prepareAddUserPage" paginator=paginator refreshDivId="workshop_prepare_add_user">
	    </@p.paginationAjaxFtl>
    </form>
<script>
	/*以下js为页面样式js*/
	$(function(){
		add_move(".mis-btn-add",".mis-btn-move",".mis-stPower-innerL",".mis-stPower-innerR");//课程添加删除
	    Sele_choose(".mis-srh-selectbox"); //模拟select 选择
	    
	    //$('#allNum').text($('#allList dd').size()-1);
	    $('#hasNum').text($('#hasList dd').size());
	    
	});
	
	function add_move(addBtn,moveBtn,faterL,faterR){
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
	        var addBtn =  $(' <a href="javascript:;" class="mis-btn mis-inverse-btn mis-btn-add" ><i class="mis-add-ico"></i>添加</a>');
	        var Fclass = $(this).parent().attr("sourceId"),
	            FL = $(this).parents(faterR).siblings(faterL);
	        FL.find("."+Fclass+"").children(".had-add").remove();
	        FL.find("."+Fclass+"").append(addBtn).removeClass(Fclass);
	        $(this).parent().remove();
	    });
	    
	    //载入页面时判断哪些课程是已添加的
	    $('.mis-stPower-innerL dd').each(function(){
	    	var sourceId = $(this).attr('sourceId');
	    	var hasSourceIds = '';
	    	$.each($('#hasList dd'),function(i,n){
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
	
</script>