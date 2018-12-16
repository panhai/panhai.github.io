import Vue from 'vue'     //引入Vue
import Vuex from 'vuex'   //引入vuex (用npm 安装)

Vue.use(Vuex) //使用状态管理器
 //定义状态
const state = {
  tab: 213,
  scroll: {}
}
 //改变状态
const mutations = {
  tab (state, val)	 {  //改变状态对象state 的tab属性
  	state.tab = val
  },
  scroll (state, val) {  //改变状态对象(state)的scroll属性对象
  	state.scroll = val
  }
}
  //输出
export default new Vuex.Store({
	state,
	mutations
})

/*
 * 
 * 1  引入 。。。。。。。。。。
 * 
 * 2  状态管理。。。。。。。。
 * 
 * 3  输出状态（常量）
 * 
 * 
 */