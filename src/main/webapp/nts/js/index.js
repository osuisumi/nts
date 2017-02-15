function closeLayer(){
	var index = parent.layer.getFrameIndex(window.name); 
	parent.layer.close(index); 
}

function downloadFile(id, fileName, type, relationId) {
	$('#downloadFileForm input[name="id"]').val(id);
	$('#downloadFileForm input[name="fileName"]').val(fileName);
	$('#downloadFileForm input[name="fileRelations[0].type"]').val(type);
	$('#downloadFileForm input[name="fileRelations[0].relation.id"]').val(relationId);
	//goLogin(function(){
		$('#downloadFileForm').submit();
	//});
}

function updateFile(id, fileName) {
	$('#updateFileForm input[name="id"]').val(id);
	$('#updateFileForm input[name="fileName"]').val(fileName);
	$.post('/file/updateFileInfo.do', $('#updateFileForm').serialize());
}

function deleteFileRelation(fileId, relationId, relationType) {
	$('#deleteFileRelationForm input[name="fileId"]').val(fileId);
	$('#deleteFileRelationForm input[name="relation.id"]').val(relationId);
	$('#deleteFileRelationForm input[name="type"]').val(relationType);
	$.post('/file/deleteFileRelation.do', $('#deleteFileRelationForm').serialize());
}

function deleteFileInfo(fileId) {
	$('#deleteFileInfoForm input[name="id"]').val(fileId);
	$.post('/file/deleteFileInfo.do', $('#deleteFileInfoForm').serialize());
}

function createCourseIndex(){
	window.location.href = '/make/course?orders=CREATE_TIME.DESC'
}

function goEditUser(userId){
	mylayerFn.open({
        type: 2,
        title: '个人资料',
        fix: false,
        area: [620, 800],
        content: '/ncts/users/'+userId+'/edit',
        shadeClose: true
    });
};

function previewFile(fileId){
	mylayerFn.open({
        type: 2,
        title: '预览文件',
        fix: true,
        area: [$(window).width() * 99 / 100, $(window).height() * 99 / 100],
        content: '/file/previewFile?fileId='+fileId,
        shadeClose: true
    });
}

function resetForm(btn){
	$(btn).closest('.mis-srh-layout').find('input').not(':button, :submit, :reset, :hidden').val('');
	$.each($(btn).closest('.mis-srh-layout').find('select'),function(i,n){
		$(n).find('option:first').prop("selected", 'selected');
	});
}

//显示搜索模块
function showCourseSelectbox(){
    //点击按钮显示隐藏
    $(".course-ManastPower-srh .stPower-srh").on('click',function(){
        var $this = $(this),
            tclass = 'z-crt';
        //判断是否在显示状态
        if($this.hasClass(tclass)){
            $this.removeClass(tclass).next().hide();
        }else {
            $this.addClass(tclass).next().show();
        }
        $(document).on('click.showCourseSearchbox',function(e){
            var target = $(e.target); 
            //点击其他地方隐藏
            if(target.closest(".course-ManastPower-srh .stPower-srh").length == 0 && target.closest(".mis-course-Machoose-serch").length == 0){ 
                //隐藏
                $this.removeClass(tclass).next().hide();
                //解除绑定
                $(document).off('click.showCourseSearchbox');
            };
        });
    });
};