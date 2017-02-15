<dl id="hasCourseList">
    <@coursesDirective relationId = (param_relationId)! page=1 orders='CREATE_TIME.DESC'>
    	<dt>
    		已选<ins class="red"> ${paginator.totalCount } </ins>门课程
    		<!-- ，共<ins class="red"> 60 </ins>学时 -->
    	</dt>
    	<#assign courses=courses>
    </@coursesDirective>
    
    <#assign courseIds=[]>
    <#list courses as course>
    	<#assign courseIds = courseIds + [course.id]>
    </#list>
    
    <#if (courseIds?size > 0)>
    	<@courseRegisterNumMapDirective courseIds=courseIds relationId=(param_relationId)! state='pass'>
    		<#assign courseRegisterNumMap=courseRegisterNumMap> 
    	</@courseRegisterNumMapDirective>
    </#if>
    
	<#list courses as course>
  		<dd class="${course.sourceId }" sourceId="${course.sourceId }" branchId="${course.id }" courseRegisterNum="${(courseRegisterNumMap[course.id])!0}">
			${course.title! }
			<div class="discrible">
                 <span>${DictionaryUtils.getEntryName('COURSE_TYPE',course.type) } </span>
                 <span class="line">|</span>
                 <span>${course.studyHours!0 }学时</span>
            </div>
           <a href="javascript:;" class="mis-btn mis-inverse-btn mis-btn-move" ><i class="mis-delete-ico"></i>删除</a>
       </dd>
  	</#list>
</dl>

<script>

</script>
	
