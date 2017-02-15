window.onload=function(){
    clientHeight();
    
	entryAnimation();

}

function clientHeight(){
    var clientHeight=document.documentElement.clientHeight;
    var mainBox = document.getElementById("mainBox");

    mainBox.style.minHeight = clientHeight - 236 + 'px';
    //alert(mainBox);
}


function entryAnimation(){
	var $block = $(".entry-lst .block"),
		$hoverBlock = $block.find(".link");

	$hoverBlock.on("mouseover",function(){
		$block.stop();
		var index = $hoverBlock.index(this);
		$block.addClass("dim");
		$block.eq(index).removeClass("dim");
		$block.animate({opacity: 0.8},200);
		$block.eq(index).animate({opacity: 1},200);
		
	})
	$hoverBlock.on("mouseout",function(){
		$block.stop();
		$block.removeClass("dim");
		$block.animate({opacity:1},400);
		
	})

}