<#macro content activity>
	<@testDirective id=(activity.entityId)!''>
		<div class="splitLine"><span>基本信息</span></div>
		<div><span class="key">测验标题:</span><span class="value">${(test.title)!}</span></div>
		<div>
			<span class="key">测验描述:</span>
			<div class="ueContent">${(test.description)!}</div>
		</div>
		<div>
			<span>题目信息:</span>
			<span class="value"><button onclick="openTestQuestionWindow('${activity.entityId!}')" type="button" class="easyui-linkbutton main-btn l-btn l-btn-small">查看题目列表</button></span>
		</div>
		<br>
	</@testDirective>
	<script>
		$('.ueContent').css('line-height','26px').css('margin','0 30px 0px 30px').css('color','#a4a4a4').css('font-size','16px');
		$('.value').css('padding-left','10px');
		
		function openTestQuestionWindow(testId){
			easyui_modal_open('test_question', '题目列表', 600, 700, '${ctx}/manage/course/testQuestion?testId='+testId, true);
		}
	</script>
</#macro>
