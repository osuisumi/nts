<#macro pagination_window paginator windowId  formId type tableId>
<input id="page" type="hidden" name="page" value="${paginator.page }" />
<input id="limit" type="hidden" name="limit" value="${paginator.limit }" />
<script>
	$(function() {
		var table = $('#${tableId}');
		table.datagrid({
			pageSize : parseInt('${paginator.limit}'),
			pageNumber : parseInt('${paginator.page}'),
			pageList : [ 10, 20 ]
		});
		var pagination = table.datagrid('getPager');
		$(pagination).pagination({
			total : parseInt('${paginator.totalCount}'),
			pageSize : parseInt('${paginator.limit}'),
			pageNumber : parseInt('${paginator.page}'),
			onSelectPage : function(pageNumber, pageSize) {
				$('#${formId} #page').val(pageNumber);
				$('#${formId} #limit').val(pageSize);
				if ('${type}' != null && '${type}' == 'ajax') {
					$.ajaxQuery('${formId}', '${tableId}');
				} else if ('${type}' != null && '${type}' == 'easyui') {
					var window = $('#${windowId}');
					window.panel('options').queryParams= $('#${formId}').serializeObject();
					window.window('refresh', $('#${formId}').attr('action'));  
				} else {
					document.getElementById('${formId}').submit();
				}
			}
		});
	});
</script>
</#macro>

