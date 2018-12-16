/*******************************************************************************
* KindEditor - WYSIWYG HTML Editor for Internet
* Copyright (C) 2006-2011 kindsoft.net
*
* @author Roddy <luolonghao@gmail.com>
* @site http://www.kindsoft.net/
* @licence http://www.kindsoft.net/license.php
*******************************************************************************/
var KindEditorFileSelectCallback = function(url, name) { return; }
KindEditor.plugin('filemanager', function(K) {
    var self = this, name = 'filemanager';
    self.plugin.filemanagerDialog = function(options) {
        var width = K.undef(options.width, 352),
			height = K.undef(options.height, 488),
			clickFn = options.clickFn; //²ÎÊýurl,title

        if (typeof (self.fileManagerJson) === "string" && self.fileManagerJson != "") {
            try { self.fileManagerJson = eval(self.fileManagerJson); } catch (e) { self.fileManagerJson = null; }
        }
        if (self.fileManagerJson == null || self.fileManagerJson == "") self.fileManagerJson = new Object();
        self.fileManagerJson.tp = K.undef(self.fileManagerJson.tp, "lsb");
        self.fileManagerJson.callbackFuncName = "parent.KindEditorFileSelectCallback";
        self.fileManagerJson.imgOnly = K.undef(self.fileManagerJson.imgOnly, (options.dirName && options.dirName == "image"));
        var parm = JB.jsonToUrlStr(self.fileManagerJson);
        KindEditorFileSelectCallback = clickFn;
        var dialog = self.createDialog({
            name: name,
            width: width,
            height: height,
            title: self.lang(name),
            body: "<iframe style='width:352px;height:420px;' frameborder='0' allowtransparency='false' scrolling='no' src='/UploadFile/Manage.aspx?r=" + Math.random() + "&" + parm + "'></iframe>"
        });
        return dialog;
    }

});