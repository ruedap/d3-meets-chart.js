gulp = require('gulp')
mocha = require('gulp-mocha')
coffee = require('gulp-coffee')
stylus = require('gulp-stylus')
concat = require('gulp-concat')
uglify = require('gulp-uglify')
notify = require('gulp-notify')
rimraf = require('gulp-rimraf')
rename = require('gulp-rename')
plumber = require('gulp-plumber')
licenseFind = require('gulp-license-finder')
runSequence = require('run-sequence')

dir =
  tmp: './tmp/'

file =
  main: 'd3-meets-chart.js'
  mainMin: 'd3-meets-chart.min.js'
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
  main: dir.tmp + file.main
  mainMin: dir.tmp + file.mainMin
  specRunner: dir.tmp + file.specRunner

# Tasks

gulp.task 'coffee-src', ->
  gulp.src(src.coffeeSrc)
    .pipe(plumber())
    .pipe(coffee())
    .pipe(concat(file.main))
    .pipe(gulp.dest(dir.tmp))

gulp.task 'coffee-spec', ->
  gulp.src(src.coffeeSpec)
    .pipe(plumber())
    .pipe(coffee())
    .pipe(concat(file.specRunner))
    .pipe(gulp.dest(dir.tmp))

gulp.task 'stylus-src', ->
  gulp.src(src.stylusSrc)
    .pipe(plumber())
    .pipe(stylus())
    .pipe gulp.dest(dir.tmp)

gulp.task 'uglify', ->
  gulp.src(src.main)
    .pipe(rename(src.mainMin))
    .pipe(uglify())
    .pipe(gulp.dest('./'))

gulp.task 'clean', ->
  gulp.src(dir.tmp)
    .pipe(plumber())
    .pipe(rimraf())

gulp.task 'licenses', ->
  licenseFind().pipe(gulp.dest('./audit'))

# Runners

gulp.task 'compile', ->
  runSequence('clean', 'coffee-src', 'coffee-spec', 'stylus-src', 'uglify')

gulp.task('coffee', ['coffee-src', 'coffee-spec'])
gulp.task('stylus', ['stylus-src'])

gulp.task 'watch', ->
  gulp.watch(['./src/*.coffee', './src/*.styl', './spec/*.coffee'], ['compile'])

gulp.task('default', ['compile'])
