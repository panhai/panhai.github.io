(function () {
    //编辑器
    var ue = UE.getEditor('Desc', { initialFrameWidth: 1000 });
    ue.ready(function () {
        ue.execCommand('serverparam', function (editor) {
            return {
                'userType': 'gp',
                'bussCode': 1000,
                'WaterMark': true
            };
        });
    });

    //地图行为
    if ($('#Lat').val() != '' && $('#Lng').val() != '') {
        defaultLat = $('#Lat').val();
        defaultLng = $('#Lng').val();
    }
    var Map = BaiduMap('MapContainer', { editable: true }, { dragend: SetCurrentPoint, reposition: SetCurrentPoint });

    //更换城市时，自动锁定新中心
    $('.Cities input[type=hidden]').change(function () {
        var city = GetArea(this.value),
            name = city[0];
        Map.search(name);
    });

    //点击定位，至少要有城市 已在页面实现
    $('#address_locate').click(function () {
        var city = GetArea($('#CityID').val()),
        cityName = city[0];
        var area = GetArea($('#AreaID').val()),
            areaName = area[0] == '不限' ? '' : area[0];
        var detail = $('.AddressDetail').val(),
            city = cityName + areaName;
        names = [];
        if (!city) {
            alert('请选择城市！');
            return false;
        }
        if (!detail) {
            alert('请输入详细地址！');
            return false;
        }
        names.push(city);
        names.push(detail);
        Map.search(names.join(''));
    });

    //设置坐标值
    function SetCurrentPoint(x, y) {
        $('#Lng').val(x);
        $('#Lat').val(y);
    }

    //自定义福利
    function InitOtherWelfare() {
        var other = $("#OtherWelfare").val();
        if (other != "") {
            var others = other.split(",");
            for (var i = 0; i < others.length; i++) {
                $(".ExtraWelfares").append('<label><input type="checkbox" name="otherWelfare" checked value="' + others[i] + '"><span>' + others[i] + '</span><q></q></label>');
            }
        }
    }
    InitOtherWelfare();

    //提交前数据处理
    $('input[type=submit]').click(function () {
        var welfare = 0;
        $('input[name=chkWelfare]:checked').map(function () {
            welfare |= $(this).val();
        });
        $('#Welfare').val(welfare);

        $('#OtherWelfare').val($('input[name=otherWelfare]').map(function () {
            return $(this).val();
        }).get().join(','));

        $('#Pictures').val($('.albumsbox img').map(function () {
            return $(this).attr('src');
        }).get().join(','));
    });

    $('.ExtraWelfares').click(function (event) {
        if (event.target.tagName == 'Q')
            $(event.target).closest('label').remove();
    });

    $('.AddWelfare').click(function () {
        if ($('.ExtraWelfares input').length >= 3) {
            alert('最多可添加3个其他福利！');
            return;
        }
        var newone = $('.ExtraWelfare').val();
        if (!newone) {
            alert('请填写新福利内容！');
            return false;
        }
        if ($('.ExtraWelfares span:contains(' + newone + ')').length) {
            alert('此福利已添加过');
            return false;
        }
        $('.ExtraWelfares').append('<label><input type="checkbox" name="otherWelfare" checked value="' + newone + '"><span>' + newone + '</span><q></q></label>');
        $('.ExtraWelfare').val('');
    });

    $('.figure').each(function () {
        //叉叉图标被点击
        $(this).find("q").click(function () {
            var figure_val = $('.albums').find('.clipAttrs').val();
            var remove_src = $(this).closest('.figure').find('img').attr("src");
            $('.albums').find('.clipAttrs').val(figure_val.replace(remove_src, ""));
            $(this).closest('.figure').find('img').remove();
            $(this).remove();
            $(this).closest('p').show();
        })

    });

    //上传器鼠标悬浮效果
    $('body').on('mouseenter', '.figure:has(img[src!=""])', function () {
        $(this).find('p').show();
    }).on('mouseleave', '.figure:has(img)', function () {
        $(this).find('p').hide();
    }).find('.figure:has(img) p').hide();

    //初始化营业执照
    var uploaderLicence = $.uploader({
        pick: { id: '#btnUpfileLicence', multiple: false },
        bussCode: 1000,
        usertype: 'gp',
        fileSingleSizeLimit: 10 * 1024 * 1024,   
        uploadAccept: function (obj, json, ctrl) {
            if (!json.success) {
                ctrl.skipFile(obj.file);
                layer.msg('营业执照上传失败：' + json.message);
                $('#licenceUploadProcessPercent').parent().hide();
            } else if (json.name) {
                //上传成功，把上传完成的工作写在此处，是因为多线程上传，合并文件的线程不一定是最后响应并导致上传成功的事件获取不到正确的图片路径
                if ($("#btnUpfileLicence img").length > 0) {
                    $("#btnUpfileLicence img").attr("src", json.url);
                } else {
                    var img = document.createElement("img");
                    img.src = json.url;
                    img.width = 158;
                    img.height = 118;

                    $("#btnUpfileLicence span").before(img);
                }
                $(".see").attr("href", json.url);
                $("#Licence").val(json.url);
            }
        },
        uploadProgress: function (file, percentage, ctrl) {
            if (percentage == Infinity) { return; }

            var contPercent = $('#licenceUploadProcessPercent');
            contPercent.parent().show();
            $(contPercent).css("width", Math.floor(percentage * 100) + '%');
            if (percentage == 1) {
                contPercent.parent().hide();
            }
        }
    });

    //初始化相册
    $('.albumsbox .figure').each(function () {
        var uploaderAlbum = $.uploader({
            pick: { id: $(this), multiple: false },
            container: $(this),
            bussCode: 1000,
            usertype: 'gp',
            fileSingleSizeLimit: 10 * 1024 * 1024,
            uploadAccept: function (obj, json, ctrl) {
                if (!json.success) {
                    ctrl.skipFile(obj.file);
                    layer.msg('相册上传失败：' + json.message);
                    $('samp', ctrl.container).parent().hide();
                } else if (json.name) { 
                    //上传成功，把上传完成的工作写在此处，是因为多线程上传，合并文件的线程不一定是最后响应并导致上传成功的事件获取不到正确的图片路径
                    upImg(json.url, ctrl.container);
                    $('span', ctrl.container).hide();
                }
            },
            uploadProgress: function (file, percentage, ctrl) {
                if (percentage == Infinity) { return; }

                var contPercent = $('samp', ctrl.container);
                $(contPercent).parent().show();
                $(contPercent).css("width", Math.floor(percentage * 100) + '%');
                if (percentage == 1) {
                    contPercent.parent().hide();
                }
            }
        });
    });

    //更新上传企业相册，src为图片路径，obj为父级容器
    function upImg(src, obj) {
        if (src) {
            var figure = $('.albums').find('.clipAttrs');
            var figure_val = figure.val();

            $img = $('<img src=' + src + ' width="158" height="118">')
            obj.find('p').hide();
            if (obj.find('img').length != 0) {
                var oldSrc = obj.find('img').attr("src");
                obj.find('img').attr("src", src)
                figure.val(figure_val.replace(oldSrc, src))
            } else {
                obj.prepend($img);
                figure.val(figure_val + "," + src);
            }

            obj.append($("<q></q>"))
            obj.find('q').click(function (event) {
                var src = $(this).closest('.figure').find('img').attr("src");
                figure_val = figure.val();
                figure.val(figure_val.replace(src, ""))
                obj.find('img').remove();
                $(this).remove();
                $(this).closest('p').show();
            });
        }
    }

    //删除相册
    $('.figure').each(function () {
        //叉叉图标被点击
        $(this).find('q').click(function () {
            var figure_val = $('.albums').find('.clipAttrs').val();
            var remove_src = $(this).closest('.figure').find('img').attr('src');
            $('.albums').find('.clipAttrs').val(figure_val.replace(remove_src, ''));
            $(this).closest('.figure').find('img').remove();
            $(this).remove();
            $(this).closest('p').show();
        });
    });

    //选择logo
    var uploaderLogo = null, logoIndex = null;
    $(".imgLoad").click(function () {
        $('#contLogo').parent().show();
        logoIndex = layer.open({
            type: 1,
            title: '上传Logo',
            content: $('#contLogo'),
            success: function () {
                if (!uploaderLogo) {
                    uploaderLogo = $.uploader({
                        pick: { id: '#btnLogoUpload', multiple: false },
                        bussCode: 1000,
                        usertype: 'gp',
                        fileSingleSizeLimit: 10 * 1024 * 1024,
                        uploadAccept: function (obj, json, ctrl) {
                            if (!json.success) {
                                ctrl.skipFile(obj.file);
                                layer.msg('Logo上传失败：' + json.message);
                                $('.LogoProgress').parent().hide();
                            } else if (json.name) {
                                //上传成功，把上传完成的工作写在此处，是因为多线程上传，合并文件的线程不一定是最后响应并导致上传成功的事件获取不到正确的图片路径
                                $('.view img').attr('src', json.url);
                                $('#vs_hasUpload').val('1');
                            }
                        },
                        uploadProgress: function (file, percentage, ctrl) {
                            if (percentage == Infinity) { return; }

                            $('.LogoProgress').show();
                            $('.LogoProgress span').css('width', percentage * 200 + 'px');
                            $('.LogoProgress span').html(parseInt(percentage * 100) + '%');

                            if (percentage == 1) {
                                $('.LogoProgress').hide();
                            }
                        }
                    });
                }
            },
            end: function (index, layero) {
                $('#contLogo').parent().hide();
            }
        });
    });

    //logo弹框的确定/取消事件
    $('#contLogo').on('click', '.cancel', function () {
        if (logoIndex) {
            layer.close(logoIndex);
        }
    }).on('click', '.submit', function () {
        if ($('#vs_hasUpload').val() == '0') {
            layer.msg('未上传企业Logo图片');
            return;
        }

        var data = { ID: $(this).data('id'), CutInfo: $('#contLogo .clipAttrs').val(), Path: $('.view img').attr('src') };
        $.ajax({
            url: '/gp/company/savelogo',
            data: data,
            type: 'POST',
            cache: false,
            dataType: 'JSON',
            beforeSend: ajaxBegin,
            success: function (ajson) {
                if (!ajson.success) {
                    layer.msg(ajson.msg);
                    return;
                } else {
                    $('#Logo').val(ajson.data);
                    $('#CutInfo').val($('#contLogo .clipAttrs').val());
                    $('.imgLoad img').attr('src', ajson.data);
                }
                if (logoIndex) {
                    layer.close(logoIndex);
                }
            },
            error: ajaxError,
            complete: ajaxComplete
        });
    });
})();