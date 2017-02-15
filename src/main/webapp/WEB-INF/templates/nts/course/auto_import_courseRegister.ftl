<form id="autoImportCourseRegisterForm" action="/manage/courseRegister/autoImportCourseRegister" method="post">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />

	<input type="hidden" name="courseId" value="${courseId }">
	<input type="hidden" name="trainId" value="${trainId }">
	
	<div class="mis-content">
		<ul class="mis-course-config">
			<li class="mis-course-configLi">
		        <h3 class="tl">
		            <span>请选择学段：</span>
		        </h3> 
		        <div class="mis-course-config-cont2">
		            <label class="mis-radio-tick">
		                <strong>
		                    <i class="ico"></i>
		                    <input type="radio" name="stage" class="" value="">
		                </strong>
		                <span>全部学段</span>
		            </label>     
		            <br>
		            <label class="mis-radio-tick">
		                <strong>
		                    <i class="ico"></i>
		                    <input type="radio" name="stage" class="" value="幼儿园">
		                </strong>
		                <span>幼儿园</span>
		            </label>      
		            <br>
		            <label class="mis-radio-tick">
		                <strong>
		                    <i class="ico"></i>
		                    <input type="radio" name="stage" class="" value="小学">
		                </strong>
		                <span>小学</span>
		            </label>      
		            <br>
		            <label class="mis-radio-tick">
		                <strong>
		                    <i class="ico"></i>
		                    <input type="radio" name="stage" class="" value="初中">
		                </strong>
		                <span>初中</span>
		            </label>      
		            <br>
		            <label class="mis-radio-tick">
		                <strong>
		                    <i class="ico"></i>
		                    <input type="radio" name="stage" class="" value="高中">
		                </strong>
		                <span>高中</span>
		            </label>      
		            <br>
		        </div>
		    </li>
		    <li class="mis-course-configLi">
		        <button onclick="autoImportCourseRegister()" type="button" class="mis-btn mis-inverse-btn"><i class="mis-next-ico"></i>导入</button>
		    </li>
		</ul>
	</div>
</form>
<script type="text/javascript">
	$(function(){
		//多选按钮模拟
		$('.mis-radio-tick input').bindCheckboxRadioSimulate();
	});

	function autoImportCourseRegister(){
		confirm('确定要按所选条件导入选课?', function(){
			var data = $.ajaxSubmit('autoImportCourseRegisterForm');
			var json = $.parseJSON(data);
			if(json.responseCode == '00'){
				alert('导入成功');
				$('.tag_name').eq(2).trigger('click');
				easyui_tabs_update('listCourseRegisterForm','layout_center_tabs');
			}
		});
	}
</script>