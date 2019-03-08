'use strict';

define(function (require) {
	var $ = require('jquery');
	var Mustache = require('mustache');
	//const Row = require('row')
	require('picker');
	require('bootstrap');
	require('cs-table');
	// const EventHandle = function(e){
	// 	console.log(e.target)
	// 	const { target } =  e
	// 	const hidden = $.Event( "row.save",{relatedTarget: $('[data-row^="save"]')})
	//     $('[data-row^="save"]').trigger(hidden);
	// }
	// $(document).on('click', '[data-row^="save"]', EventHandle)
	$(document).ready(function () {
		var statusCheck = [];
		$(document).on('click', function (e) {
			var target = $(e.target);
			var toggle = target.data('switch');
			var checked = target.data('checked');
			if (toggle) {
				if (target.hasClass('icon-sv-arrow-down')) {
					target.text('收起');
					target.removeClass('icon-sv-arrow-down').addClass('icon-sv-arrow-up');
					$(toggle).children(':gt(3)').show();
				} else {
					target.text('更多');
					target.removeClass('icon-sv-arrow-up').addClass('icon-sv-arrow-down');
					$(toggle).children(':gt(3)').hide();
				}
			}
			if (checked) {
				if (target.is(':checked')) {
					console.log($(checked));
					$(checked).find('input[type="checkbox"]').prop('checked', true);
				} else {
					$(checked).find('input[type="checkbox"]').removeAttr('checked');
				}
			}
			if (target.closest('.search-part').length === 0) {
				$('.search-control').hide();
				$('.status-list').hide();
			}
			if (target.closest('.status-col').length === 0) {
				$('.status-list').hide();
			}
			if (target.closest('.status-list').length === 1) {
				var checkObj = target.closest('.status-list');
				if (target.is(':checked') && statusCheck.indexOf(target.next().text()) === -1) {
					statusCheck.push(target.next().text());
				} else {
					statusCheck.splice(statusCheck.indexOf(target.next().text()), 1);
				}
			}
		});

		$('#search-input').on('focus', function () {
			$('.search-control').show();
		});

		var chooseList = [];
		$('#leader').on('shown.bs.modal', function () {
			chooseList = [];
			chooseModalArea();
		});
		$('#company').on('shown.bs.modal', function () {
			chooseList = [];
			chooseModalArea();
		});
		$('.search-filter span i').on('click', function (e) {
			$(e.target).parent().remove();
		});
		var chooseModalArea = function chooseModalArea() {
			$('.choose-area li input').on('change', function (e) {
				var self = $(e.target);
				var val = self.val();
				var text = self.closest('li').find('label').text();
				console.log(self.val(), text);
				if (self.is(':checked')) {
					chooseList.push(text);
				} else {
					chooseList.splice(chooseList.indexOf(text), 1);
				}
				createHtml(self.closest('.choose-area').next());
			});
			var createHtml = function createHtml(obj) {
				var html = '';
				Object.keys(chooseList).forEach(function (key) {
					html += '<span">' + chooseList[key] + ';</span>';
				});
				console.log(chooseList, html);
				obj.html(html);
			};
		};

		$('#inputStatus').on('focus', function () {
			$('.status-list').show();
		});

		$('.input-time').datetimepicker({
			language: 'zh-CN',
			weekStart: 1,
			todayBtn: 1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			minView: 2,
			forceParse: 0
		});
		$('#newMission').on('click', function (e) {
			e.stopPropagation();
			var template = $('#template').html();
			Mustache.parse(template);
			var rendered = Mustache.render(template);
			$('#mission').append(rendered);
		});
		$(document).on('click','[data-action^="feed"]',function(e){
			const { target } = e
			console.log($(target))
			if($(target).data('action') === 'feed'){
				console.log($(target).attr('href'))
			}
		})

		/*
  const row = new Row({
  	target:'.table',
  	fields:[{
  		type:'text',
  		name:'name',
  		value:'1'
  	},{
  		type:'select',
  		name:'name2',
  		value:'1',
  		template:'#option'
  	},{
  		type:'yes',
  		name:'name3',
  		value:'1'
  	},'dd','bb','cc','aa'
  	]
  })
  $(document).on('row.edit','[data-row^="edit"]',function(e){
  	row.edit(e)
  	row.success(e,['save','cancel'])
  })
  $(document).on('row.cancel','[data-row^="cancel"]',function(e){
  	row.cancel(e)
  	row.success(e,['edit','delete'])
  })
  $(document).on('row.add','[data-row^="table"]',function(e){
  	row.create()
  })
  $(document).on('row.save','[data-row^="edit"]',function(e){
  	row.success(e,['edit','delete'])
  })
  $('.table').csTable({
  	fields:[{
  		type:'text',
  		name:'name',
  		value:'1'
  	},{
  		type:'select',
  		name:'name2',
  		value:'1',
  		template:'#option'
  	},{
  		type:'yes',
  		name:'name3',
  		value:'1'
  	},'dd','bb','cc','aa'
  	]
  })
  */
	});
});