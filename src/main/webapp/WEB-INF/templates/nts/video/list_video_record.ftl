<form id="listVideoRecordForm" action="${ctx}/manage/video/record/nts"  method ="get">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<div class="mis-srh-layout">
	    <ul class="mis-ipt-lst">
	    	<li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>视频名：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="name" value="${(name[0])!}" placeholder="请输入视频名..." class="mis-ipt">
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>作者：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-ipt-mod">
	                        <input type="text" name="author" value="${(author[0])!}" placeholder="作者..." class="mis-ipt">
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>状态：</span>
	                </div>
	                <div class="tc">
	                    <div class="mis-select">
	                        <select id="parentCategoryParamSelect" name="parentCategory">
	                            <option value="">请选择...</option>
								<@videoRecordCategoriesDirective>
									<#if categories??>
										<#list categories as category>
											<option value="${category.key }"
												<#if category.key == (parentCategory[0])!''> selected </#if>
											>${category.value }</option>
										</#list>
									</#if>
								</@videoRecordCategoriesDirective>  
	                        </select> 
	                    </div>
	                </div>
	            </div>
	        </li>
	        <li class="item item-twoIpu">
	            <div class="mis-ipt-row">
	                <div class="tl">
	                    <span>录播开始时间：</span>
	                </div>
	                <div class="center">
	                    <div class="tc">
	                        <div class="mis-ipt-mod">
	                            <input type="text" name="recTimeGe" value="${(recTimeGe[0])! }" class="mis-ipt" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
	                        </div>
	                    </div>
	                    <span class="to">至</span>
	                    <div class="tc">
	                        <div class="mis-ipt-mod">
	                            <input type="text" name="recTimeLe" value="${(recTimeLe[0])! }" class="mis-ipt" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
	                        </div>
	                    </div>                                            
	                </div>
	            </div>
	        </li>
	    </ul>
	    <div class="mis-btn-row indent1">
	        <button onclick="easyui_tabs_update('listVideoRecordForm','layout_center_tabs');" type="button" class="mis-btn mis-main-btn"><i class="mis-srh-ico"></i>查询</button>
			<a onclick="resetForm(this)"  class="mis-btn mis-default-btn">
				<i class="mis-refresh-ico"></i>重置
			</a>
	    </div>
	</div>
	<div class="mis-table-layout">
	    <div class="mis-opt-row">
	        <div class="mis-opt-mod fl">
	            <button onclick="viewVideo()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-look-ico"></i>播放</button>
	        </div>
	    </div>
	    <div class="mis-table-mod">
	        <@videoRecordsDirective author=(author[0])!'' recTimeGe=(recTimeGe[0])!'' recTimeLe=(recTimeLe[0])!'' parentGrade=(parentGrade[0])!'' parentCategory=(parentCategory[0])!'' name=(name[0])!'' page=pageBounds.page limit=10>
				<table id="listVideoRecordTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="mis-table">
					<thead>
						<tr>
							<th width="50px" data-options="field:'guid',checkbox:true"></th>
							<th data-options="field:'name'">视频名</th>
							<th data-options="field:'period'">时长</th>
							<th data-options="field:'author'">作者</th>
							<th data-options="field:'recTime'">录制时间</th>					
						</tr>
					</thead>
					<tbody>
						<#if videoRecords??>
							<#list videoRecords as videoRecord>
								<tr>
									<td>${videoRecord.guid}</td>
									<td>${(videoRecord.name)!}</td>
									<td>${(videoRecord.period)!}</td>
									<td>${(videoRecord.author)!}</td>
									<td>${((TimeUtils.calendarToDate(videoRecord.recTime))?string('yyyy-MM-dd'))!}</td>
								</tr>
							</#list>
						</#if>
					</tbody>
					<tfoot>
		                <tr>
		                    <td colspan="10">
		                    	 <#if paginator??>
							    	<#import "../include/pagination.ftl" as p/>
							    	<@p.pagination paginator=paginator formId="listVideoRecordForm" divId="content"/>
								</#if>
		                    </td>
		                </tr>
		            </tfoot>
				</table>
			</@videoRecordsDirective>
	</div>
</form>
<script>
	$(function(){
		$('#listVideoRecordTable').datagrid();
	});
	
	function viewVideo() {
		var row = $('#listVideoRecordForm').find('#listVideoRecordTable').datagrid('getSelections');	
		if (row.length == 0) {
			$.messager.alert('提示', '请选择一行数据进行操作！', 'warning');
			return false;
		}else if (row.length > 1) {
			$.messager.alert('提示', '不能同时观看多个视频', 'warning');
			return false;
		}else {
			var guid = row[0].guid;
			$.get('${ctx}/video/record/'+guid+'/entity', '', function(result){
				if(result != null){
					if(result.message != null && result.message != ''){
						alert(result.message);
						return false;
					}
					window.open(result.data.nr.replace('9300','9301'));
				}
			});
		}
	}
</script>

