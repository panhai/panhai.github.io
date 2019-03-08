define('row',function(require){
	const $ = require('jquery')
	function Row (options) {
		const defaultOptions = {
			target: '.html'
		}
		this.options = $.extend({}, defaultOptions, options)
		this.id = 0
	}
	
	Row.prototype.init = function(){

	}

	Row.prototype.add = function(){
		++this.id
		const { fields, target } = this.options
		let html = `<tr id="row${this.id}">`
		html += `<td>${this._newHtml()}</td>`
		Object.keys(fields).forEach((key) => {
			if(typeof fields[key] === 'string'){
				html += `<td><span>${fields[key]}</span></td>`
			}else if(typeof fields[key] === 'object'){
				html += `<td>${this._type(fields[key])}</td>`
			}
		})
		html += '</tr>'
		$(target).find('tbody').prepend(html)
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
				html = $(template).html()
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
	Row.prototype.save = function(e){
		
		$(target).closest('tr').find('[data-type]').each(function () {
			$(this).attr('disabled',true).addClass('disabled')
	    })
	    //$(target).closest('tr').children().eq(0).html(this._editHtml())
	}
	Row.prototype.edit = function(e){
		const { target } = e
		$(target).closest('tr').find('[data-type]').each(function () {
			$(this).removeAttr('disabled').removeClass('disabled')
	    })
	    //e.closest('tr').children().eq(0).html(this._saveHtml())
	}
	Row.prototype.delete = function(e){
		const { target } = e

		const hidden = $.Event( "row.delete",{relatedTarget: $(e.target)})
        $(target).trigger(hidden);
		$(e.target).closest('tr').remove()
	}
	Row.prototype.cancel = function(e){
		const { target } = e
		$(target).closest('tr').find('[data-type]').each(function () {
			$(this).attr('disabled',true).addClass('disabled')
	    })
	    //$(target).closest('tr').children().eq(0).html(this._editHtml())
	}
	Row.prototype.success = function(e,args) {
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
		$(e.target).closest('td').html(html)
	}
	const EventHandle = function(e){
		const { target } =  e
		const type = $(target).data('row')
		switch(type){
			case 'edit':
		    	$(e.target).trigger($.Event("row.edit",{relatedTarget: $(e.target)}));
			break
			case 'delete':
				$(e.target).trigger($.Event("row.edit",{relatedTarget: $(e.target)}));
			break
			case 'save':
				$(e.target).trigger($.Event("row.save",{relatedTarget: $(e.target)}));
			break
			case 'add':
				$(e.target).trigger($.Event("row.add",{relatedTarget: $(e.target)}));
			break
			default:
				$(e.target).trigger($.Event("row.cancel",{relatedTarget: $(e.target)}));
			break

		}
	}
	// $(document).on('click', '[data-row^="save"]', EventHandle)
	// $(document).on('click', '[data-row^="delete"]', EventHandle)
	// $(document).on('click', '[data-row^="edit"]', EventHandle)
	// $(document).on('click', '[data-row^="cancel"]', EventHandle)
	// $(document).on('click', '[data-row^="add"]', EventHandle)
	// $(document).on('click', '[data-row^="save"]', EventHandle)
	// $(document).on('click', '[data-row^="cancel"]', $.proxy(Row.prototype.cancel,new Row))
	// $(document).on('click', '[data-row^="delete"]', $.proxy(Row.prototype.delete,new Row))
})