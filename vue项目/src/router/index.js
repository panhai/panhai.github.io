import Vue from 'vue'                           //引入vue
import Router from 'vue-router'                //引入vue-router  (必须用npm安装引入才有效)
import home from '@/components/home'           //引入.vue文件
import topic from '@/components/topic'         //  .vue 文件
import user from '@/components/user'           // .vue文件
import user_replies from '@/components/user_replies'  // .vue文件

Vue.use(Router)     //使用路由

//配置路由        （输出）
export default new Router({
  routes: [    // routes 是一个模块路径数组
    {
      path: '/',
      redirect: '/home/all'
    },
    {
    	path: '/home/:tab',
    	component: home
    },
    {
    	path: '/home/:tab',
    	component: home
    },
    {
    	path: '/home/:tab',
    	component: home
    },
    {
    	path: '/home/:tab',
    	component: home
    },
    {
    	path: '/home/:tab',
    	component: home
    },
    {
    	path: '/home/:tab',
    	component: home
    },
    {
    	path: '/topic/:id',
    	component: topic
    },
    {
    	path: '/user/:loginname',
    	component: user
    },
    {
    	path: '/user/user_replies/:loginname',
    	component: user_replies
    },
    {
    	path: '/topic/user_replies/:loginname',
    	component: user_replies
    }
  ]
})
