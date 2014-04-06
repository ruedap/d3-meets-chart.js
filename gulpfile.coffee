gulp = require 'gulp'
gutil = require 'gulp-util'
mocha = require 'gulp-mocha'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
uglify = require 'gulp-uglify'

gulp.task 'coffee', ->
  gulp
    .src [
      './src/chart.coffee'
      './src/*.coffee'
    ]
    .pipe coffee(bare: true)
    .on 'error', gutil.log
    .pipe concat('d3-meets-chart.js')
    .pipe gulp.dest('./')
  gulp.src './test/*.coffee'
    .pipe coffee(bare: true)
    .on 'error', gutil.log
    .pipe gulp.dest('./test/')

gulp.task 'mocha', ->
  gulp.src './test/d3-meets-chart.spec.js'
    .pipe mocha(reporter: 'spec')

gulp.task 'watch', ->
  gulp.watch ['./src/*.coffee', './test/*.coffee'], ['coffee']

gulp.task 'test', ['coffee', 'mocha']
gulp.task 'default', ['test']
