<#import "/nts/include/tab.ftl" as tab/>
<@tab.tabFtl items=items[0] />
<form id="importCourseRegisterForm" method="post">
	<input type="hidden" name="courseId" value="${courseId }">
	<input type="hidden" name="trainId" value="${trainId }">
	<#import "/nts/common/import_user.ftl"  as iu/>
	<@iu.importUser submitFunction="importCourseRegister()" templateName="import_courseRegister.xls"/>
</form>
<script type="text/javascript">
	function importCourseRegister() {
		if($('#fileUrl').val() == null || $('#fileUrl').val() == ''){
			alert('请先选择文件');
			return false;
		}
		var title = '选课导入结果';
		load_next_content('${ctx}/courseRegister/importCourseRegister', null, '选课导入结果', $('#importCourseRegisterForm').serialize(), 'post');
	}
</script>