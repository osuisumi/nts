<#import "/nts/include/tab.ftl" as tab/>
<@tab.tabFtl items=items[0] />
<form id="importStudentAccountForm">
	<#import "/nts/common/import_user.ftl"  as iu/>
	<@iu.importUser submitFunction="importStudentAccount()" templateName="import_student.xls"/>
</form>
<script type="text/javascript">

	function importStudentAccount() {
		if($('#fileUrl').val() == null || $('#fileUrl').val() == ''){
			alert('请先选择文件');
			return false;
		}
		load_next_content('${ctx}/manage/accounts/student/importAccount', null, '导入结果', $('#importStudentAccountForm').serialize(), 'post');
	}
	
</script>