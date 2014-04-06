gulp = require 'gulp'
mocha = require 'gulp-mocha'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
uglify = require 'gulp-uglify'
notify = require 'gulp-notify'
rimraf = require 'gulp-rimraf'
plumber = require 'gulp-plumber'

gulp.task 'coffee-src', ->
  gulp
    .src [
      './src/chart.coffee'
      './src/*.coffee'
    ]
    .pipe plumber()
    .pipe coffee(bare: true)
    .pipe concat('d3-meets-chart.js')
    .pipe gulp.dest('./')

gulp.task 'coffee-spec', ->
  gulp
    .src [
      './spec/spec-helper.coffee'
      './spec/*-spec.coffee'
    ]
    .pipe plumber()
    .pipe coffee(bare: true)
    .pipe concat('spec-runner.js')
    .pipe gulp.dest('./tmp/')

gulp.task 'mocha-exe', ['coffee'], ->
  gulp
    .src './tmp/spec-runner.js'
    .pipe plumber()
    .pipe mocha(reporter: 'spec')

gulp.task 'mocha-clean', ['mocha-exe'], ->
  gulp
    .src './tmp/spec-runner.js'
    .pipe rimraf()
    .pipe notify("☕")

gulp.task 'watch', ->
  gulp.watch ['./src/*.coffee', './spec/*.coffee'], ['spec']

gulp.task 'coffee', ['coffee-src', 'coffee-spec']
gulp.task 'mocha', ['mocha-exe', 'mocha-clean']
gulp.task 'spec', ['coffee', 'mocha']
gulp.task 'default', ['spec']
