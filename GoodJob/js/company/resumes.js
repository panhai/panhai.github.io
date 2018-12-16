// 简历管理系列
//未处理简历 - 职位选择
function SelectJobs()
{
	var t=$(".form-select");
	var ul=t.find("ul");
	t.mouseenter(function(){
		ul.show();
	}).mouseleave(function(){
		ul.hide();
	});
	ul.find("li a").click(function(){
		var s=$(this).text();
		t.find(".form-hidden").val(s);
		t.find("span").html(s);
		ul.hide();
	});
}
//清除所有列表中最后一个元素的下边框
function ClearBorder(name)
{
	switch(name)
	{
		case 'invite':
			$(".tr").map(function(ind,ele){
				$(ele).find(".trr").last().css("border","0");
			});
			break;
		default:
			$(".tr").last().css("border","0");
	}
}
//将各种信件的模板填到静止层的下拉列表中
function FillTemplates(JQstr) {
    if (!Templates) return;
    var goals = JQstr.split(',');
    for (var x = 0; x < goals.length; x++) {
        var goal = goals[x];
        if (
			!Templates[goal]
			|| !$("." + goal).size()
			|| !$("." + goal + "Title").size()
			|| !$("." + goal + "Content").size()
		) continue;
        var title = $("." + goal + "Title"), temps = Templates[goal];
        var titleList = title.find("dd");
        for (var i in temps) {
            if (!temps[i] || !temps[i].title) continue;
            titleList.append('<a href="javascript:void(0)" alt="' + goal + '_' + i + '" >' + temps[i].title + '</a>');
        }
        titleList.find("a").click(function () {
            var arr = $(this).attr("alt").split('_'), ind = arr[1], thegoal = arr[0];
            var content = $("." + thegoal + "Content")
            content.html(Templates[thegoal][ind].content);
            if (thegoal == "Interview") {
                $(".profile-name").val(Templates[thegoal][ind].contact);
                $(".profile-tel").val(Templates[thegoal][ind].tel);
                $(".profile-add").val(Templates[thegoal][ind].address);
            }

        });
    }
}
function CombindCenterDiv(FireJQ, CenterJQ) {
    $(FireJQ).attr("href", "javascript:void(0)").click(function () {
        $('#hdofferreqid').val($(this).data('id'));
        if (CenterJQ == ".Interview") {
            $(".profile-email").html($(this).data('name'));
        }
        BindShow();
        $(CenterJQ).get(0).open();
    });
}

function BindShow() {
    for (var key in Templates) {
        for (var i in Templates[key]) {
            if (Templates[key][i].isdefault) {
                $("." + key + "Title dd a").eq(i).click();
            }
        }
    }
}