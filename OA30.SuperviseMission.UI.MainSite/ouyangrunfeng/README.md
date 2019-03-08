引入js通过requirejs进行引入

所有的引入需要在js/main.js下配置

例：
开发人员A需要增加a.js,于是main.js修改成以下：

require.config({
    paths: {
        jquery: 'jquery',
    },
    shim: {
        jquery: {
            exports: 'jquery'
        },
        bootstrap: {
            deps: ['jquery']
        }
    }
});

#1：requirejs(['jquery','bootstrap','app','picker','demo','call','a']);  //在此处添加引入文件

a.js需要进行以下的规范

defined(['a'],function(require){ //a是空间，可以省略，如果加上则可以给其他模块进行引入，rqurie是引入其他模块
const $ = require('jquery') //引入jQuery模块，引入的模块必须已经在#1上定义了
function add(a,b){
return a+b
}
return {
add:add
}
})
模块间互相引入

开发人员B需要调用A的js，所以b.js采用如下写法：
先在#1加上b.js，不然加载不了b.js

defined(function(require){//省略了命名空间
const a = require('a')
a.add(1,1)
})

