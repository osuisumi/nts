<div class="mis-sd" id="misSide">
	<div class="mis-shrink-tree"><a href="javascript:;" class="opt"></a></div>
	<div class="mis-tree-wp">
    	<ul class="mis-tree" id="misTree">
             
        </ul>
    </div>   
</div>

<script type="text/javascript">
$(document).ready(function(e) {
	createMenuTree();
});
function createMenuTree(){
	$.get('/manage/nts/auth_menus/tree', 'userId=${Session.loginer.id}', function(data){
		$(data).each(function(i, k){
			var icon = 't1';
			if(i < 8){
				icon = 't'+(i+1);	
			}else{
				icon = 't'+(i-7);	
			}
			var li = '<li id="li_'+i+'" class="mis-tree-item '+icon+'">'+
					 	'<div class="mis-tree-info" data-open="false">'+
							'<a href="javascript:;" class="dt" title="">'+
								'<span class="txt">'+this.name+'</span>'+
								'<span class="open-icon"></span>'+
							'</a>'+
						'</div>'+
					 '</li>'
			$('#misTree').append($(li));
			if($(this.children).length > 0){
				var ul = '<ul id="ul_'+i+'" class="mis-tree-inner"></ul>';
				$('#li_'+i).append(ul);
				$(this.children).each(function(){
					var url = this.permission.actionURI;
					var name = this.name;
					var li1 = '<li class="inner-item">'+
			                  	'<div class="inner-info"  data-open="false">'+
							  		'<a onclick="loadMenu(\''+url+'\',\''+name+'\')" href="javascript:;" class="dt"><span class="txt">'+this.name+'</span></a>'+
								'</div>'+
							  '</li>'
					$('#ul_'+i).append($(li1));
				});
			}
		});
		misTreeFn(2,true);
	    treecolor();
	});
}

function loadMenu(url, name){
	var items = new Array();
	items.push(name);
	$('#content').load(encodeURI(url),encodeURI('items='+JSON.stringify(items)));
	$('.contentDiv').nextAll('.contentDiv').remove();
	$('#content').show();
}
</script>