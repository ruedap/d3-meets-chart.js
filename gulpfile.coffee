gulp = require 'gulp'
coffee = require 'gulp-coffee'
gutil = require 'gulp-util'

gulp.task 'coffee', ->
  gulp.src './d3-meets-chart.coffee'
    .pipe coffee(bare: true).on('error', gutil.log)
    .pipe gulp.dest('./')

gulp.task 'watch', ->
  gulp.watch './d3-meets-chart.coffee', ['coffee']

gulp.task 'default', ['coffee']
