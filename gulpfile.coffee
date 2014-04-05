gulp = require 'gulp'
coffee = require 'gulp-coffee'
gutil = require 'gulp-util'
mocha = require 'gulp-mocha'

gulp.task 'coffee', ->
  gulp.src './src/*.coffee'
    .pipe coffee(bare: true)
    .on 'error', gutil.log
    .pipe gulp.dest('./src/')
  gulp.src './test/*.coffee'
    .pipe coffee(bare: true)
    .on 'error', gutil.log
    .pipe gulp.dest('./test/')

gulp.task 'mocha', ->
  gulp.src './test/d3-meets-chart-spec.js'
    .pipe mocha(reporter: 'spec')

gulp.task 'watch', ->
  gulp.watch ['./src/*.coffee', './test/*.coffee'], ['coffee']

gulp.task 'test', ['coffee', 'mocha']
gulp.task 'default', ['test']
