<@survey id=surveyId!>
	<#if survey.questions??>
		<#list survey.questions as question>
			<div>
				<div class="qTitle">${question.title!}</div>
				<ul>
					<#if question.type ='singleChoice' || question.type ='multipleChoice' || question.type = 'trueOrFalse'>
						<#if question.choiceGroups??>
							<#list question.choiceGroups as choiceGroup>
								<#if choiceGroup.choices??>
									<#list choiceGroup.choices as choice>
										<li class="choice">
											<#if question.type ='multipleChoice'>
												<input type="checkbox">
											<#else>
												<input type="radio">
											</#if>
												${choice.content!}
										</li>
									</#list>
								</#if>
							</#list>
						</#if>
					<#else>
						<#if (question.textEntryInteraction.minWords)??>
							<#if question.textEntryInteraction.minWords != 0>最小字数${(question.textEntryInteraction.minWords)!}<#else>最小字数不限</#if>
						</#if>
						<#if (question.textEntryInteraction.maxWords)??>
							<#if question.textEntryInteraction.maxWords != 0>，最大字数${(question.textEntryInteraction.maxWords)!}<#else>最大字数不限</#if>
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
</@survey>