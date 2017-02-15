<@testDirective id=testId>
<@testPackageDirective testPackage=test.testPackage>
	<#if questions??>
		<#list questions as question>
			<div>
				<div class="qTitle">${question.title!}</div>
				<ul>
					<#if question.quesType ='SINGLE_CHOICE' || question.quesType ='MULTIPLE_CHOICE' || question.quesType = 'TRUE_FALSE'>
						<#if question.interactionOptions??>
							<#list question.interactionOptions as interactionOption>
								<#if interactionOption??>
									<li class="choice">
										<#if question.quesType == 'SINGLE_CHOICE' || question.quesType == 'TRUE_FALSE'>
											<input disabled="disabled" type="radio" <#if (question.correctOption!'') ==interactionOption.id>checked="checked"</#if> >${interactionOption.text}
										<#else>
											<#assign isCorrect="false"/>
											<#list question.correctOptions as correctOption>
												<#if correctOption==interactionOption.id>
													<#assign isCorrect="true"/>
												</#if>																		
											</#list>
											<input disabled="disabled" type="checkbox" <#if isCorrect =="true">checked="checked"</#if> >${interactionOption.text}
										</#if>	
									</li>
								</#if>
							</#list>
						</#if>
					</#if>				
				</ul>
			</div>
		</#list>
	</#if>
	<script>
		$(function(){
			$('.qTitle').css('background-color','#cccccc').css('margin-top','10px');
		});
	</script>
</@testPackageDirective>
</@testDirective>