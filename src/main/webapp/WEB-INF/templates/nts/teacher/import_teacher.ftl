<#import "/nts/include/tab.ftl" as tab/>
<@tab.tabFtl items=items[0] />
<form id="importTeacherForm">
	<#import "/nts/common/import_user.ftl"  as iu/>
	<@iu.importUser submitFunction="importTeacher()" templateName="import_teacher.xls"/>
</form>
<script type="text/javascript">

	function importTeacher() {
		if($('#fileUrl').val() == null || $('#fileUrl').val() == ''){
			alert('请先选择文件');
			return false;
		}
		load_next_content('${ctx}/teacher/importTeacher', null, '导入结果', $('#importTeacherForm').serialize(), 'post');
	}
	
</script>