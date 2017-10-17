// We have to require our dependencies
var gulp = require('gulp');
var $ = require('gulp-load-plugins')();
var del = require('del');
var browserSync = require('browser-sync');
var es = require('event-stream');
var files = require('./tasks/files-inject.js');
var paths = require('./tasks/gulp-config');

// create a TASK to delete dist
gulp.task('clean', function () {
    del([paths.dist]);
});
gulp.task('clean:css', function () {
    del([paths.distCSS, paths.distCSSMap]);
});
gulp.task('clean:html', function () {
    del(paths.distHTML);
});
gulp.task('clean:js', function () {
    del([paths.distJS, paths.distJSMap,]);
});

// create a TASK to compile Pug to HTML
gulp.task('html',  function () {
    gulp.src(paths.srcHTML)
        .pipe($.pug({
            pretty: true,
            data: {
                vendorCss: paths.concatVendorCSS,
                appCss: paths.concatAppCSS,
                vendorJs: paths.concatVendorJS,
                appJs: paths.concatAppJS
            }
        }))
        .on('error', $.util.log)
        .pipe($.rename(function (path) {
            if (path.basename !== 'index') {
                path.dirname = paths.distHTML;
            }
        }))
        .pipe(gulp.dest(paths.dist))
});

// create a TASK to compile CoffeeScript to JavaScript 
gulp.task('coffee', function () {
    gulp.src([paths.srcJS])
        .pipe($.sourcemaps.init())
        .pipe($.coffee({ bare: true }))
        .on('error', $.util.log)
        .pipe($.angularOrder())    
        .pipe($.concat(paths.concatAppJS))    
        // .pipe(gulp.dest(paths.dist))
        // .pipe($.rename({ suffix: '.min' }))
        // .pipe($.uglify())
        .pipe($.sourcemaps.write('.'))
        .pipe(gulp.dest(paths.dist));
});
gulp.task('outer-js', function () {
    gulp.src(files.js)
        .on('error', $.util.log)
        .pipe($.concat(paths.concatVendorJS))    
        .pipe(gulp.dest(paths.dist));
});
gulp.task('js', ['outer-js', 'coffee'], function () { });

// create a TASK to compile Sass into CSS using gulp-sass
gulp.task('sass',  function () {
    return gulp.src(paths.srcCSS)
        .pipe($.sourcemaps.init())
        .pipe($.sass({ style: 'expanded' }))
        .on('error', $.util.log)
        .pipe($.concat(paths.concatAppCSS))
        // .pipe(gulp.dest(paths.dist))
        // .pipe($.rename({ suffix: '.min' }))
        // .pipe($.cleanCss())
        .pipe($.sourcemaps.write('.'))
        .pipe(gulp.dest('./dist/'));
});

gulp.task('fonts', function () {
    gulp.src("./node_modules/bootstrap/fonts/**")
        .pipe(gulp.dest(paths.dist + "/fonts/"));
});
gulp.task('outer-css', ['fonts'], function () {
    gulp.src(files.css)
        .on('error', $.util.log)
        .pipe($.concat(paths.concatVendorCSS))
        .pipe(gulp.dest(paths.dist));
    // return gulp.src('./node_modules/bootstrap/dist/css/bootstrap.css')
    //     .pipe(gulp.dest(paths.dist));
});
gulp.task('css', ['outer-css', 'sass'], function () {});

gulp.task('webserver', function () {
    browserSync({
        port: 3000,
        file: [paths.dist],
        injectChanges: true,
        logFileChanges: false,
        notify: true,
        reloadDelay: 0,
        browser: ['google-chrome', 'chrome', 'google chrome', 'Google Chrome'],
        server: {
            baseDir: (paths.dist) 
        }
    });
});


// create a TASK to WATCH for changes in your files
// this will "watch" for any changes in your files and rerun gulp if necessary
gulp.task('watch', ['webserver', 'build'], function () {
    gulp.watch([paths.srcHTML], ['html'], browserSync.reload);
    gulp.watch([paths.srcJS], ['js'], browserSync.reload);
    gulp.watch([paths.srcCSS], ['css'], browserSync.reload);
 });

gulp.task('build', ['html', 'js', 'css'], function () {

});
// finally, create a TASK that will run all commands when typing "gulp"
// in Terminal



gulp.task('default', ['watch']);