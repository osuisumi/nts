<#macro layout>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<meta name="author" content="smile@kang.cool">
<meta name="description" content="hello">
<meta name="keywords" content="a,b,c">
<meta http-equiv="Window-target" content="_top">

<#import "../include/inc.ftl" as inc />
<@inc.incFtl />

<title>培训管理后台</title>
</head>
<body id="misBody">
	<div class="mis-wrap">
	<input id="backName" type="hidden">
	<div class="m-blackbg"></div>
	<div id="wrap">
		<div id="top">
			<#import "../include/top.ftl" as top />
			<@top.topFtl />
		</div>
		<div id="content">
			<#nested>
		</div>
		<div id="footer">
			<#import "../include/footer.ftl" as footer />
			<@footer.footerFtl />
		</div>
		<input type="hidden" id="loadDivId" value="content" />
		<div class="blackBg"></div>
		<div class="blackBg1"></div>
		<div class="whiteBg"></div>
		<div class="ag-whitebg"></div>
		<div class="ag-blackbg"></div>
	</div>
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
</#macro>