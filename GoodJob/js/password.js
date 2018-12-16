

function CheckPswdStrong(pwd) { //1弱，2中，3强
    pwd = pwd.toLowerCase().replace(/(^\s*)|(\s*$)/g, "");
    var number1 = "01234567890";
    var number2 = "09876543210";
    var letter1 = "abcdefghijklmnopqrstuvwxyz";
    var letter2 = "zyxwvutsrqponmlkjihgfedcba";
    if (!/^[0-9a-z]{6,16}$/.test(pwd) || number1.indexOf(pwd) > -1 || number2.indexOf(pwd) > -1 || letter1.indexOf(pwd) > -1 || letter2.indexOf(pwd) > -1) {
        return 1;
    }
    var curChar = "";
    var wCount = 0;
    for (var i = 0; i < pwd.length; i++) {
        if (pwd.substr(i, 1) == curChar) continue;
        curChar = pwd.substr(i, 1);
        wCount++;
    }
    if (wCount <= 2) return 1; //1111,aaaaaa,aabbbb,3333aaaa格式

    var half = pwd.substr(0, pwd.length / 2);
    if ((pwd.length == 6 || pwd.length == 8) && half == pwd.substr(half.length)) {
        if ((number1.indexOf(half) > -1 || number2.indexOf(half) > -1)
            || (letter1.indexOf(half) > -1 || letter2.indexOf(half) > -1)) return 1;
    }

    if (/^[a-z]+$/.test(pwd) || /^[0-9]+$/.test(pwd)) {
        //全为数字或全为字母（前面已经排除过一些规则）
        return 2;
    }
    var result;
    if ((result = /^([a-z]+)([0-9]+)|([0-9]+)([a-z]+)$/.exec(pwd)) != null) {
        var a = result[1] ? result[1] : result[4];
        var b = result[2] ? result[2] : result[3];
        if ((number1.indexOf(b) > -1 || number2.indexOf(b) > -1)
            && (letter1.indexOf(a) > -1 || letter2.indexOf(a) > -1)) {
            if (a.length == b.length) {
                return pwd.length < 10 ? 1 : 2;
            } else return pwd.length < 8 ? 1 : 2;
        }
    } 
    return pwd.length < 8 ? 2 : 3;
}