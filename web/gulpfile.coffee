gulp = require "gulp"

merge = require "gulp-merge"
coffee = require "gulp-coffee"
concat = require "gulp-concat"
stylus = require "gulp-stylus"

server = require "gulp-develop-server"
browserSync = require "browser-sync"

reload = browserSync.reload

gulp.task "client-js", () ->
    merge(
        gulp.src([
            "./bower_components/angular/angular.js"
            "./bower_components/angular-bootstrap/ui-bootstrap.js"
        ])
    ,
        gulp.src([
            "./assets/coffee/*.coffee"
        ])
            .pipe coffee({bare:true})
    )
        .pipe concat "client.js"
        .pipe gulp.dest "./static/build"
        .pipe reload({stream:true})

gulp.task "css", () ->
    gulp.src([
        "./assets/stylus/**/*.styl"
    ])
        .pipe stylus()
        .pipe gulp.dest "./static/build"
        .pipe reload({stream:true})

gulp.task "css-vendor", () ->
    gulp.src([
        "./bower_components/bootswatch-dist/css/bootstrap.css"
    ])
        .pipe concat "vendor.css"
        .pipe gulp.dest "./static/build"
        .pipe reload({stream:true})

gulp.task "watch", ["build"], () ->
    gulp.watch ["assets/coffee/**/*"], ["client-js"]
    gulp.watch ["assets/stylus/**/*"], ["css"]
    gulp.watch ["app.coffee", "server/**/*"], ["server:restart"]

gulp.task "build", ["client-js", "css", "css-vendor"], () ->

gulp.task "default", ["browser-sync", "server"]

gulp.task "server", () ->
    server.listen {path:"app.coffee"}


gulp.task "browser-sync", ["watch"], () ->
    browserSync {
        proxy:"localhost:3000"
        open:"false"
        port:"3001"
    }

gulp.task "server:restart", () ->
    server.restart (error) ->
        if !error
            reload()
