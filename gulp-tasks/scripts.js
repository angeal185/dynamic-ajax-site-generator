var gulp = require("gulp");
var rename = require("gulp-rename");
var uglify = require("gulp-uglify");

gulp.task("scripts", function() {
	gulp.src([
				"app/js/pre.js",
				"app/js/app.js",
				"app/js/codepen.js",
				"app/js/pagination.js",
			])
		.pipe(uglify())
		.pipe(rename({ suffix: '.min' }))
		.pipe(gulp.dest("app/js/"));
});