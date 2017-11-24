webpackJsonp([1],{

/***/ "+TbA":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__vuex_store__ = __webpack_require__("YtJ0");
//
//
//
//
//
//



/* harmony default export */ __webpack_exports__["a"] = ({
  data() {
    return {
      show: false
    };
  },
  methods: {
    backtotop() {
      let isScroll = this.$store.state.scroll;
      let timer = setInterval(function () {
        if (document.documentElement.scrollTop == 0) clearInterval(timer);
        window.scrollBy(0, -100);
      }, 5);
      if (isScroll.scrollTop) {
        let timer2 = setInterval(function () {
          if (isScroll.scrollTop == 0) clearInterval(timer2);
          isScroll.scrollBy(0, -100);
        }, 5);
      }
    }
  },
  mounted() {
    let _this = this;
    let isScroll = this.$store.state.scroll;
    //回到顶部
    isScroll.onscroll = function () {
      if (this.scrollTop >= 180) {
        _this.show = true;
      } else {
        _this.show = false;
      }
    };
    window.onscroll = function () {
      if (document.documentElement.scrollTop >= 180) {
        _this.show = true;
      } else {
        _this.show = false;
      }
    };
  },
  store: __WEBPACK_IMPORTED_MODULE_0__vuex_store__["a" /* default */]
});

/***/ }),

/***/ "18kQ":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__babel_loader_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_script_index_0_list_vue__ = __webpack_require__("1p+7");
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__node_modules_vue_loader_13_4_0_vue_loader_lib_template_compiler_index_id_data_v_3e5cde8c_hasScoped_false_transformToRequire_video_src_source_src_img_src_image_xlink_href_buble_transforms_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_template_index_0_list_vue__ = __webpack_require__("lc3Y");
function injectStyle (ssrContext) {
  __webpack_require__("j39y")
}
var normalizeComponent = __webpack_require__("0HdQ")
/* script */

/* template */

/* template functional */
  var __vue_template_functional__ = false
/* styles */
var __vue_styles__ = injectStyle
/* scopeId */
var __vue_scopeId__ = null
/* moduleIdentifier (server only) */
var __vue_module_identifier__ = null
var Component = normalizeComponent(
  __WEBPACK_IMPORTED_MODULE_0__babel_loader_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_script_index_0_list_vue__["a" /* default */],
  __WEBPACK_IMPORTED_MODULE_1__node_modules_vue_loader_13_4_0_vue_loader_lib_template_compiler_index_id_data_v_3e5cde8c_hasScoped_false_transformToRequire_video_src_source_src_img_src_image_xlink_href_buble_transforms_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_template_index_0_list_vue__["a" /* default */],
  __vue_template_functional__,
  __vue_styles__,
  __vue_scopeId__,
  __vue_module_identifier__
)

/* harmony default export */ __webpack_exports__["a"] = (Component.exports);


/***/ }),

/***/ "1p+7":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__vuex_store__ = __webpack_require__("YtJ0");
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//



/* harmony default export */ __webpack_exports__["a"] = ({
  data() {
    return {
      data: [],
      pageNum: {
        all: 2,
        good: 2,
        weex: 2,
        share: 2,
        ask: 2,
        job: 2
      }
    };
  },
  methods: {
    request() {
      let _this = this;
      _this.axios({
        method: 'get',
        url: '/api/v1/topics',
        params: {
          tab: _this.tab,
          limit: 20,
          page: 1
        },
        baseURL: 'https://www.vue-js.com',
        responseType: 'json',
        transformResponse: [function (res) {
          _this.data = res.data;
          console.log(res);
        }]
      });
    },
    goUser(loginname) {
      this.$router.push('/user/' + loginname);
    },
    goTopic(id, loginname) {
      this.$router.push({ path: '/topic/' + id, query: { loginname: loginname } });
    },
    //上拉刷新
    handleReachTop() {
      return new Promise(resolve => {
        setTimeout(() => {
          this.request();
          resolve();
        }, 200);
      });
    },
    //下拉加载更多
    handleReachBottom() {
      return new Promise(resolve => {
        setTimeout(() => {
          let _this = this;
          _this.axios({
            method: 'get',
            url: '/api/v1/topics',
            params: {
              tab: _this.tab,
              limit: 20,
              page: _this.pageNum[_this.tab]
            },
            baseURL: 'https://www.vue-js.com',
            responseType: 'json',
            transformResponse: [function (res) {
              _this.pageNum[_this.tab]++;
              for (let i = 0, len = res.data.length; i < len; i++) {
                _this.data.push(res.data[i]);
              }
            }]
          });
          resolve();
        }, 300);
      });
    }
  },
  mounted() {
    this.$store.commit('scroll', isScroll.children[0]);
    this.request();
  },
  computed: {
    tab() {
      return this.$store.state.tab;
    }
  },
  watch: {
    tab() {
      this.pageNum[this.tab] = 2;
      this.request();
    }
  },
  store: __WEBPACK_IMPORTED_MODULE_0__vuex_store__["a" /* default */]
});

/***/ }),

/***/ "41fD":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__babel_loader_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_script_index_0_topic_vue__ = __webpack_require__("fX4U");
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__node_modules_vue_loader_13_4_0_vue_loader_lib_template_compiler_index_id_data_v_c123f2f0_hasScoped_false_transformToRequire_video_src_source_src_img_src_image_xlink_href_buble_transforms_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_template_index_0_topic_vue__ = __webpack_require__("mc4W");
function injectStyle (ssrContext) {
  __webpack_require__("7TO9")
}
var normalizeComponent = __webpack_require__("0HdQ")
/* script */

/* template */

/* template functional */
  var __vue_template_functional__ = false
/* styles */
var __vue_styles__ = injectStyle
/* scopeId */
var __vue_scopeId__ = null
/* moduleIdentifier (server only) */
var __vue_module_identifier__ = null
var Component = normalizeComponent(
  __WEBPACK_IMPORTED_MODULE_0__babel_loader_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_script_index_0_topic_vue__["a" /* default */],
  __WEBPACK_IMPORTED_MODULE_1__node_modules_vue_loader_13_4_0_vue_loader_lib_template_compiler_index_id_data_v_c123f2f0_hasScoped_false_transformToRequire_video_src_source_src_img_src_image_xlink_href_buble_transforms_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_template_index_0_topic_vue__["a" /* default */],
  __vue_template_functional__,
  __vue_styles__,
  __vue_scopeId__,
  __vue_module_identifier__
)

/* harmony default export */ __webpack_exports__["a"] = (Component.exports);


/***/ }),

/***/ "7HfY":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__babel_loader_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_script_index_0_backtotop_vue__ = __webpack_require__("+TbA");
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__node_modules_vue_loader_13_4_0_vue_loader_lib_template_compiler_index_id_data_v_9036a3e8_hasScoped_false_transformToRequire_video_src_source_src_img_src_image_xlink_href_buble_transforms_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_template_index_0_backtotop_vue__ = __webpack_require__("jMLb");
function injectStyle (ssrContext) {
  __webpack_require__("IgQa")
}
var normalizeComponent = __webpack_require__("0HdQ")
/* script */

/* template */

/* template functional */
  var __vue_template_functional__ = false
/* styles */
var __vue_styles__ = injectStyle
/* scopeId */
var __vue_scopeId__ = null
/* moduleIdentifier (server only) */
var __vue_module_identifier__ = null
var Component = normalizeComponent(
  __WEBPACK_IMPORTED_MODULE_0__babel_loader_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_script_index_0_backtotop_vue__["a" /* default */],
  __WEBPACK_IMPORTED_MODULE_1__node_modules_vue_loader_13_4_0_vue_loader_lib_template_compiler_index_id_data_v_9036a3e8_hasScoped_false_transformToRequire_video_src_source_src_img_src_image_xlink_href_buble_transforms_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_template_index_0_backtotop_vue__["a" /* default */],
  __vue_template_functional__,
  __vue_styles__,
  __vue_scopeId__,
  __vue_module_identifier__
)

/* harmony default export */ __webpack_exports__["a"] = (Component.exports);


/***/ }),

/***/ "7Otq":
/***/ (function(module, exports) {

module.exports = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAADICAYAAACtWK6eAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyNpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMDE0IDc5LjE1Njc5NywgMjAxNC8wOC8yMC0wOTo1MzowMiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6OTk2QkI4RkE3NjE2MTFFNUE4NEU4RkIxNjQ5MTYyRDgiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6OTk2QkI4Rjk3NjE2MTFFNUE4NEU4RkIxNjQ5MTYyRDgiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIChNYWNpbnRvc2gpIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6NjU2QTEyNzk3NjkyMTFFMzkxODk4RDkwQkY4Q0U0NzYiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6NjU2QTEyN0E3NjkyMTFFMzkxODk4RDkwQkY4Q0U0NzYiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz5WHowqAAAXNElEQVR42uxda4xd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"

/***/ }),

/***/ "7TO9":
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),

/***/ "8I0v":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//

/* harmony default export */ __webpack_exports__["a"] = ({
	data() {
		return {
			data: {}
		};
	},
	mounted() {
		let _this = this;
		_this.axios({
			method: 'get',
			url: _this.loginname,
			baseURL: 'https://www.vue-js.com/api/v1/user/',
			responseType: 'json',
			transformResponse: [function (res) {
				_this.data = res.data;
				console.log(_this.data);
			}]
		});
	},
	computed: {
		loginname() {
			return this.$route.params.loginname;
		},
		githubUrl() {
			return 'https://github.com/' + this.$route.params.loginname;
		}
	},
	methods: {
		viewMore(loginname) {
			this.$router.push('/user/user_replies/' + loginname);
		},
		goTopic(id, loginname) {
			this.$router.push({ path: '/topic/' + id, query: { loginname: loginname } });
		}
	}
});

/***/ }),

/***/ "9tcK":
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),

/***/ "Czyj":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__components_navbar_vue__ = __webpack_require__("J56h");
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__components_backtotop_vue__ = __webpack_require__("7HfY");
//
//
//
//
//
//
//
//
//
//




/* harmony default export */ __webpack_exports__["a"] = ({
  name: 'app',
  components: {
    navbar: __WEBPACK_IMPORTED_MODULE_0__components_navbar_vue__["a" /* default */],
    backtotop: __WEBPACK_IMPORTED_MODULE_1__components_backtotop_vue__["a" /* default */]
  }
});

/***/ }),

/***/ "HZbz":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__babel_loader_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_script_index_0_user_replies_vue__ = __webpack_require__("NdEO");
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__node_modules_vue_loader_13_4_0_vue_loader_lib_template_compiler_index_id_data_v_5894a8cc_hasScoped_false_transformToRequire_video_src_source_src_img_src_image_xlink_href_buble_transforms_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_template_index_0_user_replies_vue__ = __webpack_require__("sUzC");
function injectStyle (ssrContext) {
  __webpack_require__("HrhF")
}
var normalizeComponent = __webpack_require__("0HdQ")
/* script */

/* template */

/* template functional */
  var __vue_template_functional__ = false
/* styles */
var __vue_styles__ = injectStyle
/* scopeId */
var __vue_scopeId__ = null
/* moduleIdentifier (server only) */
var __vue_module_identifier__ = null
var Component = normalizeComponent(
  __WEBPACK_IMPORTED_MODULE_0__babel_loader_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_script_index_0_user_replies_vue__["a" /* default */],
  __WEBPACK_IMPORTED_MODULE_1__node_modules_vue_loader_13_4_0_vue_loader_lib_template_compiler_index_id_data_v_5894a8cc_hasScoped_false_transformToRequire_video_src_source_src_img_src_image_xlink_href_buble_transforms_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_template_index_0_user_replies_vue__["a" /* default */],
  __vue_template_functional__,
  __vue_styles__,
  __vue_scopeId__,
  __vue_module_identifier__
)

/* harmony default export */ __webpack_exports__["a"] = (Component.exports);


/***/ }),

/***/ "HrhF":
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),

/***/ "IgQa":
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),

/***/ "Ix92":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__components_home_list__ = __webpack_require__("18kQ");
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__vuex_store__ = __webpack_require__("YtJ0");
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//




/* harmony default export */ __webpack_exports__["a"] = ({
  name: 'home',
  data() {
    return {};
  },
  mounted() {
    this.fn();
  },
  methods: {
    fn() {
      this.$store.commit('tab', this.$route.params.tab);
    }
  },
  computed: {
    tab() {
      return this.$route.params.tab;
    }
  },
  watch: {
    tab() {
      this.fn();
    }
  },
  components: {
    list: __WEBPACK_IMPORTED_MODULE_0__components_home_list__["a" /* default */]
  },
  store: __WEBPACK_IMPORTED_MODULE_1__vuex_store__["a" /* default */]
});

/***/ }),

/***/ "J0BD":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
var render = function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{attrs:{"id":"app"}},[_c('navbar'),_vm._v(" "),_c('router-view'),_vm._v(" "),_c('backtotop')],1)}
var staticRenderFns = []
var esExports = { render: render, staticRenderFns: staticRenderFns }
/* harmony default export */ __webpack_exports__["a"] = (esExports);

/***/ }),

/***/ "J56h":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__node_modules_vue_loader_13_4_0_vue_loader_lib_template_compiler_index_id_data_v_2be2baeb_hasScoped_false_transformToRequire_video_src_source_src_img_src_image_xlink_href_buble_transforms_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_template_index_0_navbar_vue__ = __webpack_require__("ramk");
function injectStyle (ssrContext) {
  __webpack_require__("dSud")
}
var normalizeComponent = __webpack_require__("0HdQ")
/* script */
var __vue_script__ = null
/* template */

/* template functional */
  var __vue_template_functional__ = false
/* styles */
var __vue_styles__ = injectStyle
/* scopeId */
var __vue_scopeId__ = null
/* moduleIdentifier (server only) */
var __vue_module_identifier__ = null
var Component = normalizeComponent(
  __vue_script__,
  __WEBPACK_IMPORTED_MODULE_0__node_modules_vue_loader_13_4_0_vue_loader_lib_template_compiler_index_id_data_v_2be2baeb_hasScoped_false_transformToRequire_video_src_source_src_img_src_image_xlink_href_buble_transforms_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_template_index_0_navbar_vue__["a" /* default */],
  __vue_template_functional__,
  __vue_styles__,
  __vue_scopeId__,
  __vue_module_identifier__
)

/* harmony default export */ __webpack_exports__["a"] = (Component.exports);


/***/ }),

/***/ "M93x":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__babel_loader_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_script_index_0_App_vue__ = __webpack_require__("Czyj");
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__node_modules_vue_loader_13_4_0_vue_loader_lib_template_compiler_index_id_data_v_d88bb72a_hasScoped_false_transformToRequire_video_src_source_src_img_src_image_xlink_href_buble_transforms_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_template_index_0_App_vue__ = __webpack_require__("J0BD");
function injectStyle (ssrContext) {
  __webpack_require__("v2B3")
}
var normalizeComponent = __webpack_require__("0HdQ")
/* script */

/* template */

/* template functional */
  var __vue_template_functional__ = false
/* styles */
var __vue_styles__ = injectStyle
/* scopeId */
var __vue_scopeId__ = null
/* moduleIdentifier (server only) */
var __vue_module_identifier__ = null
var Component = normalizeComponent(
  __WEBPACK_IMPORTED_MODULE_0__babel_loader_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_script_index_0_App_vue__["a" /* default */],
  __WEBPACK_IMPORTED_MODULE_1__node_modules_vue_loader_13_4_0_vue_loader_lib_template_compiler_index_id_data_v_d88bb72a_hasScoped_false_transformToRequire_video_src_source_src_img_src_image_xlink_href_buble_transforms_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_template_index_0_App_vue__["a" /* default */],
  __vue_template_functional__,
  __vue_styles__,
  __vue_scopeId__,
  __vue_module_identifier__
)

/* harmony default export */ __webpack_exports__["a"] = (Component.exports);


/***/ }),

/***/ "NHnr":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_vue__ = __webpack_require__("5vqR");
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__App__ = __webpack_require__("M93x");
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__router__ = __webpack_require__("YaEn");
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3_axios__ = __webpack_require__("BMa3");
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3_axios___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_3_axios__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4_iview__ = __webpack_require__("gstL");
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4_iview___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_4_iview__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5_iview_dist_styles_iview_css__ = __webpack_require__("laMd");
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5_iview_dist_styles_iview_css___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_5_iview_dist_styles_iview_css__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6_highlight_js__ = __webpack_require__("eh2P");
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_6_highlight_js___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_6_highlight_js__);
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7_highlight_js_styles_googlecode_css__ = __webpack_require__("yk+x");
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_7_highlight_js_styles_googlecode_css___default = __webpack_require__.n(__WEBPACK_IMPORTED_MODULE_7_highlight_js_styles_googlecode_css__);







 //样式文件

__WEBPACK_IMPORTED_MODULE_0_vue__["default"].use(__WEBPACK_IMPORTED_MODULE_4_iview___default.a);
__WEBPACK_IMPORTED_MODULE_0_vue__["default"].config.productionTip = false;
__WEBPACK_IMPORTED_MODULE_0_vue__["default"].prototype.axios = __WEBPACK_IMPORTED_MODULE_3_axios___default.a;

//过滤时间
__WEBPACK_IMPORTED_MODULE_0_vue__["default"].filter('timeFileter', function (val) {
	let time = '';
	let oldTime = new Date(val).valueOf();
	let newTime = Date.now();
	let difTime = newTime - oldTime;
	let second = Math.floor(difTime / 1000) + '秒钟前';
	let minute = Math.floor(difTime / 1000 / 60) + '分钟前';
	let hour = Math.floor(difTime / 1000 / 60 / 60) + '小时前';
	let day = Math.floor(difTime / 1000 / 60 / 60 / 24) + '天前';
	let month = Math.floor(difTime / 1000 / 60 / 60 / 24 / 30) + '个月前';
	let year = Math.floor(difTime / 1000 / 60 / 60 / 24 / 30 / 365) + '年前';

	if (parseInt(year)) {
		time = year;
	} else if (parseInt(month)) {
		time = month;
	} else if (parseInt(day)) {
		time = day;
	} else if (parseInt(hour)) {
		time = hour;
	} else if (parseInt(minute)) {
		time = minute;
	} else if (parseInt(second)) {
		time = second;
	}

	return time;
});

//过滤分类
__WEBPACK_IMPORTED_MODULE_0_vue__["default"].filter('translator', function (val) {
	let str = '';
	switch (val) {
		case 'job':
			str = '招聘';
			break;
		case 'ask':
			str = '问答';
			break;
		case 'share':
			str = '分享';
			break;
		case 'weex':
			str = 'weex';
			break;
	}

	return str;
});

new __WEBPACK_IMPORTED_MODULE_0_vue__["default"]({
	el: '#app',
	router: __WEBPACK_IMPORTED_MODULE_2__router__["a" /* default */],
	template: '<App/>',
	components: { App: __WEBPACK_IMPORTED_MODULE_1__App__["a" /* default */] }
});

/***/ }),

/***/ "NdEO":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__components_home_list__ = __webpack_require__("18kQ");
//
//
//
//
//
//
//
//
//



/* harmony default export */ __webpack_exports__["a"] = ({
	components: {
		list: __WEBPACK_IMPORTED_MODULE_0__components_home_list__["a" /* default */]
	},
	computed: {
		loginname() {
			return this.$route.params.loginname;
		}
	}
});

/***/ }),

/***/ "YaEn":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_vue__ = __webpack_require__("5vqR");
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_vue_router__ = __webpack_require__("zO6J");
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_2__components_home__ = __webpack_require__("wUZA");
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_3__components_topic__ = __webpack_require__("41fD");
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_4__components_user__ = __webpack_require__("ia7Y");
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_5__components_user_replies__ = __webpack_require__("HZbz");







__WEBPACK_IMPORTED_MODULE_0_vue__["default"].use(__WEBPACK_IMPORTED_MODULE_1_vue_router__["a" /* default */]);

//配置路由
/* harmony default export */ __webpack_exports__["a"] = (new __WEBPACK_IMPORTED_MODULE_1_vue_router__["a" /* default */]({
  routes: [{
    path: '/',
    redirect: '/home/all'
  }, {
    path: '/home/:tab',
    component: __WEBPACK_IMPORTED_MODULE_2__components_home__["a" /* default */]
  }, {
    path: '/home/:tab',
    component: __WEBPACK_IMPORTED_MODULE_2__components_home__["a" /* default */]
  }, {
    path: '/home/:tab',
    component: __WEBPACK_IMPORTED_MODULE_2__components_home__["a" /* default */]
  }, {
    path: '/home/:tab',
    component: __WEBPACK_IMPORTED_MODULE_2__components_home__["a" /* default */]
  }, {
    path: '/home/:tab',
    component: __WEBPACK_IMPORTED_MODULE_2__components_home__["a" /* default */]
  }, {
    path: '/home/:tab',
    component: __WEBPACK_IMPORTED_MODULE_2__components_home__["a" /* default */]
  }, {
    path: '/topic/:id',
    component: __WEBPACK_IMPORTED_MODULE_3__components_topic__["a" /* default */]
  }, {
    path: '/user/:loginname',
    component: __WEBPACK_IMPORTED_MODULE_4__components_user__["a" /* default */]
  }, {
    path: '/user/user_replies/:loginname',
    component: __WEBPACK_IMPORTED_MODULE_5__components_user_replies__["a" /* default */]
  }]
}));

/***/ }),

/***/ "YtJ0":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0_vue__ = __webpack_require__("5vqR");
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1_vuex__ = __webpack_require__("9rMa");



__WEBPACK_IMPORTED_MODULE_0_vue__["default"].use(__WEBPACK_IMPORTED_MODULE_1_vuex__["a" /* default */]);

const state = {
  tab: 213,
  scroll: {}
};

const mutations = {
  tab(state, val) {
    state.tab = val;
  },
  scroll(state, val) {
    state.scroll = val;
  }
};

/* harmony default export */ __webpack_exports__["a"] = (new __WEBPACK_IMPORTED_MODULE_1_vuex__["a" /* default */].Store({
  state,
  mutations
}));

/***/ }),

/***/ "cOrq":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
var render = function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"user"},[_c('div',{staticClass:"main"},[_c('div',{staticClass:"breadcrumb"},[_c('div',{staticClass:"header"},[_c('a',{attrs:{"href":"/"}},[_vm._v("主页")]),_vm._v(" "),_c('span',{staticClass:"divider"},[_vm._v("/")]),_vm._v(" "),_c('span',{staticClass:"dark"},[_vm._v(_vm._s(_vm.loginname)+"的主页")])])]),_vm._v(" "),_c('div',{staticClass:"inner_userinfo"},[_c('div',{staticClass:"user_big_avatar"},[_c('img',{attrs:{"src":_vm.data.avatar_url}}),_vm._v(" "),_c('span',{staticClass:"dark"},[_vm._v(_vm._s(_vm.data.loginname))])]),_vm._v(" "),_c('div',{staticClass:"unstyled"},[_c('span',[_vm._v(_vm._s(_vm.data.score)+" 积分")]),_vm._v(" "),(_vm.data.githubUsername)?_c('div',{staticClass:"unstyled"},[_c('i',{staticClass:"iconfont icon-home"}),_vm._v(" "),_c('a',{staticClass:"dark",attrs:{"href":_vm.githubUrl}},[_vm._v(_vm._s(_vm.githubUrl))]),_vm._v(" "),_c('br'),_vm._v(" "),_c('i',{staticClass:"iconfont icon-pinnedoctocat"}),_vm._v(" "),_c('a',{staticClass:"dark",attrs:{"href":_vm.githubUrl}},[_vm._v("@"+_vm._s(_vm.data.githubUsername))])]):_vm._e(),_vm._v(" "),_c('p',{staticClass:"col_fade"},[_vm._v("注册时间 "+_vm._s(_vm._f("timeFileter")(_vm.data.create_at)))])])])]),_vm._v(" "),_c('div',{staticClass:"title"},[_vm._v("最近创建的问题")]),_vm._v(" "),_vm._l((_vm.data.recent_topics),function(item){return _c('div',{staticClass:"cell"},[_c('a',{attrs:{"href":"javascript:;"},on:{"click":function($event){_vm.goTopic(item.id,item.author.loginname)}}},[_vm._v("\n\t\t\t"+_vm._s(item.title)+"\n\t\t")])])}),_vm._v(" "),_c('div',{staticClass:"title"},[_vm._v("最近参与的问题")]),_vm._v(" "),_vm._l((_vm.data.recent_replies),function(item){return _c('div',{staticClass:"cell"},[_c('a',{attrs:{"href":"javascript:;"},on:{"click":function($event){_vm.goTopic(item.id,item.author.loginname)}}},[_vm._v("\n\t\t\t"+_vm._s(item.title)+"\n\t\t")])])})],2)}
var staticRenderFns = []
var esExports = { render: render, staticRenderFns: staticRenderFns }
/* harmony default export */ __webpack_exports__["a"] = (esExports);

/***/ }),

/***/ "dSud":
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),

/***/ "fX4U":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//

/* harmony default export */ __webpack_exports__["a"] = ({
	data() {
		return {
			data: {}
		};
	},
	mounted() {
		let _this = this;
		_this.axios({
			method: 'get',
			url: _this.$route.params.id,
			baseURL: 'https://www.vue-js.com/api/v1/topic/',
			responseType: 'json',
			transformResponse: [function (res) {
				_this.data = res.data;
				setTimeout(function () {
					let code = document.querySelectorAll('pre code');
					code.forEach(code => {
						hljs.highlightBlock(code);
					});
				}, 100);
			}]
		});
	}
});

/***/ }),

/***/ "ia7Y":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__babel_loader_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_script_index_0_user_vue__ = __webpack_require__("8I0v");
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__node_modules_vue_loader_13_4_0_vue_loader_lib_template_compiler_index_id_data_v_5b64ab25_hasScoped_false_transformToRequire_video_src_source_src_img_src_image_xlink_href_buble_transforms_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_template_index_0_user_vue__ = __webpack_require__("cOrq");
function injectStyle (ssrContext) {
  __webpack_require__("oyc/")
}
var normalizeComponent = __webpack_require__("0HdQ")
/* script */

/* template */

/* template functional */
  var __vue_template_functional__ = false
/* styles */
var __vue_styles__ = injectStyle
/* scopeId */
var __vue_scopeId__ = null
/* moduleIdentifier (server only) */
var __vue_module_identifier__ = null
var Component = normalizeComponent(
  __WEBPACK_IMPORTED_MODULE_0__babel_loader_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_script_index_0_user_vue__["a" /* default */],
  __WEBPACK_IMPORTED_MODULE_1__node_modules_vue_loader_13_4_0_vue_loader_lib_template_compiler_index_id_data_v_5b64ab25_hasScoped_false_transformToRequire_video_src_source_src_img_src_image_xlink_href_buble_transforms_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_template_index_0_user_vue__["a" /* default */],
  __vue_template_functional__,
  __vue_styles__,
  __vue_scopeId__,
  __vue_module_identifier__
)

/* harmony default export */ __webpack_exports__["a"] = (Component.exports);


/***/ }),

/***/ "j39y":
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),

/***/ "jMLb":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
var render = function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('transition',{attrs:{"name":"backtotop"}},[(_vm.show)?_c('div',{staticClass:"backtotop",on:{"click":function($event){_vm.backtotop()}}},[_vm._v("返回顶部")]):_vm._e()])}
var staticRenderFns = []
var esExports = { render: render, staticRenderFns: staticRenderFns }
/* harmony default export */ __webpack_exports__["a"] = (esExports);

/***/ }),

/***/ "jV6w":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
var render = function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"main"},[_c('div',{staticClass:"home"},[_c('div',{staticClass:"header"},[_c('router-link',{attrs:{"to":"/home/all"}},[_vm._v("全部")]),_vm._v(" "),_c('router-link',{attrs:{"to":"/home/good"}},[_vm._v("精华")]),_vm._v(" "),_c('router-link',{attrs:{"to":"/home/weex"}},[_vm._v("weex")]),_vm._v(" "),_c('router-link',{attrs:{"to":"/home/share"}},[_vm._v("分享")]),_vm._v(" "),_c('router-link',{attrs:{"to":"/home/ask"}},[_vm._v("问答")]),_vm._v(" "),_c('router-link',{attrs:{"to":"/home/job"}},[_vm._v("招聘")])],1),_vm._v(" "),_c('list')],1)])}
var staticRenderFns = []
var esExports = { render: render, staticRenderFns: staticRenderFns }
/* harmony default export */ __webpack_exports__["a"] = (esExports);

/***/ }),

/***/ "laMd":
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),

/***/ "lc3Y":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
var render = function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"list"},[_c('Scroll',{attrs:{"id":"isScroll","on-reach-bottom":_vm.handleReachBottom,"on-reach-top":_vm.handleReachTop}},_vm._l((_vm.data),function(item,index){return _c('Card',{key:index,staticClass:"li",attrs:{"dis-hover":""}},[_c('a',{staticClass:"user_avatar",on:{"click":function($event){_vm.goUser(item.author.loginname)}}},[_c('img',{attrs:{"src":item.author.avatar_url}})]),_vm._v(" "),_c('a',{staticClass:"topic_title_wrapper",attrs:{"href":"javascript:;"},on:{"click":function($event){_vm.goTopic(item.id,item.author.loginname)}}},[(item.top)?_c('span',{staticClass:"put_top top"},[_vm._v("置顶")]):(item.good)?_c('span',{staticClass:"put_top good"},[_vm._v("精华")]):(_vm.tab == 'all')?_c('span',{staticClass:"put_top tab"},[_vm._v(_vm._s(_vm._f("translator")(item.tab)))]):_vm._e(),_vm._v(" "),_c('span',{staticClass:"title"},[_vm._v(_vm._s(item.title))]),_vm._v(" "),_c('span',{staticClass:"reply_count"},[_c('span',{staticClass:"count_of_replies"},[_vm._v(_vm._s(item.reply_count))]),_vm._v(" "),_c('span',{staticClass:"count_seperator"},[_vm._v("/")]),_vm._v(" "),_c('span',{staticClass:"count_of_visits"},[_vm._v(_vm._s(item.visit_count))])]),_vm._v(" "),_c('span',{staticClass:"last_active_time"},[_vm._v(_vm._s(_vm._f("timeFileter")(item.last_reply_at)))])])])}))],1)}
var staticRenderFns = []
var esExports = { render: render, staticRenderFns: staticRenderFns }
/* harmony default export */ __webpack_exports__["a"] = (esExports);

/***/ }),

/***/ "mc4W":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
var render = function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"topic"},[_c('div',{staticClass:"main"},[_c('div',{staticClass:"topic_header"},[_c('div',{staticClass:"topic_full_title"},[_c('span',{staticClass:"put_top"},[_vm._v("置顶")]),_vm._v(" "),_c('span',[_vm._v(_vm._s(_vm.data.title))])]),_vm._v(" "),_c('div',{staticClass:"changes"},[_c('span',[_vm._v("发布于 "+_vm._s(_vm._f("timeFileter")(_vm.data.create_at)))]),_vm._v(" "),_c('span',[_vm._v("作者 "+_vm._s(_vm.$route.query.loginname))]),_vm._v(" "),_c('span',[_vm._v(_vm._s(_vm.data.visit_count)+" 次浏览")]),_vm._v(" "),_c('span',[_vm._v("来自 "+_vm._s(_vm._f("translator")(_vm.data.tab)))])])]),_vm._v(" "),_c('div',{staticClass:"inner_topic"},[_c('div',{staticClass:"topic_content"},[_c('div',{domProps:{"innerHTML":_vm._s(_vm.data.content)}})])])])])}
var staticRenderFns = []
var esExports = { render: render, staticRenderFns: staticRenderFns }
/* harmony default export */ __webpack_exports__["a"] = (esExports);

/***/ }),

/***/ "oyc/":
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),

/***/ "ramk":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
var render = function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"navbar"},[_c('div',{staticClass:"navbar-inner"},[_c('div',{staticClass:"container"},[_vm._m(0),_vm._v(" "),_c('form',{staticClass:"navbar-search"},[_c('div',{staticClass:"search"},[_c('Input',{attrs:{"type":"text","icon":"android-search"}})],1)]),_vm._v(" "),_vm._m(1)])])])}
var staticRenderFns = [function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('a',{staticClass:"brand",attrs:{"href":"/"}},[_c('img',{attrs:{"src":__webpack_require__("7Otq")}}),_vm._v(" "),_c('span',[_vm._v("Vue.js")])])},function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('ul',{staticClass:"nav"},[_c('li',[_c('a',{attrs:{"href":"/"}},[_vm._v("首页")])]),_vm._v(" "),_c('li',[_c('a',{attrs:{"href":"http://www.hubwiz.com/course/?type=Vue.js&affid=vue-js"}},[_vm._v("交互教程")])]),_vm._v(" "),_c('li',[_c('a',{attrs:{"href":""}},[_vm._v("微信公众号")])]),_vm._v(" "),_c('li',[_c('a',{attrs:{"href":"http://doc.vue-js.com/"}},[_vm._v("VUE2.0")])]),_vm._v(" "),_c('li',[_c('a',{attrs:{"href":""}},[_vm._v("参考资料")])]),_vm._v(" "),_c('li',[_c('a',{attrs:{"href":""}},[_vm._v("API")])]),_vm._v(" "),_c('li',[_c('a',{attrs:{"href":""}},[_vm._v("关于")])]),_vm._v(" "),_c('li',[_c('a',{attrs:{"href":""}},[_vm._v("注册")])]),_vm._v(" "),_c('li',[_c('a',{attrs:{"href":""}},[_vm._v("登录")])])])}]
var esExports = { render: render, staticRenderFns: staticRenderFns }
/* harmony default export */ __webpack_exports__["a"] = (esExports);

/***/ }),

/***/ "sUzC":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
var render = function () {var _vm=this;var _h=_vm.$createElement;var _c=_vm._self._c||_h;return _c('div',{staticClass:"user_replies"},[_c('div',{staticClass:"main"},[_c('breadcrumb',{attrs:{"loginname":_vm.loginname}})],1),_vm._v(" "),_c('list')],1)}
var staticRenderFns = []
var esExports = { render: render, staticRenderFns: staticRenderFns }
/* harmony default export */ __webpack_exports__["a"] = (esExports);

/***/ }),

/***/ "v2B3":
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),

/***/ "wUZA":
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_0__babel_loader_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_script_index_0_home_vue__ = __webpack_require__("Ix92");
/* harmony import */ var __WEBPACK_IMPORTED_MODULE_1__node_modules_vue_loader_13_4_0_vue_loader_lib_template_compiler_index_id_data_v_9da85312_hasScoped_false_transformToRequire_video_src_source_src_img_src_image_xlink_href_buble_transforms_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_template_index_0_home_vue__ = __webpack_require__("jV6w");
function injectStyle (ssrContext) {
  __webpack_require__("9tcK")
}
var normalizeComponent = __webpack_require__("0HdQ")
/* script */

/* template */

/* template functional */
  var __vue_template_functional__ = false
/* styles */
var __vue_styles__ = injectStyle
/* scopeId */
var __vue_scopeId__ = null
/* moduleIdentifier (server only) */
var __vue_module_identifier__ = null
var Component = normalizeComponent(
  __WEBPACK_IMPORTED_MODULE_0__babel_loader_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_script_index_0_home_vue__["a" /* default */],
  __WEBPACK_IMPORTED_MODULE_1__node_modules_vue_loader_13_4_0_vue_loader_lib_template_compiler_index_id_data_v_9da85312_hasScoped_false_transformToRequire_video_src_source_src_img_src_image_xlink_href_buble_transforms_node_modules_vue_loader_13_4_0_vue_loader_lib_selector_type_template_index_0_home_vue__["a" /* default */],
  __vue_template_functional__,
  __vue_styles__,
  __vue_scopeId__,
  __vue_module_identifier__
)

/* harmony default export */ __webpack_exports__["a"] = (Component.exports);


/***/ }),

/***/ "yk+x":
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ })

},["NHnr"]);
//# sourceMappingURL=app.6ac2170bb3ab33b3ba18.js.map