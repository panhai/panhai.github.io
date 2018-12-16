// 企业中心通用效果，只能单拿出来了
$(function () {
    $(".WarmTip").find("a,q").click(function () {
        $(this).closest(".FullScreenPlugin").fadeOut();
    });
    //画信用度的条
    function DrawCredit() {
        $(".profile p samp").map(function () {
            if (/^[1-9]+[0-9]*]*$/.test($(this).text())) {
                var value = parseInt($(this).text());
                $(this).empty();
                var paper = Raphael(this, 125, 15);
                paper.rect(0, 0, 120, 12, 6).attr({ stroke: false, fill: '#d1e5ff' });
                //paper.rect(0,0,12,12,6).attr({stroke:false,fill:'#1562c8'}).animate({width:1.2*value},1000);
                paper.rect(0, 0, 1.2 * value, 12, 6).attr({ stroke: false, fill: '#1562c8' })//.animate({width:1.2*value},1000);
            }
        });
    }
    window.drawCredit = DrawCredit;

    //面试面试面试面试的邀请函中的时间
    $(".Date").click(function () {
        JBCalendar.show(this, {}, function () {
            $(".Hour dt").click();
        })
    });
    //新增简历推荐
    $(".ResumePushIcon").css({
        top: ($(window).height() - $(".ResumePushIcon").height()) / 2,
        right: function () {
            var rpx = ($(window).width() - 1060) / 2 - 130;
            return rpx < 0 ? 0 : rpx;
        }
    });
    ////////////////////////////////////////
    var fromIcon = true;
    $(".ResumePush").find("dt q").click(function () {
        CENTERDIV.close.call($(".ResumePush"), true)
    }).end()
	.on('click', 'a.invite', function () {
	    fromIcon = true;
	})
	.on('click', 'a.nomatch', function () {
	    var reReId = $(this).data("rereid");
	    CONFIRM("不合适", "<h5>确定简历不合适吗？</h5>", "确定不合适", function () {
	        var companyID = $(".vs_companyID").val();
	        $.ajax({
	            url: "/company/" + companyID + "/admin/ajax.html",
	            data: { cmd: "recommendnotmatch", id: reReId },
	            cache: false,
	            dataType: "json",
	            success: function (data) {
	                if (!data.success) {
	                    alert(data.msg);
	                }
	                $("[data-rereid='" + reReId + "']").closest("tr").remove();
	                if ($(".ResumePushList tr").length == 0) {
	                    $(".ResumePushIcon").hide();
	                    $("q").click();
	                }
	            }
	        });
	    });
	})
    ;
    $(".Right a.invite").click(function () {
        fromIcon = false;
    });
    function CloseInvitation() {
        if (fromIcon) {
            $(".ResumePush").show();
            $(".Invitation").hide();
        }
        else {
            CENTERDIV.close.call($(".Invitation"), true);
        }
    }
    window.closeInvitation = CloseInvitation;
    //另外的更新，邀请函上有data-init=false
    $(".CENTERDIV").filter(".Invitation").find(".reset,dt q").click(function () {
        CloseInvitation();
    });
    //不合适改变模版时
    $(".NotMatch .Templates").find("dt").click(function () {
        var _this = this;
        $.ajax({
            url: adminRootPath() + "/ajax.html",
            data: { cmd: "nomatchtemplate" },
            cache: false,
            dataType: "json",
            success: function (data) {
                if (data.success) {
                    NotmatchTemplates = data.data;
                    $(_this).siblings("dd").html(function () {
                        var str = [];
                        for (var n = 0; n < NotmatchTemplates.length; n++)
                            str.push('<a href="javascript:void(0)" data-id="', NotmatchTemplates[n].id, '">', NotmatchTemplates[n].title, '</a>');
                        return str.join('');
                    });
                }
            }
        });
    }).end()
	.find("input[type='hidden']").change(function () {
	    var id = $(this).val();
	    for (var n = 0; n < NotmatchTemplates.length; n++) {
	        var temp = NotmatchTemplates[n];
	        if (temp.id != id) continue;
	        $(".NotMatch .Content").val(temp.content);
	        break;
	    }
	});
    //改变模板时
    $(".Invitation .Templates").find("dt").click(function () {
        var _this = this;
        $.ajax({
            url: adminRootPath() + "/ajax.html",
            data: { cmd: "interviewtemplate" },
            cache: false,
            dataType: "json",
            success: function (data) {
                if (data.success) {
                    InviteTemplates = data.data;
                    $(_this).siblings("dd").html(function () {
                        var str = [];
                        for (var n = 0; n < InviteTemplates.length; n++)
                            str.push('<a href="javascript:void(0)" data-id="', InviteTemplates[n].id, '">', InviteTemplates[n].title, '</a>');
                        return str.join('');
                    });
                }
            }
        });
    }).end()
	.find("input[type='hidden']").change(function () {
	    var id = $(this).val();
	    for (var n = 0; n < InviteTemplates.length; n++) {
	        var temp = InviteTemplates[n];
	        if (temp.id != id) continue;
	        $(".Invitation .Author").val(temp.author);
	        $(".Invitation .Address").val(temp.address);
	        $(".Invitation .Tel").val(temp.tel);
	        $(".Invitation .Content").val(temp.content);
	        break;
	    }
	});


    // 下拉加载 wraperCls 为加在列表的父元素，list为加载列表元素，callback是滚到条到底回调函数
       var dropDownLoading = function (wraperCls,list,callback){

           var loadingIn = $(wraperCls),
               loadingInHeight = loadingIn.innerHeight(),
               loadingList =  $(list),
               loadingListHeight = 0;

           var args = arguments,
               timer = null;

           function showLoading(bol){
               if( bol ){
                   loadingIn.find(".loading").remove();
                   return false;
               }
               var div = $("<div class='loading'>加载中...</div>")
               loadingIn.append(div);
           }


           function _l(event){
               event.preventDefault();

               var scrollTop = $(loadingIn).scrollTop();

               loadingListHeight = loadingList.outerHeight();
               var num = (loadingInHeight + scrollTop >= loadingIn[0].scrollHeight)

               if( num ){
                   // 调用回调函数
                   callback.apply(this,args);
               }

               return false;
           }

           loadingIn.on("scroll" ,_l);

       }

       window.dropDownLoading = dropDownLoading;
});