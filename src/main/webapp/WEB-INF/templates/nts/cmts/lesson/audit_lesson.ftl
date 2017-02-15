<form id="auditLessonForm" action="/manage/discussion" method="put">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	
	<input type="hidden" name="id" value="${discussion.id }">
	<div class="mis-content">
	    <ol class="mis-topic-lst">
	        <li>
	            <div class="mis-topic-in">
	                <h3 class="title">您认为创课的想法及内容是否符合推广观摩要求？</h3>
	                <ol class="mis-question-lst">
	                    <li>
	                        <label class="mis-radio-tick">
	                            <strong>
	                                <i class="ico"></i>
	                                <input type="radio" name="state" value="no_pass">
	                            </strong>
	                            <span>未达标，还差一点点请教师继续努力</span>
	                        </label>
	                    </li>
	                    <li>
	                        <label class="mis-radio-tick">
	                            <strong>
	                                <i class="ico"></i>
	                                <input type="radio" name="state" value="passed">
	                            </strong>
	                            <span>已达标，通过审核同意进行下一步课程推广</span>
	                        </label>
	                    </li>
	                </ol>
	        	</div>
	        </li>
		</ol>
		<div class="mis-btn-row mis-subBtn-row">
            <button onclick="auditLesson()" type="button" class="mis-btn mis-main-btn">提交</button>
        </div>
	</div>
</form>
<script type="text/javascript">
	$(function(){
		$('.mis-radio-tick input').bindCheckboxRadioSimulate();
	});

	function auditLesson() {
		if(!$('#auditLessonForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('auditLessonForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_tabs_update('listCmtsLessonForm', 'layout_center_tabs');
				easyui_modal_close('auditLessonDiv');
			});
		}
	}
</script>