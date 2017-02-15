<#import "/nts/include/tab.ftl" as tab/>
<@tab.tabFtl items=items[0] />
<form id="importStudentForm">
	<input type="hidden" name="workshopId" value="${workshopId[0]}">
	<#import "/nts/common/import_user.ftl"  as iu/>
	<@iu.importUser submitFunction="importTrainWorkshopStudent()" templateName="import_workshop_student.xls"/>
</form>
<script type="text/javascript">
	function importTrainWorkshopStudent() {
		if($('#fileUrl').val() == null || $('#fileUrl').val() == ''){
			alert('请先选择文件');
			return false;
		}
		load_next_content('${ctx}/manage/train/workshop/workshopStudent/import', null, '工作坊学员导入结果', $('#importStudentForm').serialize(), 'post');
		//easyui_modal_close('importTrainRegisterDiv');
		//easyui_modal_close('listTrainRegisterDiv');
	}
	
</script>