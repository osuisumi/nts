<body id="layer">
<div class="g-layer-box">
	<input id="total" type="hidden" value="${(total[0])!}">
	<div style="text-align: center">共有${(total[0])!}条数据</div>
    <form id="trainRegisterStatExportFrom" action="${ctx}/manage/workshop/worker_stat/export" method="get" target="_blank">
    	<input type="hidden" name="realName" value="${(realName[0])!}">
    	<input type="hidden" name="title" value="${(title[0])!}">
    	<input type="hidden" name="assignmentSubmitType" value="${(assignmentSubmitType[0])!}">
        <ul class="mis-ipt-lst">
            <li class="item">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>导出条数：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-ipt-mod">
                            <input id="limit" type="text" name="limit"  placeholder="请输入导出条数"  class="mis-ipt" required="" aria-required="true">
                        </div>
                    </div>
                </div>
            </li>
            <li class="item">
                <div class="mis-ipt-row">
                    <div class="tl">
                        <span>页数：</span>
                    </div>
                    <div class="tc">
                        <div class="mis-selectbox">
                            <strong><span class="simulateSelect-text">请选择页数</span><i class="trg"></i></strong>
                            <select id="pageSelect" name="page">
                            	<option name="default">请选择页数</option>
                            </select>
                        </div>
                    </div>
                </div>
            </li>
        </ul>
		<div class="mis-btn-row mis-subBtn-row">
            <a href="javascript:;" onclick="doExport()" class="mis-btn mis-main-btn">导出</a>
        </div>
    </form>
</div>
<script>
	$(function(){
		$(".mis-selectbox select").simulateSelectBox();
		$('#limit').focusout(function(){
			var defaultOption = $('#pageSelect option').eq(0).clone();
			$('#pageSelect').empty();
			$('#pageSelect').append(defaultOption);
			$('#pageSelect').val('');
			var limit = $(this).val();
			limit = parseInt(limit);
			if(limit){
				var page = 1;
				var total = $('#total').val();
				total = parseInt(total);
				if(total>limit){
					page = Math.ceil(total/limit);
				}
				for(var i=1;i<=page;i++){
					$('#pageSelect').append('<option value="'+i+'">'+i+'</option>');
				}
			}
		});
	});

	function doExport(){
		var page = $('#pageSelect').val();
		page = parseInt(page);
		if(!page){
			alert('请填写有效的条数和页数');
			return false;
		}else{
			$('#trainRegisterStatExportFrom').submit();
		}
	}
</script>
</body>