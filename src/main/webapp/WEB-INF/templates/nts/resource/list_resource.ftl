<form id="listResourceForm" action="${ctx}/manage/resource/nts"  method ="get">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	
	<div class="mis-srh-layout">
	    <ul class="mis-ipt-lst">
	    	<li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>资源名：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="title" value="${(resource.title)!}" placeholder="请输入资源名..." class="mis-ipt">
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>学段：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-select">
	                        <select name="resourceExtend.stage" id="">
	                            <option value="">请选择...</option>
								${TextBookUtils.getEntryOptionsSelected('STAGE', (resource.resourceExtend.stage)!) }
	                        </select>    
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>学科：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-select">
	                        <select name="resourceExtend.subject" id="">
	                            <option value="">请选择...</option>
								${TextBookUtils.getEntryOptionsSelected('SUBJECT', (resource.resourceExtend.subject)!) }
	                        </select>    
	                    </div>
	                </div>
	            </div>
	        </li>
	    </ul>
	    <div class="mis-btn-row indent1">
	        <button onclick="easyui_tabs_update('listResourceForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
	    </div>
	</div>
	
	<div class="mis-table-layout">
	    <div class="mis-opt-row">
	        <div class="mis-opt-mod fl">
	            <button onclick="previewResource()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-look-ico"></i>预览</button>
	            <button onclick="downloadResource()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-download-ico"></i>下载</button>
	        </div>
	    </div>
	    <div class="mis-table-mod">
	        <table id="listResourceTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
	            <thead>
	                <tr>
	                    <th width="50px" data-options="field:'id',checkbox:true">选项</th>
						<th data-options="field:'fileName',hidden:true"></th>
						<th data-options="field:'title'">资源名</th>
						<th data-options="field:'stage'">学段</th>
						<th data-options="field:'subject'">学科</th>
	                </tr>
	            </thead>
	            <tbody>
	                <@resourcesDataDirective subject=(resource.resourceExtend.subject)!'' stage=(resource.resourceExtend.stage)!''  getFile=true title=(resource.title)!'' belong="public" page=pageBounds.page limit=pageBounds.limit orders="CREATE_TIME.DESC">
						<#list resources as resource>
							<tr>
								<td>${(resource.fileInfos[0].id)!}</td>
								<td>${(resource.fileInfos[0].fileName)!}</td>
								<td>${resource.title}</td>
								<td>${DictionaryUtils.getEntryName('STAGE', (resource.resourceExtend.stage)!) }</td>
								<td>${DictionaryUtils.getEntryName('SUBJECT', (resource.resourceExtend.subject)!) }</td>
							</tr>
						</#list>
					</@resourcesDataDirective>
	            </tbody>
	            <tfoot>
	                <tr>
	                    <td colspan="10">
	                    	 <#if paginator??>
						    	<#import "../include/pagination.ftl" as p/>
						    	<@p.pagination paginator=paginator formId="listResourceForm" divId="content"/>
							</#if>
	                    </td>
	                </tr>
	            </tfoot>
	        </table>
	    </div>
	</div>
</form>
<script>
	$(function(){
		$('#listResourceTable').datagrid();
	});
	
	function previewResource(){
		var row = $('#listResourceForm').find('#listResourceTable').datagrid('getSelections');
		if(row.length <=0){
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return;
		}else if(row.length >1){
			$.messager.alert('提示', '只能操作一行数据', 'warning');
			return;
		}
		var id = row[0].id;
		mylayerFn.open({
	        type: 2,
	        title: '预览文件',
	        fix: false,
	        area: [$(window).width() * 75 / 100, $(window).height() * 95 / 100],
	        content: '/file/previewFile?fileId='+id
	    });
	}
	
	function downloadResource(){
		var row = $('#listResourceForm').find('#listResourceTable').datagrid('getSelections');
		if(row.length <=0){
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return;
		}else if(row.length >1){
			$.messager.alert('提示', '只能操作一行数据', 'warning');
			return;
		}
		var id = row[0].id;
		var fileName = row[0].fileName;
		downloadFile(id, fileName);
	}
	
</script>

