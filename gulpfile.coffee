gulp = require('gulp')
mocha = require('gulp-mocha')
karma = require('gulp-karma')
coffee = require('gulp-coffee')
stylus = require('gulp-stylus')
concat = require('gulp-concat')
uglify = require('gulp-uglify')
notify = require('gulp-notify')
rimraf = require('gulp-rimraf')
plumber = require('gulp-plumber')

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
  main: dir.tmp + file.main
  specRunner: dir.tmp + file.specRunner
  d3: 'node_modules/d3/d3.min.js'
  lodash: 'node_modules/lodash/lodash.js'

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

gulp.task 'karma', ['compile'], ->
  gulp.src([src.d3, src.lodash, src.main, src.specRunner])
    .pipe(plumber())
    .pipe karma
      configFile: 'karma.conf.js'
      action: 'run'
    .on('error', (err) -> throw err)

gulp.task 'clean', ['karma'], ->
  gulp.src(src.specRunner)
    .pipe(plumber())
    .pipe(rimraf())

gulp.task 'watch', ->
  gulp.watch(['./src/*.coffee', './src/*.styl', './spec/*.coffee'], ['spec'])

gulp.task('coffee', ['coffee-src', 'coffee-spec'])
gulp.task('stylus', ['stylus-src'])
gulp.task('compile', ['coffee-src', 'coffee-spec', 'stylus-src'])
gulp.task('spec', ['compile', 'karma', 'clean'])
gulp.task('default', ['spec'])
