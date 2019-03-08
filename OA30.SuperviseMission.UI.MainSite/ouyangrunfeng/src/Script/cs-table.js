(function(factory){
    if (typeof define === 'function' && define.amd)
      define(['jquery'], factory);
    else if (typeof exports === 'object')
      factory(require('jquery'));
    else
      factory(jQuery);

}(function($, undefined){
	  const DEFAULTS = {

	  }
	  const Row = function (element,option) {
	  	this.id = 0
	    this.element = $(element)
	    const { fields } = option
	    this.option = $.extend({}, DEFAULTS, option)
	    this.editHtml = this._newHtml()
	    this.saveHtml = this._editHtml()
	    if(this.option.editBtn){
	    	this.editHtml = this.success(this.option.editBtn)
	    }
	    if(this.option.saveBtn){
	    	this.saveHtml = this.success(this.option.saveBtn)
	    }
	  }

	  Row.prototype.add = function(){
	  	this.option.addBtn.push('add')
	  	const addBtn = this.option.addBtn ? this.success(this.option.addBtn) : this._newHtml()
		++this.id
		const { fields } = this.option
		let html = `<tr id="row${this.id}">`
		html += `<td>${addBtn}</td>`
		Object.keys(fields).forEach((key) => {
			if(typeof fields[key] === 'string'){
				html += `<td><span>${fields[key]}</span></td>`
			}else if(typeof fields[key] === 'object'){
				html += `<td>${this._type(fields[key])}</td>`
			}
		})
		html += '</tr>'
		this.element.find('tbody').prepend(html)
		//this.element.find('tbody .form-group .icon-sv-reduce').replace(<span class="iconfont icon-sv-add" data-row="select" data-target="#option"></span>)
	}
	Row.prototype._type = function(field){
		let html = ''
		const { type, name, value, template } = field
 		switch(type) {
			case　'text':
				html = `<input type="text" class="form-control" name="${name || 'text'}" value="${value}"/>`
				break
			case 'yes':
				html = `<select name="${name || 'yes'}" class="form-control"><option value="1">是</option><option value="0">否</option><select>`
				break
			case 'select':
				const oldHtml = $(template).html()
				const reg = /<span.*?data-row="unselect".*?span>/ig
				const newHtml = `<span class="iconfont icon-sv-add" data-row="select" data-target="${template}"></span>`
				html = oldHtml.replace(reg,newHtml)
				console.log(html)
				break
			default:
				html = ''
				break	
		}
		return html
	}

	Row.prototype._status = function(type){
		let html = ''
 		switch(type) {
			case　'save':
				html = `<button data-row="save" type="button" class="btn btn-sm btn-default">保存</button>`
				break
			case 'edit':
				html = `<button data-row="edit" type="button" class="btn btn-sm btn-default">编辑</button>`
				break
			case 'cancel':
				html = `<button data-row="cancel" type="button" class="btn btn-sm btn-default">取消</button>`
				break
			case 'delete':
				html = `<button data-row="delete" type="button" class="btn btn-sm btn-default">删除</button>`
				break
			default:
				html = ''
				break
		}
		return html
	}
	Row.prototype._getId = function(){
		return this.id
	}
	Row.prototype._deleteHtml = function(){
		const html = '<span class="delete">删除</span>'
		return html
	}
	Row.prototype._newHtml = function(){
		const html = `<div class="btn-group btn-group-sm" role="group"><button data-row="save" type="button" class="btn btn-default">保存</button><button type="button" class="btn btn-default cancel" data-row="cancel">取消</button></div>`
		return html
	}
	Row.prototype._saveHtml = function(){
		const html = `<div class="btn-group btn-group-sm" role="group"><button data-row="save" type="button" class="btn btn-default">保存</button><button type="button" class="btn btn-default cancel" data-row="cancel">取消</button></div>`
		return html
	}
	Row.prototype._editHtml = () => {
		const html = `<div class="btn-group btn-group-sm" role="group"><button type="button" class="btn btn-default edit" data-row="edit">编辑</button><button type="button" class="btn delete btn-default cancel" data-row="delete">删除</button></div>`
		return html
	}
	Row.prototype.save = function(_relatedTarget,that){
		const e = _relatedTarget
		const self = e.closest('tr')
		const event = $.Event('row.save', { relatedTarget: e })
    	this.element.trigger(event)
		const {saveBtn} = that.option
		//self.html(this.saveHtml)
		console.log(that)
	    self.find('[data-type]').each(function () {
			$(this).attr('disabled',true).addClass('disabled')
	    })
	    e.closest('td').html(this.saveHtml)
	    self.children().eq(0).html(this.saveHtml)
	    //$(target).closest('tr').children().eq(0).html(this._editHtml())
	}
	Row.prototype.row = function (_relatedTarget) {
		console.log(_relatedTarget,123)
    	//return this.isShown ? this.hide() : this.show(_relatedTarget)
  	}
	Row.prototype.edit = function(e,option){
		console.log(this.element)
		const args = Array.prototype.slice.call(arguments, 1);
    	this.element.trigger($.Event('row.edit'), args)
		const self = e.closest('tr')
		self.find('[data-type]').each(function () {
			$(this).removeAttr('disabled').removeClass('disabled')
	    })
	    self.children().eq(0).html(this.editHtml)
	}
	Row.prototype.delete = function(e){
		const _relatedTarget = e
		const event = $.Event('row.delete', { relatedTarget: _relatedTarget })
		e.closest('tr').remove()
	}
	Row.prototype.cancel = function(e){
		const relatedTarget = e
		const event = $.Event('row.cancel', { relatedTarget: relatedTarget })
    	this.element.trigger(event)
		const self = e.closest('tr')
		console.log(self)
		self.find('[data-type]').each(function () {
			$(this).attr('disabled',true).addClass('disabled')
	    })
	    self.children().eq(0).html(this.editHtml)
	}
	Row.prototype.select = function(e){
		const relatedTarget = e
		const event = $.Event('row.select', { relatedTarget: relatedTarget })
    	this.element.trigger(event)
		const html = $($(e).data('target')).html()
		console.log(html)
		$(e).closest('td').append(html)
	}
	Row.prototype.unselect = function(e){
		const _relatedTarget = e
		const event = $.Event('row.unselect', { relatedTarget: _relatedTarget })
		this.element.trigger(event)
		$(e).closest('div').remove()
	}
	Row.prototype.success = function(args) {
		console.log(args,args.indexOf('add'))
		let html = ''
		if(typeof args === 'string'){
			html += this._status(args)
		}else if(typeof args === 'object' && args instanceof Array){
			html += '<div class="btn-group btn-group-sm" role="group">'
			Object.keys(args).forEach((key) => {
				html += this._status(args[key])
			})
			html += '<div>'
		}
		if(args.indexOf('add') > 0) {
			console.log(html)
			const newHtml = ' data-row="delete" data-type="cancel" type="button" class="btn btn-sm btn-default">取消</button>'
			const reg = /(.*?)data-row="cancel".*?button>(.*?)$/ig
			html = html.replace(reg,`$1${newHtml}$2`)
			console.log(html.replace(reg,`$1${newHtml}$2`))
		}
		return html
	}
	Row.prototype.trigger = function (name) {
        var args = Array.prototype.slice.call(arguments, 1);

        name += '.bs.table';
        this.options[Row.EVENTS[name]].apply(this.options, args);
        this.$el.trigger($.Event(name), args);

        //this.options.onAll(name, args);
        this.element.trigger($.Event('all.bs.table'), [name, args]);
    };
    Row.EVENTS = {
        'all.bs.table': 'onAll',
        'click-cell.bs.table': 'onClickCell',
        'dbl-click-cell.bs.table': 'onDblClickCell',
        'click-row.bs.table': 'onClickRow',
        'dbl-click-row.bs.table': 'onDblClickRow',
        'sort.bs.table': 'onSort',
        'check.bs.table': 'onCheck',
        'uncheck.bs.table': 'onUncheck',
        'check-all.bs.table': 'onCheckAll',
        'uncheck-all.bs.table': 'onUncheckAll',
        'check-some.bs.table': 'onCheckSome',
        'uncheck-some.bs.table': 'onUncheckSome',
        'load-success.bs.table': 'onLoadSuccess',
        'load-error.bs.table': 'onLoadError',
        'column-switch.bs.table': 'onColumnSwitch',
        'page-change.bs.table': 'onPageChange',
        'search.bs.table': 'onSearch',
        'toggle.bs.table': 'onToggle',
        'pre-body.bs.table': 'onPreBody',
        'post-body.bs.table': 'onPostBody',
        'post-header.bs.table': 'onPostHeader',
        'expand-row.bs.table': 'onExpandRow',
        'collapse-row.bs.table': 'onCollapseRow',
        'refresh-options.bs.table': 'onRefreshOptions',
        'reset-view.bs.table': 'onResetView',
        'refresh.bs.table': 'onRefresh',
        'scroll-body.bs.table': 'onScrollBody'
    };
var allowedMethods = ['save','delete', 'edit', 'cancel','select','unselect'];
	  function Plugin(option) {
	    // return this.each(function () {
	    //   var $this = $(this)
	    //   var data  = $this.data('bs.row')
	    //   //var options = $.extend({}, DEFAULTS, $this.data(), typeof option == 'object' && option)
	    //   console.log(typeof option,option)
	    //   if (!data) $this.data('bs.row', (data = new Row(this,option)))
	    //   if (typeof option == 'string') data[option].call($this,_relatedTarget,data)
	    // })
	    var value,
            args = Array.prototype.slice.call(arguments, 1);

        this.each(function () {
            var $this = $(this),
                data = $this.data('bs.row'),
                options = $.extend({}, Row.DEFAULTS, $this.data(),
                    typeof option === 'object' && option);

            if (typeof option === 'string') {
                if ($.inArray(option, allowedMethods) < 0) {
                    throw new Error("Unknown method: " + option);
                }

                if (!data) {
                    return;
                }

                value = data[option].apply(data, args);

                if (option === 'destroy') {
                    $this.removeData('bs.row');
                }
            }

            if (!data) {
                $this.data('bs.row', (data = new Row(this, options)));
            }
        });

        return typeof value === 'undefined' ? this : value;
	  }

	  var old = $.fn.csTable

	  $.fn.csTable             = Plugin
	  $.fn.csTable.Constructor = Row


	  // TAB NO CONFLICT
	  // ===============

	  $.fn.csTable.noConflict = function () {
	    $.fn.csTable = old
	    return this
	  }
/*
	const EventHandle = function(e){
		e.preventDefault()
		const type = $(this).data('row')
		if(type !== 'edit' && type !== 'select' && type !== 'unselect' && type !== 'delete' && type !== 'save' && type !== 'add' && type !== 'cancel'){
			return
		}
		// if(type === 'save'){
		// 	Plugin.call($(this),type,Row.option)
		// }else{
			Plugin.call($(this), type,$(this))
		// }
		// switch(type){
		// 	case 'edit':
		//     	$(e.target).trigger($.Event( "row.edit",{relatedTarget: $(this)}));
		// 	break
		// 	case 'delete':
		// 		$(e.target).trigger($.Event( "row.delete",{relatedTarget: $(this)}));
		// 	break
		// 	case 'save':
		// 		$(e.target).trigger($.Event( "row.save",{relatedTarget: $(this)}));
		// 	break
		// 	case 'add':
		// 		$(e.target).trigger($.Event( "row.add",{relatedTarget: $(this)}));
		// 	break
		// 	default:
		// 		$(e.target).trigger($.Event( "row.cancel",{relatedTarget: $(this)}));
		// 	break
		// }
	}

	 $(document).on('click', '[data-row^="save"]', EventHandle)
	 $(document).on('click', '[data-row^="delete"]', EventHandle)
	 $(document).on('click', '[data-row^="edit"]', EventHandle)
	 $(document).on('click', '[data-row^="cancel"]', EventHandle)
	 $(document).on('click', '[data-row="select"]', EventHandle)
	 $(document).on('click', '[data-row="unselect"]', EventHandle)
	 //$(document).on('click', '[data-row^="add"]', EventHandle)

	// const clickHandler1 = function (e) {
	//    	e.preventDefault()
	//     Plugin.call($(this), 'delete',$(this))
	// }
	 //$(document).on('row.delete', '[data-row="delete"]',clickHandler1)
*/
$(function () {
        $('[data-toggle="row"]').csTable();
    });
}))
