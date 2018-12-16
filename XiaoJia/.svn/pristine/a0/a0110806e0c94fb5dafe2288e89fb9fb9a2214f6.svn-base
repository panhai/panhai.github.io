// 左侧固定导航  合作机构 机构管理页面
$(function(){
    $('.nav>a').click(function(){
        $(this).addClass('cur').siblings('a').removeClass('cur')
    })

    // 小导航  right_nav  right_content_box
   $('.nav_url').hover(function(){
        $(this).children('.moveLayer').show(300)
   },function(){
    $(this).children('.moveLayer').hide()
   })
   $('.left_navgater .changeArrow').click(function(){
       $('.left_navgater').hide()
       $('.left_small_navgater').show()
       $('.right_content_box').css({'margin-left':'75px'})
       $('.right_nav').css({'margin-left':'54px'})

   })
   $('.left_small_navgater .changeArrow').click(function(){
       $('.left_small_navgater').hide()
       $('.left_navgater').show()
       $('.right_content_box').css({'margin-left':'181px'})
       $('.right_nav').css({'margin-left':'160px'})
       
   })
//    头部查询
   $('.search_box i.reset').click(function(){
       $(this).siblings('input').val("")
   })

   $('.inp3 .select .select_box p').click(function(e){
        $('.select>span').text($(this).text())
        $('.select_box').hide()
        e.stopPropagation();
   })

   $('.select').click(function(e){
        $('.select_box').show()
        e.stopPropagation();
   })
   $('body').click(function(){
    $('.select_box').hide()
    $('.select_box2').hide()
   })
//    我的筛选 select_box2
   $('.my_select').click(function(e){
       e.stopPropagation();
       $('.select_box2').show()
   })
   $('.select_box2 p').click(function(e){
       $('.select2 > span').text($(this).text())
       $('.select_box2').hide()
       e.stopPropagation();
   })

//    操作表格
//    点击勾选
  
//    全选 all
   $('.table_cao .all i').click(function(){
        if($(this).hasClass('cur')){
            $(this).removeClass('cur')
            $('.table_box table td i').removeClass('cur')
        }else{
            $(this).addClass('cur')
            $('.table_box table td i').addClass('cur')
        }
   })
//    单选
$('.table_box table td i').click(function(){
    if($(this).hasClass('cur')){
        $(this).removeClass('cur')
    }else{
        $(this).addClass('cur')
    }
})
// 分页
   $('.page a').click(function(){
       $(this).addClass('cur').siblings().removeClass('cur')
   })
//    选择每页显示数据条数
   $('body').click(function(){
     $('.select_num').hide()
   })
   $('.page_select').click(function(e){
       e.stopPropagation()
       $('.select_num').show()
   })
   $('.select_num p').click(function(e){
       e.stopPropagation()
       $('.page_select .num').text($(this).text())
       $('.select_num').hide()
   })
//    标记 bj
   $('.biaoji').click(function(e){
       e.stopPropagation()
       $('.bj').show()
   })
   $('.bj').click(function(e){
      e.stopPropagation()
       $(this).hide()
   })
   $('.biaoji').mouseenter(function(){
     $('.bj').hide()
   })
  $('body').click(function(){
    $('.bj').hide()
  })
})

// 新增机构页面
$(function(){
    var trOuthtml = $('.Cooperative_information2 table tr').eq(1).prop('outerHTML');
    // 新增一行
    $('body').on('click','span.add_tr',function(){
       $('.Cooperative_information2 table').append($(trOuthtml))
       $('span.delete_tr').css({'opacity':'1'})
    })
    // 删除一行
    $('body').on('click','span.delete_tr',function(){
       $(this).parents('tr').remove()
    })

   
})


// 下拉选择框
$('.select_box_box').click(function(e){
    e.stopPropagation()
    $(this).children('.select_box').show()
})

$('.select_box>p').click(function(e){
    e.stopPropagation()
    $(this).parent('.select_box').hide()
})

// 返回
$('.fanhui').click(function(){
    history.back()
})




