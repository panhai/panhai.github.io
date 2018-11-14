/**
* 列表滚动
*/
$.fn.listMove = function (opr) {
    if (this.length == 0) { return; }
    var _touchStart = function (e) {
        this.y = $(this).offset().top - $(this).parent().offset().top;
        this.startY = e.screenY;
        this.startTop = this.y || 0;
        this.startTime = e.timeStamp;
        this.moved = false;
        var _this = this;
        if (!this.maxScrollY) {
            this.maxScrollY = $(this).parent().height() - $(this).height();
            if (this.maxScrollY > 0) { this.maxScrollY = 0; }
            $(window).resize(function () {
                _this.maxScrollY = $(_this).parent().height() - $(_this).height();
                if (_this.maxScrollY > 0) { _this.maxScrollY = 0; }
            });
        }
        $(this).css({
            "transform": "translate3d(0," + this.y + "px, 0)",
            "transition-duration": "0"
        });
    };
    var _touchMove = function (e) {
        e.preventDefault();
        e.stopPropagation();
        this.moving = true;
        this.y = e.screenY - this.startY + this.startTop;
        if (this.y > 0 || this.y < this.maxScrollY) {
            var newY = this.y - (e.screenY - this.startY) * 2 / 3;
            this.y = this.y > 0 ? 0 : this.maxScrollY;
            if (newY > 0 || newY < this.maxScrollY) { this.y = newY; }
        }
        $(this).css({
            "transform": "translate3d(0," + this.y + "px, 0)",
            "transition-duration": "0"
        });
        var timeStamp = e.timeStamp;
        if (timeStamp - this.startTime > 300) {
            this.startTime = timeStamp;
            this.startY = e.screenY;
            this.startTop = this.y;
        }
    };
    var _touchEnd = function (e) {
        if (this.moving) {
            this.moving = false;

            if (this.y > 0 || this.y < this.maxScrollY) {
                _scrollTo(this, this.y, this.maxScrollY, 600);
                this.y = this.y > 0 ? 0 : this.maxScrollY;
                return;
            }

            this.endTime = e.timeStamp;
            var duration = this.endTime - this.startTime;
            if (duration < 300) {
                var move = _calculateMoment(this.y, this.startTop, duration, this.maxScrollY, $(this).parent().height());
                this.y = move.destination;
                var time = move.duration;
                $(this).css({
                    "transform": "translate3d(0, " + this.y + "px, 0)",
                    "transition-timing-function": "cubic-bezier(0.1, 0.3, 0.5, 1)",
                    "transition-duration": time + "ms"
                });
                var _this = this;
                setTimeout(function () { _scrollTo(_this, _this.y, _this.maxScrollY, 600); }, time + 100);
                return;
            }
        } 
    };
    var _scrollTo = function (obj, y, maxY, time) {
        if (y > 0 || maxY > 0) { y = 0 }
        else if (y < maxY) { y = maxY }
        $(obj).css({
            "transform": "translate3d(0, " + y + "px, 0)",
            "transition-timing-function": "cubic-bezier(0.25, 0.46, 0.45, 0.94)",
            "transition-duration": time + "ms"
        });
    };
    var _calculateMoment = function (current, start, time, lowerMargin, wrapperSize) {
        var distance = current - start,
		    speed = Math.abs(distance) / time,
		    destination,
		    duration;
        deceleration = 6e-4;
        destination = current + speed * speed / (2 * deceleration) * (distance < 0 ? -1 : 1);
        duration = speed / deceleration;
        if (destination < lowerMargin) {
            destination = wrapperSize ? lowerMargin - wrapperSize / 2.5 * (speed / 8) : lowerMargin;
            distance = Math.abs(destination - current);
            duration = distance / speed
        } else if (destination > 0) {
            destination = wrapperSize ? wrapperSize / 2.5 * (speed / 8) : 0;
            distance = Math.abs(current) + destination;
            duration = distance / speed
        }
        return {
            destination: Math.round(destination),
            duration: duration
        }
    };
    this.on("vmousedown", _touchStart).on("vmousemove", _touchMove).on("vmouseup", _touchEnd);;

    return this;
};

$(".listmove").listMove();
$(".menu").on("vmousemove",function(e){
    e.preventDefault();
    e.stopPropagation();
});