gulp = require 'gulp'
mocha = require 'gulp-mocha'
coffee = require 'gulp-coffee'
stylus = require 'gulp-stylus'
concat = require 'gulp-concat'
uglify = require 'gulp-uglify'
notify = require 'gulp-notify'
rimraf = require 'gulp-rimraf'
plumber = require 'gulp-plumber'

dir =
  tmp: './tmp/'

file =
  main: 'd3-meets-chart.js'
  specRunner: 'spec-runner.js'

src =
  coffeeSrc: [
    './src/chart.coffee'
    './src/chart-d3-chart.coffee'
    './src/chart-d3-pie.coffee'
    './src/*.coffee'
  ]
  coffeeSpec: [
    './spec/spec-helper.coffee'
    './spec/chart-d3-chart-spec.coffee'
    './spec/chart-d3-pie-spec.coffee'
    './spec/*-spec.coffee'
  ]
  stylusSrc: [
    './src/d3-meets-chart.styl'
  ]
  specRunner: dir.tmp + file.specRunner

gulp.task 'coffee-src', ->
  gulp
    .src src.coffeeSrc
    .pipe plumber()
    .pipe coffee(bare: true)
    .pipe concat(file.main)
    .pipe gulp.dest(dir.tmp)

gulp.task 'coffee-spec', ->
  gulp
    .src src.coffeeSpec
    .pipe plumber()
    .pipe coffee(bare: true)
    .pipe concat(file.specRunner)
    .pipe gulp.dest(dir.tmp)

gulp.task 'stylus-src', ->
  gulp
    .src src.stylusSrc
    .pipe plumber()
    .pipe stylus()
    .pipe gulp.dest(dir.tmp)

gulp.task 'mocha-exe', ['coffee'], ->
  gulp
    .src src.specRunner
    .pipe plumber()
    .pipe mocha(reporter: 'spec')

gulp.task 'mocha-clean', ['mocha-exe'], ->
  gulp
    .src src.specRunner
    .pipe rimraf()
    .pipe notify("☕")

gulp.task 'watch', ->
  gulp.watch ['./src/*.coffee', './src/*.styl', './spec/*.coffee'], ['spec']

gulp.task 'coffee', ['coffee-src', 'coffee-spec']
gulp.task 'stylus', ['stylus-src']
gulp.task 'mocha', ['mocha-exe', 'mocha-clean']
gulp.task 'spec', ['coffee', 'mocha', 'stylus']
gulp.task 'default', ['spec']
