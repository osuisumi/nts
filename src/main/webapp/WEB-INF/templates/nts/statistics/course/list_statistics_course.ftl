<@statisticsCourseData courseStatistics=courseStatistics! pageBounds=pageBounds!>
<form id="listStatisticsCourseForm" action="${ctx!}/statistics/course" method="get">
	<div>
		<table>
			<tr>
				<td width="5%">查看方式：</td>
				<td width="10%">
					<select onchange="changeType(this,'listStatisticsCourseForm')" style="width: 258px;" editable="false">
		                <option value="table">表格</option>
		                <option value="image">统计图</option>
		            </select>
				</td>
				<td></td>
			</tr>
			<tr>
				<@projects>
					<td width="5%">项目：</td>
					<td width="10%">
						<select id="projectSelect_statisticCourse" name="project.id" value="${(courseStatistics.project.id)!}" class="easyui-combobox" style="width: 258px;" editable="false"
						data-options="    
							valueField: 'id',    
				        	textField: 'name',    
					        onLoadSuccess: function(){    
					            var value = '${(courseStatistics.project.id)!}';
					        	if(value != null && value != ''){
					        		var data = $('#projectSelect_statisticCourse').combobox('getData');
					        		var hasValue = false;
					        		$(data).each(function(){
					        			if(this.id == value){
					        				hasValue = true;
					        				return false;
					        			}
					        		});
					        		if(hasValue){
					        			$('#projectSelect_statisticCourse').combobox('select', value);
					        		}else{
					        			$('#projectSelect_statisticCourse').combobox('select', '');
					        		}
					        	}else{
					        		$('#projectSelect_statisticCourse').combobox('select', '');
					        	}
					        },
					        onSelect: function(record){
					        	var data = 'projectIds='+record.id;
					        	$.get('${ctx!}/train/api/trains',data,function(data){
					    			data.unshift({'name':'请选择','id':''});
					    			$('#trainSelect_statisticCourse').combobox('loadData', data);
					    		});
					        }
					        ">     
							<option value="">请选择...</option>
							<#list projects as project>
								<option value="${(project.id)!}">${(project.name)!}</option>
							</#list>
						</select>
					</td>
				</@projects>
				
				<td width="5%">&nbsp;&nbsp;培训：</td>
				<td width="10%">
					<select id="trainSelect_statisticCourse" name="train.id" value="${(courseStatistics.train.id)!}" class="easyui-combobox" style="width: 258px;" editable="false"
					data-options="
						valueField: 'id',
						textField: 'name',
						onLoadSuccess: function(){    
				            var value = '${(courseStatistics.train.id)!}';
				        	if(value != null && value != ''){
				        		var data = $('#trainSelect_statisticCourse').combobox('getData');
				        		var hasValue = false;
				        		$(data).each(function(){
				        			if(this.id == value){
				        				hasValue = true;
				        				return false;
				        			}
				        		});
				        		if(hasValue){
				        			$('#trainSelect_statisticCourse').combobox('select', value);
				        		}else{
				        			$('#trainSelect_statisticCourse').combobox('select', '');
				        		}
				        	}else{
				        		$('#trainSelect_statisticCourse').combobox('select', '');
				        	}
				        }
					">   
						<option value="">请选择...</option>
					</select>
				</td>
				<td></td>
			</tr>
			<tr>
				<td width="5%">课程名：</td>
				<td width="10%">
				<input style="width:258px;" type="text" class="easyui-textbox" name="title" value="${(courseStatistics.title)!}">
				</td>
				<td></td>
			</tr>
			<tr>
				<td colspan="6"><br />
					<button type="button" class="easyui-linkbutton main-btn" onclick="searchStatisticsCourse()">
						<i class="fa fa-search"></i> 查询
					</button>
				 	<button type="button" class="easyui-linkbutton" onclick="resetStatisticsCourse()">
						<i class="fa fa-plus"></i> 重置
					</button>  
				</td>
			</tr>
		</table>
	</div>
	<div id="tableType" style="display:block;">
	<table id="listStatisticsCourseTable"  pagination="true" rownumbers="true" 
	fitColumns="true" singleSelect="false" checkOnSelect="true" 
	selectOnCheck="true">
		<thead>
			<tr>
				<th width="10" data-options="field:'id',checkbox:true"></th>
				<th width="20" data-options="field:'title'">课程名</th>
				<th width="20" data-options="field:'organization'">课程机构</th>
				<th width="20" data-options="field:'type'">类型</th>
				<th width="20" data-options="field:'trainHeadcount'">选课人数</th>
				<th width="20" data-options="field:'passHeadcount'">合格人数</th>
				<th width="20" data-options="field:'passProportion'">合格率</th>
			</tr>
		</thead>
		<tbody>
			<#list courseStatisticsList as cs>
			<tr>
				<td>${(cs.id)!}</td>
				<td>${(cs.title)!}</td>
				<td>${(cs.organization)!}</td>
				<td>${DictionaryUtils.getEntryName('COURSE_TYPE', (cs.type)!) }</td>
				<td>${(cs.trainHeadcount)!}</td>
				<td>${(cs.passHeadcount)!}</td>
				<td>${(((cs.passProportion)!0)*100)?default(0.00)}%</td>
			</tr>
			</#list>
		</tbody>
	</table>
	<#if paginator??>
      <#import "../../include/pagination.ftl" as p/>
      <@p.pagination paginator=paginator! formId="listStatisticsCourseForm" type="easyui" tableId="listStatisticsCourseTable"/>
	</#if>
	</div>
	<div id="imageType" style="display:none;">
		<div id="statisticsCourseChart1" style="width:1517px; height: 400px;"></div>
	</div>
</form>
</@statisticsCourseData>
<script>

	$(function(){
		var myChart1 = echarts.init(document.getElementById('statisticsCourseChart1'));
		var titles = new Array();
		var seriesJson ;
		var seriesJsonArray = new Array();
		var seriesJsonStr = '';
		var rows = $("#listStatisticsCourseTable").datagrid("getRows");
		for(var i=0;i<rows.length;i++)
		{
			titles.push(rows[i].title);
			seriesJsonStr ='{"type":"bar","name":"'+rows[i].title+'"'+',"data":['+rows[i].trainHeadcount+','+rows[i].passHeadcount+']}';
			seriesJson = jQuery.parseJSON(seriesJsonStr);
			seriesJsonArray.push(seriesJson);
		}		
		var option1 = {
            tooltip: {
                show: true
            },
            legend: {
                data:titles
            },
            xAxis : [
                {
                    type : 'category',
                    data : ['选科人数', '合格人数']
                }
            ],
            yAxis : [
                {
                    type : 'value'
                }
            ],
            series :seriesJsonArray
        };
        myChart1.setOption(option1);		
	});
	
	function searchStatisticsCourse() {
		$('#listStatisticsCourseForm #page').val('1');
		removeDeleteCheckBox('listStatisticsCourseForm');
		easyui_tabs_update('listStatisticsCourseForm','layout_center_tabs');
	};
	
	function resetStatisticsCourse() {
		$('#listStatisticsCourseForm').form('clear');
	};
	
	function removeDeleteCheckBox(formId){
		$('#'+formId+' input[type="checkbox"]:checked').remove();
	}; 
	
	function changeType(a,formId){
		var type = $(a).val();
		if(type == 'table'){
			$('#' + formId + ' #tableType').show();
			$('#' + formId + ' #imageType').hide();
		}		
		if(type == 'image'){
			$('#' + formId + ' #tableType').hide();
			$('#' + formId + ' #imageType').show();
		}
	};
</script>