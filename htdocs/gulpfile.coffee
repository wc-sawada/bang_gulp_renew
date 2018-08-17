gulp = require 'gulp'
coffee = require 'gulp-coffee'
plumber = require 'gulp-plumber'
sass = require 'gulp-sass'
minifycss = require 'gulp-minify-css'
replace = require 'gulp-replace'
haml = require 'gulp-haml'
prettify = require 'gulp-prettify'
config = require './gulp_config.json'

#compileのタスク
gulp.task 'sass', ->
	for i in [0 ... config.buildPathScss.scss.length]
		gulp.src config.buildPathScss.scss[i]
		.pipe plumber()
		.pipe sass()
		.pipe minifycss()
		.pipe gulp.dest config.buildPathScss.dest[i]
	return

#haml コンパイルタスク
gulp.task 'haml', ->
	return gulp.src config.buildPathHaml.haml
	.pipe haml()
	.pipe prettify()
	.pipe gulp.dest config.buildPathHaml.dest

#haml コンパイルタスク本番
gulp.task 'haml_prod', ->
	return gulp.src config.buildPathHaml.haml
	.pipe haml()
	.pipe gulp.dest config.buildPathHaml.dest

#ファイルを監視し続ける
gulp.task 'watch', ->
	gulp.watch [config.buildPathScss.scss], ['sass']
	gulp.watch [config.buildPathHaml.haml],['haml']