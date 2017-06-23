var gulp = require("gulp"),
requireDir  = require("require-dir"),
gutil 		= require("gulp-util"),
chalk 		= require("chalk"); 
requireDir("./gulp-tasks", {recurse: true}),
nunjucksRender = require("gulp-nunjucks-render"),
data = require('gulp-data');

gulp.task('nunjucks', function() {
  return gulp.src('views/pages/**/*.njk')
    .pipe(data(function() {
      return require('./app/json/data.json')
    }))
	.pipe(nunjucksRender({
      path: ['views/templates']
    }))
	.pipe(gulp.dest('./includes'))
});

gulp.task("default", ["start"], function() {
	console.log(chalk.blue('Server listening with tasks:'),chalk.green(' Start'))
});