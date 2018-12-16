var subjectArray = [
["互联网/计算机/通信", "0", "1000", "", ""],
["互联网/电子商务 ", "1000", "1010", "", ""],
["网络游戏 ", "1000", "1011", "", ""],
["计算机软件 ", "1000", "1012", "", ""],
["计算机硬件 ", "1000", "1013", "", ""],
["IT/计算机服务 ", "1000", "1014", "", ""],
["通信/电信 ", "1000", "1015", "", ""],
["金融/银行/保险 ", "0", "1100", "", ""],
["金融/银行 ", "1100", "1110", "", ""],
["保险 ", "1100", "1111", "", ""],
["信托/担保/拍卖/典当 ", "1100", "1112", "", ""],
["贸易/消费/运输/物流 ", "0", "1200", "", ""],
["贸易/进出口 ", "1200", "1210", "", ""],
["批发/零售", "1200", "1211", "", ""],
["快速消费品", "1200", "1212", "", ""],
["耐用消费品 ", "1200", "1213", "", ""],
["交通/运输/物流/仓储 ", "1200", "1214", "", ""],
["生产/加工/制造/电子 ", "0", "1300", "", ""],
["办公用品及设备 ", "1300", "1310", "", ""],
["服装/纺织/皮革 ", "1300", "1311", "", ""],
["机械/重工/设备 ", "1300", "1312", "", ""],
["交通工具/零配件 ", "1300", "1313", "", ""],
["制药/生物工程 ", "1300", "1314", "", ""],
["仪器仪表/自动化 ", "1300", "1315", "", ""],
["航天研究与制造 ", "1300", "1316", "", ""],
["原料加工/制造 ", "1300", "1317", "", ""],
["医疗设备/器械 ", "1300", "1318", "", ""],
["电子技术/半导体/集成电路 ", "1300", "1319", "", ""],
["广告/媒体 ", "0", "1400", "", ""],
["广告/创意 ", "1400", "1410", "", ""],
["出版/印刷/造纸 ", "1400", "1411", "", ""],
["影视/媒体/艺术/文体/出版 ", "1400", "1412", "", ""],
["房地产/建筑 ", "0", "1500", "", ""],
["房地产/建筑/建材/工程 ", "1500", "1510", "", ""],
["家居/室内设计/装潢 ", "1500", "1511", "", ""],
["物业管理/商业中心 ", "1500", "1512", "", ""],
["专业服务/教育/培训 ", "0", "1600", "", ""],
["中介/专业服务 ", "1600", "1610", "", ""],
["外包服务 ", "1600", "1611", "", ""],
["租赁服务 ", "1600", "1612", "", ""],
["检验/检测/认证 ", "1600", "1613", "", ""],
["公关/会展/市场推广 ", "1600", "1614", "", ""],
["学术/科研 ", "1600", "1615", "", ""],
["教育/培训/院校 ", "1600", "1616", "", ""],
["服务业|医疗 ", "0", "1700", "", ""],
["酒店/餐饮/旅游 ", "1700", "1710", "", ""],
["娱乐/休闲/体育 ", "1700", "1711", "", ""],
["医疗/护理/卫生/保健/美容 ", "1700", "1712", "", ""],
["其他生活服务 ", "1700", "1713", "", ""],
["能源/矿产 ", "0", "1800", "", ""],
["能源/矿产/采掘/冶炼 ", "1800", "1810", "", ""],
["电气/电力/水利 ", "1800", "1811", "", ""],
["新能源 ", "1800", "1812", "", ""],
["政府/非赢利机构/其他 ", "0", "1900", "", ""],
["政府/公共事业/非盈利机构 ", "1900", "1910", "", ""],
["环保 ", "1900", "1911", "", ""],
["农/林/牧/渔 ", "1900", "1912", "", ""],
["多元化业务集团公司 ", "1900", "1913", "", ""],
["其他行业 ", "1900", "1914", "", ""]
];

function GetTopSubjects() {
    var subjects = new Array();
    for (var i = 0; i < subjectArray.length; i++) {
        if (subjectArray[i][1] == "0") {
            subjects.push(subjectArray[i]);
        }
    }
    return subjects;
}

function GetSubject(id) {
    for (var i = 0; i < subjectArray.length; i++) {
        if (subjectArray[i][2] == id) {
            return subjectArray[i];
        }
    }
    return null;
}

function GetSubjectByPinyinKey(ky) {
    for (var i = 0; i < subjectArray.length; i++) {
        if (subjectArray[i][3] == ky) return subjectArray[i];
    }
    return null;
}
function SubjectContainPinyinKey(ky) {
    for (var i = 0; i < subjectArray.length; i++) {
        if (subjectArray[i][3] == ky) return true;
    }
    return null;
}

function GetSubjects(id) {
    var subjects = new Array();
    for (var i = 0; i < subjectArray.length; i++) {
        if (subjectArray[i][1] == id) {
            subjects.push(subjectArray[i]);
        }
    }
    return subjects;
}

function GetSubjectsByIds(ids, containBig) {
    var subjects = new Array();
    for (var i = 0; i < subjectArray.length; i++) {
        var pt = new RegExp(subjectArray[i][2]);
        if ((containBig || subjectArray[i][1] != "0") && pt.test(ids)) {
            subjects.push(subjectArray[i]);
        }
    }
    return subjects;
}

function GetSubjectsByNames(names) {
    var subjects = new Array();
    if (!names.pop) names = [names];
    for (var i = 0; i < subjectArray.length; i++) {
        for (var j = 0; j < names.length; j++) {
            if (subjectArray[i][0] == names[j]) subjects.push(subjectArray[i]);
        }
    }
    return subjects;
}


function CreateSubjectSelector(option) {
    //option {subArr,obj1,obj2,title1,title2,value,afterchange}
    if (option == null || option.obj1 == null || option.obj2 == null) return;
    var sl1 = option.obj1;
    var sl2 = option.obj2;
    if (typeof (sl1) == "string") sl1 = document.getElementById(sl1);
    if (typeof (sl2) == "string") sl2 = document.getElementById(sl2);
    sl1.length = 0;
    sl2.length = 0;
    var subsArr = option.subArr || subjectArray;
    var getArray = function (parentId) {
        var sbjs = new Array();
        for (var i = 0; i < subsArr.length; i++) {
            if (subsArr[i][1] == parentId) {
                sbjs.push(subsArr[i]);
            }
        }
        return sbjs;
    }
    var subChanged = function (init) {
        sl2.length = 0;
        if (option.title2) sl2.options[sl2.length] = new Option(option.title2, "");
        var arr = getArray(sl1.value);
        var selected = false;
        for (var i = 0; i < arr.length; i++) {
            sl2.options[sl2.length] = new Option(arr[i][0], arr[i][2]);
            if (arr[i][2] == option.value) {
                sl2.options[sl2.length - 1].selected = true;
                selected = true;
            }
        }
        if (!selected && sl2.options[0]) sl2.options[0].selected = true;
        sl2.disabled = (sl2.length == 0 || (sl2.length == 1 && option.title2));
        if (init != true && option.afterchange) option.afterchange(sl1.value);
    }
    var arr1 = getArray(0);
    sl1.length = 0;
    if (option.title1) sl1.options[sl1.length] = new Option(option.title1, "");
    for (var i = 0; i < arr1.length; i++) {
        sl1.options[sl1.length] = new Option(arr1[i][0], arr1[i][2]);
        if (option.value && option.value.length == 4 && arr1[i][2].substr(0, 1) == option.value.substr(0, 1)) {
            sl1.options[sl1.length - 1].selected = true;
        }
    }
    if (sl1.selectedIndex < 0 && sl1.options[0]) sl1.options[0].selected = true;
    subChanged(true);
    sl1.onchange = subChanged;
    if (option.afterchange) sl2.onchange = function () { option.afterchange(sl2.value); };
}