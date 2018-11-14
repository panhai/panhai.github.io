$(".MBcash-text").click(function(){
    $(".MBcash-text img").attr("src","../images/MBcash-ico04.png");
    $(".black").fadeIn(300);
    $(".MBcash-tc").slideDown(300);
})

$(".black").click(function(){
    $(".MBcash-text img").attr("src","../images/MBcash-ico01.png");
    $(".black").fadeOut(300);
    $(".MBcash-tc").slideUp(300);
})




$(".MBcash-phone .phone-yz").click(function(){
    $(".black01").fadeIn(300);
    $(".MBcash-yz").slideDown(300);
})
$(".black01").click(function(){
    $(".black01").fadeOut(300);
    $(".MBcash-yz").slideUp(300);
})
$(".MBcash-yz01").click(function(){
    $(".now").removeClass().addClass("MBcash-ico02");
    $(this).find(".MBcash-ico02").removeClass().addClass("now");
    $(".black01").click();
    $(".phone-yz input").val($(this).find(".yz").html());
})


$(".MBcash-close").click(function(){
    $(".tishi").fadeOut(300);
    $(".MBcash-tishi01").slideUp(300);
})
$(".MBcash-btn").click(function(){
    $(".tishi").fadeIn(300);
    $(".MBcash-tishi01").slideDown(300);
})



$(".MBcash-main>.MBcash-main-bank:eq(1)").click(function(){
    $(".MBbank-choice").slideDown(500);
})
$(".MBbank-choice .return_ico").click(function(){
    $(".MBbank-choice").slideUp(500);
})
$(".MBbank").click(function(){
    $(".MBcash-main>.MBcash-main-bank:eq(1)>input").val($(this).find(".name").html());
    $(".MBbank-choice").slideUp(500);
})