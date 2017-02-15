<#macro pagination paginator formId divId='' refrechDivId=''>
<div class="mis-select-tabNum">
    <span>每页显示条数:</span>
    <select name="limit" id="limitSelect" onchange="changeLimit()">
        <option value="5">5条</option>
        <option value="10">10条</option>
        <option value="15">15条</option>
        <option value="20">20条</option>
    </select>
</div>
<div class="mis-trun-page">
    <a onclick="indexPage()" href="javascript:;" class="first" title="第一页"></a>
    <a onclick="previous()" href="javascript:;" class="prev" title="上一页"></a>
    <span>第<input type="text" name="page" value="${paginator.page }" class="ipt" />页，共
    <span class="totalPage">
    	<#if (paginator.totalCount % paginator.limit != 0)>
    		${(paginator.totalCount / paginator.limit + 1)?floor }
    	<#else>
    		${(paginator.totalCount / paginator.limit)?floor }
    	</#if>
    </span>页</span>
    <a onclick="next()" href="javascript:;" class="next" title="下一页"></a>
    <a onclick="lastPage()" href="javascript:;" class="last" title="最后一页"></a>
</div>
<span class="page-num">第<strong>
	${(paginator.page - 1) * paginator.limit + 1} -
	<#if (paginator.page * paginator.limit > paginator.totalCount)>
 		${paginator.totalCount }
 	<#else>
 		${paginator.page * paginator.limit}
	</#if>
</strong>条，共<strong>${paginator.totalCount }</strong>条</span>
<script>
	$(function(){
		$('#limitSelect option[value="${paginator.limit}"]').prop('selected', true);
	});
	
	function changeLimit(){
		$("#${formId} input[name='page']").val(1);
		submitPage();
	}

	function indexPage(){
		if('${paginator.page }' != '1'){
			$("#${formId} input[name='page']").val(1);
			submitPage();
		}else{
			alert('已经是第一页');
		}
	}
	
	function lastPage(){
		var totalPages = $('#${formId} .totalPage').text();
		if('${paginator.page }' != totalPages.trim()){
			$("#${formId} input[name='page']").val(parseInt(totalPages));
			submitPage();
		}else{
			alert('已经是最后一页');
		}
	}
	
	function previous(){
		var page = $("#${formId} input[name='page']");
		if(parseInt($(page).val())>1){
			$(page).val(parseInt($(page).val())-1);
			submitPage();
		}else{
			alert('已经是第一页');
		}
	}
	
	function next(){
		var page = $("#${formId} input[name='page']");
		var totalPages = $('#${formId} .totalPage').text();
		if(parseInt($(page).val())<parseInt(totalPages)){	
			$("#${formId} input[name='page']").val(parseInt($(page).val()) + 1);
			submitPage();
		}else{
			alert('已经是最后一页');
		}
	}
	
	function skipPage(){
		var goPage = $("#${formId} input[name='page']");
		var totalPages = $("#${formId} .totalPage");
		if(parseInt($(goPage).val()) <= parseInt(totalPages.val())&&parseInt($(goPage).val())>=1){
			$("#${formId} input[name='page']").val($(goPage).val());
			submitPage();
		}else{
			alert('输入的跳转页不在页面范围内');
		}
	}
	
	function goPage(pageNo){
		$("#${formId} input[name='page']").val(pageNo);
		submitPage();
	}
	
	function submitPage(){
		if('${refrechDivId}' == ''){
			$.ajaxQuery('${formId}', $('#${formId}').parents('.contentDiv').attr('id'));
		}else{
			$.ajaxQuery('${formId}', '${refrechDivId}');
		}
	}
</script> 
</#macro>
