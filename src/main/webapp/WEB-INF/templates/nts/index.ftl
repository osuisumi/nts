<!DOCTYPE html>
<html lang="zh-CN">
<head>
<title>管理后台</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="content-type" content="text/html;charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="">
<meta http-equiv="description" content="">
<#include "include/inc.ftl"/>
</head>
<body id="misBody">
	<div class="mis-wrap">
		<#include "include/top.ftl" />
		<#include "include/menu_left.ftl" />
		<div class="mis-bd" id="misContent">
	        <div class="mis-bd-inner">
	            <div class="mis-index-wrap">
	                <div class="mis-mod contentDiv" id="content">
	                
					</div>
					<!-- <div class="mis-mod contentDiv" id="list_content" style="display: none;">
	                
					</div>
					<div class="mis-mod contentDiv" id="edit_content" style="display: none;">
	                
					</div> -->
				</div>
				<#include "${app_path }/include/footer.ftl" />
			</div>
		</div>
	</div>
	<form id="downloadExcelForm" action="${ctx }/excel/downloadExcel" target="_blank" method="post">
		<input type="hidden" name="fileName"> 
	</form>
	<form id="downloadFileForm" action="/file/downloadFile.do" method="post" target="_blank">
		<input type="hidden" name="id">
		<input type="hidden" name="fileName">
		<input type="hidden" name="fileRelations[0].type"> 
		<input type="hidden" name="fileRelations[0].relation.id"> 
	</form>
	<form id="updateFileForm" target="_blank">
		<input type="hidden" name="id">
		<input type="hidden" name="fileName">
	</form>
	<form id="deleteFileRelationForm" target="_blank">
		<input type="hidden" name="fileId">
		<input type="hidden" name="relation.id">
		<input type="hidden" name="type">
	</form>
	<form id="deleteFileInfoForm" target="_blank">
		<input type="hidden" name="id">
	</form>
</body>
</html>
