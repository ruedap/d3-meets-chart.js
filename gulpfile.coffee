gulp = require 'gulp'
gutil = require 'gulp-util'
mocha = require 'gulp-mocha'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
uglify = require 'gulp-uglify'
notify = require 'gulp-notify'
plumber = require 'gulp-plumber'

gulp.task 'coffee', (cb) ->
  gulp
    .src [
      './src/chart.coffee'
      './src/*.coffee'
    ]
    .pipe plumber()
    .pipe coffee(bare: true)
    .pipe concat('d3-meets-chart.js')
    .pipe gulp.dest('./')
  gulp.src './test/*.coffee'
    .pipe coffee(bare: true)
    .pipe plumber()
    .pipe gulp.dest('./test/')
  cb()

gulp.task 'mocha', ['coffee'], ->
  gulp.src './test/d3-meets-chart.spec.js'
    .pipe plumber()
    .pipe mocha(reporter: 'spec')
    .pipe notify("☕")

gulp.task 'watch', ->
  gulp.watch ['./src/*.coffee', './test/*.coffee'], ['test']

gulp.task 'test', ['coffee', 'mocha']
gulp.task 'default', ['test']
