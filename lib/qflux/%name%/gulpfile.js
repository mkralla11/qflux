'use strict';

var gulp = require('gulp'),
    env = require('./env.json'),
    gulpFilter = require('gulp-filter'),
    flatten = require('gulp-flatten'),
    mainBowerFiles = require('main-bower-files'),
    rename = require("gulp-rename"),
    replace = require("gulp-replace"),
    minifycss = require('gulp-minify-css'),
    changed = require('gulp-changed'),
    sass = require('gulp-sass'),
    csso = require('gulp-csso'),
    gutil = require('gulp-util'),
    autoprefixer = require('gulp-autoprefixer'),
    browserify = require('browserify'),
    watchify = require('watchify'),
    source = require('vinyl-source-stream'),
    buffer = require('vinyl-buffer'),
    reactify = require('reactify'),
    coffeeify = require('coffeeify'),
    uglify = require('gulp-uglify'),
    del = require('del'),
    extend = require("extend"),
    sourcemaps = require('gulp-sourcemaps'),
    notify = require('gulp-notify'),
    browserSync = require('browser-sync'),
    reload = browserSync.reload,
    p = {
      main: './scripts/App.coffee',
      scss: 'styles/main.scss',
      scssSource: 'styles/**/*',
      font: 'fonts/*',
      bundle: 'app.js',
      publicJs: 'public/assets/js',
      publicCss: 'public/assets/css',
      publicFont: 'public/assets/fonts'
    };

var node_env = null;
var config = {};

gulp.task('clean', function(cb) {
  del(['public/assets'], cb);
});

gulp.task('browserSync', function() {
  browserSync({
    https: true,
    notify: false,
    open: false
  })
});

var replaceConfig = function(match, p1){
  return JSON.stringify(config);
}

gulp.task('watchify', function() {
  gutil.log(watchify.args);
  var bundler = watchify(browserify(p.main, extend(watchify.args, {debug: true})));

  function rebundle() {
    return bundler
      .bundle()
      .on('error', notify.onError())
      .pipe(source(p.bundle))
      .pipe(buffer())
      .pipe(replace(/(\{\{\{CONFIG\}\}\})/, replaceConfig))
      .pipe(sourcemaps.init({loadMaps: true}))
      .pipe(sourcemaps.write('./'))
      .pipe(gulp.dest(p.publicJs))
      .pipe(reload({stream: true}));
  }

  bundler.transform(reactify)
  .transform(coffeeify)
  .on('update', rebundle);
  return rebundle();
});

gulp.task('browserify', function() {
  browserify(p.main)
    .transform(reactify)
    .transform(coffeeify)
    .bundle()
    .pipe(replace(/(\{\{\{CONFIG\}\}\})/, replaceConfig))
    .pipe(source(p.bundle))
    .pipe(buffer())
    .pipe(uglify())
    .pipe(gulp.dest(p.publicJs));
});

gulp.task('fonts', function() {
  return gulp.src(p.font)
    .pipe(gulp.dest(p.publicFont));
});

gulp.task('styles', function() {
  return gulp.src(p.scss)
    .pipe(changed(p.publicCss))
    .pipe(sass({errLogToConsole: true}))
    .on('error', notify.onError())
    .pipe(autoprefixer('last 1 version'))
    .pipe(csso())
    .pipe(gulp.dest(p.publicCss))
    .pipe(reload({stream: true}));
});

// Ugly hack to bring modernizr in
gulp.task('modernizr', function() {
  return gulp.src('bower_components/modernizr/modernizr.js')
  .pipe(gulp.dest(p.publicJs));
});

gulp.task('bower-libs', function() {
  var jsFilter = gulpFilter('*.js');
  var cssFilter = gulpFilter('*.css');
  var fontFilter = gulpFilter(['*.eot', '*.woff', '*.svg', '*.ttf']);

  return gulp.src(mainBowerFiles())

  // JS from bower_components
  .pipe(jsFilter)
  .pipe(gulp.dest(p.publicJs))
  .pipe(uglify())
  .pipe(rename({
    suffix: ".min"
  }))
  .pipe(gulp.dest(p.publicJs))
  .pipe(jsFilter.restore())

  // css from bower_components, minified
  .pipe(cssFilter)
  .pipe(gulp.dest(p.publicCss))
  .pipe(minifycss())
  .pipe(rename({
    suffix: ".min"
  }))
  .pipe(gulp.dest(p.publicCss))
  .pipe(cssFilter.restore())

  // font files from bower_components
  .pipe(fontFilter)
  .pipe(flatten())
  .pipe(gulp.dest(p.publicFont));
});

gulp.task('libs', function() {
  gulp.start(['modernizr', 'bower-libs', 'fonts']);
});

gulp.task('watchTask', function() {
  gulp.watch(p.scssSource, ['styles']);
});

gulp.task('watch', ['clean'], function() {
  process.env.NODE_ENV = node_env = 'development';
  config = env[node_env];
  gulp.start(['libs', 'browserSync', 'watchTask', 'watchify', 'styles']);
});

gulp.task('build', ['clean'], function() {
  process.env.NODE_ENV = node_env = 'production';
  config = env[node_env];
  gulp.start(['libs', 'browserify', 'styles']);
});

gulp.task('default', function() {
  console.log('Run "gulp watch or gulp build"');
});

