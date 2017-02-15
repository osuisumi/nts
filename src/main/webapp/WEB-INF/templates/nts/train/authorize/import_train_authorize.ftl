<#import "/nts/include/tab.ftl" as tab/>
<@tab.tabFtl items=items[0] />
<form id="importTrainAuthorizeForm">
	<input type="hidden" name="trainId" value="${trainId!}">
	<#import "/nts/common/import_user.ftl"  as iu/>
	<@iu.importUser submitFunction="importTrainAuthorize()" templateName="import_authorize.xls"/>
</form>
<script type="text/javascript">

	function importTrainAuthorize() {
		if($('#fileUrl').val() == null || $('#fileUrl').val() == ''){
			alert('请先选择文件');
			return false;
		}
		load_next_content('${ctx}/manage/train/authorize/importTrainAuthorize', null, '导入结果', $('#importTrainAuthorizeForm').serialize(), 'post');
	}
	
</script>