(function () {
    function createShare() {
        var htmlTemplate = '<div class="shareFixed fixed">' +
                            '<div class="in">' +
                                '<h2>点击右上角按钮分享</h2>' +
                                '<p>（看不到分享按钮？请用浏览器分享此页面链接发送给好友！）</p>' +
                            '</div>' +
                        '</div>';
        var dom = document.createElement('div');
        dom.innerHTML = htmlTemplate;
        dom.addEventListener("click", function (event) {
            document.body.removeChild(dom)
        }, false);
        document.body.appendChild(dom);
    }

    var shareBtn = document.querySelectorAll(".share");
    if (shareBtn.length == 0) return false;
    for (var i = 0; i < shareBtn.length; i++) {
        shareBtn[i].addEventListener("click", function (event) {
            event.preventDefault();
            createShare();
        });
    }
})();