/* 
* @Author: ssf
* @Date:   2015-12-14 15:44:56
* @Last Modified by:   ssf
* @Last Modified time: 2015-12-23 18:12:50
*/

$(document).ready(function(){
    // 侧边栏
    $(".main-l h2").click(function(event) {
        if($(this).hasClass('on')){
            $(this).siblings('ul').slideDown(400)
            .end()
            .removeClass('on');
        }else{
            $(this).siblings('ul').slideUp(400)
            .end()
            .addClass('on');
        }
    });

    // 复选
    var hideVal = $(".full-sign").find('[type="hidden"]');
    console.log(hideVal)
     $(".main-r table").delegate("label","click",function(event){

             if(!$(this).hasClass('check')){
                 $(this).addClass('check')
                         .find("input").prop("checked",true);
             hideVal.val(hideVal.val()+$(this).find('input').data("id")+',')
           var id = $(this).find('input').data("id");
           
             }else if($(this).has(":checkbox").size()){
                 $(this).removeClass('check')
                         .find("input").prop("checked",false);
                   hideVal.val( (hideVal.val().replace($(this).find('input').data("id")+',','')))
             }
         return false;

     });


     $(".full-sign label").click(function(){
         var _this = this;
          if(!$(this).hasClass('check')){
                 $(this).addClass('check')
                         .find("input").prop("checked",true);
           
             }else if($(this).has(":checkbox").size()){
                 $(this).removeClass('check')
                         .find("input").prop("checked",false);
             }
         hideVal.val('');
         setTimeout(function(){
             var bool = $(_this).hasClass("check"),
                     attr = bool ? "addClass":"removeClass";
             $(".bj-info table").find("label").each(function(idx,el){

                 $(this)[attr]("check").find("input").prop("checked",bool);
             
                 bool ?  hideVal.val(hideVal.val()+$(this).find('input').data("id")+',') : hideVal.val('');
             });
         },10)
          return false;
     });

     $(".date").click(function(event) {
         JBCalendar.show(this);
     });
     var doc=document,
             inputs=doc.getElementsByTagName('input'),
             supportPlaceholder='placeholder'in doc.createElement('input'),

             placeholder=function(input){
                 var text=input.getAttribute('placeholder'),
                         defaultValue=input.defaultValue;
                 if(defaultValue==''){
                     input.value=text
                 }
                 input.onfocus=function(){
                     if(input.value===text)
                     {
                         this.value=''
                     }
                 };
                 input.onblur=function(){
                     if(input.value===''){
                         this.value=text
                     }
                 }
             };

     if(!supportPlaceholder){
         for(var i=0,len=inputs.length;i<len;i++){
             var input=inputs[i],
                     text=input.getAttribute('placeholder');
             if(input.type==='text'&&text){
                 placeholder(input)
             }
         }
     }

     // 全部有权限无权限
     $(".full-yes").click(function(event) {
         $("input:checked").each(function(index, el) {
            $(this).closest('tr').find('dt').html('<b class="" title="有权限">有权限</b><i></i>')
            .end()
            .find('input[type="hidden"]').val(0)
        });

     });
     $(".full-on").click(function(event) {
        $("input:checked").each(function(index, el) {
            
            $(this).closest('tr').find('dt').html('<b class="" title="无权限">无权限</b><i></i>')
            .end()
            .find('input[type="hidden"]').val(1)
        });
     })
});