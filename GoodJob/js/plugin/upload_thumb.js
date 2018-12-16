
//新增的上传方法//////////////////////////////////////////////////////////////////////////
function ThumbInit() {
    //(function(){
    var $main = $(".ThumbClipping"),//整体
        $view = $(".view", $main),//可视区及尺寸
        piViewWidth = $view.width(),
        piViewHeight = $view.height(),
        $img = $view.find("img"),//原图片对象及尺寸
        img = document.createElement("img");
    img.src = $img.get(0).src;

    var piImagePrimaryWidth = img.width || 680,
        piImagePrimaryHeight = img.height || 680,
        newWidth, newHeight,//随时变化的图片的尺寸
        newLeft, newTop,//随时变化的图片位置
        piPivotX = .5,//缩放变形中心坐标，为可视区中心相对于图片左上角的坐标
        piPivotY = .5,
        $primary = $(".primary", $main),//原始图片容器及尺寸
        piPrimaryWidth = $primary.width(),
        piPrimaryHeight = $primary.height(),
        maxNegX = piImagePrimaryWidth - piViewWidth,//最大负位移，图片相对于可视区的坐标
        maxNegY = piImagePrimaryHeight - piViewHeight,
        sClips = $(".clipAttrs", $main).val(),//剪裁属性串及剪裁属性对象
        nImageRatio = piImagePrimaryWidth / piImagePrimaryHeight,//图片自身比例
        bWider = nImageRatio > piViewWidth / piViewHeight,//图片过宽(true)还是可视区过宽(false)
        minRatio = bWider ? //图片的最小比例
            piViewHeight / piImagePrimaryHeight //图片过宽，是可视区高除以图片高
            : piViewWidth / piImagePrimaryWidth,//图片过高，是可视区宽除以图片宽
        oClips/*={//所有数字非负
				ratio:r,//大图显示在页面上的比例，
				width:w,//从大图原图上裁剪的宽高
				height:h,
				x:x,//从大图原图上裁剪的坐标，是大图相对于可视区坐标的相反数
				y:y
			}*/,
    sth;

    $(".cover", $main).css({
        backgroundColor: '#000'
        , opacity: .5
    });

    var paper = Raphael($(".slider sub").get(0), 22, 20);
    var zoomIn = paper.path('M13,1A7,7,0,1,1,12.9,1M9,8H17M8,12L1,19').attr({ stroke: '#808080', 'stroke-width': 2, fill: '#fff' });
    paper = Raphael($(".slider sup").get(0), 22, 20);
    var zoomOut = paper.path('M13,1A7,7,0,1,1,12.9,1M9,8H17M13,4V12M8,12L1,19').attr({ stroke: '#808080', 'stroke-width': 2, fill: '#fff' });
    paper = Raphael($(".slider .role").get(0), 290, 20);
    paper.rect(0, 5, 290, 10, 5).attr({ stroke: '#e6e6e6', fill: '#ededed' })
    var progress = paper.rect(0, 6, 5, 8, 4).attr({ fill: '#498fed', stroke: false });
    paper = Raphael($(".slider .role b").get(0), 20, 20);
    var slider = paper.circle(10, 10, 8).attr({ fill: '#fff', stroke: '#498fed' })
    //图片最小不能小于可视区尺寸

    if (maxNegX < 0 || maxNegY < 0) {
        //console.log("原图过小");
        return;
    }

    //设置调节部分的遮罩
    $primary.find(".top,.bottom").height((piPrimaryHeight - piViewHeight) / 2)
        .end().find(".left,.right").height(piViewHeight)
            .width((piPrimaryWidth - piViewWidth) / 2)
    ;
    if (sClips)//如果有配置参数，就按配置参数计算
    {
        try {
            eval("oClips={" + sClips + "}");
            newWidth = oClips.ratio * piImagePrimaryWidth;
            newHeight = oClips.ratio * piImagePrimaryHeight;
            maxNegX = newWidth - piViewWidth;
            maxNegY = newHeight - piViewHeight;
            newLeft = -oClips.x * oClips.ratio;
            newTop = -oClips.y * oClips.ratio;
        } catch (e) {
            alert("配置参数格式错误");
            return;
        }
    }
    else//如果配置参数为空，则计算原始剪裁，将图片剪裁到充满可视区的最小尺寸
    {
        oClips = {};
        newWidth = bWider ? nImageRatio * piViewHeight : piViewWidth;
        newHeight = bWider ? piViewHeight : piViewWidth / nImageRatio;
        oClips.ratio = newWidth / piImagePrimaryWidth;
        maxNegX = newWidth - piViewWidth;
        maxNegY = newHeight - piViewHeight;
        newLeft = -maxNegX / 2;
        newTop = -maxNegY / 2;
        oClips.x = -newLeft / oClips.ratio;
        oClips.y = -newTop / oClips.ratio;
        oClips.width = piViewWidth / minRatio;
        oClips.height = piViewHeight / minRatio;
    }
    $img.css({
        width: newWidth,
        height: newHeight,
        marginLeft: newLeft,
        marginTop: newTop
    });
    setPivot();
    $(".thumb", $main).each(function () {
        $(this).empty().append($("<img>").prop('src', $img.prop('src')))
    });
    thumbsFollow();
    //缩略图随主图变化
    function thumbsFollow() {
        $(".thumb", $main).each(function () {
            var ratio = $(this).data("ratio");
            $(this).find("img").css({
                width: newWidth * ratio,
                height: newHeight * ratio,
                marginLeft: newLeft * ratio,
                marginTop: newTop * ratio
            });
            //console.log(oClips.x,oClips.y);
        });
    }

    //将剪裁属性拼成字符串加入到隐藏域中
    function fillClips() {
        $(".clipAttrs", $main).val([
            "width:" + Math.floor(oClips.width),
            "height:" + Math.floor(oClips.height),
            "ratio:" + Number(oClips.ratio).toFixed(2),
            "x:" + Math.floor(oClips.x),
            "y:" + Math.floor(oClips.y)
        ].join(','));
        //console.log(oClips);
    }
    fillClips();

    //拖动大图
    var lockDrag = false,//拖拽锁
        dragX, dragY,//拖拽起始时的鼠标坐标（相对于浏览器）
        dragLeft, dragTop,//拖拽起始时的外边距
        deltaX, deltaY//拖拽坐标差
    ;
    function refuseDragSelect() {//禁止拖选
        window.getSelection ? window.getSelection().removeAllRanges() : document.selection.empty();
    }

    function ImageDragging(event) {
        if (!lockDrag) return;
        refuseDragSelect();
        deltaX = event.clientX - dragX;
        deltaY = event.clientY - dragY;
        newLeft = Math.min(Math.max(dragLeft + deltaX, -maxNegX), 0);
        newTop = Math.min(Math.max(dragTop + deltaY, -maxNegY), 0);
        $img.css({
            marginLeft: newLeft,
            marginTop: newTop
        });
        oClips.x = -newLeft / oClips.ratio;
        oClips.y = -newTop / oClips.ratio;
        fillClips();
        thumbsFollow();
        //			event.cancelBubble=true;
        //	        event.returnValue = false;
        return false;
    }
    function DropDragging() {
        lockDrag = false;
        $(document).off('mousemove', ImageDragging)
            .off('mousemove', SliderDragging)
            .off('mouseup', DropDragging);
    }
    $img.mousedown(function (event) {
        lockDrag = true;
        dragX = event.clientX;
        dragY = event.clientY;
        dragLeft = parseInt($img.css('marginLeft'));
        dragTop = parseInt($img.css('marginTop'));
        $(document).mousemove(ImageDragging)
            .mouseup(function () {
                DropDragging();
                setPivot();
            });
        event.preventDefault();
        event.stopPropagation();
    });

    //比例与位置的换算
    function ratio2margin(ratio) {
        return (ratio - minRatio) * maxRoleX / (1 - minRatio);
    }
    function margin2ratio(margin) {
        return margin ? (margin * (1 - minRatio) / maxRoleX + minRatio) : minRatio;
    }
    function setPivot() {
        //重新设定缩放中心
        piPivotX = (-parseInt($img.css('margin-left')) + piViewWidth / 2) / newWidth;
        piPivotY = (-parseInt($img.css('margin-top')) + piViewHeight / 2) / newHeight;
    }

    //初始化滑动条
    var $roll = $(".role"),
        $slider = $roll.find("b"),
        maxRoleX = $roll.width() - $slider.width()//滑块最大左边距
    ;
    newLeft = ratio2margin(oClips.ratio);
    progress.attr({ width: newLeft + 5 });
    $slider.css({
        marginLeft: newLeft
    }).mousedown(function (event) {
        lockDrag = true;
        dragLeft = parseInt($(this).css("marginLeft"));
        dragX = event.clientX;
        setPivot();
        $(document).mousemove(SliderDragging)
            .mouseup(DropDragging);
        event.preventDefault();
        event.stopPropagation();
    });
    function SliderDragging(event) {
        if (!lockDrag) return;
        refuseDragSelect();
        deltaX = event.clientX - dragX;
        left = Math.max(Math.min(dragLeft + deltaX, maxRoleX), 0);
        $slider.css({
            marginLeft: left
        });
        progress.attr({ width: left + 5 });
        oClips.ratio = margin2ratio(left);
        ImageScale()
        return false;
    }
    function ImageScale() {
        newWidth = Math.floor(oClips.ratio * piImagePrimaryWidth);
        newHeight = Math.floor(oClips.ratio * piImagePrimaryHeight);
        maxNegX = newWidth - piViewWidth;
        maxNegY = newHeight - piViewHeight;
        newLeft = Math.floor(piPivotX * newWidth - piViewWidth / 2);
        newLeft = Math.max(Math.min(0, -newLeft), -maxNegX);
        newTop = Math.floor(piPivotY * newHeight - piViewHeight / 2);
        newTop = Math.max(Math.min(0, -newTop), -maxNegY);
        oClips.x = -newLeft / oClips.ratio;
        oClips.y = -newTop / oClips.ratio;
        oClips.width = Math.floor(piViewWidth / oClips.ratio);
        oClips.height = Math.floor(piViewHeight / oClips.ratio);

        $img.css({
            width: newWidth,
            height: newHeight,
            marginLeft: newLeft,
            marginTop: newTop
        });
        fillClips();
        thumbsFollow();
    }

    //图片重置路径后
    function ImageReload() {
        //var img = document.createElement("img");
        //img.src = $img.get(0).src;
        oClips.ratio = 1;
        $img.css({
            width: 'auto',
            height: 'auto'
        });
        piImagePrimaryWidth = $img.width();
        piImagePrimaryHeight = $img.height();
        console.log(piImagePrimaryWidth, piImagePrimaryHeight);

        nImageRatio = piImagePrimaryWidth / piImagePrimaryHeight;//图片自身比例
        bWider = nImageRatio > piViewWidth / piViewHeight;//图片过宽(true)还是可视区过宽(false)
        minRatio = bWider ? //图片的最小比例
            piViewHeight / piImagePrimaryHeight //图片过宽，是可视区高除以图片高
            : piViewWidth / piImagePrimaryWidth;//图片过高，是可视区宽除以图片宽
        newWidth = bWider ? nImageRatio * piViewHeight : piViewWidth;
        newHeight = bWider ? piViewHeight : piViewWidth / nImageRatio;
        oClips.ratio = newWidth / piImagePrimaryWidth;
        maxNegX = newWidth - piViewWidth;
        maxNegY = newHeight - piViewHeight;
        //图片最小不能小于可视区尺寸
        if (maxNegX < 0 || maxNegY < 0) {
            //console.log("原图过小");
            return;
        }
        newTop = -maxNegY / 2;
        newLeft = -maxNegX / 2;
        oClips.x = -newLeft / oClips.ratio;
        oClips.y = -newTop / oClips.ratio;
        oClips.width = piViewWidth / minRatio;
        oClips.height = piViewHeight / minRatio;
        $img.css({
            width: newWidth,
            height: newHeight,
            marginLeft: newLeft,
            marginTop: newTop
        });
        $(".thumb img", $main).each(function () {
            this.src = $img.get(0).src;
        });
        thumbsFollow();
        newLeft = 0;
        progress.attr({ width: 5 });
        $slider.css({
            marginLeft: 0
        })
        fillClips();
        setPivot();
    }

    $img.off('load', ThumbInit);
    $img.load(ImageReload);

    zoomIn.click(function () {
        Scale(-.01);
    });
    zoomOut.click(function () {
        Scale(.01);
    });
    function Scale(sign) {
        var ratio = Math.max(Math.min(oClips.ratio + sign, 1), minRatio);
        oClips.ratio = ratio;
        left = ratio2margin(ratio)
        left = Math.min(Math.max(left, 0), maxRoleX);
        $slider.css('margin-left', left);
        progress.attr({ width: left + 5 });
        ImageScale()
    }

    /*setTimeout(function(){
        alert($img.data('src'));
        $img.attr('src',$img.data('src'));
    },3000);*/
    //})();
}
//ThumbInit();
$(".ThumbClipping .view img").each(function () {
    if (this.complete) {
        ThumbInit();
    }
    else {
        $(this).load(ThumbInit);
    }
});