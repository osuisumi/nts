$(document).ready(function(){
    //公共模块js初始化
    qq_seriveJs.fn.init();
})
//定义公共模块js
var qq_seriveJs = $(window).qq_seriveJs || {};

qq_seriveJs.fn = {
    init : function(){
        var _this = this;
        //返回顶部
        _this.toTop();
        //侧边qq
        _this.addqq();
    },
    addqq : function(){
        //侧边qq，返回顶部模块html
        
        var epHtml =    '<div class="m-side-bigbox">'+
                            '<div class="m-side-qq">'+
                                '<a href="javascript:;" class="side-qq">'+        
                                    '<span class="icon-lt"><i class="u-qq-ico"></i></span>'+
                                    '<span class="txt">在线<br>客服</span>'+
                                '</a>'+
                                '<div class="ESQ-box">'+
                                    '<h3>在线客服</h3>'+
                                    '<ul class="ESQ-list">'+
                                        '<li class="ESQ-block">'+
                                            '<div class="call">'+
                                                '<i class="u-lit-qq"></i>'+
                                                '<span>在线客服1</span>'+
                                            '</div>'+
                                            '<a class="call-qq" href="http://wpa.qq.com/msgrd?v=3&amp;uin=2675604571&amp;site=qq&amp;menu=yes" target="_blank"><img alt="点击这里给我发消息" src="http://wpa.qq.com/pa?p=2:2675604571:51" style="border-width: 0px; border-style: solid;" title="点击这里给我发消息"></a>'+
                                        '</li>'+
                                        '<li class="ESQ-block">'+
                                            '<div class="call">'+
                                                '<i class="u-lit-qq"></i>'+
                                                '<span>在线客服2</span>'+
                                            '</div>'+
                                            '<a class="call-qq" href="http://wpa.qq.com/msgrd?v=3&amp;uin=2923944607&amp;site=qq&amp;menu=yes" target="_blank"><img  alt="点击这里给我发消息" src="http://wpa.qq.com/pa?p=2:2923944607:51" style="border-width: 0px; border-style: solid;" title="点击这里给我发消息"></a>'+
                                        '</li>'+
                                        '<li class="ESQ-block">'+
                                            '<div class="call">'+
                                                '<i class="u-lit-qq"></i>'+
                                                '<span>在线客服3</span>'+
                                            '</div>'+
                                            '<a class="call-qq" href="http://wpa.qq.com/msgrd?v=3&amp;uin=2969370854&amp;site=qq&amp;menu=yes" target="_blank"><img alt="点击这里给我发消息" src="http://wpa.qq.com/pa?p=2:2969370854:51" style="border-width: 0px; border-style: solid;" title="点击这里给我发消息"></a>'+
                                        '</li>'+
                                        '<li class="ESQ-block">'+
                                            '<div class="call">'+
                                                '<i class="u-lit-qq"></i>'+
                                                '<span>在线客服4</span>'+
                                            '</div>'+
                                            '<a class="call-qq" href="http://wpa.qq.com/msgrd?v=3&amp;uin=3550649221&amp;site=qq&amp;menu=yes" target="_blank"><img alt="点击这里给我发消息" src="http://wpa.qq.com/pa?p=2:3550649221:51" style="border-width: 0px; border-style: solid;" title="点击这里给我发消息"></a>'+
                                        '</li>'+
                                    '</ul>'+
                                '</div>'+

                            '</div>'+
                            '<div class="m-side-Totop">'+
                                '<a href="javascript:void(0);" id="toTop">'+
                                    '<span class="icon-lt"+><i class="t-ico"></i></span>'+
                                    '<span class="txt">返回</br>顶部</span>'+
                                '</a>'+          
                            '</div>'+
                        '</div>';
        $("body").append(epHtml);
    },
    //返回顶部
    toTop : function(){
        //点击返回顶部
        $(document).on("click","#toTop",function(){
            $('html,body').animate({
                scrollTop: 0
            },100);
            return false;
        })
    }
};

