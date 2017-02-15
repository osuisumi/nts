$(function(){

    //后台管理系统通用js
    misFn.init();
    //多选按钮模拟
    $('.mis-checkbox input').bindCheckboxRadioSimulate();
    $('.mis-checkbox-tick input').bindCheckboxRadioSimulate();
    //点选按钮模拟
    $('.mis-radio-tick input').bindCheckboxRadioSimulate();
    //模拟下拉框
    $(".mis-selectbox select").simulateSelectBox();

});


/*后台管理系统通用js*/
var misFn = $(window).misFn || {};
misFn = {
    init : function(){
        var _this = this;
        //设置侧边栏树框架和内容框架的高度
        _this.settingHeight();
        //多选框选择操作
        _this.checkboxSelect();
        //多选框关联操作按钮
        _this.checkboxCorrelationBtn($('.mis-table'),true);
    },
    //setting side tree height and content height
    settingHeight : function(){
        var middleHeight = $(window).height() - $('.mis-hd').innerHeight();
        $("#misSide").height(middleHeight + 'px');
        $("#misContent").css('height',middleHeight + 'px');
        $("#rightFrame").css('height',middleHeight + 'px');
    },
    /*
        table checkbox selected 
        多选框选择操作
    */
    checkboxSelect : function(){
        //操作选择框
        $('.mis-table').on('click','.checkRow',function(){
            var $this = $(this);
            //判断当前多选框是否选中
            if($this.is(':checked')){
                addStyle($this);
            }else {
                removeStyle($this);
            }
            //关联操作按钮
            misFn.checkboxCorrelationBtn($this.parents(".mis-table"),true);

        });
        //给tr添加选中样式
        function addStyle(element){
            element.parents('tr').addClass('z-crt');
        };
        //移除tr选中样式
        function removeStyle(element){
            element.parents('tr').removeClass('z-crt');
        };
    },
    //多选框关联操作按钮
    checkboxCorrelationBtn : function(misTable,ifSettingTr){
        //获取元素
        var $checkbox = misTable.find('.checkRow'),
            $optRow = misTable.parents(".mis-table-layout").find(".mis-opt-row"),
            $optBtn = $optRow.find('.mis-btn'),
            $selectedNum = $optRow.find('.selectedNum .num');

        //默认设置当前多选框已选择数量为0
        var checkedNum = 0;
        $checkbox.parents('tr').removeClass('z-crt');   
        //判断选中数量
        for(var i = 0; i < $checkbox.length; i++){
            if($checkbox.eq(i).is(':checked')){
                checkedNum++;
                if(ifSettingTr){
                    //给选中tr添加已选中效果
                    $checkbox.eq(i).parents('tr').addClass('z-crt');
                }
            }
            //记录选中数
            $selectedNum.text(checkedNum);
        }
        //console.log(checkedNum);
        //判断选择个数
        if(checkedNum <= 0){
            //没选中是给按钮添加disabled
            for(var i = 0; i < $optBtn.length; i++){
                if($optBtn.eq(i).attr("correlation") == 'true'){
                    $optBtn.eq(i).addClass('disabled').prop('disabled',true)
                }
            }
        }else {
            //没选中是给按钮添加disabled
            for(var i = 0; i < $optBtn.length; i++){
                if($optBtn.eq(i).attr("correlation") == 'true'){
                    $optBtn.eq(i).removeClass('disabled').prop('disabled',false);
                }
            }
        }
    },
    /*
        全选
        checkAllBtn： 全选多选框
        checkboxs: 被全选的多选框
        fn：执行函数
    */
    checkboxAll : function(checkAllBtn,checkboxs,fn){
        //点击全选按钮
        checkAllBtn.on('click',function(){
            //判断是否选中
            if(checkAllBtn.is(':checked')){
                //执行全选
                checkboxs.prop('checked',true);
            }else {
                checkboxs.prop('checked',false);
            }
            //执行函数
            fn();
        });
    },
    /*
        右边侧边栏显示
        ifShow: 是否显示右边侧边栏，true为显示，false为不显示, 默认为true
    */
    showRightFrame : function(ifShow){
        //获取主内容和侧边栏
        var $content = $("#misContent");
        var $rightFrame = $("#rightFrame");
        //判断是否显示侧边栏
        if(ifShow == true || ifShow == undefined || ifShow == "undefined" || ifShow == null || ifShow == "") {
            $content.css('padding-right',$rightFrame.innerWidth() + "px");
        }else {
            $content.css('padding-right',0);
            $rightFrame.hide();
        }
    }   
};





/*--start-----radio单选与checkbox多选按钮的模拟---start---*/
(function ($) {
    $.fn.bindCheckboxRadioSimulate = function (options) {
        var settings = {
            className: 'on',
            onclick: null,
            checkbox_checked_fn: function (obj) {
                obj.parent().addClass(this.className);
            },
            checkbox_nochecked_fn: function (obj) {
                obj.parent().removeClass(this.className);
            },
            radio_checked_fn: function (obj) {
                obj.parent().addClass(this.className);
            },
            radio_nochecked_fn: function (obj) {
                obj.parent().removeClass(this.className);
            }
        };
        $.extend(true, settings, options);

        //input判断执行
        function inputJudge_fn(obj_this) {
           
            var $this = obj_this,
                $type;
            if ($this.attr('type') != undefined) {
                $type = $this.attr('type');
                if ($type == 'checkbox') {//if=多选按钮
                    if ($this.prop("checked")) {
                        settings.checkbox_checked_fn($this);
                    } else {
                        settings.checkbox_nochecked_fn($this);
                    }
                } else if ($type == 'radio') {//if=单选按钮
                    var $thisName;
                    if ($this.attr('name') != undefined) {
                        $thisName = $this.attr('name');
                        if ($this.prop("checked")) {
                            settings.radio_checked_fn($this);
                            $("input[name='" + $thisName + "']").not($this).each(function () {
                                settings.radio_nochecked_fn($(this));
                            });
                        } else {
                            settings.radio_nochecked_fn($this);
                        }
                    }
                }
            }
        }
        return this.each(function () {
            inputJudge_fn($(this));
        }).click(function () {
            inputJudge_fn($(this));
            if (settings.onclick) {
                settings.onclick(this, {
                    isChecked: $(this).prop("checked"),//返回是否选中
                    objThis: $(this)//返回自己
                });
            }
        });
    };
})(jQuery);
/*--end-----radio单选与checkbox多选按钮的模拟---end---*/


/*--start-----下拉多选款select按钮模拟---start---*/
(function ($) {
    $.fn.simulateSelectBox = function (options) {
        var settings = {//默认参数
            selectText: '.simulateSelect-text',
            byValue: null
        };
        //$.extend(true, settings, options);
        var options = $.extend(true,settings,options),
            _ts = this,
            selectText = options.selectText, //下拉框模拟文字class
            byValue = options.byValue;  //传入value值，重置默认选中


        return _ts.each(function(){
            var $this = $(this);
            
            //清除其他选中
            //$this.find('option').prop('selected',false);
            //alert($this.find('option:selected').text());
            //判断是否传入value值
            if(byValue == "" || byValue == null || byValue == undefined){
                //$this.find('option').eq(0).prop('selected',true);
            }else {
                //console.log(byValue);
                //编辑选项，匹配传入的value值
                for(var i = 0; i < $this.find('option').length; i++){
                    if($this.find('option').eq(i).val() == byValue) {
                        //设置传入的value值选项为默认选中
                        $this.find('option').eq(i).prop('selected',true);
                    }
                }
            }
            //改变模拟下拉框的文字
            $this.parent().find(selectText).text($this.find('option[selected="selected"]').text());
            $this.parent().find(selectText).text($this.find('option:selected').text());
        //点击下拉改变
        }).on('change',function(){
            //改变模拟下拉框的文字
            $(this).parent().find(selectText).text($(this).find('option:selected').text());
        });

    };
})(jQuery);
/*--end-----下拉多选款select按钮模拟---end---*/

/*
树打开关闭  
selectNode: 默认选中第几个节点，包括最外层的节点
onOff:打开当前菜单时，其他菜单是否关闭，true为关闭，flase为不关闭,不传参数默认为false
*/
function misTreeFn(selectNode,onOff){
    var $misTree = $("#misTree");


    if(!isNaN(selectNode)){
        
        var $selectNode = $misTree.find('li').eq(selectNode);
        $selectNode.addClass('z-crt open').children().addClass('z-crt').attr('data-open',true);
        $selectNode.parents('.inner-item').addClass('open z-crt');
        $selectNode.parents('.mis-tree-inner').show().prev().addClass('z-crt open').attr('data-open',true);
    }

    //alert($misTree.find('li').eq(5).html());
    //点击图标展开收起树
    $misTree.on('click',".mis-tree-info",function(){
        var $this = $(this),
            $treeItem = $this.parent();
        

        //判断是否在打开状态
        if($this.attr('data-open') === "true"){
            $this.attr('data-open',false).removeClass('open').next().hide();
            $treeItem.removeClass('open');
        }else if($this.attr('data-open') === "false") {

            if(onOff === '' || onOff === undefined || onOff === 'undefined' || onOff === null){

            }else if(onOff == true){
                $misTree.children().removeClass('open').children('.mis-tree-info').attr('data-open',false).removeClass('open');
                $misTree.find('.inner-item').removeClass('open z-crt');
                $misTree.find('.inner-info').attr('data-open',false).removeClass('open');
                $misTree.find('.mis-tree-inner').hide();
            }

            $this.attr('data-open',true).addClass('open').next().show();
            $treeItem.addClass('open');
        }
    });
    //点击图标展开收起树
    $misTree.on('click',".inner-info",function(){
        var $this = $(this),
            $treeItem = $this.parent();

        $misTree.find('.mis-tree-inner .inner-item').removeClass('z-crt');
            
        if($this.next().length > 0){
            //判断是否在打开状态
            if($this.attr('data-open') === "true"){
                $this.attr('data-open',false).removeClass('open').next().hide();
                $treeItem.removeClass('open z-crt');
            }else if($this.attr('data-open') === "false") {
                $this.attr('data-open',true).addClass('open').next().show();
                $treeItem.addClass('open z-crt');
            }
        }else {
            $misTree.find('.inner-info').removeClass('z-crt');
            $this.addClass('z-crt').parents('.inner-item').addClass('z-crt');
        }

    });
    

};

//控制blue1树的打开关闭样式
function treecolor(){
    $(".mis-tree-inner").find(".mis-tree-inner.tree-bottom").parents(".inner-item.z-crt").children('.inner-info').addClass('addyellow');
    $("body").on("click",".mis-tree-inner .inner-info",function(){
        var itemsP = $(this).siblings('.mis-tree-inner.tree-bottom').length;
        var itemsPS = $(this).parents('.mis-tree-inner.tree-bottom').length;
           // alert(itemsP)
           // alert(itemsPS)
        if(itemsP==0 && itemsPS==0 && $(this).hasClass("z-crt")){
            // alert(1)
             $(".mis-tree-inner").find(".inner-info").removeClass('addyellow').addClass('delcolor')
             $(this).addClass('addyellow');
         }else if(itemsP==1 && itemsPS==0){


         }else if(itemsP==0 && itemsPS==1 && $(this).hasClass("z-crt")){
              $(".mis-tree-inner").find(".inner-info").removeClass('addyellow').removeClass('delcolor')
             $(this).parents(".mis-tree-inner.tree-bottom").siblings('.inner-info').addClass('addyellow');
         }

    })


    $("body").on("click",".mis-tree .mis-tree-item",function(){
        var indexnum = $(this).index();
        var attrtxt = $(this).children(".mis-tree-info").attr("data-open")
        // alert(attrtxt)
        $(".mis-tree-item").each(function(index, el) {
            if(!$(this).children('.mis-tree-info').hasClass("open")){
                $(this).find(".inner-info.z-crt").parents(".mis-tree-item").addClass('addyellow').addClass('addstyle');
                if($(this).siblings().find(".inner-info").hasClass('z-crt')){
                    $(this).removeClass('addyellow').removeClass('addstyle');
                }
            }else{
                $(this).removeClass('addyellow').removeClass('addstyle');
            }
        });
        if($(this).hasClass("open")){

            $(this).find(".inner-info.z-crt").parents(".mis-tree-inner.tree-bottom").css({"display":"block"});
        } 

    });
    var clickup=true;
    $("body").on("click",".mis-shrink-tree",function(){
        if(clickup==true){
            $(".mis-sd").addClass('addwidth');
            $(".mis-wrap").addClass('addpadd');
            $(".mis-shrink-tree .opt").addClass('opt-hori');
            $(".mis-tree-item").each(function(index, el) {
                $(this).addClass('addheight');
                $(this).find('.inner-info.z-crt').parents(".mis-tree-item").addClass('addclose');
            });
            clickup=false;                
        }else if(clickup==false){

            $(".mis-sd").removeClass('addwidth');
            $(".mis-wrap").removeClass('addpadd');
            $(".mis-shrink-tree .opt").removeClass('opt-hori');
            $(".mis-tree-item").each(function(index, el) {
                $(this).removeClass('addheight').removeClass('addclose');
                $(this).find('.inner-info.z-crt').parents(".mis-tree-item").removeClass('addclose');
            });   
            clickup=true;            
        }

    });

};