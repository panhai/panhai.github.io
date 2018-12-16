/* 
* @Last Modified time: 2015-10-12 16:46:43
*/
$(document).ready(function(){
    


    /*邮箱提示*/

    //输入邮箱地址时的自动提示
    $(function(){
      var emails = 'qq.com,163.com,126.com,139.com,sohu.com,sina.com,21cn.com,yeah.net,tom.com'.split(',');
      $(".EMAILS").on('keyup focus click',function(event){
        var key=event.which;
        if($.inArray(key,[40,38,13])>=0 && event.type=='keyup')return true;
        key=this.value;
        var dl=$(this).closest('dl'),
          result=dl.find('.matches');
        //不是邮箱收回提示和匹配
        if(key.indexOf("@") === -1)
        {
          result.hide();
          return true;
        }
        var results,passport;
        //如果输入了@则会过滤掉一些邮箱后缀
        if(key.indexOf('@')>0)
        {
          results=[];
          var arr=key.split('@'),suffix=arr[1];
          passport=arr[0];
          for(var n=0; n<emails.length;n++)
          {
            if(emails[n].indexOf(suffix)>=0) results.push(emails[n]);
          }
        }
        else
        {
          results=emails;
          passport=key;
        }
        var str=[];
        for(var n=0;n<results.length;n++)
        str.push('<a href="javascript:void(0)">', passport , '@' , results[n] ,'</a>');
        result.html(str.join('')).show();
      }).closest(".SELECT").data('type','string');
    });
// 点击发送验证码的倒计时效果
//已签至页面
//$(function(){
//    var tip1=$(".SendVerify").val(),
//        tip2='秒后重发';
//    $(".SendVerify").click(function(){
//        var O=this;
//        if(O.disabled) return;
//        var number=60;
//        O.disabled=true;
//        $(O).addClass("disabled").val(number+tip2);
//        O.timer=setInterval(function(){
//            number--;
//            O.value=number+tip2;
//            if(!number)
//            {
//                clearTimeout(O.timer);
//                O.timer=0;
//                O.disabled=false;
//                $(O).removeClass("disabled").val(tip1);
//            }
//        },1e3);
//    });
//})

});
  

  