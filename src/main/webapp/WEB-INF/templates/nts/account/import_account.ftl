<#import "/nts/include/tab.ftl" as tab/>
<@tab.tabFtl items=items[0] />
<form id="importAccountForm">
	<#import "/nts/common/import_user.ftl"  as iu/>
	<@iu.importUser submitFunction="importAccount()" templateName="import_account.xls"/>
</form>
<script type="text/javascript">

	function importAccount() {
		if($('#fileUrl').val() == null || $('#fileUrl').val() == ''){
			alert('请先选择文件');
			return false;
		}
		load_next_content('${ctx}/manage/accounts/importAccount', null, '导入结果', $('#importAccountForm').serialize(), 'post');
	}
	
</script>