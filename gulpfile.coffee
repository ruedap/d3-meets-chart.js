gulp = require('gulp')
mocha = require('gulp-mocha')
karma = require('gulp-karma')
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
  dist: './dist/'

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
  tmp:
    main: dir.tmp + file.main
    mainMin: dir.tmp + file.mainMin
  dist:
    main: dir.dist + file.main
    mainMin: dir.dist + file.mainMin
  karmaFiles: [
    'bower_components/d3/d3.min.js',
    'tmp/d3-meets-chart.js',
    'tmp/spec-runner.js'
  ]

# Tasks

taskCoffee = (srcPath, concatPath, destPath) ->
  gulp.src(srcPath)
    .pipe(plumber())
    .pipe(coffee())
    .pipe(concat(concatPath))
    .pipe(gulp.dest(destPath))

gulp.task('coffee:src:tmp', -> taskCoffee(src.coffeeSrc, file.main, dir.tmp))
gulp.task('coffee:spec:tmp', -> taskCoffee(src.coffeeSpec, file.specRunner, dir.tmp))
gulp.task('coffee:src:dist', -> taskCoffee(src.coffeeSrc, file.main, dir.dist))

gulp.task 'stylus:src', ->
  gulp.src(src.stylusSrc)
    .pipe(plumber())
    .pipe(stylus())
    .pipe(gulp.dest(dir.tmp))

taskUglify = (srcPath, renamePath) ->
  gulp.src(srcPath)
    .pipe(rename(renamePath))
    .pipe(uglify())
    .pipe(gulp.dest('./'))

gulp.task('uglify:tmp', -> taskUglify(src.tmp.main, src.tmp.mainMin))
gulp.task('uglify:dist', -> taskUglify(src.dist.main, src.dist.mainMin))

taskClean = (srcPath) ->
  gulp.src(srcPath)
    .pipe(plumber())
    .pipe(rimraf())

gulp.task('clean:tmp', -> taskClean(dir.tmp))
gulp.task('clean:dist', -> taskClean(dir.dist))

gulp.task 'karma:travis', ->
  gulp.src(src.karmaFiles)
    .pipe(
      karma(
        configFile: 'karma.conf.js'
        browsers: ['Firefox', 'PhantomJS']
        reporters: ['progress', 'coverage']
        action: 'run'
      )
    )
    .on('error', (err) -> throw err)

gulp.task('licenses', -> licenseFind().pipe(gulp.dest('./audit')))

# Runners
gulp.task('compile:tmp', -> runSequence('clean:tmp', 'coffee:src:tmp', 'coffee:spec:tmp', 'stylus:src', 'uglify:tmp'))
gulp.task('compile:dist', -> runSequence('clean:dist', 'coffee:src:dist', 'uglify:dist'))
gulp.task('travis', -> runSequence('clean:tmp', 'coffee:src:tmp', 'coffee:spec:tmp', 'stylus:src', 'uglify:tmp', 'karma:travis'))
gulp.task('watch', -> gulp.watch(['./src/*.coffee', './src/*.styl', './spec/*.coffee'], ['compile:tmp']))
gulp.task('build', ['compile:dist'])
gulp.task('default', ['compile:tmp'])
