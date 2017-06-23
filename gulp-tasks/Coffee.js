var gulp = require("gulp");

// Task to compile coffeescript files
gulp.task("coffee", function() {
	gulp.src("app/coffee/*.coffee")
		.pipe(coffee({bare: true}))
		.pipe(gulp.dest("app/js"));
});