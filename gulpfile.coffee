###
Modules
###
_           = require('lodash')
chalk       = require('chalk')
gulp        = require('gulp')
clean       = require('gulp-rimraf')
cjsx        = require('gulp-cjsx')
filter      = require('gulp-filter')
iif         = require('gulp-if')
imagemin    = require('gulp-imagemin')
jade        = require('gulp-jade')
plumber     = require('gulp-plumber')
rename      = require('gulp-rename')
sass        = require('gulp-ruby-sass')
nodemon     = require('gulp-nodemon')
uglify      = require('gulp-uglify')
sync        = require('browser-sync')
{ spawn }   = require('child_process')


###
Variables
###
env = require('./env.json')
data = _.extend({}, env)


###
Directory Paths
###
_src = './src'
_build = './_build'
DIR =
  modules: './node_modules'
  src:
    root: _src
    html: "#{_src}/frontend/html"
    js: "#{_src}/frontend/js"
    css: "#{_src}/frontend/css"
    img: "#{_src}/frontend/img"
    misc: "#{_src}/frontend/misc"
    vendor: "#{_src}/frontend/vendor"
    backend: "#{_src}/backend"
    shared: "#{_src}/shared"
  build:
    root: _build
    public: "#{_build}/public"
    js: "#{_build}/public/js"
    css: "#{_build}/public/css"
    img: "#{_build}/public/img"
    vendor:
      js: "#{_build}/public/js/vendor"
      css: "#{_build}/public/css/vendor"

###
Task Manager
###
_do = (src='', dest='', task='', filename='') ->
  _copy = task is ''
  _sass = /sass/.test task
  _jade = /jade/.test task
  _coffee = /coffee|cjsx/.test task
  _uglify = /uglify/.test task
  _imagemin = /imagemin/.test task
  _rename = /rename/.test task
  _dev = /dev/.test task

  if _sass
    sass(src, {compass: true, style: 'compressed', sourcemap: false}) # Sass
      .pipe(do plumber) # Plumber
      .pipe(gulp.dest(dest)) # Destination
      .pipe(filter('**/*.css')) # Filter CSS
      .pipe(sync.reload(stream: true)) # BrowserSync
  else
    gulp.src(src)
      .pipe(do plumber) # Plumber
      .pipe(iif(_jade, jade({data, pretty: true}))) # Jade
      .pipe(iif(_coffee, cjsx(bare: true))) # Coffee/React
      .pipe(iif(_uglify and not _dev, uglify(compress: drop_debugger: false))) # Uglify
      .pipe(iif(_imagemin and not _dev, imagemin(progressive: true))) # Imagemin
      .pipe(iif(_rename and !!filename, rename(basename: filename))) # Rename
      .pipe(gulp.dest(dest)) # Destination


###
Clean
###
gulp.task 'clean', ->
  gulp.src(DIR.build.root, {read: false}).pipe(clean())
gulp.task 'clean:modules', ->
  gulp.src([DIR.modules, DIR.src.vendor], {read: false}).pipe(clean())

gulp.task 'clean:all', ['clean', 'clean:modules']


###
Vendor Files
###
gulp.task 'vendor', ->
  _do("#{DIR.src.vendor}/requirejs/require.js", DIR.build.vendor.js, 'uglify')
  _do("#{DIR.src.vendor}/zepto/zepto.js", DIR.build.vendor.js, 'uglify')
  _do("#{DIR.src.vendor}/lodash/lodash.js", DIR.build.vendor.js, 'uglify')
  _do("#{DIR.src.vendor}/react/react-with-addons.js", DIR.build.vendor.js, 'uglify rename', 'react')
  _do("#{DIR.src.vendor}/flux/dist/Flux.js", DIR.build.vendor.js, 'uglify rename', 'flux')
  _do("#{DIR.src.vendor}/eventEmitter/eventEmitter.js", DIR.build.vendor.js, 'uglify rename', 'event')
  _do("#{DIR.src.vendor}/backbone/backbone.js", DIR.build.vendor.js, 'uglify')
  _do("#{DIR.src.vendor}/bluebird/js/browser/bluebird.js", DIR.build.vendor.js, 'uglify rename', 'bluebird')
  _do("#{DIR.src.vendor}/prism/prism.js", DIR.build.vendor.js, 'uglify')
  _do("#{DIR.src.vendor}/prism/themes/prism.css", DIR.build.vendor.css)



###
Tasks
###
gulp.task 'misc', ->
  _do("#{DIR.src.misc}/**/*",  DIR.build.public)
gulp.task 'html', ->
  _do(["#{DIR.src.html}/**/*.jade", "!#{DIR.src.html}/**/_*.jade"],  DIR.build.public, 'jade')
gulp.task 'css', ->
  _do(DIR.src.css, DIR.build.css, 'sass')
gulp.task 'js', ->
  _do("#{DIR.src.js}/**/*.{coffee,cjsx}", DIR.build.js, 'cjsx uglify')
gulp.task 'img', ->
  _do("#{DIR.src.img}/**/*", DIR.build.img, 'imagemin')

gulp.task 'js:dev', ->
  _do("#{DIR.src.js}/**/*.{coffee,cjsx}", DIR.build.js, 'cjsx dev')
gulp.task 'img:dev', ->
  _do("#{DIR.src.img}/**/*", DIR.build.img, 'imagemin dev')

gulp.task 'backend', ->
  _do(["!#{DIR.src.backend}/**/*.coffee", "#{DIR.src.backend}/**/*"], DIR.build.root)
  _do("#{DIR.src.backend}/**/*.coffee", DIR.build.root, 'cjsx uglify')

gulp.task 'shared', ->
  _do("#{DIR.src.shared}/**/*.coffee", DIR.build.js, 'coffee')
  _do("#{DIR.src.shared}/**/*.coffee", DIR.build.root, 'coffee')



###
Build
###
gulp.task 'build:backend', ['shared', 'backend']
gulp.task 'build:static:dev', ['shared', 'misc', 'html', 'css', 'js:dev', 'img:dev']
gulp.task 'build:static:prod', ['vendor', 'shared', 'misc', 'html', 'js', 'css', 'img']
gulp.task 'build:dev', ['build:static:dev', 'build:backend']
gulp.task 'build:prod', ['build:static:prod', 'build:backend']


###
Watch/BrowserSync
###
gulp.task 'watch', ['watch:backend', 'watch:static']

gulp.task 'watch:backend', ['nodemon'], ->
  gulp.watch ["!#{DIR.src.backend}/public", "#{DIR.src.backend}/**/*"], ['backend', sync.reload]

gulp.task 'nodemon', ['build:backend'], ->
  nodemon
    script: "#{DIR.build.root}/server.js"
    ignore: ["#{DIR.build.public[2..]}/", "#{DIR.modules[2..]}/"]
    nodeArgs: ['--debug']
    env:
      NODE_ENV: 'development'
      DEBUG: 'StahkPhotos'

gulp.task 'watch:static', ['browser-sync'], ->
  gulp.watch "#{DIR.src.css}/**/*.sass", ['css']
  gulp.watch "#{DIR.src.js}/**/*.{coffee,cjsx}", ['js:dev', sync.reload]
  gulp.watch "#{DIR.src.html}/**/*.jade", ['html', sync.reload]
  gulp.watch "#{DIR.src.shared}/**/*.coffee", ['shared', sync.reload]

gulp.task 'browser-sync', ['build:static:dev'], ->
  sync
    proxy: "localhost:#{env.PORT}"
    port: env.BROWSERSYNC_PORT
    open: false
    notify: false


###
Deploy Heroku
###
write = (data) ->
  process.stdout.write(chalk.white(data.toString()))

run = (cmd, cwd, cb) ->
  opts = if cwd then { cwd } else {}
  parts = cmd.split(/\s+/g)
  p = spawn(parts[0], parts[1..], opts)
  p.stdout.on('data', write)
  p.stderr.on('data', write)
  p.on 'exit', (code) ->
    if code
      err = new Error("command #{cmd} exited [code: #{code}]")
      err = _.extend {}, err, { code, cmd }
    cb?(err or null)

series = (cmds, cwd, cb) ->
  do execNext = ->
    run cmds.shift(), cwd, (err) ->
      return cb(err) if err
      if cmds.length then execNext() else cb(null)

heroku = (prod) ->
  app = "#{env.HEROKU.toLowerCase()}#{unless prod then '-qa' else ''}"

  ->
    CMDS = [
      "rm -rf .git"
      "git init"
      "git add -A"
      "git commit -m '.'"
      "git remote add heroku git@heroku.com:#{app}.git"
      "git push -fu heroku master"
    ]

    series CMDS, DIR.build.root, (err) ->
      if err
        console.log err
        console.log(chalk.red('[Error] Deploy to Heroku failed!'))
      else
        console.log(chalk.green('[Success] Deploy to Heroku successful!'))

deploy = (prod) ->
  ->
    CMDS = [
      "gulp clean"
      "gulp build:prod"
      "gulp heroku:#{if prod then 'prod' else 'qa'}"
    ]

    series CMDS, null, (err) ->
      if err
        console.log(chalk.red('[Error] Deploy failed!'))
      else
        console.log(chalk.green('[Success] Deploy successful!'))

gulp.task 'heroku:qa', heroku(false)
gulp.task 'heroku:prod', heroku(true)
gulp.task 'deploy:qa', deploy(false)
gulp.task 'deploy:prod', deploy(true)


###
Default Tasks
###
gulp.task 'init', ['vendor', 'watch']
gulp.task 'default', ['watch']
