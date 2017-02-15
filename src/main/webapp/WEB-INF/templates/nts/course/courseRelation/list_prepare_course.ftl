<@coursesDirective title=param_title!'' state='pass' isTemplate='Y' orders='CREATE_TIME.DESC'>
	<dd class="all-course">
    	共 <span class="red">${courses?size }</span> 门课程
 	</dd>
 	<#list courses as course>
		<dd class="${course.id }" sourceId="${course.id }" branchId="${course.id }">
  			${course.title! }
      		<div class="discrible">
            <span>${DictionaryUtils.getEntryName('COURSE_TYPE',course.type) } </span>
            <span class="line">|</span>
            <span>${course.studyHours!0 }学时</span>
               </div>
            <a href="javascript:;" class="mis-btn mis-inverse-btn mis-btn-add" ><i class="mis-add-ico"></i>添加</a>
    	</dd>
    </#list>
</@coursesDirective>
