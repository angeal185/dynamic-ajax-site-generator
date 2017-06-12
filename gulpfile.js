var gulp = require("gulp");
var nunjucksRender = require("gulp-nunjucks-render");
var data = require('gulp-data');
var htmlmin = require('gulp-htmlmin');


gulp.task('minify', function() {
  return gulp.src('includes/*.html')
    .pipe(htmlmin({collapseWhitespace:true,minifyJS:true}))
    .pipe(gulp.dest('includes'));
});

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

