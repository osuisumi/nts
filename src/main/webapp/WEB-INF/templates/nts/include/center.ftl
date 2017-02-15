<div id="layout_center_tabs" style="overflow:hidden;" class="easyui-tabs" data-options="tabPosition:'top',cache:false,tabHeight:50">
	<div id="layout_center_tabs_index" title="我的主页" data-options="" style=""></div>
</div>
<div id="layout_center_tabsMenu" style="width: 120px;display:none;">
	<div type="refresh" data-options="iconCls:'icon-reload'">刷新</div>
	<div class="menu-sep"></div>
	<div type="close" data-options="iconCls:'icon-remove'">关闭</div>
	<div type="closeOther" data-options="iconCls:'icon-clear'">关闭其他</div>
	<div type="closeAll" data-options="iconCls:'icon-cancel'">关闭所有</div>
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
