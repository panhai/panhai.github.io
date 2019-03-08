'use strict';

define(function (require) {
    var _ = require('lodash')
    var state = {
        index:0,
        page: [],
        dType:'company',
        //部门列表
        fDepts: [],
        sDepts: [],
        deptGroup: {},
        company: {},
        //设置当前的page
        setPage: function (index) {
            state.index = index - 1;
        },
        //设置值
        setValue: function (name, value, sg) {
            var index = state.index;
            if (state && state.page[index] !== undefined && typeof value !== 'object') {
                state.page[index][name] = value
            } else if (typeof value === 'object') {
                if (state.page[index].single || sg) {
                    state.page[index][name] = {}
                    state.page[index][name][value[0]] = value[1]
                } else {
                    for (var v in value) {
                        state.page[index][name][value[0]] = value[1]
                    }
                }
            } else {
                error('当前page不存在');
            }
        },
        //删除值
        deleteValue: function (key, name) {
            delete state.getState()[name][key]
        },
        //删除值
        deleteItem: function (key) {
            delete state.getState()[key];
        },
        //搜索部门
        searchfDept: function (word) {
            var result = []
            _.map(state.fDepts, function (item) {
                if (item.DeptName.indexOf(word) > -1) {
                    result.push(item)
                }
            })
            return result;
            //return _.find(state.fDepts, function (item) {
                //return item.DeptName.indexOf(word) > -1
           // })
        },
        //搜索部门
        searchDeptGroup: function (dept) {
            var result = [];
            var group = state.fDepts;
            dept = dept.split(',');
            _.each(dept, function (data) {
                result.push(_.find(group, function (d) {
                    return d.DeptId === data
                }))
            })
            return result;
        },
        //添加元素到state
        setState: function (obj) {
            if (typeof obj === 'object') {
                state.page.push(obj)
            } else {
                error('参数只能是对象');
            }
        },
        //部门分组
        setDeptGroup: function (data) {
            var dg = state.deptGroup
            for (var i = 0, len = data.length; i < len; i++) {
                if (dg.hasOwnProperty(data[i].GroupId)) {
                    return;
                }
                state.deptGroup[data[i].GroupId] = data[i]
            }
        },
        //设置部门
        setfDept: function (data) {
            _.map(data, function (item, key) {
                if (_.some(state.fDepts, item)) {
                    return
                }
                state.fDepts.push(_.assign({check:false},item))
            })
        },
        stringToObject: function(name,key, value) {
            var obj = {}
            if (key) {
                if (value.indexOf(';') > -1) {
                    var ids = key.split(';');
                    var vds = value.split(';');
                    _.each(ids, function (item, index) {
                        if (item)
                            obj[item] = vds[index]
                    });
                } else {
                    obj[key] = value
                }
            }
            state.getState()[name] = obj
        },
        //对象转字符串
        objectToString: function (obj, ids, names, symbol) {
            var page = this.getState();
            var aIds = [];
            var aNames = [];
            for (var k in obj) {
                if (k === 0) return;
                aIds.push(k);
                aNames.push(obj[k]);
            }
            page[name] = aNames.join(symbol);
            page[ids] = aIds.join(symbol);
        },
        //设置选中部门
        setDeptCheck: function (value) {
            _.each(state.fDepts, function (item) {
                if (item.DeptId === value) {
                    item.check = true
                }
            })
        },
        //重置
        setObjectNull: function (name) {
            state.getState()[name] = {}
        },
        //设置取消选中部门
        setDeptunCheck: function (value) {
            _.each(state.fDepts, function (item) {
                if (item.DeptId === value) {
                    item.check = false
                }
            })
        },
        //设置是否单选
        setSingle: function (bool) {
            state.getState()['single'] = bool;
        },
        //增加page
        setIndex: function (obj) {
            var sn = {
                company: {},
                endTime: '',
                text: '',
                single:false,
                office: {},
            }
            state.page.push(_.assign(sn,obj))
        },
        //获取当前页
        getPage: function () {
            return state.index;
        },
        //获取当前索引
        getIndex: function () {
            return state.page.length;
        },
        //获取当前索引
        getPerson: function (type) {
            var p = state.getState()[type];
            var html = [];
            for (var i in p) {
                html.push(p[i] + '(' + i + ')');
            }
            return html.join(';')
        },
        //获取部门
        getDept: function () {
            var st = state.getState()
            return st[state.dType]
        },
        //设置部门还是责任处室
        setDeptType: function (type) {
            state.dType = type;
        },
        //是否单选
        getSingle: function () {
            return (state.page[state.index] && state.page[state.index].single) || false
        },
        //获取当前state
        getState: function () {
            return state.page[state.index]
        },
        //获取所有部门
        getAllDept: function () {
            return state.fDepts;
        },
        //获取当前state
        getDeptGroup: function () {
            return state.deptGroup
        },
        //获取当前state
        getDeptByName: function () {
            var name = []
            _.map(state.getDept(), function (item) {
                name.push(item);
            })
            return name.join(';');
        }
    }
    function error(err) {
        throw new Error(err); 
    }
    return state
});