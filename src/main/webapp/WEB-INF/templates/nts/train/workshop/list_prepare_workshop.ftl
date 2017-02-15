<@workshopsDirective title=param_title!'' isTemplate='Y' state="published" orders='CREATE_TIME.DESC'>
	<dd class="all-course">
     	共 <span class="red">${workshops?size }</span> 个工作坊
    </dd>
 	<#list workshops as workshop>
		<dd class="${workshop.id }" sourceId="${workshop.id }" branchId="${workshop.id }">
  			${workshop.title! }
      		<div class="discrible">
            	<span></span>
            </div>
            <a href="javascript:;" class="mis-btn mis-inverse-btn mis-btn-add" ><i class="mis-add-ico"></i>添加</a>
    	</dd>
    </#list>
 </@workshopsDirective>
<script>
$(function(){
	add_move(".mis-btn-add",".mis-btn-move",".mis-stPower-innerL",".mis-stPower-innerR")//课程添加删除
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
    	$.each($('#hasWorkshopList dd'),function(i,n){
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