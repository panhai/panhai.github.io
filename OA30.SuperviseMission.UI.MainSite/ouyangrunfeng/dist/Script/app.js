'use strict';

define(function (require) {
	var $ = require('jquery');
	var Mustache = require('mustache');
	//const Row = require('row')
	require('picker');
	require('bootstrap');
	require('cs-table');

	$(document).ready(function () {
		var statusCheck = [];
		var height = 0;
		if (!$('#main').length) {
			height = !$('#main').length && $('.main').height();
		}
		if (height > 0) {
			$(window.parent.document.getElementById('main')).height(height + 50);
		}

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
		$(document).on('change', '.dropdown-menu input', function (e) {
			var event = $(e.target);
			if (event.closest('.checkbox').hasClass('checkbox')) {
				var status = [];
				event.closest('.dropdown-menu').find('input').each(function (item) {
					var text = event.closest('label').text().trim();
					if ($(this).is(':checked')) {
						status.push($(this).closest('label').text().trim());
					}
				});
				event.closest('.dropdown').find('.form-control').val(status.toString());
			} else {
				event.closest('.dropdown').find('.form-control').val(event.closest('label').text().trim());
			}
		});
		var flterArray = [];
		$(document).on('click', '.search-btn', function (e) {
			var event = $(e.target);
			var html = '';
			event.closest('.search-control').find('input[type="text"]').each(function () {
				if ($(this).val()) {
					var arr = $(this).val().split(',');
					if (arr.length > 0) {
						$(arr).each(function (index) {
							flterArray.push(arr[index]);
							html += '<span>' + arr[index] + '<i class="iconfont icon-sv-close-s"></i></span>';
						});
					} else {
						flterArray.push($(this).val());
						html += '<span>' + $(this).val() + '<i class="iconfont icon-sv-close-s"></i></span>';
					}
				}
			});
			$('.search-filter').html(html);
		});

		$(document).on('click', '.reset-btn', function (e) {
			var event = $(e.target);
			event.closest('.search-control').find('input[type="text"]').each(function () {
				$(this).val('');
			});
			event.closest('.search-control').find('input[type="checkbox"]').each(function () {
				$(this).prop('checked', false);
			});
			$('.search-filter').html('');
		});

		$(document).on('click', '.search-filter span', function (e) {
			var event = $(e.target);
			var text = '';
			if ($(e.target).hasClass('iconfont')) {
				text = event.closest('span').text();
				event.closest('span').remove();
			} else {
				text = event.text();
				event.remove();
			}
			$('.search-control').find('input[type="text"]').each(function () {
				if ($(this).data('status') === 'more' && $(this).val().indexOf(text) >= 0) {
					console.log(text, $(this).val());
					$(this).val($(this).val().replace(text, ''));
					$(this).val($(this).val().replace(',,', ''));
					$('.dropdown-menu .checkbox label').each(function () {
						console.log(text, $(this).text().trim());
						if (text == $(this).text().trim()) {
							$(this).find('input').prop('checked', false);
						}
					});
				} else if (text === $(this).val()) {
					$(this).val('');
				}
			});
		});

		$('#search-input').on('click', function () {
			$('.search-control').show();
		});

		var chooseList = [];
		$('#leader').on('shown.bs.modal', function () {
			chooseList = [];
			chooseModalArea();
		});
		$(document).on('click', '[data-target="#company"]', function (e) {
			$('.choose-area li input').prop('checked', false);
			$('.result-area').html('');
			chooseList = [];
		});
		$('#company').on('shown.bs.modal', function (e) {
			$('.choose-area li input').prop('checked', false);
			$('.result-area').html('');
			chooseList = [];
		});
		$('#company').on('hide.bs.modal', function (e) {
			$('.choose-area li input').prop('checked', false);
			$('.result-area').html('');
			chooseList = [];
		});
		$('.search-filter span i').on('click', function (e) {
			$(e.target).parent().remove();
		});
		$('#chooseArea li input').on('change', function (e) {
			var self = $(e.target);
			var val = self.val();
			var text = self.closest('li').find('label').text();
			if (self.is(':checked')) {
				chooseList.push(text);
			} else {
				chooseList.splice(chooseList.indexOf(text), 1);
			}
			createHtml($('#resultArea'));
		});
		var createHtml = function createHtml(obj) {
			var html = '';
			Object.keys(chooseList).forEach(function (key) {
				html += '<span">' + chooseList[key] + ';</span>';
			});
			obj.html(html);
		};
		var chooseModalArea = function chooseModalArea() {
			$('#chooseArea li input').on('change', function (e) {
				var self = $(e.target);
				var val = self.val();
				var text = self.closest('li').find('label').text();
				if (self.is(':checked')) {
					chooseList.push(text);
				} else {
					chooseList.splice(chooseList.indexOf(text), 1);
				}
				createHtml($('#resultArea'));
			});
			var createHtml = function createHtml(obj) {
				var html = '';
				Object.keys(chooseList).forEach(function (key) {
					html += '<span">' + chooseList[key] + ';</span>';
				});
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
		var tIndex = 1;
		$('#newMission').on('click', function (e) {
			++tIndex;
			e.stopPropagation();
			var template = $('#template').html();
			Mustache.parse(template);
			var rendered = Mustache.render(template, { index: tIndex });
			$('#mission').append(rendered);
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
		});

		$(document).on('click', '[data-action^="feed"]', function (e) {
			var target = e.target;

			e.stopPropagation();
			e.preventDefault();
			var id = $(target).attr('href');
			if ($(target).hasClass('on')) {
				$(target).removeClass('on');
				$(this).find(id).hide();
			} else {
				$(target).addClass('on').siblings().removeClass('on');
				$(this).find('.tab-pane').hide();
				$(this).find(id).show();
			}
		});
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
		$('.table').csTable({
			fields: [{
				type: 'text',
				name: 'name',
				value: '1'
			}, {
				type: 'select',
				name: 'name2',
				value: '1',
				template: '#option'
			}, {
				type: 'yes',
				name: 'name3',
				value: '1'
			}, '23'],
			addBtn: ['save', 'cancel'],
			editBtn: 'delete',
			saveBtn: 'delete'
		});
		$(document).on('click', '[data-row^="table"]', function (e) {
			$('.table').csTable('add');
		});
		$(document).on('row.save', '[data-row^="save"]', function (e) {
			console.log('im save');
			//var event = $(e.target).closest('td')
			// setTimeout(function(){
			// 	event.html('<button type="button" class="btn btn-default cancel" data-row="delete">删除</button>')
			// })
		});
		// $('.pagination').csPage({
		//           totalCount: 122,
		//           showCount: 10,
		//           limit: 10,
		//           callback: function (curr, limit, totalCount) {
		//               console.log(curr,limit,totalCount)
		//           }
		//       });
		$(document).on('click', '.icon-sv-add', function (e) {
			var event = $(e.target);
			var arr = '';
			event.closest('td').find('.form-control').each(function (index) {
				console.log(index);
				//arr.push('<div class="form-group">'+$(this).val()+'</div>')
				arr += '<div class="form-group" data-index="' + index + '">' + $(this).val() + '</div>';
			});
			event.closest('td').next().html(arr);
		});
		$(document).on('change', '[data-toggle="depart"]', function (e) {
			var event = $(e.target);
			var arr = '';
			event.closest('td').find('.form-control').each(function (index) {
				console.log($(this).val());
				//arr.push('<div class="form-group">'+$(this).val()+'</div>')
				arr += '<div class="form-group" data-index="' + index + '">' + $(this).val() + '</div>';
			});
			event.closest('td').next().html(arr);
		});
		$(document).on('row.unselect', '[data-row="unselect"]', function (e) {
			var event = $(e.target);
			var select = event.prev('.form-control').val();
			var key = event.closest('.form-group').index();
			event.closest('td').next().find('[data-index="' + key + '"]').remove();
			event.closest('td').next().find('.form-group').each(function (index) {
				console.log($(this).data('index'), index);
				$(this).attr('data-index', index);
			});
		});
		var targetIndex = 0;
		$('#targetModal').on('shown.bs.modal', function (e) {
			var event = $(e.target);
			event.find('.alert').remove();
			//event.find('.btn-add').trigger('click',event)
			//event.find('.btn-add').on('click',function(){
			// ++targetIndex
			// console.log(event)
			// const val = event.find('.form-control').val()
			// if(val === ''){
			// 	alert('目标不能为空')
			// 	//event.find('.modal-body').prepend('<div class="alert alert-danger alert-dismissible fade in" role="alert"><button type="button" class="close" data-dismiss="alert" ria-label="Close"><span aria-hidden="true">×</span></button>目标不能为空</div>')
			// 	return
			// }
			// const template = $('#yearTargetTemplate').html()
			// Mustache.parse(template)
			// const rendered = Mustache.render(template,{index:targetIndex,content:val})
			// $('.card').eq(0).after(rendered)
			// $(event).modal('hide')
			//})
		});
		$(document).delegate('click', '.btn-add', function (event) {
			console.log(event);
			// ++targetIndex
			// console.log(event)
			// const val = event.find('.form-control').val()
			// if(val === ''){
			// 	alert('目标不能为空')
			// 	//event.find('.modal-body').prepend('<div class="alert alert-danger alert-dismissible fade in" role="alert"><button type="button" class="close" data-dismiss="alert" ria-label="Close"><span aria-hidden="true">×</span></button>目标不能为空</div>')
			// 	return
			// }
			// const template = $('#yearTargetTemplate').html()
			// Mustache.parse(template)
			// const rendered = Mustache.render(template,{index:targetIndex,content:val})
			// $('.card').eq(0).after(rendered)
			// $(event).modal('hide')
		});
		$(document).on('click', '[data-card="delete"]', function (e) {
			$(e.target).closest('.card').remove();
		});
	});
});