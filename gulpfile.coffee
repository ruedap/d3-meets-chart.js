gulp = require 'gulp'
coffee = require 'gulp-coffee'
gutil = require 'gulp-util'

gulp.task 'coffee', ->
  gulp.src './src/*.coffee'
    .pipe coffee(bare: true)
    .on 'error', gutil.log
    .pipe gulp.dest('./src/')
  gulp.src './test/*.coffee'
    .pipe coffee(bare: true)
    .on 'error', gutil.log
    .pipe gulp.dest('./test/')

gulp.task 'watch', ->
  gulp.watch ['./src/*.coffee', './test/*.coffee'], ['coffee']

gulp.task 'default', ['coffee']
