import Vue from 'vue'
import App from './App'
import router from './router'
import axios from 'axios'
import iView from 'iview'
import 'iview/dist/styles/iview.css'
import hljs from 'highlight.js'
import 'highlight.js/styles/googlecode.css' //样式文件

Vue.use(iView)
Vue.config.productionTip = false
Vue.prototype.axios = axios

//过滤时间
Vue.filter('timeFileter', function (val) {
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
})

//过滤分类
Vue.filter('translator', function (val) {
	let str = '';
	switch (val){
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
})

new Vue({
  el: '#app',
  router,
  template: '<App/>',
  components: { App }
})
