<#import "/nts/include/tab.ftl" as tab/>
<@tab.tabFtl items=items[0] />
<form id="importTrainRegisterForm">
	<input type="hidden" name="trainId" value="${trainId }">
	<#import "/nts/common/import_user.ftl"  as iu/>
	<@iu.importUser submitFunction="importTrainRegister()" templateName="import_trainRegister.xls"/>
</form>
<script type="text/javascript">
	function importTrainRegister() {
		if($('#fileUrl').val() == null || $('#fileUrl').val() == ''){
			alert('请先选择文件');
			return false;
		}
		load_next_content('${ctx}/trainRegister/importTrainRegister', null, '培训报名导入结果', $('#importTrainRegisterForm').serialize(), 'post');
		//easyui_modal_close('importTrainRegisterDiv');
		//easyui_modal_close('listTrainRegisterDiv');
	}
	
</script>