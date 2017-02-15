<form id="saveDepartmentForm" action="${ctx!}/manage/departments" method="post">
	<#import "/nts/include/tab.ftl" as tab/>
	<@tab.tabFtl items=items[0] />
	<input id="ctx" type="hidden" name="ctx" value="${ctx!}">
	<#if (department.id)??>
		<input id="id" type="hidden" name="id" value="${(department.id)!}">
		<script>
			$(function(){
				$('#saveDepartmentForm').attr('method','put');
				$('#saveDepartmentForm').attr('action','${ctx!}/manage/departments');
			});
		</script>
	</#if>
	<div class="mis-srh-layout">
	    	<ul class="mis-ipt-lst">
		    	<li class="item">
					<div class="mis-ipt-row">
		                <div class="tl">
		                    <span>机构名称：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-ipt-mod">
		                        <input type="text" id="deptName" name="deptName" value="${(department.deptName)!}" placeholder="请输入机构名称..." class="mis-ipt required">
		                    </div>
		                </div>
		            </div>
				</li>
				<li class="item">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>机构类型：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-select">
		                        <select name="deptType" id="deptTypeSelect">
		                        	<option value="2" >学校机构</option>  
									<#--<option value="1" >行政机构</option>  
								    <option value="3" >个人用户</option>--> 
		                        </select>    
		                    </div>
		                </div>
		            </div>
		        </li>
		        <script>
		        	$(function(){
			   	 		$('#deptTypeSelect option[value="${(department.deptType)!}"]').attr('selected','selected');
		        		var deptTypeSelectValue = $('#deptTypeSelect').val();
		        		if(deptTypeSelectValue == '2'){
		 						$('#stageLi').show();
		 						$('#stageLi select').removeAttr("disabled");
		 					}else{
		 						$('#stageLi').hide();
		 						$('#stageLi select').attr("disabled",true);
		 					}
		        		
		        		$("#deptTypeSelect").change(function(){
					 		var _this = $(this);
					 		if(_this.val() == '2'){
		 						$('#stageLi').show();
		 						$('#stageLi select').removeAttr("disabled");
		 					}else{
		 						$('#stageLi').hide();
		 						$('#stageLi select').attr("disabled",true);
		 					}
					    });
		        	});
		        </script>
		        <#--<li class="item">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>上级机构：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-select">
		                        <select name="parentDepartment.id" id="departmentSelect">
									<@departmentsData>
										<#list departments as d>
											<option value="${(d.id)!}" >${(d.deptName)!}</option>  
										</#list>
									</@departmentsData>
		                        </select>    
		                    </div>
		                </div>
		            </div>
		        </li>-->
		        <#if (department.parentDepartment.id)?? && (department.parentDepartment.id) != ''>
					<script>
						$(function(){
							$('#saveDepartmentForm #departmentSelect option[value=${(department.parentDepartment.id)!''}]').attr('selected',true);
						});
					</script> 
				</#if>
		        <li class="item">
	                <div class="mis-ipt-row">
	                    <div class="tl">
	                        <span>机构代码：</span>
	                    </div>
	                    <div class="tc">
		                    <div class="mis-ipt-mod">
		                        <input type="text" id="deptCode" name="deptCode" value="${(department.deptCode)!}" placeholder="请输入机构代码..." class="mis-ipt required">
		                    </div>
		                </div>
	                </div>
	            </li>
	        	<li class="item">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>机构链接：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-ipt-mod">
		                        <input type="text" name="website" value="${(department.website)!}" placeholder="请输入机构链接..." class="mis-ipt required">
		                    </div>
		                </div>
		            </div>
		        </li>
		        <li class="item" id="stageLi">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>学段：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-select">
		                        <select name="stage">
									<option value="1">小学</option>
					                <option value="2">初中</option>
					                <option value="3">高中</option>
		                        </select>    
		                    </div>
		                </div>
		            </div>
		        </li>
		        <script>
                	$(function(){
                		$('#stageLi select option[value="${(department.stage)!}"]').attr('selected','selected');
                	})
                </script>
                <li class="item">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>省：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-select">
		                        <select name="province.regionsCode" id="province">
									<option class="static" value="">请选择省</option>
                                   	${RegionsUtils.getEntryOptionsSelected('1', (province.regionsCode)!'')}
		                        </select>
		                    </div>
		                </div>
		            </div>
		        </li>
		        <li class="item">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>市：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-select">
		                        <select name="city.regionsCode" id="city">
		                        	<option class="static" value="">请选择市</option>
		                        	<#if (department.province)??>
										<#list RegionsUtils.getEntryList('2', (department.province.regionsCode)!'') as entry>
	                                   		<option class="cityOption" value="${entry.regionsCode}">${entry.regionsName}</option>
	                                   	</#list> 
                                   	</#if>
		                        </select>
		                    </div>
		                </div>
		            </div>
		        </li>
		        <li class="item">
		            <div class="mis-ipt-row">
		                <div class="tl">
		                    <span>区：</span>
		                </div>
		                <div class="tc">
		                    <div class="mis-select">
		                        <select name="counties.regionsCode" id="counties">
		                        	<option class="static" value="">请选择区</option>
		                        	<#if (department.city)??>
										<#list RegionsUtils.getEntryList('3', (department.city.regionsCode)!'') as entry>
	                                   		<option class="countiesOption" value="${entry.regionsCode}">${entry.regionsName}</option>
	                                   	</#list> 
                                   	</#if>
		                        </select>
		                    </div>
		                </div>
		            </div>
		        </li>
			</ul>
		</div>
		<div class="mis-btn-row indent1">
	        <button onclick="saveDepartment()" type="button" class="mis-btn mis-main-btn"><i class="mis-save-ico"></i>保存</button>
	    </div>
</form>
<script type="text/javascript">

	$(function(){
	
		$("#saveDepartmentForm").validate({
			rules : {
				deptName : {
					required : true,
					remote : {
						url :  $('#ctx').val() + '/manage/departments/countForValidDeptNameIsExist?id=${(department.id)!""}', 
	                    type : "get", 
	                    dataType : "text",
						data :  {
							deptName : function() {   
			                    return $("#deptName").val() ;   
			                }
						},
						dataFilter : function (result,type) {
							return parseInt(result) > 0 ? false : true;
						} 
					}
				},
				deptCode : {
					required : true,
					remote : {
						url :  $('#ctx').val() + '/manage/departments/ValidDeptCodeIsExist?id=${(department.id)!""}', 
	                    type : "get", 
	                    dataType : "text",
						data : {
							deptCode : function() {   
			                    return $("#deptCode").val() ;   
			                }
						},
						dataFilter : function (result,type) {
							return parseInt(result) > 0 ? false : true;
						} 
					}
				}
			},
			messages : {
				deptName : {
					required : '必填',
					remote : '机构名称已存在'
				},
				deptCode : {
					required : '必填',
					remote : '组织机构代码已存在'
				}
			}
		});
		
		$("#province").simulateSelectBox({
	    	byValue: '${(department.province.regionsCode)!""}'
	    });
	    $("#city").simulateSelectBox({
	    	byValue: '${(department.city.regionsCode)!""}'
	    });
	    $("#counties").simulateSelectBox({
	    	byValue: '${(department.counties.regionsCode)!""}'
	    });
	    
	  	//省市区联动
	    $('#province').on('change',function(){
	    	var _this = $(this);
	    	$.get('${ctx}/regions/entities',{
	    		"level":'2',
	    		"parentCode":_this.val(),
	    	},function(regions){
	    		$('#city .cityOption').remove();
	    		$('#city .static').attr('selected','selected');
	    		$('#city').trigger('change');
	    		$.each(regions,function(i,n){
	    			$('#city').append('<option class="cityOption" value="'+n.regionsCode+'" >'+n.regionsName+'</option>');
	    		});
	    	});
	    });
	    
	    $('#city').on('change',function(){
	    	var _this = $(this);
	    	$.get('${ctx}/regions/entities',{
	    		"level":'3',
	    		"parentCode":_this.val(),
	    	},function(regions){
	    		$('#counties .countiesOption').remove();
	    		$('#counties .static').attr('selected','selected');
	    		$.each(regions,function(i,n){
	    			$('#counties').append('<option class="countiesOption" value="'+n.regionsCode+'" >'+n.regionsName+'</option>');
	    		});
	    	});
	    });
	
	});

	function saveDepartment() {
		if(!$('#saveDepartmentForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('saveDepartmentForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			$.messager.alert("提示信息", "操作成功！", 'info', function() {
				easyui_tabs_update('listDepartmentForm', 'layout_center_tabs');
				easyui_modal_close('editDepartmentDiv');
			});
		}
	}
</script>