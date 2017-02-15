<#import "/nts/include/tab.ftl" as tab/>
<@tab.tabFtl items=items[0] />
<form id="importWorkshopUserForm">
	<input type="hidden" name="workshopId" value="${workshopId}">
	<#import "/nts/common/import_user.ftl"  as iu/>
	<@iu.importUser submitFunction="importTrainRegister()" templateName="import_workshopUser.xls"/>
</form>
<script type="text/javascript">

	function importWorkshopUser() {
		if($('#fileUrl').val() == null || $('#fileUrl').val() == ''){
			alert('请先选择文件');
			return false;
		}
		load_next_content('${ctx}/manage/workshopUser/importWorkshopUser', null, '导入结果', $('#importWorkshopUserForm').serialize(), 'post');
	}
	
</script>