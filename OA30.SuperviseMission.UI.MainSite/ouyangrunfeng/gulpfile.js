const gulp = require('gulp')
const ejs = require('gulp-ejs')
const sass = require('gulp-sass');
const less = require('gulp-less');
const clean = require('gulp-clean');
const path = require('path');
const babel = require('gulp-babel');
const rev = require('gulp-rev');
const revCollector = require('gulp-rev-collector');
const autoprefixer = require('gulp-autoprefixer');
const gulpWebpack = require('webpack-stream');

// 设定路径
const node_path = path.resolve(__dirname, './','node_modules');

gulp.task('html',function() {
	gulp.src("./src/ejs/**/*.ejs")
    .pipe(ejs({},{},{ext: '.html'}))
    .pipe(gulp.dest("./dist/html"))
})

gulp.task('css', function () {
  return gulp.src('./src/Css/style.css')
    .pipe(autoprefixer({
        browsers: ['last 2 versions', 'Android >= 4.0', 'ie >= 8.0'],
    }))
    .pipe(gulp.dest('./dist/Css'))
    //.pipe(gulp.dest('../Css'));
});

gulp.task('sass', function () {
  return gulp.src('./src/sass/style.scss')
    //.pipe(revCollector())
    .pipe(sass().on('error', sass.logError))
    .pipe(autoprefixer({
        browsers: ['last 2 versions', 'Android >= 4.0', 'ie >= 8.0'],
    }))
    .pipe(gulp.dest('./dist/Css'))
    //.pipe(gulp.dest('../Css'));
});

gulp.task('webpack',function () {
   return gulp.src('./src/Script/app.js')
        .pipe(gulpWebpack({
            output:{
                filename: 'app.js'
            },
            module: {
                rules:[
                    {
                        test: /\.js$/,
                        use:['babel-loader']
                    }
                ]
            },
        }))
        .pipe(gulp.dest('./dist/Script'))
        //.pipe(gulp.dest('../Script'));
});

gulp.task('js',function () {
   return gulp.src('./src/Script/*.js')
        .pipe(babel({
            presets:['es2015']
        }))
        .pipe(gulp.dest('./dist/Script'))
        .pipe(gulp.dest('../Script'));
});


gulp.task('tmp',['app'], function () {
   return gulp.src('./src/tmp/app.js')
        .pipe(gulpWebpack())
        .pipe(gulp.dest('./dist/Script'))
        .pipe(gulp.dest('../Script'));
});

gulp.task('app',function(){
    return gulp.src('./src/Script/*.js')
        .pipe(babel({
            presets:['es2015']
        }))
        .pipe(gulp.dest('./src/tmp'))
})

gulp.task('watch', function () {
  gulp.watch('./src/sass/*.scss', ['sass']);
  gulp.watch('./src/Script/*.js', ['js']);
  gulp.watch('./src/ejs/**/*.ejs', ['html']);
   gulp.watch('./src/Image/*', ['img']);
});

gulp.task('clean', function () {
  return gulp.src('./dist/*', {read: false})
    .pipe(clean());
});



gulp.task('jquery',function() {
    gulp.src(node_path+'/jquery/dist/jquery.js')
        .pipe(gulp.dest('./dist/Script/'))
        .pipe(gulp.dest('../Script'))
});

gulp.task('font', function(){
    return gulp.src('./src/Font/*')
        //.pipe(rev())
        .pipe(gulp.dest('./dist/Font'))
        .pipe(gulp.dest('../Font'));
        //.pipe(rev.manifest())
        //.pipe(gulp.dest('src/rev/font'));
});

gulp.task('img', function(){
    return gulp.src('./src/Image/*')
        .pipe(gulp.dest('./dist/Image'))
        .pipe(gulp.dest('../Image'));
});

// 建立任务
gulp.task('bootstrap',function() {
    // 生成scss
    gulp.src(node_path+'/bootstrap/less/bootstrap.less')
        .pipe(less())
        .pipe(gulp.dest('./dist/css/'));
    // 将所有的src目录下的js进行编译，用babel，放到一个dist目录下
    return gulp.src(node_path+'/bootstrap/js/*.js')
        .pipe(babel({
            presets:['es2015']
        }))
        .pipe(gulp.dest(node_path+'/bootstrap/js/dist2'));
});
// 建立新的任务，依赖bootstrap任务
gulp.task('vendor',['bootstrap'],function() {
    // 将所有的dist2下的文件进行模块化打包放到bootstrap.js文件
    return gulp.src(node_path+'/bootstrap/js/dist2/*.js')
        .pipe(gulpWebpack({
            entry: [node_path+'/jquery/dist/jquery.js'],
            output:{
                filename:'vendor.js'
            }
        }))
        .pipe(gulp.dest('./dist/Script/'));
});

gulp.task('build',['font','html','sass','img','css','js'])